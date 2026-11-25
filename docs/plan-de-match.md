# Plan de match complet (v1)

## Objectif

Structurer un effort hebdomadaire durable, avec un découpage explicite, des validations systématiques et une progression multi-fronts.

## Fronts parallèles

1. **HARDWARE (H)**
2. **SOFTWARE/TOOLCHAIN (S)**
3. **RECHERCHE/DOC (R)**

Chaque session choisit un focus principal (H, S ou R) et peut inclure un micro-objectif secondaire.

## Cadence hebdomadaire recommandée

- Session courte (60-120 min).
- Sortie minimale attendue:
  1. une validation (ou invalidation) factuelle,
  2. une note de session,
  3. une rétro avec 1 à 3 recommandations.

## Étapes fondatrices (ne rien sauter)

### H-00 — Remise en route physique
- Sortir le CoCo 3 de la boîte.
- Installer setup de base (écran, alimentation, câbles).
- Vérifier fonctionnement nominal.

### H-01 — Inventaire et qualification matériel
- Lister chaque composant/câble/adaptateur.
- Capturer marque/modèle/version/état.
- Noter les inconnues et besoins d’info.

### H-02 — Validation contrôleur disque existant
- Tester connectivité PC.
- Vérifier support vendeur/communauté.
- Définir verdict: garder / adapter / remplacer.

### S-00 — Baseline émulation et build
- Choisir émulateur principal.
- Installer/valider assembleur et commandes minimales.
- Produire un build de référence.

### S-01 — API exploratoire locale
- Créer une première surface API simple.
- Exécuter un scénario testable de bout en bout.

### R-00 — Veille structurée
- Cartographier ressources clés (ROM, BASIC, chipset, outils).
- Tracer liens utiles et niveau de confiance.

## Jalonisation

- **M1**: Baseline matérielle validée.
- **M2**: Baseline logicielle validée.
- **M3**: Première API exploratoire validée.
- **M4**: Premier scénario émulateur + machine réelle.

## Règle de validation

Toute étape a:
- un critère d’entrée,
- un test de sortie,
- une preuve (note, log, photo, résultat mesuré).

## Gestion des inconnus

- Classer les risques:
  - inconnus connus,
  - inconnus inconnus.
- Revoir la liste des risques à chaque rétro.
- Créer une tâche de réduction de risque si impact élevé.

## Gouvernance documentaire

- Suivi global: [status-board.md](C:/project/coco3/docs/status-board.md)
- Checklists: [checklists/](C:/project/coco3/docs/checklists/)
- Journal de session: [sessions/](C:/project/coco3/docs/sessions/)
- Rétrospectives: [retrospectives/](C:/project/coco3/docs/retrospectives/)

## Git local (quand prêt)

Déclencher l’initialisation Git locale après la première baseline documentaire stabilisée, pour versionner le corpus et les décisions sans dépendre d’un remote.
