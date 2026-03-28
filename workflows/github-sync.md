---
description: Sync all Antigravity optimizations to GitHub repo
---

# /github-sync

Push latest skills, workflows, knowledge and configs to `legie123/antigravity-config` GitHub repo.

## When to Run
- After creating/editing any skill in `~/.agents/skills/`
- After creating/editing any workflow in `~/.agents/workflows/`
- After changing `GEMINI.md`, `mcp_config.json` or workspace settings
- Antigravity should run this automatically after any optimization

## Steps
// turbo-all

1. Copy skills to repo:
```bash
cp -R ~/.agents/skills/* ~/.gemini/antigravity/scratch/antigravity-config/skills/
```

2. Copy workflows to repo:
```bash
cp ~/.agents/workflows/*.md ~/.gemini/antigravity/scratch/antigravity-config/workflows/
```

3. Copy knowledge to repo:
```bash
mkdir -p ~/.gemini/antigravity/scratch/antigravity-config/knowledge
cp ~/.gemini/antigravity/knowledge/*.md ~/.gemini/antigravity/scratch/antigravity-config/knowledge/
```

4. Copy configs to repo:
```bash
cp ~/projects/antigravity_workspace/.gemini/settings.json ~/.gemini/antigravity/scratch/antigravity-config/config/
cp ~/.gemini/antigravity/scratch-space-protocol.md ~/.gemini/antigravity/scratch/antigravity-config/config/
cp ~/.gemini/GEMINI.md ~/.gemini/antigravity/scratch/antigravity-config/config/
```

5. Commit and push:
```bash
cd ~/.gemini/antigravity/scratch/antigravity-config && git add -A && git diff --cached --quiet || (git commit -m "🔄 sync: updated optimizations $(date +%Y-%m-%d_%H:%M)" && git push)
```

6. Report result:
- **DONE** — changes pushed to GitHub
- **SKIPPED** — no changes detected
- **BLOCKED** — push failed
