---
description: High-value integrations workflow
---

# High‑Value Integrations

## Developer Knowledge MCP
- **Purpose:** Provides contextual code suggestions, documentation lookup, and best‑practice recommendations for developers.
- **When to Use:** During coding sessions, refactoring, or when searching for API usage examples.
- **Auth Requirements:** None – operates locally using cached knowledge bases.
- **Timeout/Fallback:** Immediate response; if the knowledge base is unavailable, fallback to a generic web search.

## Google Data / Database MCP Options
- **BigQuery MCP**
  - **Purpose:** Execute SQL queries against large datasets, retrieve analytics results.
  - **When to Use:** For data‑analysis tasks, reporting, or feeding results into applications.
  - **Auth Requirements:** Google Cloud service‑account key with `roles/bigquery.user`.
  - **Timeout/Fallback:** 60 seconds per query; on timeout, report `BLOCKED` and suggest reducing query size.

- **Firestore MCP**
  - **Purpose:** Interact with NoSQL document database for real‑time apps.
  - **When to Use:** Storing user preferences, session data, or any hierarchical JSON‑like data.
  - **Auth Requirements:** Service‑account with `roles/datastore.user`.
  - **Timeout/Fallback:** 30 seconds; on failure, report `BLOCKED` and suggest checking network connectivity.

- **Cloud SQL MCP**
  - **Purpose:** Manage relational databases (PostgreSQL, MySQL) via SQL commands.
  - **When to Use:** Legacy relational data migrations, complex joins, transactional workloads.
  - **Auth Requirements:** Service‑account with `cloudsql.instances.connect` and appropriate DB credentials.
  - **Timeout/Fallback:** 45 seconds; on timeout, report `BLOCKED` and advise splitting operations.

## General Guidance
- **Health Checks:** Run each MCP's `--help` command before use (see `mcp-usage-policy.md`).
- **Credential Management:** Store all keys in environment variables or secret manager; never hard‑code.
- **Error Handling:** On any `BLOCKED` status, log the error and continue with remaining integrations.

---
*Created as part of the hardening pass.*
