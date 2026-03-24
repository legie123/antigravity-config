---
description: Check health of all configured MCP servers
---

# /mcp-check

Verify each MCP server can start and report status.

## Steps
1. Read `~/.gemini/antigravity/mcp_config.json`.
2. For each server, run its exact command + args with `--help`:
   - `npx -y @googlemaps/code-assist-mcp@latest --help`
   - `npx -y @google-cloud/cloud-run-mcp --help`
   - `go run github.com/GoogleCloudPlatform/gke-mcp@latest --help`
3. Capture exit code, stdout, and stderr for each.
4. Report per server:
   - **DONE** – exit code 0, server starts
   - **BLOCKED** – auth required or toolchain missing
5. If the same command fails twice, stop retrying and report BLOCKED.
