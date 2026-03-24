---
name: mcp_health_check
description: Verify all configured MCP servers can start
---

# mcp_health_check

Check health of each MCP server by running its configured command.

## Config Source
`~/.gemini/antigravity/mcp_config.json`

## Checks per Server

| Server | Command | Expected |
|---|---|---|
| gmp-code-assist | `npx -y @googlemaps/code-assist-mcp@latest --help` | Exit 0, server starts |
| cloudrun | `npx -y @google-cloud/cloud-run-mcp --help` | Exit 0 (requires ADC) |
| gke-oss | `go run github.com/GoogleCloudPlatform/gke-mcp@latest --help` | Exit 0 (requires Go) |

## Rules
- Run each command with a 30-second timeout.
- If a command fails, do NOT retry with the same command.
- Report per server: `DONE` (healthy), `BLOCKED` (auth/toolchain issue).
- Capture the real exit code — do not pipe through `head` or other commands that mask it.

## Script
```bash
#!/usr/bin/env bash
set -uo pipefail

echo "=== gmp-code-assist ==="
OUTPUT_GMP=$(timeout 30 npx -y @googlemaps/code-assist-mcp@latest --help 2>&1) || true
EXIT_GMP=${PIPESTATUS[0]:-$?}
echo "$OUTPUT_GMP" | head -5
echo "Exit code: $EXIT_GMP"

echo "=== cloudrun ==="
OUTPUT_CR=$(timeout 30 npx -y @google-cloud/cloud-run-mcp --help 2>&1) || true
EXIT_CR=${PIPESTATUS[0]:-$?}
echo "$OUTPUT_CR" | head -5
echo "Exit code: $EXIT_CR"

echo "=== gke-oss ==="
OUTPUT_GKE=$(timeout 30 go run github.com/GoogleCloudPlatform/gke-mcp@latest --help 2>&1) || true
EXIT_GKE=${PIPESTATUS[0]:-$?}
echo "$OUTPUT_GKE" | head -5
echo "Exit code: $EXIT_GKE"

echo "=== Summary ==="
[ "$EXIT_GMP" -eq 0 ] && echo "gmp-code-assist: DONE" || echo "gmp-code-assist: BLOCKED (exit $EXIT_GMP)"
[ "$EXIT_CR" -eq 0 ] && echo "cloudrun: DONE" || echo "cloudrun: BLOCKED (exit $EXIT_CR)"
[ "$EXIT_GKE" -eq 0 ] && echo "gke-oss: DONE" || echo "gke-oss: BLOCKED (exit $EXIT_GKE)"
```
