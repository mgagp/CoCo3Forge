# MCP CoCo3 - démarrage à froid (5 min)

Objectif: permettre à un agent sans contexte de retrouver vite le fork MCP, les
chemins locaux et la validation minimale.

## 1) Localiser les composants

- Fork MCP: `C:\project\CoCo3_MCP_Server`
- Entrée serveur MCP: `C:\project\CoCo3_MCP_Server\MCP\dist\index.js`
- MAME: `C:\Tools\MAME\0.289\mame.exe`
- ROMs: `C:\Coco3Lab\mame\roms`
- Disque de test: `C:\Coco3Lab\mame\disks\hello.dsk`

## 2) Vérifier l'intégration VS Code

- Le workspace `coco3` doit contenir `.vscode/mcp.json`.
- Le serveur configuré est `coco3-local` en `stdio`.

## 3) Valider le chemin MCP (smoke test)

Depuis la racine de `coco3`:

```powershell
powershell -ExecutionPolicy Bypass -File .\automation\mcp\run_hello_via_mcp.ps1
```

## 4) Critère de succès

- La sortie console contient `"ok": true`.
- Un dossier est créé sous `automation/mcp/output/<timestamp>/`.
- Les fichiers `result.json` et `snapshot.png` sont présents.

## 5) Si échec

1. Vérifier les chemins locaux ci-dessus.
2. Vérifier que `MCP/dist/index.js` existe (build du fork MCP).
3. Vérifier que les ROMs CoCo3 sont dans `C:\Coco3Lab\mame\roms`.
4. Relancer le smoke test et conserver `result.json` comme preuve.
