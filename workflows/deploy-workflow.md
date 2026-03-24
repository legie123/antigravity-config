---
description: Deploy a project to Cloud Run using gcloud source deploy
---

# /deploy

Deploy the current project to Cloud Run. Uses `--source .` for simplicity (Cloud Build handles Docker).

## Prerequisites
- `gcloud` authenticated (`gcloud auth login`)
- Project has a `Dockerfile` in root
- Working directory is the project root

## Steps

// turbo
1. Verify Dockerfile exists — `ls Dockerfile`

// turbo
2. Verify gcloud auth — `gcloud auth print-access-token > /dev/null 2>&1 && echo "AUTH OK" || echo "AUTH FAIL"`

3. Deploy to Cloud Run:
```bash
gcloud run deploy SERVICE_NAME \
  --source . \
  --project evident-trees-453923-f9 \
  --region europe-west1 \
  --allow-unauthenticated \
  --memory 128Mi \
  --cpu 1 \
  --max-instances 3 \
  --cpu-throttling
```

> **Note**: Adjust `SERVICE_NAME` to match the project name.
> Adjust `--memory` and `--max-instances` based on project type:
> - Static: `128Mi`, max `3`
> - Node.js: `256Mi`, max `10`
> - Heavy: `512Mi`, max `10`

// turbo
4. Verify deployment — `gcloud run services describe SERVICE_NAME --region europe-west1 --format="value(status.url)"`

5. Report:
   - **DONE** — deployed successfully, print URL
   - **BLOCKED** — deployment failed, show error
