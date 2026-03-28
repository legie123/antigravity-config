---
name: auto_deploy
description: Smart Deploy pentru Cloud Run cu Auto-Rollback la HTTP 5xx
---

# auto_deploy

Un utilitar de deployment inteligent pentru mediul Antigravity. În loc să facă doar "push and pray", acest skill lansează aplicația, obține noul URL curent, pingează pentru a verifica răspunsul și, dacă întâlnește o catastrofă (HTTP 5xx), redirijează instantaneu traficul la versiunea precedentă activă (Rollback).

## Trigger
- Poate fi utilizat în loc de comanda clasică din `/deploy`.
- Utilitate maximă pentru aplicațiile NodeJS complexe (ex: Dragons Alliance Command Center, DS APP V2) unde un bug trece ușor neobservat de build process.

## Input Necesare:
- **SERVICE_NAME** (exemplu: `ds-app-v2`)
- **PROJECT_ID** (din GEMINI.md: `evident-trees-453923-f9`)
- **REGION** (din GEMINI.md: `europe-west1`)

## Script (Mecanism Internal)
```bash
#!/usr/bin/env bash
set -eo pipefail

SERVICE_NAME=${1:-""}
PROJECT_ID=${2:-"evident-trees-453923-f9"}
REGION=${3:-"europe-west1"}

if [ -z "$SERVICE_NAME" ]; then
  echo "BLOCKED — Lipsește SERVICE_NAME. Folosire: auto_deploy nume-serviciu"
  exit 1
fi

echo "=== Auto-Deploy & Verify: $SERVICE_NAME ==="

# 1. Obținem Revizia Curentă Activă (pentru fallback, salvam traffic=100)
OLD_REVISION=$(gcloud run revisions list --service="$SERVICE_NAME" --project="$PROJECT_ID" --region="$REGION" --format="value(REVISION)" --limit=1 2>/dev/null || echo "none")

echo "Revizie precedentă salvată pentru rollback: $OLD_REVISION"

# 2. Deploy standard dintr-un source local
echo "Rulăm deploy..."
gcloud run deploy "$SERVICE_NAME" \
  --source . \
  --project "$PROJECT_ID" \
  --region "$REGION" \
  --allow-unauthenticated > /dev/null 2>&1 || (echo "BLOCKED — Deploy-ul inițial (Build) a eșuat" && exit 1)

# 3. Validare Post-Deploy
URL=$(gcloud run services describe "$SERVICE_NAME" --project "$PROJECT_ID" --region "$REGION" --format 'value(status.url)')
echo "Verificare URL live: $URL"

# Testam endpointul principal pentru statusul HTTP (asteapta 5s pentru cold-start cloud run)
sleep 5
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL" || echo "failed")

echo "HTTP Status returnat: $HTTP_STATUS"

# Daca e 5xx, aplicam Auto-Rollback
if [[ "$HTTP_STATUS" == 5* ]] || [[ "$HTTP_STATUS" == "failed" ]]; then
  echo "CRITICAL: EROARE 5xx DETECTATĂ ($HTTP_STATUS)! INIȚIERE ROLLBACK..."
  
  if [ "$OLD_REVISION" != "none" ]; then
    gcloud run services update-traffic "$SERVICE_NAME" \
      --project="$PROJECT_ID" \
      --region="$REGION" \
      --to-revisions="$OLD_REVISION=100" > /dev/null 2>&1
    echo "BLOCKED — Deploy eșuat din cauza HTTP $HTTP_STATUS pe instanța nouă. S-a făcut ROLLBACK automat la $OLD_REVISION."
  else
    echo "BLOCKED — Deploy eșuat. Aceasta este prima revizie, deci rollback-ul este imposibil. Va necesita intervenție."
  fi
  exit 1
fi

echo "DONE — Deploy finalizat cu succes. Aplicația este stabilă ($HTTP_STATUS)."
```

## Reguli Antigravity & Consecințe
- Dacă statusul HTTP primit după deploy este 404, 403, 401, sau 200, deploy-ul este considerat REUSIT dpdv Infrastructural, deoarece serverul răspunde logic la comenzi. Se face rollback DOAR pe fatalități de server (500, 502, 503).
- Rollback-ul alterează split-ul din Cloud Run pentru a arunca 100% din trafic pe vechea revizie stabilă.
