# Triage sécurité et qualité

## Préparer le lot

Regrouper d'abord les signaux qui ont la même cause, le même paquet ou le même
appel. Un seul correctif ou une seule issue suffit pour plusieurs alertes si le
périmètre et la clôture attendue de chacune sont explicites.

## Pour chaque signal

1. Confirmer l'emplacement et le flux de données réellement atteignable.
2. Évaluer l'exploitabilité dans ce projet, pas seulement la sévérité générale
   de l'avis.
3. Chercher un correctif existant, une nouvelle configuration ou une mise à
   niveau du composant parent.
4. Classer le résultat :
   - **corriger maintenant** ;
   - **créer une issue analysée** si conception ou migration ;
   - **attendre upstream** avec déclencheur de reprise ;
   - **faux positif** ou risque non applicable, avec preuve.
5. Laisser une trace dans le signal GitHub, l'issue ou la PR liée.

## Priorité

- `P1` : vulnérabilité exploitable ou défaut bloquant sur le chemin actif.
- `P2` : important pour un objectif concret, avec exposition ou impact réel
  mais contournable.
- `P3` : amélioration défensive, hygiène ou opportunité sans blocage.

La sévérité d'un outil n'est pas automatiquement la priorité du projet. La
priorité combine exploitabilité, chemin actif, impact utilisateur, effort et
possibilité de différer sans créer de dette inutile.

## Faux positifs

Un faux positif n'est déclaré que si la raison est vérifiable :

- le chemin est inatteignable dans l'architecture actuelle ;
- la contrainte ou l'assainissement existe avant l'opération sensible ;
- la dépendance n'est jamais chargée dans le contexte concerné ;
- le signal ne correspond pas à une propriété du code après inspection.

Fermer ou ignorer le signal avec sa raison précise, la fonction ou configuration
observée et le test/trace qui soutient la conclusion. Si le contexte peut
changer, créer une issue `P3` plutôt que maintenir une exemption silencieuse.

## Quand créer une issue

Créer une issue si la réponse exige une décision de conception, une migration,
plusieurs PR, une dépendance parent ou un travail différé. Inclure :

- signal(s) source(s) ;
- hypothèse d'impact ;
- preuve d'exploitabilité ou de non-impact ;
- options et recommandation ;
- priorité et labels ;
- critères de clôture ;
- validation minimale.

Une revue humaine est requise avant de fermer un signal de sécurité comme faux
positif ou de fusionner un correctif de sécurité à impact élevé.

## Automatisation de triage

L'automatisation peut collecter les alertes, dédupliquer par règle/paquet,
ajouter des labels et préparer un brouillon d'issue. Elle ne doit pas masquer,
rejeter ou fermer un signal sans preuve inspectable ni approbation humaine.

Les agents peuvent être sollicités ponctuellement ou par lot, mais chaque
résultat doit rester compatible avec une issue, une PR, un commentaire et des
commandes reproductibles ; aucun format d'agent ne doit devenir obligatoire.
L'issue doit rester exploitable par Copilot, Claude Code, Cursor ou un humain :
objectif, preuves, contraintes et critères d'acceptation dans son texte, sans
dépendre d'un identifiant ou d'un état interne propre à un client.

Une assignation à un agent prépare l'analyse et le correctif ; la responsabilité
de la décision reste attribuée à un humain avant fusion ou clôture d'un signal.
