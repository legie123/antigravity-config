---
description: MCP usage policy workflow
---

# MCP Usage Policy

This workflow defines how each configured MCP server should be used, including health‑check procedures, authentication requirements, and timeout/fallback behavior.

## Servers

- **cloudrun**
  - **Purpose:** Deploy and manage Cloud Run services.
  - **Health Check:** Run `npx -y @google-cloud/cloud-run-mcp --help` with a 30 s timeout.
  - **Auth:** Requires a valid Google Cloud service‑account key with `roles/run.admin`.
  - **Timeout:** 30 seconds per command.
  - **Fallback:** If health check fails, report `BLOCKED` and skip Cloud Run operations.

- **gmp-code-assist**
  - **Purpose:** Provide Google Maps Platform code assistance.
  - **Health Check:** Run `npx -y @googlemaps/code-assist-mcp --help` with a 30 s timeout.
  - **Auth:** Requires a Maps API key set in the environment variable `GMAPS_API_KEY`.
  - **Timeout:** 30 seconds.
  - **Fallback:** On failure, report `BLOCKED` and continue without code‑assist features.

- **gke-oss**
  - **Purpose:** Interact with GKE clusters via the open‑source MCP.
  - **Health Check:** Run `go run github.com/GoogleCloudPlatform/gke-mcp@latest --help` with a 30 s timeout.
  - **Auth:** Requires `kubectl` configured with appropriate cluster credentials.
  - **Timeout:** 30 seconds.
  - **Fallback:** If health check fails, report `BLOCKED` and skip GKE‑related actions.

## General Rules

1. **Run health checks** before any MCP command execution.
2. **Enforce timeout** of 30 seconds; abort and report `BLOCKED` on timeout.
3. **Log output** to `mcp_health.log` for audit purposes.
4. **Never expose credentials** in logs or UI.
5. **If a server is unavailable**, continue with remaining servers.

---
*This file was created as part of the hardening pass.*
