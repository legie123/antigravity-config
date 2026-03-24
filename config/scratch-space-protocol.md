---
description: Scratch Space Protocol
---

# Scratch Space Protocol

This document defines how to use the temporary scratch directory for quick experiments without polluting the main workspace.

- **Location**: `/Users/user/.gemini/antigravity/scratch`
- **Purpose**: Run short scripts, test snippets, generate temporary files.
- **Guidelines**:
  1. Create a sub‑folder for each experiment (e.g., `exp-001`).
  2. Delete the folder after the experiment is finished.
  3. Do not commit anything from `scratch` to version control.
  4. Use `git clean -fd` in the workspace to ensure no stray files remain.

**Example**:
```sh
mkdir -p ~/.gemini/antigravity/scratch/exp-001
# ... run your test script ...
rm -rf ~/.gemini/antigravity/scratch/exp-001
```
