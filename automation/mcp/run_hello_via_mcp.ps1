$ErrorActionPreference = "Stop"

$mcpRoot = "C:\project\CoCo3_MCP_Server\MCP"
$mamePath = "C:\Tools\MAME\0.289\mame.exe"
$romPath = "C:\Coco3Lab\mame\roms"
$diskPath = "C:\Coco3Lab\mame\disks\hello.dsk"
$outRoot = "C:\project\coco3\automation\mcp\output"

if (-not (Test-Path $mcpRoot)) { throw "MCP repo not found: $mcpRoot" }
if (-not (Test-Path $mamePath)) { throw "MAME not found: $mamePath" }
if (-not (Test-Path $romPath)) { throw "ROM path not found: $romPath" }
if (-not (Test-Path $diskPath)) { throw "Disk image not found: $diskPath" }

New-Item -ItemType Directory -Force -Path $outRoot | Out-Null

$js = @'
import fs from "node:fs/promises";
import path from "node:path";
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StdioClientTransport } from "@modelcontextprotocol/sdk/client/stdio.js";

const root = process.cwd();
const outRoot = "C:/project/coco3/automation/mcp/output";
const runId = new Date().toISOString().replace(/[-:]/g, "").replace(/\..+/, "").replace("T", "T");
const runDir = path.join(outRoot, runId);
await fs.mkdir(runDir, { recursive: true });

const transport = new StdioClientTransport({
  command: process.execPath,
  args: [path.join(root, "dist", "index.js")],
  cwd: root,
  env: {
    ...process.env,
    MAME_PATH: "C:/Tools/MAME/0.289/mame.exe",
    MAME_ROMPATH: "C:/Coco3Lab/mame/roms",
    DECB_PATH: "C:/project/CoCo3_MCP_Server/toolshed/decb.exe",
  },
});

const client = new Client({ name: "coco3-mcp-smoke", version: "1.0.0" });
const textOf = (res) => (res?.content || []).filter((p) => p.type === "text").map((p) => p.text || "").join("\n");
const result = { runDir, ok: false, steps: [] };

try {
  await client.connect(transport);
  const listed = await client.listTools();
  result.tools = listed.tools.map((t) => t.name).sort();

  for (const call of [
    { name: "coco_start", arguments: {} },
    { name: "coco_mount_flop", arguments: { path: "C:/Coco3Lab/mame/disks/hello.dsk", drive: "flop1" } },
    { name: "coco_type", arguments: { text: "DIR" } },
    { name: "coco_type", arguments: { text: "RUN\"HELLO\"" } },
  ]) {
    const res = await client.callTool(call);
    result.steps.push({ step: call.name, text: textOf(res), isError: !!res.isError });
    if (res.isError) throw new Error(`${call.name} failed: ${textOf(res)}`);
  }

  const snap = await client.callTool({ name: "coco_snapshot", arguments: {} });
  result.steps.push({ step: "coco_snapshot", text: textOf(snap), isError: !!snap.isError });
  if (snap.isError) throw new Error(`coco_snapshot failed: ${textOf(snap)}`);

  const image = (snap.content || []).find((p) => p.type === "image");
  if (!image?.data) throw new Error("snapshot returned no image content");
  const snapPath = path.join(runDir, "snapshot.png");
  await fs.writeFile(snapPath, Buffer.from(image.data, "base64"));
  result.snapshotPath = snapPath;
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

$tmp = Join-Path $mcpRoot "tmp-coco3-mcp-hello.mjs"
Set-Content -Path $tmp -Value $js -Encoding UTF8

$old = Get-Location
try {
  Set-Location $mcpRoot
  node $tmp
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
} finally {
  Set-Location $old
  Remove-Item -Path $tmp -Force -ErrorAction SilentlyContinue
}
