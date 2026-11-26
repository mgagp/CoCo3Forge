# Session 2026-11-26 - Prototype agentique MAME A0

## Intention
- Valider une première interaction agent hôte vers MAME sans intervenir
  manuellement pendant l'émulation.
- Établir une architecture locale minimale avant toute surface MCP.

## Point de départ
- MAME 0.289 installé sous Windows dans `C:\Tools\MAME\0.289`.
- Driver `coco3` fonctionnel et ROMs validées.
- Une image `C:\Coco3Lab\mame\disks\hello.dsk` contient un programme BASIC.
- Une instance interactive de MAME peut déjà être ouverte.

## Travail réalisé
- Décision ADR-0002: utiliser une session MAME dédiée, Lua dans MAME et Python
  comme lanceur hôte.
- Création d'une roadmap A0 à A5 dans
  [agent-automation-roadmap.md](C:/project/coco3/docs/agent-automation-roadmap.md).
- Création de `automation/mame/run_smoke.py`.
- Création du scénario MAME Lua `automation/mame/smoke.lua`.
- Isolation des configurations, NVRAM, différences et preuves dans un
  répertoire d'exécution.
- Copie de la disquette source dans la session isolée afin d'éviter les verrous
  d'écriture Windows.
- Production d'un `result.json`, d'une `capture.png` et d'un journal hôte.

## Résultats observés
- A0 a réussi deux fois consécutivement sans interaction humaine.
- MAME se termine avec le code 0 depuis Lua.
- Le clavier naturel est disponible.
- Le premier lecteur présente bien l'image copiée, en écriture.
- Le second lecteur est vide.
- L'écran détecté mesure 640 x 239.
- Chaque exécution prend environ 5,3 secondes.
- La capture A0 montre l'écran de démarrage Disk Extended Color BASIC.
- La capture seule est une preuve visuelle ; elle n'est pas encore une assertion
  structurée du texte affiché.

## Signal important
Une image de disquette déjà ouverte en écriture par une autre instance MAME
peut produire `Permission denied` sous Windows. La copie de travail par session
est donc une propriété nécessaire de l'automatisation initiale.

## Questions ouvertes
- Comment synchroniser l'envoi clavier après que Disk Extended BASIC est prêt?
- Quelle observation structurée peut éviter de dépendre d'un OCR fragile?
- Comment confirmer depuis la machine émulée qu'un `LOAD` a réussi?

## Prochaines actions
1. Créer A1: envoyer les commandes `LOAD "HELLO/BAS"` puis `RUN`.
2. Capturer le résultat après consommation complète du tampon clavier.
3. Examiner la mémoire/CPU du CoCo pour identifier une condition de
   synchronisation plus robuste que le délai fixe.
4. Faire valider `HELLO.BAS` indépendamment avec `imgtool`.
5. Évaluer en fork le serveur MCP de dbowlin, sans remplacer encore ce dépôt,
   selon l'évaluation documentaire dédiée.
