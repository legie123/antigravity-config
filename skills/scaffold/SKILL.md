---
name: scaffold
description: Generate complete project skeleton for static or Node.js Cloud Run apps
---

# scaffold

Generate all standard files for a new project, ready for Cloud Run deployment.

## Trigger
Called manually or via `/new-project` workflow.

## Parameters
- **PROJECT_NAME** — name of the project (kebab-case)
- **TYPE** — `static` or `nodejs`

## Generated Files

### For `static` type:
```
<PROJECT_NAME>/
├── index.html           # Basic HTML5 boilerplate with Google Fonts
├── style.css            # CSS reset + dark mode design system
├── app.js               # Empty JS with DOM ready listener
├── Dockerfile           # nginx:alpine, port 8080
├── nginx.conf           # Full config with gzip, cache, security headers
├── cloudbuild.yaml      # Build → Push → Deploy pipeline
├── .dockerignore
├── .gcloudignore
├── .gitignore
└── README.md
```

### For `nodejs` type:
```
<PROJECT_NAME>/
├── server.js            # Express server on port 8080
├── package.json         # With start, dev scripts
├── Dockerfile           # node:alpine, port 8080
├── cloudbuild.yaml      # Build → Push → Deploy pipeline
├── .dockerignore
├── .gcloudignore
├── .gitignore
└── README.md
```

## Rules
1. All templates MUST follow GEMINI.md rules (security headers, port 8080, cache config)
2. Use templates from `knowledge/templates.md` as base
3. `cloudbuild.yaml` substitution `_SERVICE_NAME` must be set to PROJECT_NAME
4. Memory: 128Mi for static, 256Mi for nodejs
5. Max instances: 3 for static, 10 for nodejs
6. Always include `--cpu-throttling` and `--allow-unauthenticated`
7. After scaffolding, initialize git repo: `git init && git add . && git commit -m "initial scaffold"`
8. After scaffolding, add project entry to `knowledge/projects.md`

## HTML Boilerplate (static)
```html
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="PROJECT_DESCRIPTION">
    <title>PROJECT_NAME</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <main id="app">
        <h1>PROJECT_NAME</h1>
    </main>
    <script src="app.js"></script>
</body>
</html>
```

## Node.js Server Boilerplate
```javascript
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.use(express.json());
app.use(express.static('public'));

app.get('/health', (req, res) => res.json({ status: 'ok' }));

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
```

## Output
After execution, report:
- `DONE <PROJECT_NAME>` — all files created, git initialized
- `BLOCKED` — if target directory already exists
