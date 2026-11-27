# CoCo3Forge

![CoCo3Forge logo](./media/logo-coco3forge.svg)

**An AI-first retrocomputing laboratory**

Un laboratoire pour créer, expérimenter et faire revivre le **Tandy Color
Computer 3**, sur émulateur comme sur matériel réel.

## Positionnement

Le projet comporte deux volets complémentaires:

1. **Volet MCP (fork upstream validé localement)**  
   Industrialiser un chemin de contrôle agentique basé MCP pour l'émulation.
2. **Volet laboratoire hardware/API**  
   Concevoir progressivement une façade d'API commune pouvant cibler un CoCo 3
   simulé ou réel.

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
3. Lire la [méthode de travail](C:/project/coco3/docs/engineering-work-method.md)
4. Vérifier l’état courant dans [current-state.md](C:/project/coco3/docs/current-state.md)
5. Créer/mettre à jour une note de session avec [SESSION_TEMPLATE.md](C:/project/coco3/docs/sessions/SESSION_TEMPLATE.md)
6. Clore la session avec une rétro via [RETRO_TEMPLATE.md](C:/project/coco3/docs/retrospectives/RETRO_TEMPLATE.md)
7. Pour le test local via MCP, suivre [mcp-local-smoke-test.md](C:/project/coco3/docs/mcp-local-smoke-test.md)
8. Pour un démarrage agent à froid, suivre [mcp-cold-start.md](C:/project/coco3/docs/mcp-cold-start.md)

## Structure documentaire

- [docs/](C:/project/coco3/docs/)
  - [vision.md](C:/project/coco3/docs/vision.md): vision produit et finalité
  - [product-spec.md](C:/project/coco3/docs/product-spec.md): périmètre, priorités, contraintes
  - [plan-de-match.md](C:/project/coco3/docs/plan-de-match.md): exécution complète par étapes
  - [agents.md](C:/project/coco3/docs/agents.md): protocole “agent froid”
  - [engineering-work-method.md](C:/project/coco3/docs/engineering-work-method.md): principes de décision, dette et tests proportionnés
  - [dependency-upgrade-workflow.md](C:/project/coco3/docs/dependency-upgrade-workflow.md): analyse et validation des PR de dépendances
  - [security-quality-triage.md](C:/project/coco3/docs/security-quality-triage.md): triage des alertes, faux positifs et issues
  - [upstream-contribution-policy.md](C:/project/coco3/docs/upstream-contribution-policy.md): participation communautaire au projet original
  - [mcp-local-smoke-test.md](C:/project/coco3/docs/mcp-local-smoke-test.md): procédure locale de validation `Hello` via le fork MCP
  - [github-labels.md](C:/project/coco3/docs/github-labels.md): priorités et taxonomie GitHub
  - [cloud.md](C:/project/coco3/docs/cloud.md): conventions cloud/outillage distant
  - [mcp-cold-start.md](C:/project/coco3/docs/mcp-cold-start.md): repère unique pour chemins locaux + validation rapide MCP
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

Les points d'entrée [AGENTS.md](C:/project/coco3/AGENTS.md),
[CLAUDE.md](C:/project/coco3/CLAUDE.md), Copilot et Cursor renvoient tous vers
ce corpus commun afin d'éviter des règles divergentes.
