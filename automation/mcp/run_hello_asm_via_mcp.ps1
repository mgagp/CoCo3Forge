$ErrorActionPreference = "Stop"

$repoRoot = "C:\project\coco3"
$mcpRoot = "C:\project\CoCo3_MCP_Server\MCP"
$mamePath = "C:\Tools\MAME\0.289\mame.exe"
$romPath = "C:\Coco3Lab\mame\roms"
$lwasmPath = "C:\Tools\LWTOOLS\4.25\lwtools-4.25-win64\lwasm.exe"
$decbPath = "C:\Tools\ToolShed\2.7.0\toolshed-2.7.0\decb.exe"
$sourceAsm = Join-Path $repoRoot "automation\asm\hello_world.asm"
$outRoot = Join-Path $repoRoot "automation\mcp\output"
$runCommand = if ($env:COCO3_ASM_RUN_COMMAND) { $env:COCO3_ASM_RUN_COMMAND } else { 'RUN"HELLO"' }

foreach ($p in @($mcpRoot, $mamePath, $romPath, $lwasmPath, $decbPath, $sourceAsm)) {
  if (-not (Test-Path $p)) { throw "Missing required path: $p" }
}

New-Item -ItemType Directory -Force -Path $outRoot | Out-Null
$runId = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmss")
$runDir = Join-Path $outRoot ("asm-" + $runId)
New-Item -ItemType Directory -Path $runDir -Force | Out-Null

$binPath = Join-Path $runDir "HELLOASM.BIN"
$dskPath = Join-Path $runDir "helloasm.dsk"
$lstPath = Join-Path $runDir "helloasm.lst"
$launcherPath = Join-Path $runDir "HELLO.BAS"

& $lwasmPath --6809 --decb --list=$lstPath -o $binPath $sourceAsm
if ($LASTEXITCODE -ne 0) { throw "lwasm failed with exit code $LASTEXITCODE" }

& $decbPath dskini $dskPath
if ($LASTEXITCODE -ne 0) { throw "decb dskini failed with exit code $LASTEXITCODE" }

& $decbPath copy -2 -b $binPath "$dskPath,HELLOASM.BIN"
if ($LASTEXITCODE -ne 0) { throw "decb copy failed with exit code $LASTEXITCODE" }

Set-Content -Path $launcherPath -Encoding ASCII -Value @(
  "10 LOADM""HELLOASM"":EXEC"
)
& $decbPath copy -0 -a -t $launcherPath "$dskPath,HELLO.BAS"
if ($LASTEXITCODE -ne 0) { throw "decb copy HELLO.BAS failed with exit code $LASTEXITCODE" }

$js = @'
import fs from "node:fs/promises";
import path from "node:path";
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StdioClientTransport } from "@modelcontextprotocol/sdk/client/stdio.js";

const mcpRoot = process.cwd();
const runDir = process.env.COCO3_ASM_RUN_DIR;
const dskPath = process.env.COCO3_ASM_DSK;
const mamePath = process.env.COCO3_MAME_PATH;
const romPath = process.env.COCO3_ROM_PATH;
const decbPath = process.env.COCO3_DECB_PATH;
const runCommand = process.env.COCO3_ASM_RUN_COMMAND;

if (!runDir || !dskPath || !mamePath || !romPath || !decbPath || !runCommand) {
  throw new Error("Missing required environment variables for MCP run");
}

const transport = new StdioClientTransport({
  command: process.execPath,
  args: [path.join(mcpRoot, "dist", "index.js")],
  cwd: mcpRoot,
  env: {
    ...process.env,
    MAME_PATH: mamePath,
    MAME_ROMPATH: romPath,
    DECB_PATH: decbPath,
  },
});

const client = new Client({ name: "coco3-asm-smoke", version: "1.0.0" });
const textOf = (res) => (res?.content || []).filter((p) => p.type === "text").map((p) => p.text || "").join("\n");
const result = { runDir, ok: false, steps: [] };

