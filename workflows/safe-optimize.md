---
description: Apply safe optimizations without user intervention
---

# /safe-optimize

Identify and apply only safe, non-destructive optimizations.

## Steps
1. Scan all JSON config files for syntax issues (trailing commas, missing keys).
2. Fix any JSON syntax errors in place and validate with `node -e "JSON.parse(...)"`.
3. Check all workflow files for valid YAML frontmatter.
4. Check all skill files for proper structure (title, purpose, implementation sections).
5. Scan for empty or orphaned files and **report them only** — do NOT auto-delete.
6. Report each change as:
   - **FIXED** – issue found and corrected
   - **REPORTED** – issue found but requires user approval to act on (e.g. orphaned files)
   - **SKIPPED** – cannot fix without user input
7. Do NOT modify credentials, auth tokens, or MCP server configurations.
8. Do NOT delete any files unless the user explicitly approves.
9. Output final summary in DONE/BLOCKED/NEXT format.
