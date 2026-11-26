# ADR-0002 - Validation agentique par session MAME dédiée

## Contexte

Le projet doit tester comment un agent hôte peut interagir avec un CoCo 3
émulé. MAME offre une API Lua riche, mais aucune couche projet n'existe encore.
Une instance MAME interactive peut aussi être ouverte pendant l'apprentissage.

## Décision

- Les premiers scénarios utilisent un processus MAME dédié lancé par l'agent.
- Lua est la couche d'adaptation dans MAME.
- Python standard-library est le lanceur hôte initial.
- Le contrat est synchrone, local, versionné et produit des preuves dans des
  fichiers.
- MCP n'est pas introduit pendant les jalons A0 à A3.
- Le choix de transmettre une API par MCP sera réévalué après stabilisation des
  opérations locales.

## Alternatives considérées

- Piloter l'interface utilisateur de la fenêtre MAME avec le souris/clavier de
  l'hôte : plus fragile, dépendant du focus et peu adapté comme première
  architecture.
- Démarrer immédiatement un serveur MCP : ajoute transport, cycle de vie et
  sécurité avant que les opérations MAME utiles soient validées.
- Placer toute la logique dans Python avec capture de fenêtre : dépendant de
  l'OS et moins proche de l'état interne disponible à Lua.

## Conséquences

- Positives:
  - Une preuve peut être relancée de façon isolée.
  - Les actions utilisent les API MAME plutôt que des coordonnées d'écran.
  - Le futur transport API/MCP peut rester remplaçable.
- Négatives/risques:
  - L'API Lua MAME n'est pas déclarée stable.
  - Le lancement d'une session dédiée n'est pas encore un contrôle d'une
    instance interactive existante.
  - La validation par capture écran demandera éventuellement une observation
    plus structurée que des pixels.

## Validation

La décision est validée si A0 produit deux fois un résultat JSON, une capture
et un arrêt propre sans interaction humaine.
