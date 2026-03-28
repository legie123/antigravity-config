---
description: Analizează ultimele erori critice și propune automat un patch
---

# /logs-analyzer

Un instrument inteligent (AI) Antigravity bazat pe comanda de `/logs`. Diferența este că acest workflow nu doar aruncă text în consolă, ci forțează agentul (Antigravity) să facă următoarele: să vâneze eroarea în mod autonom, să citească fișierele locale și să elaboreze reparația pe loc.

## Parametri
1. **SERVICE_NAME** — numele serviciului (ex: `ds-app-v2`)
2. **PROJECT_ID** (opțional, default: `evident-trees-453923-f9`)
3. **REGION** (opțional, default: `europe-west1`)

## Steps

// turbo
1. Obținerea ultimelor 10 **Erori Critice** din Cloud Run:
```bash
gcloud logging read 'resource.type="cloud_run_revision" AND resource.labels.service_name="<SERVICE_NAME>" AND severity>=ERROR' \
  --project="evident-trees-453923-f9" \
  --limit=10 \
  --format="table(timestamp, resource.labels.revision_name, jsonPayload.message, textPayload)"
```

2. **Misiunea Agentului (Obligatoriu):**
   - [ ] Citește Output-ul de mai sus.
   - [ ] Găsește linia de cod responsabilă (StackTrace) sau endpoint-ul de API (ex: `/api/auth/qr`).
   - [ ] Folosește tool-ul `grep_search` pe directorul curent de lucru pentru a găsi ruta/funcția pe disk-ul local.
   - [ ] Folosește `view_file` pentru a citi zona defectă.
   - [ ] Trimite-i utilizatorului un block de cod cu Remedierea Exactă (Patch).
   - [ ] Folosește regula **Anti-Loop** (dacă nu ești sigur, cere permisiunea de editare cu un plan scurt).

3. Raport: Așteptăm feed-backul uman pentru injectarea patch-ului.
