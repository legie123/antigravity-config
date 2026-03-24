---
description: Full hardening audit of the Antigravity setup
---

# /audit-hard

Run a comprehensive audit of all configuration, MCP servers, skills, and workflows.

## Steps
1. Read and validate `~/.gemini/settings.json` (JSON parse check).
2. Read and validate `~/projects/antigravity_workspace/.gemini/settings.json`.
3. List all workflows in `~/.agents/workflows/` and confirm each has valid YAML frontmatter.
4. List all skills in `~/.agents/skills/` and confirm each has a `skill.md`.
5. For each MCP server in `mcp_config.json`, run its command with `--help` and capture exit code.
6. Report findings as:
   - **PASS** – file exists and validates
   - **FAIL** – file missing, invalid, or command fails
   - **BLOCKED** – requires manual action (credentials, installs)
7. Output final summary in DONE/BLOCKED/NEXT format.
