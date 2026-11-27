# CoCo3Forge

![CoCo3Forge logo](./media/logo-coco3forge.svg)

**An AI-first retrocomputing laboratory**

A laboratory to build, experiment, and revive the **Tandy Color Computer 3**
on both emulator and real hardware.

## Positioning

The project has two complementary tracks:

1. **MCP track (upstream fork validated locally)**  
   Industrialize an MCP-based agentic control path for emulation.
2. **Hardware/API lab track**  
   Incrementally build a shared API facade that can target either a simulated
   or real CoCo 3.

## Goals

1. Design an API surface to control the CoCo 3:
   - storage/disk
   - keyboard input injection
   - reset (soft/hard)
   - run/stop cycle (including debug/step options)
2. Establish a simple documentation method for both humans and cold-start AI agents.
3. Build a local workflow: research, prototyping, testing, emulation, then real-hardware validation.

## Quick start (method)

1. Read [vision.md](/docs/vision.md)
2. Read [agents.md](/docs/agents.md)
3. Read the [engineering work method](/docs/engineering-work-method.md)
4. Check current status in [current-state.md](/docs/current-state.md)
5. Create/update a session note with [SESSION_TEMPLATE.md](/docs/sessions/SESSION_TEMPLATE.md)
6. Close the session with a retro using [RETRO_TEMPLATE.md](/docs/retrospectives/RETRO_TEMPLATE.md)
7. For local MCP validation, follow [mcp-local-smoke-test.md](/docs/mcp-local-smoke-test.md)
8. For cold-start agent onboarding, follow [mcp-cold-start.md](/docs/mcp-cold-start.md)
9. For assembly flow validation through MCP, follow [mcp-asm-smoke-test.md](/docs/mcp-asm-smoke-test.md)

## Documentation structure

- [docs/](/docs/)
  - [vision.md](/docs/vision.md): product vision and purpose
  - [product-spec.md](/docs/product-spec.md): scope, priorities, constraints
  - [plan-de-match.md](/docs/plan-de-match.md): full execution plan by steps
  - [agents.md](/docs/agents.md): cold-start agent protocol
  - [engineering-work-method.md](/docs/engineering-work-method.md): decision principles, debt control, proportional testing
  - [dependency-upgrade-workflow.md](/docs/dependency-upgrade-workflow.md): dependency PR analysis and validation
  - [security-quality-triage.md](/docs/security-quality-triage.md): security/quality alert triage
  - [upstream-contribution-policy.md](/docs/upstream-contribution-policy.md): upstream contribution policy
  - [mcp-local-smoke-test.md](/docs/mcp-local-smoke-test.md): local `Hello` validation through the MCP fork
  - [mcp-asm-smoke-test.md](/docs/mcp-asm-smoke-test.md): assembly pipeline validation (lwasm + decb + MCP run)
  - [github-labels.md](/docs/github-labels.md): priorities and GitHub label taxonomy
  - [cloud.md](/docs/cloud.md): cloud/remote tooling conventions
  - [mcp-cold-start.md](/docs/mcp-cold-start.md): single entry point for local paths + quick MCP validation
  - [current-state.md](/docs/current-state.md): current hardware/software status
  - [roadmap.md](/docs/roadmap.md): progressive roadmap
  - [status-board.md](/docs/status-board.md): multi-track status board
  - [checklists/](/docs/checklists/): operational checklists
  - [sessions/](/docs/sessions/): session notes
  - [verbatims/](/docs/verbatims/): source excerpts and historical framing
  - [retrospectives/](/docs/retrospectives/): end-of-session retrospectives
  - [decisions/](/docs/decisions/): architecture and method decisions

## Golden rule

Each session should leave enough explicit context to continue without implicit memory:
- intent
- starting state
- changes
- validation
- next actions
- retrospective and process recommendations

The entry points [AGENTS.md](/AGENTS.md),
[CLAUDE.md](/CLAUDE.md), Copilot, and Cursor all point to this
shared corpus to avoid divergent rule sets.

