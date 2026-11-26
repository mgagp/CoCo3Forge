# Évaluation - dbowlin/CoCo3_MCP_Server

## Référence

- Dépôt : <https://github.com/dbowlin/CoCo3_MCP_Server>
- État consulté : commit `60c3cbf61a41`
- Licence : MIT
- Langage principal : TypeScript
- Serveur MCP : stdio
- Pont MAME : TCP localhost, JSON délimité par lignes, implémenté par Lua

## Résumé exécutif

Ce dépôt couvre déjà une grande partie des jalons A1 à A5 de la roadmap
agentique. Il n'est pas seulement une idée : son pont fonctionne avec le MAME
0.289 installé localement.

Un test réel a confirmé :

- démarrage de `coco3` ;
- connexion du script Lua au pont Node ;
- énumération de `flop1` et `flop2` ;
- montage d'une copie de `hello.dsk` ;
- injection de `LOAD "HELLO/BAS"` ;
- injection de `RUN` ;
- capture de l'écran final ;
- arrêt du processus MAME.

Les 49 tests du dépôt passent et TypeScript compile.

## Correspondance avec notre roadmap

| Jalons du projet | Candidat |
|---|---|
| A0 - session et preuve | Partiellement : une session persistante démarre sous contrôle MCP, mais pas de résultat de scénario isolé avec copie disque automatique |
| A1 - charger Hello World | Oui, validé localement avec le pont |
| A2 - créer/valider une disquette | Partiellement : création via ToolShed `decb`, sans chaîne de scénario complète |
| A3 - protocole local structuré | Oui : commandes JSON corrélées, délais, erreurs |
| A4 - surface API locale | Oui : 14 outils de domaine CoCo exposés |
| A5 - couche MCP | Oui : serveur MCP stdio TypeScript |

## Actifs réutilisables

- Script Lua `MCP/scripts/bridge.lua`.
- Protocole Node/Lua bidirectionnel par TCP loopback.
- Lancement de MAME et gestion du cycle de vie.
- Clavier naturel avec attente de la file d'entrée.
- Montage/démontage des images.
- Capture écran déterministe.
- Lecture/écriture de la fenêtre mémoire 64K courante.
- Construction de DSK via ToolShed.
- Outils MCP déjà nommés et testés.
- Tests TypeScript sur le protocole, les chemins, les outils et les erreurs.

## Limites et risques

### Maturité

- Trois commits publics au moment de l'évaluation.
- Aucun historique d'issues ou de pull requests.
- Faible activité et nombre de contributeurs.
- Présentation partielle comme application générée avec assistance agentique.

### Couverture de validation

- Les 49 tests sont principalement unitaires ou basés sur mocks.
- Le dépôt ne contient pas de test end-to-end qui lance réellement MAME.
- La réussite de `coco_type` signifie que le tampon clavier est vide, pas que
  BASIC a exécuté correctement une commande.
- Une capture PNG prouve le rendu, pas encore la sémantique du résultat.

### Cycle de vie et stockage

- Le média monté est utilisé directement ; il n'existe pas de copie isolée
  automatique par scénario.
- Le serveur maintient une session MAME persistante plutôt qu'une exécution
  synchrone à preuve isolée.
- Les options de save/load state existent alors que MAME 0.289 déclare ce driver
  avec `savestate="unsupported"` ; elles ne sont pas équivalentes à une preuve de
  restauration fiable.

### Dépendances

`npm audit` relève huit vulnérabilités dans l'installation évaluée, dont trois
de gravité élevée. Elles touchent notamment :

- `@modelcontextprotocol/sdk` 1.30.0 ;
- `zod` 3.25.76 ;
- des dépendances HTTP transitives.

Le serveur utilise stdio et le pont est restreint à localhost, ce qui réduit
l'exposition de plusieurs alertes orientées HTTP. Cela n'élimine pas le besoin
d'une mise à niveau contrôlée avant usage durable.

### Adéquation documentaire

Le fichier `AGENTS.md` du candidat référence plusieurs documents qui ne sont
pas présents dans le dépôt consulté. Son corpus documentaire n'est donc pas
encore aussi cohérent que son code.

## Recommandation

Recommandation : **forker le projet dans le compte GitHub du propriétaire comme
implémentation candidate**, mais ne pas encore remplacer le dépôt et le corpus
du laboratoire.

Raisons :

1. Le socle évite de réinventer le pont Node/Lua déjà fonctionnel.
2. Il a été validé avec le même MAME 0.289, les mêmes ROMs et `hello.dsk`.
3. MIT permet l'évolution indépendante.
4. La taille du code reste adaptée à un projet éducatif.
5. Le fork n'impose pas d'adopter d'emblée la totalité du serveur comme produit.

## Conditions avant adoption comme base

1. Mettre à jour le SDK MCP et vérifier la compatibilité par la suite complète.
2. Ajouter une preuve end-to-end réelle qui lance MAME, copie une DSK, fait
   `LOAD`/`RUN`, capture l'écran et s'arrête.
3. Ajouter un identifiant de session/scénario et un répertoire isolé par
   exécution.
4. Éviter que le montage direct verrouille ou modifie une disquette canonique.
5. Distinguer :
   - « texte envoyé » ;
   - « tampon clavier consommé » ;
   - « commande BASIC exécutée » ;
   - « résultat observé ».
6. Ajouter une observation structurée ou un oracle de test plutôt que de
   dépendre seulement d'une inspection visuelle.
7. Conserver MCP comme adaptateur au-dessus d'une couche de scénario locale.

## Stratégie de fork

Pendant le prototype :

```text
CoCo3 Revival Lab
    corpus, décisions, matériel, roadmap

CoCo3_MCP_Server (fork)
    implémentation candidate Node/TypeScript/Lua
```

Le fork peut devenir l'implémentation principale après validation des conditions
ci-dessus. D'ici là, notre dépôt conserve la vérité produit et les décisions.

## Non-recommandations

- Ne pas copier les 14 outils sans les tester.
- Ne pas modifier simultanément le dépôt actuel et le fork sans motif.
- Ne pas considérer les tests unitaires comme une preuve MAME réelle.
- Ne pas présenter les save states comme fiables tant que MAME ne supporte pas
  officiellement cette capacité pour `coco3`.
