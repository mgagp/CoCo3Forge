# ADR-0001 - MAME comme émulateur principal

## Contexte

Le projet doit permettre à un agent de piloter et d'observer un CoCo 3 de façon
reproductible. Le contexte cible est un PC Windows.

Le projet est éducatif, réalisé en mode solo et AI-first. La priorité est de
faire progresser une chaîne de travail utile, pas de construire ou de valider
une solution de qualité industrielle.

## Décision

- MAME est l'émulateur principal du projet.
- La baseline, l'orchestration, les tests et les futures intégrations agentiques
  reposent d'abord sur MAME.
- Aucun émulateur complémentaire ne fait partie du plan de base.
- Un autre émulateur pourra être évalué seulement si une difficulté concrète
  avec MAME produit un signal clair justifiant cet effort.
- Cette évaluation ponctuelle ne devient pas une règle de validation croisée.

## Alternatives considérées

- Utiliser XRoar comme émulateur principal : moins bien aligné avec le besoin
  global de scripting et de contrôle agentique.
- Maintenir MAME et XRoar en parallèle : rejeté, car la dilution de l'effort ne
  sert pas les objectifs fondamentaux de ce projet.

## Conséquences

- Positives:
  - Un seul environnement à installer, comprendre et automatiser.
  - Une roadmap plus directe vers la baseline logicielle et l'API exploratoire.
  - Les scripts, preuves et conventions sont concentrés sur MAME.
- Négatives/risques:
  - Certaines limites propres à MAME seront découvertes plus tard.
  - Une fonctionnalité plus pratique dans un autre émulateur ne suffit pas, à
    elle seule, à ouvrir un second chantier ; il faut un blocage identifié.

## Validation

La décision est tenue lorsque :

1. MAME Windows peut lancer le profil CoCo 3 de façon reproductible.
2. Un scénario minimal peut être piloté sans interaction manuelle.
3. Le scénario produit une observation vérifiable.
4. Aucune preuve de blocage ne justifie une étude d'un autre émulateur.
