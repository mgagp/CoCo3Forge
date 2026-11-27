# État actuel

## Statut matériel

- CoCo 3: disponible mais pas encore réinstallé (dans sa boîte).
- Contrôleur disque USB/SD: présent, à revalider.
- Piste RS232: essais passés à reprendre.

## Statut logiciel

- Corpus documentaire initial en place et évolutif.
- Architecture API: en définition, avec séparation explicite entre
  **contrat fonctionnel de contrôle** et **mode d'exposition MCP**.
- Émulateur principal: MAME, documenté dans
  [ADR-0001-emulateur-principal.md](/docs/decisions/ADR-0001-emulateur-principal.md).
- Baseline logicielle validée:
  - pipeline BASIC via MCP;
  - pipeline assembleur via MCP (lwasm + decb + exécution auto MAME).
- Smoke test local via MCP disponible:
  [mcp-local-smoke-test.md](/docs/mcp-local-smoke-test.md).
- Smoke test assembleur via MCP disponible:
  [mcp-asm-smoke-test.md](/docs/mcp-asm-smoke-test.md).
- Plan multi-fronts en place (H/S/R) avec suivi et checklists.

## Prochain objectif immédiat

1. Exécuter [HARDWARE_BRINGUP_CHECKLIST.md](/docs/checklists/HARDWARE_BRINGUP_CHECKLIST.md).
2. Compléter l'inventaire matériel initial dans [status-board.md](/docs/status-board.md).
3. Lancer la baseline logicielle avec [SOFTWARE_BASELINE_CHECKLIST.md](/docs/checklists/SOFTWARE_BASELINE_CHECKLIST.md).

