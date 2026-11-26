# Rétrospective 2026-11-26 - Prototype MAME A0

## Ce qui a bien fonctionné
- MAME 0.289 possède suffisamment d'API Lua pour A0.
- Le lancement par processus dédié est reproductible et contrôlable.
- La séparation Python hôte / Lua MAME donne des responsabilités claires.
- Les résultats structurés permettent déjà de distinguer succès et échec.

## Ce qui a ralenti
- Une image disque utilisée par la session interactive était verrouillée sous
  Windows.
- La propriété Lua `frame_number` est une fonction dans cette version, ce qui a
  provoqué une erreur répétée dans le callback.
- `screen:snapshot()` retourne `nil` lorsqu'il réussit ; le prototype a d'abord
  interprété ce retour comme un échec.

## Signaux importants capturés
- Technique: copier le média avant montage évite les conflits et protège
  l'original.
- Technique: l'API Lua MAME doit être validée sur la version épinglée 0.289,
  pas seulement déduite de la documentation.
- Produit: la session dédiée précède le contrôle d'une fenêtre déjà ouverte.
- Méthode: l'observation, le cycle de vie et les preuves doivent être validés
  avant l'automatisation clavier.

## Recommandations d'amélioration (prochaine session)
1. Ajouter un scénario A1 avec envoi clavier séquencé.
2. Ajouter un motif ou une sonde d'état permettant d'attendre la disponibilité
   du prompt plutôt que de supposer un délai.
3. Conserver l'échec explicite et les journaux pour toute prochaine erreur Lua.

## Ajustements documentaires
- Roadmap A0 à A5 créée dans `docs/agent-automation-roadmap.md`.
- ADR-0002 créée pour la décision Python/Lua/session dédiée.
- Statut S-03/S-04 à poursuivre avec A1.
