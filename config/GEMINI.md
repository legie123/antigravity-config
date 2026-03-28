# 🌐 Global Improvement Protocol — Antigravity

> Acest document este sursa unică de reguli, standarde și optimizări aplicate implicit la TOATE proiectele (curente și viitoare).
> Locație: `~/.gemini/GEMINI.md` — citit automat în fiecare conversație.

---

## 🏗️ GCP Environment (Global)

- **Account**: `lemuriandeals@gmail.com`
- **Project**: `evident-trees-453923-f9` (My First Project)
- **Region**: `europe-west1`
- **Billing**: `019422-9B5C05-04A8E9` (activ)
- **APIs active**: Run, Build, Artifact Registry, Monitoring, Storage, IAM, Pub/Sub, Logging
- **Service Account**: `657910053930-compute@developer.gserviceaccount.com`

---

## 📐 Reguli de Proiect (aplicate implicit)

### Containerizare
- Folosește `nginx:alpine` pentru site-uri statice (HTML/CSS/JS)
- Folosește `node:alpine` pentru aplicații Node.js
- Portul containerului: **8080** (standard Cloud Run)
- Fiecare proiect TREBUIE să aibă: `Dockerfile`, `.dockerignore`, `.gcloudignore`

### Nginx Config (site-uri statice)
- **Gzip**: activat pe text/plain, text/css, application/javascript, application/json, image/svg+xml
- **Cache static**: 7 zile cu `public, immutable` (.png, .jpg, .css, .js, .woff2)
- **Cache HTML**: 5 minute cu `must-revalidate`
- **Security headers** (toate 7, obligatoriu):
  - `X-Frame-Options: SAMEORIGIN`
  - `X-Content-Type-Options: nosniff`
  - `X-XSS-Protection: 1; mode=block`
  - `Referrer-Policy: strict-origin-when-cross-origin`
  - `Permissions-Policy: camera=(), microphone=(), geolocation=()`
  - `Strict-Transport-Security: max-age=31536000; includeSubDomains`
  - `Content-Security-Policy: default-src 'self'; ...` (adaptat per proiect)

### Cloud Run Deploy
- Memory: **128Mi** (static) / **256Mi** (Node.js) / **512Mi** (heavy apps)
- CPU: **1 vCPU**, throttled (idle = $0)
- Min instances: **0** (cost saving)
- Max instances: **3** (static) / **10** (apps cu trafic)
- **Always** `--allow-unauthenticated` pentru site-uri publice
- **Always** `--cpu-throttling` pentru cost optimization

### CI/CD Pipeline
- Fiecare proiect TREBUIE să aibă: `cloudbuild.yaml`
- Trigger: GitHub push to `main` → Cloud Build → Cloud Run deploy
- GitHub org: `legie123`
- Build config standard: build → push to Artifact Registry → deploy

### Monitoring & Alerting
- Fiecare serviciu Cloud Run TREBUIE să aibă:
  - Uptime check (5 min interval)
  - Alert policy pe 5xx errors
  - Email notification → `lemuriandeals@gmail.com`

### Git & Versioning
- Branch principal: `main`
- Commit messages: descriptive, lowercase
- `.gitignore` obligatoriu: `node_modules/`, `.DS_Store`, `.env`, `.npm-cache/`
- Auto-sync disponibil via `/github-sync` workflow

---

## 🖥️ Reguli Sistem Local

### Memory Management
- `NODE_OPTIONS="--max-old-space-size=2048"` (setat în `.zshrc`)
- Dacă RAM free < 1GB → kill Safari, Chrome, Docker
- Cleanup periodic: `rm -rf ~/.npm/_cacache/*`

### Tooling Instalat
- `gcloud` CLI (cu beta)
- `gh` CLI (GitHub)
- `node`, `npm`
- MCP servers: `cloudrun`, `gmp-code-assist`

---

## 🎨 Reguli UI/Design (web)

- Design premium, modern, dark mode preferred
- Google Fonts (Inter, Roboto, Outfit)
- Micro-animații, hover effects, gradienți subtili
- Mobile-first responsive
- SEO: title tags, meta descriptions, semantic HTML, heading hierarchy
- Unique IDs pe toate elementele interactive

---

## 🔒 Reguli Securitate

- NICIODATĂ API keys în cod sursă
- `.env` pentru secrets, NICIODATĂ commited
- 7 security headers pe ORICE site public
- HTTPS only (Cloud Run auto-SSL)
- CSP adaptat per proiect

---

## 📂 Proiecte Curente

| Proiect | Tip | Status | URL |
|---------|-----|--------|-----|
| Dragons Delivery | Static (nginx) | ✅ Live | https://dragons-delivery-657910053930.europe-west1.run.app |
| DS APP V2 | Node.js app | 🔧 In development | — |
| TRADE AI | Trading bot | 🔧 In development | — |
| openclaw-monitor | Node.js monitor | 🔧 In development | — |
| START ANTy'profi | — | 📁 Stored | — |

---

## 📋 Workflows Disponibile

| Command | Ce face |
|---------|---------|
| `/deploy` | Deploy orice proiect la Cloud Run (source deploy) |
| `/status` | Check status toate serviciile Cloud Run + system health |
| `/logs` | View Cloud Run logs rapid pentru debugging |
| `/new-project` | Scaffold proiect complet (static/Node.js) cu toate fișierele |
| `/cleanup` | System cleanup: npm cache, Docker prune, free memory |
| `/predeploy` | Pre-deploy checklist (lint, tests, config validation) |
| `/github-sync` | Sincronizare auto Mac ↔ Remote PC prin GitHub |

---

## ⚡ Quick Reference

```bash
# Deploy orice proiect static la Cloud Run
gcloud run deploy SERVICE_NAME --source . --region europe-west1 --allow-unauthenticated --memory 128Mi --cpu 1 --max-instances 3 --cpu-throttling

# CI/CD push
git add . && git commit -m "update" && git push

# System cleanup
killall Safari 2>/dev/null; killall "Google Chrome" 2>/dev/null; rm -rf ~/.npm/_cacache/*

# Check headers
curl -sI https://SERVICE_URL/

# View logs
gcloud run services logs read SERVICE_NAME --region=europe-west1 --limit=20
```
