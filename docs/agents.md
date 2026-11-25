# Protocole agent froid

Ce document définit comment un agent (Copilot, Claude, etc.) reprend efficacement le travail sans contexte implicite.

## Ordre de lecture minimal

1. [vision.md](C:/project/coco3/docs/vision.md)
2. [product-spec.md](C:/project/coco3/docs/product-spec.md)
3. [current-state.md](C:/project/coco3/docs/current-state.md)
4. Dernière session dans [sessions/](C:/project/coco3/docs/sessions/)
5. Dernière rétro dans [retrospectives/](C:/project/coco3/docs/retrospectives/)
6. Décisions dans [decisions/](C:/project/coco3/docs/decisions/)

## Règles d’écriture (discoverability)

- Une info importante = un endroit clair (pas de duplication diffuse).
- Séparer:
  - **Faits validés**
  - **Hypothèses**
  - **Questions ouvertes**
- Toujours inclure:
  - date
  - source de validation (test, mesure, photo, log, doc)
  - prochaine action concrète

## Progressive disclosure pragmatique

### Niveau 1 (2-5 minutes)
- Vision, état actuel, prochain objectif immédiat.

### Niveau 2 (10-20 minutes)
- Détails techniques de la session active + risques.

### Niveau 3 (référence)
- Historique complet des décisions, essais et artefacts.

## Format de sortie recommandé en fin de session

1. Note de session (template)
2. Rétro (template)
3. Mise à jour état courant
4. Si nécessaire, création d’une décision (ADR légère)

## Place du verbatim (recommandée)

Le verbatim vaut la peine pour:
- préserver l’intention originale,
- garder une trace historique utile,
- permettre une extraction future de signaux (priorités, contraintes, risques, décisions implicites).

Règle pratique: stocker du verbatim **court et ciblé** (extraits), pas des transcriptions massives par défaut.

À chaque extrait, ajouter:
- source/date,
- thème,
- pourquoi cet extrait est important,
- tags de recherche.
