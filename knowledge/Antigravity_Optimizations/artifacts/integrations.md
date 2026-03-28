# 🔌 Antigravity Integrations Protocol

> Acest document centralizează toate setările, modulele npm și snippet-urile de cod arhitecturale validate pentru instrumente third-party (Neon, Redis, APIs). Agenții vor citi acest fișier pentru a conecta instantaneu orice proiect viitor la aceleași tehnologii, folosind standardele oficiale Antigravity.
> **ATENȚIE**: NU INCLUGEȚI NICIODATĂ parole, JWT tokens sau API Keys direct aici. Folosiți notații sub formă de `process.env.VARIABLE_NAME`.

---

## 🐘 Neon.tech (Serverless PostgreSQL)
**Status**: Aprobat pentru scale-out rapid și aplicații Node.js (ex: Openclaw Monitor).
**Dependințe standard**: `npm install pg`

**Snippet Conexiune Standard (Pool)**:
```javascript
const { Pool } = require('pg');

// SSL este obligatoriu pentru Neon.tech
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    require: true,
    rejectUnauthorized: false // necesar pentru anumite environmenturi
  }
});

module.exports = {
  query: (text, params) => pool.query(text, params),
};
```
**Reguli specifice Neon**:
- Nu lăsa un trigger de connection deschis fără a-l închide în Lambda/Cloud Run (`pool.end()`) dacă instanța are scări de timp extinse la shut down, deși `pg` Pool gestionează corect conexiunile persistente. Vezi documentația de Pooling.

---

## ⚡ Redis (In-Memory Data Store)
**Status**: Aprobat pentru Caching & Rate-Limiting.
**Dependințe Standard**: `npm install redis`

**Snippet Conexiune Standard**:
```javascript
const redis = require('redis');

const redisClient = redis.createClient({
    url: process.env.REDIS_URL
});

redisClient.on('error', (err) => console.error('Redis Client Error', err));

(async () => {
    await redisClient.connect();
})();

module.exports = redisClient;
```
**Reguli specifice Redis**:
- Folosit extrem de util cu `express-rate-limit` sau stocarea sesiunilor WebSocket pentru aplicații live-tracking (Dragons Delivery).

---

## ☁️ Cloud Knowledge & Google APIs
**Status**: Aprobat pentru arhitecturile ce folosesc Native Google Services.
**Autentificare**: 
- Folosire exclusivă a `Google Application Default Credentials (ADC)` via environmentul Cloud Run (Service Account: `657910053930-compute...`). Niciodată nu importăm `key.json` fizic!

*(Acest document se va auto-expanda de fiecare dată când Antigravity integrează un sistem nou pe un proiect)*
