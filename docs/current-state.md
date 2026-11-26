# État actuel

## Statut matériel

- CoCo 3: disponible mais pas encore réinstallé (dans sa boîte).
- Contrôleur disque USB/SD: présent, à revalider.
- Piste RS232: essais passés à reprendre.

## Statut logiciel

- Corpus documentaire initial en création.
- Architecture API: en définition.
- Émulateur principal: MAME, documenté dans
  [ADR-0001-emulateur-principal.md](C:/project/coco3/docs/decisions/ADR-0001-emulateur-principal.md).
- Pipeline émulateur/build: à construire autour de MAME.
- Smoke test local via MCP disponible:
  [mcp-local-smoke-test.md](C:/project/coco3/docs/mcp-local-smoke-test.md).
- Plan multi-fronts en place (H/S/R) avec suivi et checklists.

## Prochain objectif immédiat

1. Exécuter [HARDWARE_BRINGUP_CHECKLIST.md](C:/project/coco3/docs/checklists/HARDWARE_BRINGUP_CHECKLIST.md).
2. Compléter l’inventaire matériel initial dans [status-board.md](C:/project/coco3/docs/status-board.md).
3. Lancer la baseline logicielle avec [SOFTWARE_BASELINE_CHECKLIST.md](C:/project/coco3/docs/checklists/SOFTWARE_BASELINE_CHECKLIST.md).
