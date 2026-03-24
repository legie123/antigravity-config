---
description: Verify changes after every file edit
---

# /postchange-verify

Run after every file modification to confirm integrity.

## Steps
// turbo
1. If the changed file is JSON, validate with `node -e "JSON.parse(require('fs').readFileSync('<path>','utf8'))"`.
// turbo
2. If the changed file is Markdown with YAML frontmatter, check the frontmatter is present and has a `description` field.
// turbo
3. If the changed file is JavaScript/TypeScript, run `node --check <path>` to verify syntax.
4. Compare file size before and after – flag if the file grew by more than 200% or shrank to 0 bytes.
5. Report:
   - **PASS** – file validates
   - **FAIL** – validation error with details
