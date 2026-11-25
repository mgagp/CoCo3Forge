# Spécification produit (v1)

## 1) Périmètre initial

### A. Contrôle disque (priorité haute)
- Évaluer le contrôleur USB/SD existant.
- Déterminer s’il suffit tel quel ou s’il faut une nouvelle interface.
- Explorer une option série (RS232) selon faisabilité.

### B. Contrôle clavier
- Injection de touches fidèle à l’entrée humaine.
- Option cible: interface en “Y” pour conserver le clavier physique + contrôle externe.

### C. Contrôle cycle machine
- Soft reset et hard reset exposés via API.
- Étudier un mécanisme d’arrêt/step CPU (debug matériel) si faisable et sûr.

### D. Observation affichage
- Option 1: capture caméra de l’écran.
- Option 2: lecture via interface matérielle dédiée.
- Décision à prendre après essais.

## 2) Architecture cible (orientation)

- Couche matérielle (microcontrôleur + interfaces physiques)
- Couche firmware/protocole
- Couche service local (backend API)
- Couche outillage (CLI/scripts/tests/agents)

Technologies backend candidates: Java, C, TypeScript (à trancher sur base de prototypes).

## 3) Modèle d’exécution (plan de match)

Le projet avance sur trois tracks parallèles:

1. **Track hardware**
   - remise en service machine,
   - inventaire matériel,
   - validation des interfaces physiques (disque, série, clavier, reset, affichage).
2. **Track software/toolchain**
   - émulateur crédible,
   - chaîne de build locale,
   - scripts de test/repro,
   - ébauche API et mode agentique.
3. **Track recherche/documentation**
   - docs ROM/BASIC/Disk/MCU,
   - veille communauté (forums, produits récents),
   - consolidation en notes exploitables.

## 4) Jalons et validations

### J0 — Baseline matérielle
- CoCo 3 sorti/raccordé/testé en mode standard.
- Inventaire hardware documenté.
- Contrôleur USB/SD identifié (marque, version, mode de connexion PC).

### J1 — Faisabilité interface disque
- Test de bout en bout du contrôleur existant.
- Décision: garder / adapter / remplacer.

### J2 — Baseline logicielle
- Émulateur choisi et validé.
- Toolchain assembleur/compilation documentée.
- Build local minimal reproductible.

### J3 — Première API exploratoire
- Backend local exposant au moins un scénario pilotable.
- Journal de validation (résultats + limites).

### J4 — Pont émulateur ↔ machine réelle
- Même scénario exécuté sur émulateur puis sur CoCo réel.
- Écart documenté et actions correctives.

## 5) Contraintes et risques

- Niveau électronique débutant côté pilotage principal (collaboration expert électronique disponible).
- Matériel CoCo 3 non encore réinstallé (dépendance de disponibilité).
- Validation physique plus lente que validation sur émulateur.
- Risques d’incompatibilités imprévues matériel/logiciel.
- Risques de dispersion: importance du focus de session et checklists.

## 6) Critères de succès (phase 1)

1. API locale capable de:
   - monter/contrôler stockage,
   - envoyer des entrées clavier,
   - déclencher reset soft/hard.
2. Procédure de test reproductible.
3. Documentation sessionnelle exploitable par un agent froid sans contexte oral.
4. Suivi d’avancement clair par track (hardware, software, recherche).
