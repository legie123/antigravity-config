---
description: Vezi sau analizează rapid ultimele log-uri ale unui serviciu Cloud Run
---

# /logs

Vizualizarea rapidă a log-urilor (erori, ieșiri standard) pentru un serviciu Cloud Run.

## Parametri
Când rulezi acest workflow, vei avea nevoie de:
1. **SERVICE_NAME** — numele serviciului (ex: `ds-app-v2`, `dragons-delivery`)
2. **LIMIT** (opțional) — numărul liniilor (de bază: 20, max: 100)
3. **TYPE** (opțional) — `error` pentru a arăta doar erorile serioase

## Steps
// turbo-all

// turbo
1. Verifică existența serviciului:
```bash
gcloud run services describe <SERVICE_NAME> --region europe-west1 --project evident-trees-453923-f9 >/dev/null 2>&1 || (echo "BLOCKED: Serviciul <SERVICE_NAME> nu există în regiune." && exit 1)
```

// turbo
2. Extrage logs conform preferinței:
Dacă tragi log-uri generale:
```bash
gcloud run services logs read <SERVICE_NAME> --region=europe-west1 --project=evident-trees-453923-f9 --limit=20
```

Dacă dorești doar **erorile** severe:
```bash
gcloud logging read 'resource.type="cloud_run_revision" AND resource.labels.service_name="<SERVICE_NAME>" AND severity>=ERROR' --project=evident-trees-453923-f9 --limit=20 --format="table(timestamp, textPayload, jsonPayload.message)"
```

3. **Report:** 
   - Afișează log-urile în consolă.
   - **Misiunea Agentului (Tu):** Citește log-ul și dacă sunt erori `.js` (stack traces / 500 errors), fa un mic rezumat explicativ din ce observi acolo!
