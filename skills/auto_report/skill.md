---
name: auto_report
description: Emit DONE/BLOCKED/NEXT status after every action
---

# auto_report

After every executed action, emit a concise status line.

## Trigger
Automatically after each file edit, command execution, or validation step.

## Exact Output Format
Each report is exactly one line, structured as:

```
<STATUS> <target> — <summary>
```

Where:
- `<STATUS>` is one of: `DONE`, `BLOCKED`, `NEXT`
- `<target>` is the file path, command, or action name
- `<summary>` is a one-line description (max 80 chars)

## Status Definitions
- **DONE** – Action completed and validated without errors.
- **BLOCKED** – Action failed or requires manual intervention. Always include the error.
- **NEXT** – Action completed; describe what comes next.

## Rules
- If validation fails, emit `BLOCKED` and stop further actions until resolved.
- Never emit more than one status line per action.
- Never emit `NEXT` if the current action failed.

## Examples

### Example 1: Successful file creation
```
DONE ~/.agents/workflows/audit-hard.md — Created and validated (YAML frontmatter OK)
```

### Example 2: Blocked by missing credentials
```
BLOCKED cloudrun MCP — Google Application Default Credentials not configured
```

### Example 3: Ready for next step
```
NEXT — Proceeding to update mcp_health_check skill in place
```
