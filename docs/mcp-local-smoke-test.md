# Smoke test local via MCP (CoCo3)

Cette procédure valide le chemin que nous voulons privilégier pour les tests:

1. VS Code voit le serveur MCP local du fork `CoCo3_MCP_Server`.
2. Un test `Hello` passe par les outils MCP (`coco_start`, `coco_mount_flop`, `coco_type`, `coco_snapshot`, `coco_stop`).
3. Une preuve (capture + résultat JSON) est produite.

## Prérequis locaux

- Fork local: `C:\project\CoCo3_MCP_Server`
- Build MCP présent: `C:\project\CoCo3_MCP_Server\MCP\dist\index.js`
- MAME: `C:\Tools\MAME\0.289\mame.exe`
- ROMs CoCo3: `C:\Coco3Lab\mame\roms`
- Disquette de test: `C:\Coco3Lab\mame\disks\hello.dsk`

## Configuration VS Code

Le workspace `coco3` contient `.vscode/mcp.json` avec un serveur `coco3-local`.

Après ouverture/rechargement du workspace, le serveur doit être visible côté MCP dans VS Code.

## Exécuter le smoke test

Depuis la racine du repo `coco3`:

```powershell
powershell -ExecutionPolicy Bypass -File .\automation\mcp\run_hello_via_mcp.ps1
```

## Résultats attendus

- Sortie console JSON avec `"ok": true`
- Artefacts dans `automation/mcp/output/<timestamp>/`:
  - `result.json`
  - `snapshot.png`

Le fichier `result.json` contient l'historique des appels MCP utilisés pendant le test.

## Notes

- Le script lance le serveur MCP en `stdio`, exécute le scénario, puis appelle `coco_stop`.
- Le test reste local et n'exige pas de modifier le fork tant qu'on reste sur ce scénario minimal.
