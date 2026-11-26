# Labels GitHub

## Règle générale

Utiliser peu de labels, orthogonaux et lisibles :

- **priorité** : quand agir ;
- **area** : où se trouve le changement ;
- **track** : fork laboratoire ou candidat upstream ;
- **statut exceptionnel** : pourquoi le travail ne progresse pas normalement ;
- **type existant GitHub** : bug, enhancement, documentation, dependencies.

Ne pas multiplier les synonymes ni reproduire la priorité dans le titre.

## Priorités

- `priority:P1` : bloque le prochain jalon ou expose un risque concret qui
  requiert une action immédiate.
- `priority:P2` : nécessaire à un objectif précis, mais contournable ou non
  bloquant.
- `priority:P3` : intérêt utile mais reportable, irritant ou opportunité
  d'amélioration.

Une issue sans priorité n'est pas considérée triée. Les PR Dependabot de faible
risque peuvent rester sans P1/P2/P3 si elles sont traitées immédiatement ; une
PR différée reçoit une priorité sur l'issue de suivi.

## Taxonomie initiale

Conserver les labels déjà en place lorsqu'ils apportent une information claire :

- `area:tests`, `area:workflow`, `area:mame`, `area:security` ;
- `track:lab`, `track:upstream` ;
- `dependencies`, `javascript` ;
- `bug`, `enhancement`, `documentation`, `duplicate`, `question`.

Ajouter uniquement :

- `priority:P1`, `priority:P2`, `priority:P3` ;
- `status:blocked` : une dépendance externe empêche l'action ;
- `status:deferred-upstream` : correction reportée à une publication upstream
  identifiée.

## Revue

Revoir cette liste lorsqu'une répétition de triage révèle un angle manquant.
Ajouter un label seulement s'il change une décision, filtre une file de travail
ou remplit une automatisation vérifiable. Supprimer ou fusionner les labels qui
restent inutilisés.
