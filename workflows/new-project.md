---
description: Scaffold a new project with all standard files, git init, and register in knowledge
---

# /new-project

Create a complete new project ready for Cloud Run deployment.

## Parameters
Ask the user for:
1. **Project name** (kebab-case, e.g. `my-cool-app`)
2. **Type**: `static` or `nodejs`
3. **Description**: one-line description for SEO meta tag

## Steps

1. Read the scaffold skill: `~/.agents/skills/scaffold/SKILL.md`

2. Create project directory at `~/projects/<project-name>/` (or current workspace)

3. Generate all files using the scaffold skill templates + `knowledge/templates.md`

4. Customize:
   - Replace `PROJECT_NAME` in all files
   - Replace `PROJECT_DESCRIPTION` in HTML meta
   - Set `_SERVICE_NAME` in `cloudbuild.yaml` to project name
   - Adjust memory/instances based on type

// turbo
5. Initialize git:
```bash
cd ~/projects/<project-name> && git init && git add . && git commit -m "initial scaffold"
```

6. Add project entry to `~/.gemini/antigravity/knowledge/projects.md`

7. Report:
   - **DONE** — list all created files
   - **BLOCKED** — if directory already exists (do NOT overwrite)

## Post-Setup (optional, ask user)
- Create GitHub repo: `gh repo create legie123/<project-name> --public --source . --push`
- Set up Cloud Build trigger
- First deploy: run `/deploy` workflow
