# Contribution au projet upstream

## Intention

Le fork sert les besoins du laboratoire sans oublier que le projet original a
été créé par un auteur dont le temps doit être respecté. Le principe est de
restituer les améliorations génériques utiles et de conserver localement ce qui
est expérimental, spécifique ou encore insuffisamment mûr.

## Candidat upstream

Un changement est candidat upstream s'il :

- corrige un défaut reproductible ou améliore un contrat général ;
- fonctionne sans chemin, outil, média, secret ou hypothèse propres au
  laboratoire ;
- peut être expliqué, revu et testé avec un périmètre limité ;
- profite à l'auteur ou à d'autres utilisateurs du projet ;
- n'embarque pas plusieurs sujets ni une refonte opportuniste.

Les améliorations du fork doivent être décomposées : remonter la part générique
et conserver séparément l'adaptation laboratoire.

## Déroulement communautaire

1. Vérifier les issues et PR upstream récentes pour éviter un doublon.
2. Pour une correction petite et évidente, préparer une PR ciblée.
3. Pour un changement majeur, une orientation ou une rupture, ouvrir d'abord
   une discussion ou une issue concise afin d'aligner la solution.
4. Partir de la branche attendue par upstream, habituellement `upstream/main`,
   sans empiler les commits propres au fork.
5. Expliquer le problème, la reproduction, le choix effectué, la validation et
   les limites ; ne pas imposer une automatisation ou une architecture.
6. Répondre aux retours sans modifier hors sujet. Si les avis divergent,
   accepter la décision du mainteneur ou maintenir le besoin dans le fork.

## Tester la disponibilité du mainteneur

Une première contribution petite sert aussi à mesurer si une collaboration est
possible. La PR ou l'issue précise que la contribution est prête à être adaptée
aux préférences upstream, sans demander une intégration immédiate.

Suivre ce cycle :

1. Attendre 14 jours calendaires sans relance répétée.
2. Si nécessaire, ajouter un rappel unique, bref, avec le lien vers les preuves.
3. Après 30 jours sans réaction, classer le résultat « pas de signal observable »
   et orienter les nouvelles maintenances vers le fork.
4. En cas de refus explicite ou de préférence contraire du mainteneur, respecter
   cette décision et poursuivre le besoin dans le fork.
5. Si le mainteneur répond, corrige, demande des changements ou valide l'issue,
   continuer la voie collaborative.

L'absence de réponse sur une seule contribution n'interdit pas une future
tentative utile. Elle change simplement le mode par défaut : ne pas bloquer le
fork dans l'attente d'une décision upstream. Conserver le lien, limiter la
divergence et resynchroniser lorsqu'upstream intègre une solution équivalente.

## Ce qui reste dans le fork

Garder dans le fork les prototypes, choix locaux, médias, chemins,
configurations MAME, workflows agentiques et expériences non encore utiles à la
majorité. Une adaptation temporaire peut rester dans le fork si elle attend une
version ou une décision upstream ; la documenter avec `track:upstream` et un
lien de suivi.

## Mise à niveau des dépendances

Une PR Dependabot du fork ne crée pas automatiquement une PR upstream. Avant de
proposer :

- vérifier si upstream a déjà intégré une version équivalente ;
- estimer si la mise à niveau résout un défaut ou une alerte réelle pour lui ;
- isoler les changements de manifeste, lockfile et migration nécessaires ;
- éviter de transférer des contraintes propres au fork ;
- intégrer une solution upstream disponible plutôt que maintenir un doublon.

Si upstream absorbe le correctif, synchroniser le fork et fermer les PR
locales rendues obsolètes.

## Responsabilité et attribution

Préserver l'historique, la licence, les notices et l'attribution existante. Ne
jamais inclure de secret, donnée personnelle, ROM, média, résultat local ou
élément dont la diffusion n'a pas été validée.

Un agent peut préparer le diagnostic, la branche, les tests et un brouillon.
Un humain relit le diff, confirme la valeur pour upstream et autorise l'envoi
de la PR ou du commentaire.

## Trace minimale

```text
Sujet unique: défaut ou amélioration générale
Raison pour upstream: valeur pour le projet commun
Portée: fichiers et contrats concernés
Validation: commandes et résultats
Spécificités lab exclues: confirmation
Lien upstream/fork: issue ou PR correspondante
Décision humaine: prête / à discuter / fork uniquement
```
