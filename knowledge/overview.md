# Antigravity Knowledge Overview

> Ultima actualizare: 2026-03-24

## Sistem Local
- **OS**: macOS
- **Shell**: zsh
- **Node**: instalat + `NODE_OPTIONS="--max-old-space-size=2048"`
- **CLI Tools**: `gcloud` (cu beta), `gh` CLI, `node`, `npm`

## GCP Environment
- **Account**: `lemuriandeals@gmail.com`
- **Project ID**: `evident-trees-453923-f9`
- **Region**: `europe-west1`
- **Billing**: `019422-9B5C05-04A8E9` (activ)
- **Service Account**: `657910053930-compute@developer.gserviceaccount.com`
- **APIs active**: Run, Build, Artifact Registry, Monitoring, Storage, IAM, Pub/Sub, Logging

## MCP Servers
| Server | Status | Scop |
|--------|--------|------|
| `cloudrun` | ✅ Activ | Deploy & manage Cloud Run services |
| `gmp-code-assist` | ✅ Activ | Google Maps Platform docs & code |

## Structura Antigravity
```
~/.gemini/
├── GEMINI.md                    # Reguli globale (citit automat)
├── antigravity/
│   ├── knowledge/               # Memorie persistentă
│   │   ├── overview.md          # Acest fișier
│   │   ├── projects.md          # Documentație proiecte
│   │   └── templates.md         # Template-uri reutilizabile
│   ├── brain/                   # Artefacte per conversație
│   ├── browser_recordings/      # Înregistrări browser
│   └── playground/              # Workspace-uri temporare
~/.agents/
├── skills/                      # Capabilități extinse
│   ├── auto_report/             # Status DONE/BLOCKED/NEXT
│   ├── deploy_guard/            # Pre-deploy safety checks
│   ├── lint_check/              # Linter runner
│   ├── mcp_health_check/        # MCP server health
│   ├── scaffold/                # NEW: Project scaffolding
│   └── scratch_test/            # Isolated experiments
└── workflows/                   # Fluxuri de lucru (/commands)
    ├── deploy-workflow.md       # /deploy
    ├── status.md                # /status
    ├── new-project.md           # /new-project
    ├── cleanup.md               # /cleanup
    ├── predeploy.md             # /predeploy
    ├── incremental-work.md      # Incremental work rules
    └── ... (13+ workflows)
```

## GitHub
- **Org**: `legie123`
- **Branch principal**: `main`
- **CI/CD**: GitHub push → Cloud Build → Cloud Run

## Protocoale
- **Optimizare & Administrare**: `knowledge/optimization-protocol.md` — protocol complet cu inventar skills/workflows, sync local↔remote, reguli protecție, deploy protocol
- **Sync Config**: repo GitHub `legie123/antigravity-config` — `/sync-config` (push) + `/pull-config` (pull pe remote)

## Proiecte Active
Vezi `knowledge/projects.md` pentru detalii complete.
