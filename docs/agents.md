# Protocole agent froid

Ce document définit comment un agent (Copilot, Claude, etc.) reprend efficacement le travail sans contexte implicite.

## Attention à la dictée vocale

L'utilisateur emploie un outil de dictée qui peut transcrire incorrectement ce
qu'il tente d'exprimer. Si une formulation paraît étrange, contradictoire ou
hors contexte, ne pas l'interpréter immédiatement au pied de la lettre.
L'agent doit d'abord la reconsidérer :

- phonétiquement (rechercher un mot ou un acronyme proche à l'oral) ;
- contextuellement (selon le projet, la phrase et les décisions connues) ;
- en retenant l'interprétation la plus cohérente.

En cas d'ambiguïté importante après cette relecture, demander une confirmation
et proposer l'interprétation probable. Exemple : « iFirst » doit être compris
comme « AI-first » dans ce projet.

## Ordre de lecture minimal

1. [vision.md](C:/project/coco3/docs/vision.md)
2. [product-spec.md](C:/project/coco3/docs/product-spec.md)
3. [current-state.md](C:/project/coco3/docs/current-state.md)
4. [mcp-cold-start.md](C:/project/coco3/docs/mcp-cold-start.md)
5. [mcp-local-smoke-test.md](C:/project/coco3/docs/mcp-local-smoke-test.md)
6. Dernière session dans [sessions/](C:/project/coco3/docs/sessions/)
7. Dernière rétro dans [retrospectives/](C:/project/coco3/docs/retrospectives/)
8. Décisions dans [decisions/](C:/project/coco3/docs/decisions/)

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

## Politique de langue du projet

Objectif: garder un corpus lisible pour l'équipe et pour les agents, sans
double maintenance.

### Règles de base

1. **Une seule langue par document** (pas de mélange FR/EN au fil du texte).
2. **Respecter la langue existante du document** ; ne pas basculer
   spontanément.
3. **Pas de traduction parallèle systématique** d'un même contenu.
4. **Noms techniques en anglais**: API, fonctions, symboles, identifiants,
   noms de fichiers techniques.
5. **Conventions de commit et code**: anglais pour le code et les messages
   exposés publiquement.

### Cible par type de contenu

- **Public/externe (anglais)**:
  - README principal
  - guides d'utilisation partagés
  - issues/PR GitHub
  - ADR de référence destinés au partage
- **Exploration interne (français)**:
  - notes de laboratoire
  - journaux d'expérimentation
  - brouillons d'architecture et réflexions de travail

### Règle agentique explicite

Quand un agent crée ou modifie un document:

- il conserve la langue du document ;
- il applique les termes techniques déjà utilisés dans le projet ;
- il n'introduit pas de seconde version traduite sauf demande explicite.

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
