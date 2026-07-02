# Yarn Visibility

Sistema de monitorització de visibilitat de marques de llana i patronistes als assistents d'IA.

## Què és

Yarn Visibility monitoritxa com les IAs (ChatGPT, Gemini, Claude...) mencionen marques de llana i patronistes quan els usuaris fan preguntes sobre teixir.

**Exemples de mètriques:**
- Quantes vegades menciona Gemini la marca "Drops" quan pregunten per llanes per a principiants?
- En quina posició apareix una patronista vs. la seva competència?
- Com evoluciona la visibilitat al llarg del temps?

## Relació amb yarn-plugin

[yarn-plugin](https://github.com/laurabcn/yarn-plugin) és la peça que *alimenta* les IAs amb dades de llanes i patrons. Yarn Visibility és la que *mesura* com de visible és una marca o patronista als assistents d'IA.

## Stack

- **Backend**: Python 3.12 + FastAPI
- **Base de dades**: PostgreSQL 16
- **Cues**: Celery + Redis (les crides a LLMs són asíncrones)
- **Contenidors**: Docker Compose

## Estat

Projecte en fase de definició. El producte i l'arquitectura s'estan concretant.
