---
description: Deploy workflow placeholder
---

# Deploy Workflow (Placeholder)

This workflow outlines the steps for deploying a project to Cloud Run. Replace the placeholder commands with your actual deployment steps.

1. **Build** – `npm run build`
2. **Package** – `docker build -t gcr.io/<PROJECT_ID>/<SERVICE_NAME>:latest .`
3. **Push** – `docker push gcr.io/<PROJECT_ID>/<SERVICE_NAME>:latest`
4. **Deploy** – `gcloud run deploy <SERVICE_NAME> --image gcr.io/<PROJECT_ID>/<SERVICE_NAME>:latest --region europe-west1`

*Update the `<PROJECT_ID>` and `<SERVICE_NAME>` placeholders before running.*
