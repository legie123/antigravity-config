---
name: scratch_test
description: Run temporary experiments in an isolated scratch directory
---

# scratch_test

Execute commands in an isolated scratch folder, then clean up automatically.

## Scratch Location
`~/projects/antigravity_workspace/scratch/`

## Usage
```
scratch_test "<command>"
```

## Accepted Command Patterns
Only the following patterns are accepted (no shell metacharacters, no pipes, no redirects):
- Simple commands: `node script.js`, `npm test`, `python3 test.py`
- Commands with flags: `node --check file.js`, `npm run lint`
- Rejected: anything containing `|`, `>`, `<`, `;`, `&&`, `||`, `` ` ``, `$()`

## Steps
1. Create a timestamped subdirectory: `scratch/exp-$(date +%s)`
2. Copy any needed files into the subdirectory.
3. Validate the command against accepted patterns (reject unsafe input).
4. Run the command inside the subdirectory using `bash -c` (not `eval`).
5. Capture stdout, stderr, and exit code.
6. Delete the subdirectory after execution.
7. Report `DONE` if exit code 0, `BLOCKED` otherwise.

## Safety Rules
- Never modify files outside the scratch directory.
- Always clean up, even on failure.
- Do not commit scratch files to version control.
- Maximum scratch directory lifetime: 5 minutes.

## Script
```bash
#!/usr/bin/env bash
set -uo pipefail
CMD="$1"

# Reject unsafe patterns
if echo "$CMD" | grep -qE '[|><;]|\&\&|\|\||`|\$\('; then
  echo "BLOCKED — Unsafe command pattern rejected: $CMD"
  exit 1
fi

SCRATCH="$HOME/projects/antigravity_workspace/scratch/exp-$(date +%s)"
mkdir -p "$SCRATCH"
cd "$SCRATCH" || exit 1

bash -c "$CMD" 2>&1
EXIT_CODE=$?

cd - > /dev/null
rm -rf "$SCRATCH"

if [ "$EXIT_CODE" -eq 0 ]; then
  echo "DONE"
else
  echo "BLOCKED — exit code $EXIT_CODE"
fi
exit $EXIT_CODE
```
