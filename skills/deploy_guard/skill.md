---
name: deploy_guard
description: Pre-deployment safety checks before Cloud Run deploy
---

# deploy_guard

Gate deployments behind a checklist of verified conditions. Read-only — never auto-deploys.

## Checks
1. **Config validation** – all JSON files in workspace parse cleanly.
2. **No placeholders** – `deploy-workflow.md` has no `<PROJECT_ID>` or `<SERVICE_NAME>` remaining.
3. **Auth check** – `gcloud auth application-default print-access-token` returns a token.
4. **Build check** – if `package.json` has a `build` script, run `npm run build` and check exit code.
5. **MCP cloudrun health** – run `npx -y @google-cloud/cloud-run-mcp --help` and check for auth errors.

## Output
- **DEPLOY OK** – all checks pass, safe to deploy.
- **DEPLOY BLOCKED** – list which checks failed.

## Rules
- If ANY check fails, block the deploy and report all failures.
- **Never auto-deploy** — only report readiness.
- Do not retry failed auth checks.
- This skill is strictly read-only.

## Script
```bash
#!/usr/bin/env bash
set -uo pipefail
WS="$HOME/projects/antigravity_workspace"
FAILURES=""

# 1. Config validation
echo "=== Config Validation ==="
while IFS= read -r -d '' jsonfile; do
  node -e "JSON.parse(require('fs').readFileSync('$jsonfile','utf8'))" 2>&1
  if [ $? -ne 0 ]; then
    FAILURES="$FAILURES\nFAIL: Invalid JSON in $jsonfile"
  fi
done < <(find "$WS" -name "*.json" -print0)
echo "Config validation complete."

# 2. Placeholder check
echo "=== Placeholder Check ==="
if grep -qE '<PROJECT_ID>|<SERVICE_NAME>' "$HOME/.agents/workflows/deploy-workflow.md" 2>/dev/null; then
  echo "FAIL: Placeholders still present in deploy-workflow.md"
  FAILURES="$FAILURES\nFAIL: Placeholders in deploy-workflow.md"
else
  echo "PASS: No placeholders found"
fi

# 3. Auth check
echo "=== Auth Check ==="
gcloud auth application-default print-access-token > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: No Application Default Credentials"
  FAILURES="$FAILURES\nFAIL: No ADC configured"
else
  echo "PASS: ADC configured"
fi

# 4. Build check
echo "=== Build Check ==="
if [ -f "$WS/package.json" ]; then
  HAS_BUILD=$(node -e "const p=require('$WS/package.json'); console.log(p.scripts && p.scripts.build ? 'YES' : 'NO')")
  if [ "$HAS_BUILD" = "YES" ]; then
    cd "$WS" && npm run build 2>&1
    if [ $? -ne 0 ]; then
      FAILURES="$FAILURES\nFAIL: npm run build failed"
    else
      echo "PASS: Build succeeded"
    fi
  else
    echo "SKIP: No build script in package.json"
  fi
else
  echo "SKIP: No package.json found"
fi

# 5. Cloudrun MCP health
echo "=== Cloudrun MCP Health ==="
CR_OUTPUT=$(timeout 15 npx -y @google-cloud/cloud-run-mcp --help 2>&1) || true
if echo "$CR_OUTPUT" | grep -q "Application Default Credentials are not set"; then
  echo "FAIL: Cloudrun MCP requires ADC"
  FAILURES="$FAILURES\nFAIL: Cloudrun MCP auth not configured"
elif echo "$CR_OUTPUT" | grep -q "Cloud Run MCP server"; then
  echo "PASS: Cloudrun MCP starts"
else
  echo "FAIL: Cloudrun MCP unexpected output"
  FAILURES="$FAILURES\nFAIL: Cloudrun MCP health unknown"
fi

# Summary
echo ""
echo "=== Summary ==="
if [ -z "$FAILURES" ]; then
  echo "DEPLOY OK — all checks passed"
else
  echo "DEPLOY BLOCKED"
  echo -e "$FAILURES"
fi
```
