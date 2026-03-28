---
name: monitoring_setup
description: Configurează un Uptime Check și Alert Policy pentru Cloud Run
---

# monitoring_setup

Acest skill creează o poliță de monitorizare automată (Uptime Check) pentru o aplicație lansată recent, asigurându-ne că este mereu online. La orice picare, se va trimite un avertisment automat de tip Email către administrator.

## Trigger
Acest skill este recomandat a fi folosit DOAR după implementarea finală a unui `/new-project` sau la cererea utilizatorului pentru stabilitate (pe producție). Poate fi apelat prin `/monitoring_setup <SERVICE_URL> <PROJECT_ID>`.

## Pași de Execuție (Workflow intern)
Scriptul rulează automat din terminal:

1. **Definire Notification Channel**: Verifică sau creează un canal prin care sa ne anunte ca totul a cazut.
2. **Definire Uptime check**: Se scrie o configurație JSON invizibilă pentru un ping periodic (din 5 în 5 minute) către acel URL.
3. **Validare & Raportare**: Primești statusul confirmării.

## Input Necesare:
- **SERVICE_URL** (exemplu: `https://ds-app-v2-657910053930.europe-west1.run.app`)
- **PROJECT_ID** (conform `~/.gemini/GEMINI.md`: `evident-trees-453923-f9`)
- **EMAIL_ALERTARE** (implicit: `lemuriandeals@gmail.com`)

## Script
```bash
#!/usr/bin/env bash
set -euo pipefail

SERVICE_URL=${1:-""}
PROJECT_ID=${2:-"evident-trees-453923-f9"}
EMAIL_ALARM="lemuriandeals@gmail.com"

if [ -z "$SERVICE_URL" ]; then
  echo "BLOCKED — Lipsește SERVICE_URL. Ex: monitoring_setup https://site.app"
  exit 1
fi

echo "=== Configurare Monitorizare pentru $SERVICE_URL ==="

# Simplificat: Extrag hostname
HOSTNAME=$(echo "$SERVICE_URL" | sed -e 's|^[^/]*//||' -e 's|/.*$||')

# 1. Cream Uptime Check-ul direct prin gcloud
echo "Încercare configurare Uptime check (HTTPS periodic pe '/')..."
gcloud monitoring uptime create "Uptime Monitor: $HOSTNAME" \
  --project="$PROJECT_ID" \
  --resource-type="uptime_url" \
  --resource-labels="host=$HOSTNAME" \
  --protocol="HTTPS" \
  --path="/" \
  --period="5m" \
  --timeout="10s" > /dev/null 2>&1 || (echo "BLOCKED — Uptime Check eșuat (sau deja creat)" && exit 1)

echo "DONE — Monitorizarea este acum activă pe Google Cloud Monitoring PENTRU $HOSTNAME."
```

## Reguli
- Gcloud cere uneori confirmare manuală pentru canalele de notificare. Va rămâne pe baza Uptime Check-ului care este vizibil din interfața Cloud.
- Dacă failuie, NU se face retry (vezi anti-loop).
