# Traiter une PR de dépendance

## Objet

Une mise à niveau n'est pas acceptée parce que ses numéros changent ou parce
qu'une alerte disparaît. Elle est acceptée quand son impact est caractérisé et
que les comportements plausiblement exposés ont été vérifiés.

## Analyse en quatre étapes

1. **Identifier le changement**
   - direct ou transitive ;
   - runtime, construction ou test ;
   - patch, mineur ou majeur ;
   - portée du diff de manifeste et de lockfile ;
   - notes de version, migrations et prérequis upstream.
2. **Cartographier l'usage**
   - trouver les imports et points d'appel dans le dépôt ;
   - repérer protocoles, entrées/sorties, sécurité, configuration et contrats
     publics touchés ;
   - relever les tests existants qui protègent déjà ces comportements.
3. **Évaluer le moment**
   - intégrer maintenant si le correctif est isolé, utile ou faible coût ;
   - attendre une mise à niveau de la dépendance parent si elle doit absorber
     la transitive dans un horizon raisonnable et vérifiable ;
   - dans ce cas, ouvrir une issue `P2` ou `P3` avec `status:deferred-upstream`
     et le déclencheur de reprise.
4. **Décider la preuve**
   - exécuter le plus petit test pertinent, puis élargir si le risque l'exige ;
   - documenter les commandes, résultats et limites dans la PR ;
   - ajouter un test seulement si un comportement plausible n'était pas
     caractérisé.

## Profondeur de validation

| Changement | Risque | Validation minimale |
| --- | --- | --- |
| Patch de dépendance indirecte, lockfile seul, aucun chemin pertinent | Faible | Installation propre, build, test fumée ou suite ciblée existante |
| Patch de dépendance directe ou correctif de sécurité | Moyen | Validation du cas exposé, suite existante du composant, build |
| Mineur d'une API, transport, protocole ou outil de validation | Moyen à élevé | Suite complète pertinente et test de compatibilité ciblé |
| Majeur ou changement de contrat | Élevé | Analyse de migration, tests ciblés nouveaux si nécessaire, suite complète, scénario d'intégration |

Cette grille est un point de départ, pas un quota de tests. Réduire une
validation seulement si le code montre que le chemin n'est pas utilisé. Ne pas
confondre changement de chiffre sémantique et impact réel : vérifier le diff et
le contrat.

## Attente d'une mise à jour upstream

Attendre est raisonnable si la dépendance parent :

- prépare déjà une publication qui absorbe le correctif ;
- impose une contrainte empêchant une correction directe stable ;
- doit synchroniser plusieurs paquets qui forment une unité.

Ouvrir une issue plutôt que laisser une PR indéfiniment ouverte. Indiquer la
version attendue, la source upstream, la date ou condition de nouvelle
vérification et le coût de l'attente. Une attente sans déclencheur n'est pas un
plan.

## Éligibilité à une future automatisation

Une PR n'est candidate à l'auto-fusion que si :

- elle vise un patch ou un changement faiblement couplé ;
- le diff est limité aux manifestes/lockfiles attendus ;
- CI exécute au minimum installation, build et tests pertinents avec succès ;
- aucun appel public, contrat de protocole, prérequis runtime ou comportement
  de sécurité n'est modifié de manière ambiguë.

Les majeurs, changements de runtime, alertes de haute criticité exploitables et
les migrations sont soumis à revue humaine.

## Trace minimale dans la PR

```text
Impact: direct/transitif; runtime/build/test; patch/mineur/majeur
Usage affecté: fichiers ou contrats concernés
Risque: faible/moyen/élevé et raison
Décision upstream: intégrer maintenant / attendre et motif
Validation: commandes + résultats + limites
Tests: réutilisés, adaptés, ajoutés ou aucun ajout justifié
```
