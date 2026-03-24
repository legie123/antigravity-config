---
description: Pull latest optimizations from GitHub on remote PC
---

# /pull-config

Pull and install latest Antigravity optimizations from GitHub.

## When to Run
- When starting work on the remote PC
- After the local Mac has pushed new optimizations
- Periodically to stay in sync

## Steps
// turbo-all

1. Pull latest changes:
```bash
cd ~/antigravity-config && git pull origin main
```

2. Run installer:
```bash
cd ~/antigravity-config && bash install.sh
```

3. Verify installation:
- Check skills exist: `ls ~/.agents/skills/`
- Check workflows exist: `ls ~/.agents/workflows/`
- Check MCP config: `cat ~/.gemini/antigravity/mcp_config.json | head -5`

4. Report:
- **DONE** — all optimizations synced and installed
- **BLOCKED** — pull or install failed