try {
  await client.connect(transport);
  const listed = await client.listTools();
  result.tools = listed.tools.map((t) => t.name).sort();

  const preCalls = [
    { name: "coco_start", arguments: {} },
    { name: "coco_mount_flop", arguments: { path: dskPath, drive: "flop1" } },
  ];

  for (const call of preCalls) {
    const res = await client.callTool(call);
    result.steps.push({ step: call.name, text: textOf(res), isError: !!res.isError });
    if (res.isError) throw new Error(`${call.name} failed: ${textOf(res)}`);
  }

  await new Promise((resolve) => setTimeout(resolve, 8000));

  const markerInit = await client.callTool({ name: "coco_write_memory", arguments: { address: "7000", data: "00" } });
  result.steps.push({ step: "coco_write_memory_7000", text: textOf(markerInit), isError: !!markerInit.isError });
  if (markerInit.isError) throw new Error(`coco_write_memory failed: ${textOf(markerInit)}`);

  const runRes = await client.callTool({ name: "coco_type", arguments: { text: runCommand } });
  result.steps.push({ step: "coco_type_" + runCommand, text: textOf(runRes), isError: !!runRes.isError });
  if (runRes.isError) throw new Error(`coco_type failed: ${textOf(runRes)}`);
  await new Promise((resolve) => setTimeout(resolve, 6000));

  const loadProbe = await client.callTool({ name: "coco_read_memory", arguments: { address: "2000", length: 4 } });
  result.steps.push({ step: "coco_read_memory_2000", text: textOf(loadProbe), isError: !!loadProbe.isError });
  if (!loadProbe.isError) {
    result.loadProbe = JSON.parse(textOf(loadProbe));
  }

  const snap = await client.callTool({ name: "coco_snapshot", arguments: {} });
  result.steps.push({ step: "coco_snapshot", text: textOf(snap), isError: !!snap.isError });
  if (snap.isError) throw new Error(`coco_snapshot failed: ${textOf(snap)}`);

  const probe = await client.callTool({ name: "coco_read_memory", arguments: { address: "7000", length: 1 } });
  result.steps.push({ step: "coco_read_memory_7000", text: textOf(probe), isError: !!probe.isError });
  if (!probe.isError) {
    result.memoryProbe = JSON.parse(textOf(probe));
  }

  const image = (snap.content || []).find((p) => p.type === "image");
  if (!image?.data) throw new Error("snapshot returned no image content");
  const snapPath = path.join(runDir, "snapshot.png");
  await fs.writeFile(snapPath, Buffer.from(image.data, "base64"));
  result.snapshotPath = snapPath;

  const screenProbe = await client.callTool({ name: "coco_read_memory", arguments: { address: "0400", length: 512 } });
  result.steps.push({ step: "coco_read_memory_0400_512", text: textOf(screenProbe), isError: !!screenProbe.isError });
  if (!screenProbe.isError) {
    result.screenProbe = JSON.parse(textOf(screenProbe));
  }
  result.ok = true;
} catch (error) {
  result.error = error instanceof Error ? error.message : String(error);
} finally {
  try {
    const stop = await client.callTool({ name: "coco_stop", arguments: {} });
    result.steps.push({ step: "coco_stop", text: textOf(stop), isError: !!stop.isError });
  } catch (error) {
    result.stopError = error instanceof Error ? error.message : String(error);
  }
  await client.close().catch(() => {});
  await fs.writeFile(path.join(runDir, "result.json"), JSON.stringify(result, null, 2) + "\n", "utf8");
  console.log(JSON.stringify({ runDir, ok: result.ok, snapshotPath: result.snapshotPath || null, error: result.error || null }));
  if (!result.ok) process.exitCode = 1;
}
'@

$tmp = Join-Path $mcpRoot "tmp-coco3-asm-hello.mjs"
Set-Content -Path $tmp -Value $js -Encoding UTF8

$old = Get-Location
try {
  Set-Location $mcpRoot
  $env:COCO3_ASM_RUN_DIR = $runDir
  $env:COCO3_ASM_DSK = $dskPath
  $env:COCO3_MAME_PATH = $mamePath
  $env:COCO3_ROM_PATH = $romPath
  $env:COCO3_DECB_PATH = $decbPath
  $env:COCO3_ASM_RUN_COMMAND = $runCommand
  node $tmp
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
} finally {
  Set-Location $old
  Remove-Item -Path $tmp -Force -ErrorAction SilentlyContinue
  Remove-Item Env:\COCO3_ASM_RUN_DIR -ErrorAction SilentlyContinue
  Remove-Item Env:\COCO3_ASM_DSK -ErrorAction SilentlyContinue
  Remove-Item Env:\COCO3_MAME_PATH -ErrorAction SilentlyContinue
  Remove-Item Env:\COCO3_ROM_PATH -ErrorAction SilentlyContinue
  Remove-Item Env:\COCO3_DECB_PATH -ErrorAction SilentlyContinue
  Remove-Item Env:\COCO3_ASM_RUN_COMMAND -ErrorAction SilentlyContinue
}
