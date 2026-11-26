# Workflow GitHub - fork CoCo3 MCP

## Rôles des dépôts

- `coco3` : corpus produit, décisions, roadmap, recherche, documentation
  matériel et scénarios du laboratoire.
- `mgagp/CoCo3_MCP_Server` : implémentation candidate du serveur MAME/MCP.

Le dépôt d'implémentation est un fork de
<https://github.com/dbowlin/CoCo3_MCP_Server>.

## Authentification de l'agent

Le poste utilise actuellement `gh` authentifié comme `mgagp`, avec les droits
administrateur sur le fork. Le jeton reste dans le coffre de GitHub CLI/Windows
et ne doit pas être copié dans un fichier, un prompt permanent, une issue ou le
dépôt.

Si un jeton dédié agent est requis (autre machine, runner externe ou séparation
des accès), créer un fine-grained Personal Access Token limité au seul fork :

- **Nom recommandé** : `coco3-mcp-agent-maintenance-full` ;
- **Expiration** : 30 à 90 jours (rotation régulière) ;
- **Resource owner** : `mgagp` ;
- **Repository access** : `Only select repositories` puis
  `mgagp/CoCo3_MCP_Server`.

Permissions recommandées pour couvrir workflows, sécurité/qualité, issues et PR :

- Metadata: lecture (obligatoire, imposé) ;
- Actions: lecture/écriture ;
- Contents: lecture/écriture ;
- Issues: lecture/écriture ;
- Pull requests: lecture/écriture ;
- Commit statuses: lecture/écriture ;
- Code scanning alerts: lecture/écriture ;
- Dependabot alerts: lecture/écriture ;
- Secret scanning alerts: lecture/écriture.

Ne pas accorder Administration ni Secrets repository/org sans besoin concret.

Les workflows GitHub utilisent leur `GITHUB_TOKEN` avec contenu en
lecture seule.

### Navigation GitHub (création du PAT)

1. Ouvrir GitHub `Settings` (profil) > `Developer settings`.
2. Aller dans `Personal access tokens` > `Fine-grained tokens`.
3. Cliquer `Generate new token`.
4. Renseigner le nom recommandé, la date d'expiration et le dépôt ciblé.
5. Appliquer les permissions listées ci-dessus.
6. Générer le token et le copier une seule fois dans un coffre sécurisé.

### Activation pour les sessions locales

Sur le poste local, privilégier le coffre `gh` (Credential Manager) :

```powershell
gh auth login --hostname github.com --with-token
gh auth status
gh auth setup-git
```

Alternative temporaire pour une session non interactive :

```powershell
$env:GH_TOKEN = "<PAT_FINE_GRAINED>"
gh auth status
```

Ne jamais versionner le token, ni l'écrire dans un fichier du dépôt.

## Branches

- `main` : miroir de `upstream/main`, synchronisé régulièrement.
- `lab` : branche d'intégration du laboratoire et branche par défaut du fork.
- `feat/*`, `fix/*`, `test/*`, `chore/*` : branches courtes, supprimées après
  merge.

Un changement générique candidat upstream part de `upstream/main`. Un changement
spécifique au laboratoire part de `lab`.

## Issues et pull requests

Chaque changement non trivial commence par une issue. La pull request :

- référence l'issue ;
- a un seul objectif ;
- indique si elle est candidate upstream ou spécifique au laboratoire ;
- contient les commandes exactes de validation ;
- ne contient aucun secret, ROM, DSK modifiable canonique, log ou snapshot
  personnel.

Une PR est privilégiée à un push direct, même en solo. L'approbation obligatoire
n'est pas exigée dans la phase solo, mais les vérifications CI doivent être
vertes.

## Configuration GitHub retenue

- issues activées ;
- branche par défaut : `lab` ;
- squash merge uniquement ;
- suppression automatique des branches après merge ;
- secret scanning et push protection ;
- alertes Dependabot et mises à jour de sécurité ;
- workflow token en lecture seule ;
- Actions limitées ensuite par des règles si un besoin de tiers apparaît.

## Flux upstream

```text
upstream/main
    |
    +--> origin/main          miroir du fork
    |
    `--> feature générique ---> PR vers upstream

lab
  `--> feature lab ---------> PR vers le fork

origin/main
  `--> merge vers lab         réintégration upstream
```

Les changements génériques ne doivent pas dépendre des conventions, chemins,
fixtures ou décisions propres à ce laboratoire. Une divergence qui ne peut être
proposée upstream est documentée comme telle.

## Niveau d'autonomie de l'agent

L'agent peut :

- lire le fork et l'upstream ;
- créer des branches locales ;
- créer et mettre à jour des issues ;
- pousser une branche de travail ;
- ouvrir une pull request ;
- exécuter tests/builds ;
- lire les alertes Dependabot et workflows.

La décision humaine reste nécessaire pour :

- changer des réglages destructifs ou la visibilité ;
- approuver les accès à de nouveaux dépôts/secrets ;
- proposer une PR à l'upstream après revue du diff ;
- fusionner une PR ;
- publier une release ;
- autoriser un workflow externe ou une action non encore validée.

## Mini-roadmap initiale

1. Bootstrap gouvernance, templates et remotes.
2. Ajouter CI Node 20 (`npm ci`, tests, build).
3. Ajouter un test end-to-end réel MAME/Hello World.
4. Isoler copies de DSK, configuration, NVRAM et snapshots par session.
5. Mettre à niveau les dépendances de sécurité.
6. Extraire les améliorations génériques et les proposer upstream.
