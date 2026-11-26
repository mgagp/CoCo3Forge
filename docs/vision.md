# Vision produit

## Pourquoi

Faire revivre un **Color Computer 3** comme plateforme d’expérimentation moderne, en combinant:
- nostalgie technique
- contrôle matériel pilotable par API
- workflow local efficace pour humains + agents IA

## Finalité utilisateur (dans la vraie vie)

Permettre à une personne de:
1. contrôler un CoCo 3 réel depuis un PC (disque, clavier, reset, etc.),
2. itérer rapidement via émulateur + pipeline local,
3. déployer ensuite sur la machine physique,
4. expérimenter sur du logiciel rétro (démos, jeux, langage Forth perso, outillage),
5. partager les résultats avec la communauté.

## Vision long terme

Créer un socle de contrôle “agentique” du CoCo 3, suffisamment complet pour qu’un agent IA puisse exécuter des tâches de bout en bout (chargement, exécution, observation, recovery).

## Principes directeurs

- Projet éducatif, solo et AI-first (« iFirst ») ; la cible n'est pas une qualité
  industrielle.
- **Priorité #1: interface disque**.
- MAME est l'émulateur principal ; un autre émulateur n'est évalué que sur
  signal concret de blocage.
- Simplicité documentaire: lisible par humain et agent froid.
- Itération pragmatique: preuves rapides, instrumentation claire, décisions traçables.
- Séparer hypothèses vs faits validés.
- Privilégier des interfaces robustes plutôt que des optimisations précoces.
- Travailler en fronts parallèles: hardware, software/toolchain, recherche documentaire.
- Ne rien prendre pour acquis: toute hypothèse importante doit être validée et journalisée.

## Mode d’exécution

- Rythme cible: petites avancées hebdomadaires (trame de fond durable).
- Découpage fin: inclure explicitement les étapes “évidentes” (inventaire, setup, câbles, tests de base).
- Plan global + sous-découpage adaptatif selon apprentissages.
- Gestion active des risques: inconnus connus + inconnus inconnus.
