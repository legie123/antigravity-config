# 🧯 Antigravity Troubleshooting Guide

> Această pagină conține cele mai frecvente erori cu care s-a confruntat Antigravity în ecosistemul tău legat de Cloud Run și Node.js, împreună cu pașii de remediere la foc automat. Adaugă erori noi doar aici.

---

## Erori legate de Google Cloud Run & Deploy

### 1. `Application Default Credentials are not set` (sau MCP Health Blocked)
**Cauza**: Asistentul a pierdut token-ul temporar ADC necesar pentru a face call-uri către serverul `cloudrun` MCP sau scripturi locale CLI.
**Rezolvare**:
Rulează în terminal local:
```bash
gcloud auth application-default login
```

### 2. Eroare 500, 502, sau 503 imediat după un Deploy
**Cauza**: Aplicația nu se poate porni la rece (Cold Start fail). Motivul principal: Portul 8080 nu este deschis, lipsește o variabilă de mediu din interfața Cloud Run (ca API keys) sau un `package.json` cu erori (ex: modul lipsă - nu ai compilat cu comanda corectă).
**Rezolvare Rapidă**:
1. Folosește workflow `/logs` pe acel serviciu pentru a vedea eroarea reală.
2. Folosește skill `auto_deploy` (automatizează rollback-ul), astfel traficul pe vechea versiune nu pică niciodată vizibil.

### 3. HTTP `429 Too Many Requests` în log-uri
**Cauza**: Rate-limiter (dacă e Node.js) este prea strict, sau serviciul este scanat de boți automatizați și instanța suferă strangulări (bottlenecks). 
**Rezolvare**:
- Verifică codul Node.js (`express-rate-limit`) dacă e prea strâns.
- Dacă atacul e la nivel de rețea (din afara aplicației), poți lega Cloud Armor la Cloud Run.

---

## Erori legate de Ecosistemul Antigravity

### 1. Buclă Infinită de Scriere/Rulare Erori
**Cauza**: Antigravity folosește un utilitar (ex. `replace_file_content`) incorect sau prinde un blocaj unde rulează același patch peste și peste.
**Rezolvare**:
Protocolul `anti-loop` (parte din Hardening) oprește la max 2 retries repetitive. Pentru intervenția manuală a utilizatorului: Verifică direct fișierul corupt și scrie manual soluția cerând Antigravity doar o comandă concretă.

### 2. Memorie Plină pe Local (Warning sau Crash Safari/Mac)
**Cauza**: Docker + Chrome/Safari + procesul Node pot papa memorie, Mac-ul începe să folosească Swap memory masiv.
**Rezolvare**:
Apelează imediat workflow-ul `/cleanup` care:
- Oprește Chrome / Safari forțat.
- Taie npm cache (`~/.npm/_cacache/*`).
- Prunează Docker system space.

---

## Erori legate de Configurare Proiect (Nginx/Dockerfile)

### 1. Content-Security-Policy sau CORS blochează assets
**Cauza**: Extragerea de fonturi, imagini din CDN diferit, scripturi de trackere etc. este blocată de headerele noastre stricte de securitate (`index.html` Nginx configs).
**Rezolvare**:
Deschide `~/.gemini/antigravity/knowledge/templates.md`, caută secțiunea _Security Headers_ în `nginx.conf` și editează `Content-Security-Policy ...` extinzând la hosturile necesare. Exemplu: `script-src 'self' 'unsafe-inline' https://apis.google.com`.
