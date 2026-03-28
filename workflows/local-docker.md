---
description: Testează aplicația Node.js/Statică local într-un container izolat (Emulare Cloud Run)
---

# /local-docker

O procedură de siguranță supremă înainte de a lansa cod incert pe Cloud Run. Acest workflow construiește și rulează aplicația local într-un container de Docker, exact așa cum o va face Google Cloud, permițând testarea izolată a erorilor de `8080` port, lipsă environment variables sau module NPM corupte.

## Când să o folosești
- După modificări arhitecturale grele în `DS APP V2` sau `openclaw-monitor`.
- Dacă Cloud Run îți dă Erori `502 Bad Gateway` pe un build despre care tu crezi că funcționează.

## Parametri
Nimic necesar, dar **trebuie să rulezi aplicația dintr-un director care conține `Dockerfile`**.

## Steps

// turbo
1. **Verificare Docker Engine**: Verificăm dacă Docker/OrbStack e funcțional pe sistem:
```bash
docker info >/dev/null 2>&1 || (echo "BLOCKED — Docker nu este deschis. Pornește Docker Desktop sau OrbStack întâi!" && exit 1)
```

// turbo-all
2. **Curățare Mediu Vechi**: Omorâm orice container vechi de test.
```bash
docker rm -f antigravity-test-container >/dev/null 2>&1 || true
```

3. **Build Container (Emulare Artifact Registry)**:
```bash
echo "📦 Construire Imagine Docker locală..."
docker build -t antigravity-app-test .
```

4. **Spin-Up Container (Emulare Cloud Run pe port 8080)**:
```bash
echo "🚀 Pornire Container pe localhost:8080..."
docker run -d --name antigravity-test-container -p 8080:8080 antigravity-app-test
```

5. **Misiunea Agentului (Obligatoriu):**
   - Așteaptă 3 secunde (`sleep 3`).
   - Fă un HTTP Ping `curl -sI http://localhost:8080` folosind `run_command`.
   - Extrage log-urile interne să vezi dacă Node.js s-a plâns: `docker logs antigravity-test-container | tail -n 15`.
   - Afișează-i utilizatorului o analiză: Ești sigur că va rula pe Google Cloud fără să pice? (DA/NU).
   - Indiferent de răspuns, fa Garbage Collection: `docker rm -f antigravity-test-container`.
