#!/usr/bin/env python3
import argparse
import json
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run an isolated MAME CoCo 3 inspection smoke test."
    )
    parser.add_argument(
        "--mame",
        type=Path,
        default=Path(r"C:\Tools\MAME\0.289\mame.exe"),
        help="Path to mame.exe.",
    )
    parser.add_argument(
        "--rompath",
        type=Path,
        default=Path(r"C:\Coco3Lab\mame\roms"),
        help="Path containing coco3.zip and coco_fdc.zip.",
    )
    parser.add_argument(
        "--disk",
        type=Path,
        default=Path(r"C:\Coco3Lab\mame\disks\hello.dsk"),
        help="Optional disk image mounted in drive 0.",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("automation/mame/output"),
        help="Output directory for this run.",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=60,
        help="Maximum wall-clock runtime in seconds.",
    )
    return parser.parse_args()


def ensure_path(path: Path, label: str) -> Path:
    resolved = path.resolve()
    if not resolved.exists():
        raise FileNotFoundError(f"{label} does not exist: {resolved}")
    return resolved


def main() -> int:
    args = parse_args()
    mame = ensure_path(args.mame, "MAME executable")
    rompath = ensure_path(args.rompath, "ROM path")
    disk = ensure_path(args.disk, "Disk image") if args.disk else None

    repo_root = Path(__file__).resolve().parents[2]
    script = repo_root / "automation" / "mame" / "smoke.lua"
    output = (repo_root / args.output).resolve()
    run_id = time.strftime("%Y%m%dT%H%M%S")
    run_dir = output / run_id
    run_dir.mkdir(parents=True, exist_ok=False)

    result_path = run_dir / "result.json"
    screenshot_path = run_dir / "capture.png"
    host_log_path = run_dir / "mame.log"

    state_directories = ("cfg", "nvram", "snap", "diff")
    for name in state_directories:
        (run_dir / name).mkdir()

    mounted_disk = None
    if disk:
        mounted_disk = run_dir / disk.name
        shutil.copy2(disk, mounted_disk)

    env = os.environ.copy()
    env["COCO3_RESULT_PATH"] = str(result_path)
    env["COCO3_SCREENSHOT_PATH"] = str(screenshot_path)

    command = [
        str(mame),
        "coco3",
        "-window",
        "-nomouse",
        "-skip_gameinfo",
        "-rompath",
        str(rompath),
        "-cfg_directory",
        str(run_dir / "cfg"),
        "-nvram_directory",
        str(run_dir / "nvram"),
        "-snapshot_directory",
        str(run_dir / "snap"),
        "-diff_directory",
        str(run_dir / "diff"),
        "-autoboot_delay",
        "0",
        "-autoboot_script",
        str(script),
    ]
    if mounted_disk:
        command.extend(["-flop1", str(mounted_disk)])

    started_at = time.time()
    with host_log_path.open("w", encoding="utf-8") as host_log:
        process = subprocess.Popen(
            command,
            cwd=mame.parent,
            env=env,
            stdout=host_log,
            stderr=subprocess.STDOUT,
        )
        try:
            return_code = process.wait(timeout=args.timeout)
        except subprocess.TimeoutExpired:
            process.terminate()
            try:
                process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait()
            print(f"FAILED: MAME exceeded {args.timeout}s; evidence in {run_dir}")
            return 2

    if return_code != 0:
        print(f"FAILED: MAME exited with code {return_code}; see {host_log_path}")
        return 3
    if not result_path.exists():
        print(f"FAILED: MAME produced no result.json; see {host_log_path}")
        return 4

    try:
        result = json.loads(result_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        print(f"FAILED: invalid result.json: {error}; see {host_log_path}")
        return 5

    duration = round(time.time() - started_at, 3)
    result["host"] = {
        "exit_code": return_code,
        "duration_seconds": duration,
        "command": command,
        "run_directory": str(run_dir),
        "source_disk": str(disk) if disk else None,
        "mounted_disk": str(mounted_disk) if mounted_disk else None,
    }
    result_path.write_text(
        json.dumps(result, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )

    if result.get("status") != "passed" or not screenshot_path.exists():
        print(f"FAILED: smoke test result is not complete; see {result_path}")
        return 6

    print(f"PASSED: {result_path}")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (FileNotFoundError, OSError) as error:
        print(f"FAILED: {error}", file=sys.stderr)
        sys.exit(1)
