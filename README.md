# 🚀 Antigravity Config — TopG Optimisations

Toate optimizările, skill-urile, workflow-urile și configurările Antigravity într-un singur repo.

## Ce conține

### Skills (5)
| Skill | Ce face |
|---|---|
| `auto_report` | Raportare automată DONE/BLOCKED/NEXT după fiecare acțiune |
| `deploy_guard` | Verificări de siguranță pre-deploy (JSON, auth, build, MCP) |
| `lint_check` | Rulează linter-ul pe workspace |
| `mcp_health_check` | Health check pentru fiecare MCP server |
| `scratch_test` | Rulează experimente izolate în scratch dir |

### Workflows (11)
| Workflow | Ce face |
|---|---|
| `anti-loop-policy` | Previne loop-uri infinite (max 2 retry) |
| `audit-hard` | Audit complet de hardening |
| `browser-usage-policy` | Reguli de folosire browser |
| `deploy-workflow` | Pași deploy Cloud Run |
| `high-value-integrations` | Ghid integrări MCP |
| `incremental-work` | Reguli lucru incremental |
| `mcp-check` | Health check MCP servers |
| `mcp-usage-policy` | Policy per MCP server |
| `postchange-verify` | Verificare post-edit |
| `predeploy` | Checklist pre-deploy |
| `safe-optimize` | Optimizări safe non-destructive |

### Config
- `mcp_config.json` — Configurare servere MCP (cloudrun, gmp-code-assist, gke-oss)
- `settings.json` — Setări workspace (limba, reporting, MCP list)
- `scratch-space-protocol.md` — Protocol scratch directory

## 🔧 Instalare pe PC-ul Remote

```bash
git clone https://github.com/legie123/antigravity-config.git
cd antigravity-config
bash install.sh
```

Scriptul copiază automat toate fișierele în locațiile corecte.

## 📁 Structura după instalare

```
~/.agents/
├── skills/
│   ├── auto_report/skill.md
│   ├── deploy_guard/skill.md
│   ├── lint_check/skill.md
│   ├── mcp_health_check/skill.md
│   └── scratch_test/skill.md
└── workflows/
    ├── anti-loop-policy.md
    ├── audit-hard.md
    ├── browser-usage-policy.md
    ├── deploy-workflow.md
    ├── high-value-integrations.md
    ├── incremental-work.md
    ├── mcp-check.md
    ├── mcp-usage-policy.md
    ├── postchange-verify.md
    ├── predeploy.md
    └── safe-optimize.md

~/.gemini/antigravity/
├── mcp_config.json
└── scratch-space-protocol.md

~/projects/antigravity_workspace/.gemini/
└── settings.json
```
