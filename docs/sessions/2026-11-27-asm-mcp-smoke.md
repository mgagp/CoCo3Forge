# Session 2026-11-27 - ASM pipeline smoke via MCP

## Intent

Reproduce the BASIC automation pattern for an assembly path:

- source `.asm`,
- compile to DECB binary,
- package into DSK,
- run automatically through MCP + MAME,
- capture a screenshot and structured evidence.

## Starting point

- BASIC MCP smoke already available and reproducible.
- No validated assembler pipeline documented yet.

## What was done

1. Selected baseline tooling:
   - LWTOOLS `lwasm` for 6809 assembly and DECB output;
   - ToolShed `decb` for DSK creation and file copy.
2. Added assembly sample:
   - [hello_world.asm](/automation/asm/hello_world.asm).
3. Added MCP-driven automation script:
   - [run_hello_asm_via_mcp.ps1](/automation/mcp/run_hello_asm_via_mcp.ps1).
4. Added procedure doc:
   - [mcp-asm-smoke-test.md](/docs/mcp-asm-smoke-test.md).
5. Ran the flow and collected artifacts in
   `automation/mcp/output/asm-20261127T144923/`.

## Evidence

- `result.json` reports `"ok": true`.
- `screenProbe` contains `HELLO WORLD FROM ASM`.
- `memoryProbe` reports marker `42` at `$7000`.
- `snapshot.png` was generated through MCP.

## Quick wins

- Stable Windows toolchain found quickly (`lwasm` + `decb`).
- Full automated path achieved in one script from source to evidence.

## Deeper issues observed

- OCR alone is not reliable enough for proof on CoCo screenshots.
- Command timing matters: keyboard injection can appear queued but still needs
  pragmatic delays for deterministic evidence.
- Address probes must be interpreted carefully in CoCo3/MMU context.

## Lessons learned

1. Keep screenshot as visual evidence, but rely on a structured probe for pass/fail.
2. Preserve a marker-based assertion in addition to text output.
3. Capture troubleshooting traces (`loadProbe`, `screenProbe`) in `result.json`
   to make cold-session debugging faster.

## Next actions

1. Add a second ASM scenario (e.g., ROM API-only output without direct screen mirror).
2. Replace fixed waits with a readiness predicate where possible.
3. Extract common MCP smoke helpers shared by BASIC and ASM scripts.

