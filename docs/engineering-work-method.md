# Méthode de travail pragmatique

## Principes

1. **Résoudre le besoin réel.** Chercher le changement le plus simple qui
   réduit le risque sans créer de mécanisme spéculatif.
2. **Viser 80 % de valeur pour 20 % d'effort.** Arrêter dès que les preuves
   nécessaires à la décision sont obtenues.
3. **Choisir le bon moment.** Corriger maintenant si le coût marginal est
   raisonnable et si différer crée du travail jetable. Reporter si le problème
   est peu probable, isolé et réversible.
4. **Éviter la complexité accidentelle.** Préférer les outils, contrats et
   conventions déjà présents. Ne pas ajouter de couche, d'abstraction ou de
   configuration sans besoin observé.
5. **Défier le perfectionnisme.** Accepter un compromis local pour une
   catégorie de « beaux problèmes » qui ne croise pas les usages actuels, à
   condition de noter la limite et le déclencheur qui justifiera une reprise.
6. **Laisser une trace sobre.** Une décision, ses raisons, ses preuves et sa
   prochaine action doivent pouvoir être retrouvées sans mémoire implicite.

## Coût maintenant ou plus tard

Avant de lancer une correction, répondre à ces quatre questions :

- Quel impact concret si elle est faite maintenant ?
- Quel coût ou risque si elle est repoussée ?
- Reporter évite-t-il vraiment du travail, ou en prépare-t-il davantage ?
- Quelle condition objective rendra la reprise nécessaire ?

Si la dernière question a une réponse vérifiable, différer peut être le bon
choix. Créer alors une issue courte et priorisée, avec l'hypothèse et le
déclencheur de reprise.

## Tests proportionnés

Un test doit protéger un comportement, un contrat ou une frontière. Il ne doit
pas recopier l'implémentation ni doubler une preuve existante.

- Préserver l'orthogonalité : un scénario par risque distinct.
- Préférer compléter un test existant à en ajouter un qui couvre le même chemin.
- Lorsqu'un comportement change, adapter ou retirer les assertions devenues
  obsolètes.
- Réexaminer périodiquement les tests coûteux, instables, redondants ou sans
  utilisateur clair.
- Vérifier d'abord avec le niveau le plus petit qui réfute la régression
  plausible, puis élargir si le risque ou le résultat le justifie.

## Définition d'une preuve utile

Une preuve mentionne au minimum la commande exacte, le résultat, le périmètre
observé et les limites restantes. Une validation manuelle précise le scénario,
le résultat attendu et le résultat obtenu. Une commande qui n'a pas été
exécutée ne constitue pas une validation.

## Limites d'autonomie

Un agent peut analyser, classer, tester, préparer une branche, commenter avec
des preuves et proposer une PR. La fusion, le rejet d'un signal de sécurité, le
changement de réglages de dépôt et la publication vers upstream restent des
décisions humaines explicites.
