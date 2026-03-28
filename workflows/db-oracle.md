---
description: Pornește un Proxy sigur către o bază de date de pe Cloud și generează scheme grafice
---

# /db-oracle

Un workflow indispensabil când ai nevoie să manipulezi direct un Postgres, MySQL sau Firestore în mediul tău. Când rulezi această comandă, asistentul Antigravity se va erija într-un Oracle de date.

## Parametri
1. **DB_TYPE** — `postgres`, `mysql`, sau `firestore`
2. **INSTANCE_NAME** — ex: `evident-trees-453923-f9:europe-west1:postgres-1`
3. **PORT_LOCAL** (opțional, default 5432)

## Steps

// turbo
1. **Cloud SQL Proxy**: Deschide tunelul securizat către instanța din cloud (evitând IP-uri publice expuse):
```bash
echo "Verificare/Pornire Cloud SQL Proxy pe portul <PORT_LOCAL>..."
# În producție reală asistentul instanțiază proxy-ul ca back-ground job
# ./cloud-sql-proxy <INSTANCE_NAME> --port <PORT_LOCAL> & 
echo "GCLOUD PROXY EMULAT pentru: <INSTANCE_NAME>"
```

2. **Misiunea Agentului (Obligatoriu):**
   - [ ] Confirmă cu utilizatorul că MCP-ul `postgres` (sau cel de Firestore) listat în `~/.gemini/antigravity/mcp_config.json` se conectează cu succes la `localhost:<PORT_LOCAL>`.
   - [ ] Dacă conexiunea este blocată de lipsă parole, folosește CLI nativ (`psql`, `gcloud firestore databases list`) în `run_command` pentru a rula ce cere utilizatorul.
   - [ ] Analizează logica. Dacă utilizatorul zice *"Fă un raport cu toți uzerii noi"*, tu transformi asta în SQL -> extragi datele -> Generezi un tabel Markdown sau CSV în consolă.
   - [ ] NU DA DELETE SAU DROP FĂRĂ CONFIRMARE (CAUTION).

## Utilizare frecventă (Openclaw Monitor)
Aici s-a re-migrat către Postgres recent (după SQLite). Acest tool ajută la verificarea bunei funcționări prin comanda:
`Asistent, rulează /db-oracle pe openclaw-db (sau făce test connection prin CLI)`
