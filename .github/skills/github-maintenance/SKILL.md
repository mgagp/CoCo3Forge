---
name: github-maintenance
description: Triage et préparation de PR de dépendances ou d'alertes sécurité/qualité dans le fork CoCo3 MCP.
---

# Maintenance GitHub

Utiliser ce skill lorsqu'une PR Dependabot, une alerte Dependabot, un signal
CodeQL, secret scanning ou qualité doit être trié.

## Choisir la procédure

- Mise à niveau de dépendance :
  suivre [dependency-upgrade-workflow.md](../../../docs/dependency-upgrade-workflow.md).
- Alerte sécurité ou qualité :
  suivre [security-quality-triage.md](../../../docs/security-quality-triage.md).
- Contribution au projet original :
  suivre [upstream-contribution-policy.md](../../../docs/upstream-contribution-policy.md).
- Dans tous les cas, appliquer [github-labels.md](../../../docs/github-labels.md).

## Résultat attendu

Laisser une décision explicite et traçable : correction validée, issue de
suivi, attente upstream documentée ou faux positif justifié. Inclure la preuve
de validation exacte et ne jamais déclarer un résultat non reproduit.
