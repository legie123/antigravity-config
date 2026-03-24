---
description: Pre-deployment checklist before pushing to Cloud Run
---

# /predeploy

Run all checks before deploying.

## Steps
// turbo
1. Verify workspace has a `package.json` – `ls ~/projects/antigravity_workspace/package.json`
// turbo
2. Run linter if configured – `npm run lint --prefix ~/projects/antigravity_workspace` (skip if no lint script)
// turbo
3. Run tests if configured – `npm test --prefix ~/projects/antigravity_workspace` (skip if no test script)
// turbo
4. Validate all JSON configs – `node -e "JSON.parse(require('fs').readFileSync('<path>','utf8'))"`
5. Check MCP `cloudrun` server health (run `/mcp-check` workflow for cloudrun only).
6. Verify `deploy-workflow.md` has no remaining `<PLACEHOLDER>` values.
7. Report:
   - **PASS** – all checks green
   - **FAIL** – which check failed and why
   - **BLOCKED** – if credentials or toolchain missing
