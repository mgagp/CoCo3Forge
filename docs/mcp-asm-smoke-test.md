# ASM smoke test via MCP (CoCo3)

This procedure validates the assembly pipeline end-to-end through the local MCP server:

1. assemble 6809 source with `lwasm`,
2. build a DSK with `decb`,
3. boot MAME through MCP,
4. run the loader command automatically,
5. capture a screenshot and structured execution evidence.

## Tooling choice (community baseline)

- **Assembler:** `lwasm` (LWTOOLS)
- **Disk tooling:** `decb` (ToolShed)

Why this pair:

- widely used in CoCo/6809 cross-development workflows;
- native support for DECB binaries (`lwasm --decb`);
- direct host↔disk image operations (`decb dskini`, `decb copy`).

## Local prerequisites

- MCP fork: `C:\project\CoCo3_MCP_Server\MCP`
- MAME: `C:\Tools\MAME\0.289\mame.exe`
- ROMs: `C:\Coco3Lab\mame\roms`
- LWTOOLS: `C:\Tools\LWTOOLS\4.25\lwtools-4.25-win64\lwasm.exe`
- ToolShed: `C:\Tools\ToolShed\2.7.0\toolshed-2.7.0\decb.exe`

## Run

From `coco3` repo root:

```powershell
powershell -ExecutionPolicy Bypass -File .\automation\mcp\run_hello_asm_via_mcp.ps1
```

## Expected artifacts

Under `automation/mcp/output/asm-<timestamp>/`:

- `HELLOASM.BIN`
- `helloasm.dsk`
- `helloasm.lst`
- `HELLO.BAS`
- `result.json`
- `snapshot.png`

## Current success signal

- `result.json` contains `"ok": true`;
- screen-memory probe includes `HELLO WORLD FROM ASM`;
- marker probe confirms execution path (`"memoryProbe": {"data":"42"}`);
- screenshot is produced via MCP (`snapshot.png`).
