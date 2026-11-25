# Coco3 Revival Lab

Guide local pour concevoir et documenter des interfaces de contrôle d’un **Tandy Color Computer 3 (CoCo 3)** depuis un PC, avec une approche progressive: d’abord le contrôle matériel, ensuite l’expérimentation logicielle.

## Objectifs

1. Concevoir une surface d’API pour piloter le CoCo 3:
   - stockage/disque
   - clavier (injection de touches)
   - reset (soft/hard)
   - exécution/arrêt (incluant pistes debug/step)
2. Établir une méthode documentaire simple pour sessions humaines + agents IA “froids”.
3. Construire un flux de travail local: recherche, prototypage, tests, émulation, puis validation sur machine physique.

## Démarrage rapide (méthode)

1. Lire [vision.md](C:/project/coco3/docs/vision.md)
2. Lire [agents.md](C:/project/coco3/docs/agents.md)
3. Vérifier l’état courant dans [current-state.md](C:/project/coco3/docs/current-state.md)
4. Créer/mettre à jour une note de session avec [SESSION_TEMPLATE.md](C:/project/coco3/docs/sessions/SESSION_TEMPLATE.md)
5. Clore la session avec une rétro via [RETRO_TEMPLATE.md](C:/project/coco3/docs/retrospectives/RETRO_TEMPLATE.md)

## Structure documentaire

- [docs/](C:/project/coco3/docs/)
  - [vision.md](C:/project/coco3/docs/vision.md): vision produit et finalité
  - [product-spec.md](C:/project/coco3/docs/product-spec.md): périmètre, priorités, contraintes
  - [plan-de-match.md](C:/project/coco3/docs/plan-de-match.md): exécution complète par étapes
  - [agents.md](C:/project/coco3/docs/agents.md): protocole “agent froid”
  - [cloud.md](C:/project/coco3/docs/cloud.md): conventions cloud/outillage distant
  - [current-state.md](C:/project/coco3/docs/current-state.md): statut matériel/logiciel actuel
  - [roadmap.md](C:/project/coco3/docs/roadmap.md): étapes progressives
  - [status-board.md](C:/project/coco3/docs/status-board.md): suivi multi-fronts
  - [checklists/](C:/project/coco3/docs/checklists/): checklists opérationnelles
  - [sessions/](C:/project/coco3/docs/sessions/): notes de sessions
  - [verbatims/](C:/project/coco3/docs/verbatims/): extraits sources et cadrage historique
  - [retrospectives/](C:/project/coco3/docs/retrospectives/): rétrospectives de fin de session
  - [decisions/](C:/project/coco3/docs/decisions/): décisions d’architecture et de méthode

## Règle d’or

Chaque session doit laisser un contexte exploitable sans mémoire implicite:
- intention
- état de départ
- changements
- validation
- prochaines actions
- rétro et recommandations process
