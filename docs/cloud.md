# Cloud / outillage distant (v0)

Ce projet est local pour l’instant. Ce document prépare une future ouverture (wiki/site/partage).

## Principes

- Local-first: vérité documentaire dans ce repo local.
- Publication différée: on publiera seulement des contenus stabilisés.
- Traçabilité: toute publication doit pointer vers une source locale.
- Frontière linguistique claire: publication externe en anglais, exploration
  interne possible en français.

## Local machine profile (agent-friendly)

Pour les validations MCP locales, les chemins de référence sont conservés dans
[mcp-cold-start.md](C:/project/coco3/docs/mcp-cold-start.md).

Ces chemins restent un **profil local de machine** (pratique en solo), pas une
contrainte cloud. Si l'environnement change, mettre à jour ce seul point
d'entrée.

## Politique de langue pour l'ouverture publique

- **Canaux publics** (README, wiki/site, guides utilisateurs, issues/PR):
  anglais.
- **Corpus laboratoire interne**: français autorisé et encouragé pour
  l'exploration.
- Pas de miroir FR/EN systématique. La traduction est ciblée aux artefacts qui
  passent en visibilité publique.

## Candidats futurs (à décider)

- Documentation publique (wiki/site)
- Hébergement (ex: Cloudflare ou autre)
- Automatisation de publication

## Critère de passage en public

- Architecture de base validée
- Flux de test reproductible
- Documentation nettoyée (sans brouillons sensibles)
