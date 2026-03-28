# 🔧 Protocol de Optimizare și Administrare Antigravity

> Ultima actualizare: 2026-03-24
> Sursă: conversație de hardening + sync setup

---

## 📋 Inventar Complet Optimizări

### Skills (5)
| Skill | Scop | Locație |
|---|---|---|
| `auto_report` | Raportare DONE/BLOCKED/NEXT după fiecare acțiune | `~/.agents/skills/auto_report/` |
| `deploy_guard` | Verificări safety pre-deploy (JSON, auth, build, MCP) | `~/.agents/skills/deploy_guard/` |
| `lint_check` | Rulează linter pe workspace | `~/.agents/skills/lint_check/` |
| `mcp_health_check` | Health check fiecare MCP server | `~/.agents/skills/mcp_health_check/` |
| `scratch_test` | Experimente izolate în scratch dir | `~/.agents/skills/scratch_test/` |

### Workflows (13)
| Workflow | Scop | Command |
|---|---|---|
| `anti-loop-policy` | Previne loop-uri infinite (max 2 retry) | automatic |
| `audit-hard` | Audit complet hardening | `/audit-hard` |
| `browser-usage-policy` | Reguli browser tool | automatic |
| `deploy-workflow` | Pași deploy Cloud Run | `/deploy` |
| `high-value-integrations` | Ghid integrări MCP (BigQuery, Firestore, Cloud SQL) | referință |
| `incremental-work` | Reguli lucru incremental | automatic |
| `mcp-check` | Health check MCP servers | `/mcp-check` |
| `mcp-usage-policy` | Policy per MCP server | automatic |
| `postchange-verify` | Verificare post-edit | `/postchange-verify` |
| `predeploy` | Checklist pre-deploy | `/predeploy` |
| `safe-optimize` | Optimizări safe non-destructive | `/safe-optimize` |
| `sync-config` | Push optimizări la GitHub | `/sync-config` |
| `pull-config` | Pull optimizări pe remote PC | `/pull-config` |

### Config Files
| Fișier | Locație | Scop |
|---|---|---|
| `mcp_config.json` | `~/.gemini/antigravity/` | Servere MCP (cloudrun, gmp-code-assist, gke-oss) |
| `settings.json` | `~/projects/antigravity_workspace/.gemini/` | Setări workspace (limba, reporting) |
| `scratch-space-protocol.md` | `~/.gemini/antigravity/` | Protocol scratch directory |
| `GEMINI.md` | `~/.gemini/` | Reguli globale (citit automat la fiecare conversație) |

---

## 🔄 Sistem de Sincronizare Local ↔ Remote

### Arhitectura
```
┌─────────────────┐     git push      ┌──────────────────┐     git pull      ┌─────────────────┐
│   Mac (Local)   │ ──────────────►  │     GitHub       │ ◄──────────────── │   Remote PC     │
│                 │  /sync-config    │ legie123/        │  /pull-config     │                 │
│ ~/.agents/      │                  │ antigravity-     │                   │ ~/.agents/      │
│   skills/       │                  │ config           │                   │   skills/       │
│   workflows/    │                  │                  │                   │   workflows/    │
└─────────────────┘                  └──────────────────┘                   └─────────────────┘
```

### Flux de Lucru
1. **Local**: Se face o optimizare (skill/workflow/config nou sau modificat)
2. **Local**: Antigravity rulează `/sync-config` → copiază în repo → commit → push
3. **Remote**: Antigravity rulează `/pull-config` → pull → `install.sh` → totul e la zi

### Repo GitHub
- **URL**: https://github.com/legie123/antigravity-config
- **Branch**: `main`
- **Locație locală**: `~/.gemini/antigravity/scratch/antigravity-config/`

### Install Script (`install.sh`)
Copiază automat din repo în locațiile corecte:
- `skills/` → `~/.agents/skills/`
- `workflows/` → `~/.agents/workflows/`
- `config/mcp_config.json` → `~/.gemini/antigravity/`
- `config/settings.json` → `~/projects/antigravity_workspace/.gemini/`

---

## 🛡️ Reguli de Protecție

### Anti-Loop (automatic)
- Max 2 retry pe aceeași comandă
- Dacă aceeași eroare apare de 2 ori → BLOCKED
- Nu repeta niciodată exact aceeași abordare după eșec

### Browser Usage (automatic)
- Browser doar pentru verificare vizuală
- Pentru docs/API → `read_url_content` sau `curl`
- Screenshot la fiecare verificare vizuală

### Incremental Work (automatic)
- Task-uri mici, pas cu pas
- Max 2-3 fișiere editate simultan
- Verificare după fiecare pas

### Post-Change Verify (automatic)
- JSON → parse check cu node
- Markdown → YAML frontmatter check
- JS/TS → syntax check cu `node --check`

---

## 🚀 Deploy Protocol

### Pre-Deploy (`/predeploy`)
1. `package.json` există?
2. Lint check (dacă e configurat)
3. Tests (dacă sunt configurate)
4. JSON configs valide
5. Cloudrun MCP functional

### Deploy Guard (`deploy_guard` skill)
1. Config validation
2. No placeholders
3. Auth check (ADC)
4. Build check
5. MCP cloudrun health
→ Output: **DEPLOY OK** sau **DEPLOY BLOCKED**

### Deploy (`/deploy`)
1. Build → Docker → Push → `gcloud run deploy`
2. Memory: 128Mi (static) / 256Mi (Node.js) / 512Mi (heavy)
3. Always: `--allow-unauthenticated`, `--cpu-throttling`

---

## 📊 Status Reporting

Fiecare acțiune se termină cu unul din:
- **DONE** — acțiune completă și validată
- **BLOCKED** — eșec sau necesită intervenție manuală
- **NEXT** — gata, ce urmează
- **SKIPPED** — nu se aplică (ex: no lint script)

---

## 🔍 Audit & Health

### `/audit-hard`
Verifică totul: settings, workflows (YAML frontmatter), skills (structură), MCP servers

### `/mcp-check`
Health check fiecare MCP server cu `--help` + timeout 30s

### `/safe-optimize`
Optimizări non-destructive: fix JSON, fix YAML, raportează fișiere orfane
