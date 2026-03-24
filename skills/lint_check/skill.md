---
name: lint_check
description: Run the project linter and report results
---

# lint_check

Run lint checks on the active workspace and report pass/fail.

## Workspace
`~/projects/antigravity_workspace`

## Steps
1. Check if `package.json` exists in the workspace.
2. Check if a `lint` script is defined in `package.json`.
3. If YES, run `npm run lint` and capture output and exit code.
4. If NO `package.json` or no `lint` script, report `SKIPPED`.

## Output
- **DONE** – lint passed (exit code 0)
- **BLOCKED** – lint failed (include error output)
- **SKIPPED** – no `package.json` or no lint script configured

## Script
```bash
#!/usr/bin/env bash
set -uo pipefail
WS="$HOME/projects/antigravity_workspace"
cd "$WS" || { echo "BLOCKED — workspace not found"; exit 1; }

if [ ! -f package.json ]; then
  echo "SKIPPED — no package.json found"
  exit 0
fi

HAS_LINT=$(node -e "const p=require('./package.json'); console.log(p.scripts && p.scripts.lint ? 'YES' : 'NO')")
if [ "$HAS_LINT" = "YES" ]; then
  npm run lint 2>&1
  EXIT_CODE=$?
  if [ "$EXIT_CODE" -eq 0 ]; then
    echo "DONE — lint passed"
  else
    echo "BLOCKED — lint failed (exit code $EXIT_CODE)"
  fi
  exit $EXIT_CODE
else
  echo "SKIPPED — no lint script defined in package.json"
  exit 0
fi
```
