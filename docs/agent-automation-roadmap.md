# Roadmap - Automatisation agentique de MAME

## Objectif

Établir une interaction vérifiable entre un agent hôte et une session MAME CoCo
3 dédiée, en progressant par preuves courtes avant de construire une API
permanente ou un serveur MCP.

Le projet reste local-first, éducatif, solo et AI-first. L'objectif n'est pas de
simuler une qualité industrielle, mais d'obtenir une chaîne simple, observable
et reproductible.

## Principe d'architecture

```text
Agent hôte / CLI
    |
    | commande structurée + chemin de session
    v
Lanceur Python
    |
    | processus MAME dédié + -autoboot_script
    v
Scénario Lua dans MAME
    |
    | clavier, médias, mémoire, écran, reset
    v
Preuves locales
    |- resultat.json
    |- capture.png
    `- journal du lanceur
```

## Pourquoi Python hôte et Lua dans MAME

- **Lua** est la couche la plus proche de MAME pour le clavier naturel, l'état
  des périphériques, la mémoire, le debugger, la capture et l'arrêt.
- **Python** offre un lanceur hôte simple, sans dépendance externe, facile à
  reprendre par un humain ou un agent froid.
- La future surface API ne sera pas liée au transport choisi aujourd'hui.

## Contrat initial

Le premier contrat est volontairement synchrone :

1. l'agent demande une opération sur un scénario ;
2. un processus MAME dédié est lancé ;
3. le scénario Lua attend les conditions nécessaires ;
4. MAME produit une capture et un résultat JSON ;
5. MAME se termine proprement ;
6. le lanceur retourne `0` en cas de succès, une valeur non nulle en cas
   d'échec ou de dépassement du délai.

Résultat minimal :

```json
{
  "schema_version": 1,
  "status": "passed",
  "operation": "inspect",
  "emulator": {
    "name": "mame",
    "version": "0.289"
  },
  "target": {
    "system": "coco3"
  },
  "input": {
    "natural_keyboard_available": true
  },
  "media": [],
  "evidence": {
    "screenshot": "inspect.png"
  }
}
```

## Incréments

### A0 - Session dédiée et observation

Entrée :
- MAME 0.289 installé ;
- ROMs CoCo 3 valides.

Test :
- lancer `coco3` dans une fenêtre dédiée ;
- attendre un nombre de trames stable ;
- confirmer le driver, le clavier naturel, les médias et les dimensions écran ;
- capturer une image ;
- quitter depuis Lua.

Preuve :
- code de sortie du processus ;
- `result.json` ;
- `capture.png`.

### A1 - Hello World lu par l'agent

Étendre A0 :
- monter `hello.dsk` dans `flop1` ;
- envoyer `NEW`, `LOAD "HELLO/BAS"` et `RUN` via le clavier naturel ;
- attendre que la saisie soit consommée ;
- capturer l'écran ;
- rechercher `HELLO.BAS` dans l'image avec `imgtool` comme preuve indépendante.

Limite volontaire : une capture prouve le rendu, mais ne garantit pas encore une
lecture OCR automatique robuste.

### A2 - Création du programme depuis l'agent

À partir d'une disquette vide :
- saisir un court programme BASIC ;
- exécuter `RUN` ;
- sauvegarder avec `SAVE "HELLO/BAS"` ;
- terminer proprement ;
- redémarrer une autre session MAME ;
- charger, exécuter et comparer les preuves.

### A3 - Mini-commande machine/lisible

Stabiliser une commande telle que :

```text
run-scenario <nom-du-scenario>
```

Le scénario décrit :
- système ;
- image disque ;
- commandes clavier ;
- attentes exprimées en trames ou secondes ;
- preuves attendues.

Le format reste local, simple et versionné avant toute introduction réseau.

### A4 - Surface API locale

Créer seulement après la réussite de A2/A3 :

- `start`
- `mount`
- `type`
- `wait`
- `soft_reset`
- `hard_reset`
- `read_memory`
- `capture_screen`
- `shutdown`

Chaque appel aura :
- une requête JSON versionnée ;
- un résultat JSON versionné ;
- un identifiant de scénario ;
- un délai ;
- une preuve ou une erreur explicite.

### A5 - Décision MCP

MCP n'est pas nécessaire pour valider la chaîne. Il devient pertinent lorsque :

- les primitives locales sont stables ;
- plusieurs agents/clients doivent les consommer ;
- la découverte d'outils et les contrats typés apportent plus qu'ils ne coûtent ;
- le transport MCP reste une couche mince au-dessus de l'API locale.

L'objectif n'est pas de créer MCP pour tester MAME, mais de tester MAME afin de
savoir si une surface MCP mérite ensuite d'exister.

Un candidat de référence a été découvert :
[dbowlin/CoCo3_MCP_Server](https://github.com/dbowlin/CoCo3_MCP_Server).
Son pont Node/Lua a été validé avec MAME 0.289 localement. La recommandation est
de le forker comme implémentation candidate sans remplacer le corpus produit ;
voir
[evaluation-coco3-mcp-server.md](C:/project/coco3/docs/evaluation-coco3-mcp-server.md).

Le fork est désormais disponible dans
<https://github.com/mgagp/CoCo3_MCP_Server>. Sa gouvernance, ses permissions, ses
branches et la contribution upstream sont définies dans
[github-fork-workflow.md](C:/project/coco3/docs/github-fork-workflow.md).

## Stratégie autour d'une session déjà ouverte

Une session MAME interactive existante est utile pour apprendre manuellement.
L'automatisation initiale utilise cependant un **processus MAME dédié** :

- aucun vol de focus ni capture clavier implicite ;
- configuration et médias connus ;
- processus, timeout et code de sortie contrôlés ;
- aucune dépendance à l'état humain de l'autre fenêtre.

Le contrôle d'une instance déjà ouverte reste un jalon futur possible. Il ne
sera entrepris qu'après validation du canal dédié, car il introduit la
localisation du processus, le contrôle à distance, les conflits de fichier et
les problèmes de fenêtre/focus.

Sous Windows, une image montée en écriture par MAME peut être verrouillée par le
processus. Le lanceur copie donc l'image source dans le répertoire isolé de
l'exécution avant de la monter. Cette copie est une donnée d'exécution, pas une
référence canonique.

## Critères de passage

- A0 réussit deux fois de suite sans intervention humaine.
- A1 charge le disque Hello World et produit la preuve attendue.
- A2 fonctionne après redémarrage complet de MAME.
- Une erreur de délai ou de média est visible, jamais convertie en succès.
- Aucune étape ne dépend d'une session MAME interactive laissée ouverte.

## Premier prototype

Le dossier [`automation/mame/`](C:/project/coco3/automation/mame/) contient le
prototype A0 :

```bash
python automation/mame/run_smoke.py \
  --disk C:/Coco3Lab/mame/disks/hello.dsk
```

