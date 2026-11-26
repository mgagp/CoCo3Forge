# Roadmap (v1)

## Vue globale

Le projet progresse en parallèle sur:
- Track H: hardware
- Track S: software/toolchain
- Track R: recherche/documentation

## Phase 1 — Baseline et inventaire

### H
- Sortir le CoCo 3 de la boîte et faire le setup régulier.
- Vérifier alimentation/câblage de base.
- Inventorier le hardware disponible.
- Tester le contrôleur disque existant.

### S
- Utiliser MAME comme émulateur principal sur Windows.
- Définir un build local minimal.
- Valider un scénario MAME minimal et reproductible.

### R
- Démarrer la veille documentaire et communautaire.

## Phase 2 — Faisabilité des interfaces

### H
- Valider options disque (USB/SD, RS232, autre).
- Cadrer options clavier (incluant piste Y).
- Cadrer reset soft/hard et piste debug stop/step.

### S
- Construire A0: session MAME dédiée, observation et preuves.
- Construire A1/A2: charger puis créer Hello World par agent.
- Définir protocole de test des commandes selon
  [agent-automation-roadmap.md](C:/project/coco3/docs/agent-automation-roadmap.md).

### R
- Cartographier les références techniques des composants CoCo 3.

## Phase 3 — Première intégration

### H
- Prototyper un premier scénario de contrôle matériel.
- Valider une stratégie d’observation d’affichage.

### S
- Stabiliser une mini-surface API synchrone locale.
- Lancer des tests de robustesse et recovery.

### R
- Consolider les preuves et décisions en ADR.

## Phase 4 — Montée en maturité

- Surface API stable
- Scripts de tests end-to-end
- Réévaluer MCP seulement après validation des primitives locales

## Phase 5 — Expérimentation logicielle

- Démos graphiques simples
- Études ROM/Disk BASIC/Extended BASIC
- Relance projets historiques (ex: Forth personnel)

## Phase 6 — Partage communauté

- Packaging des résultats
- Choix plateforme de publication
- Plan de communication
