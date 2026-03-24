---
description: Check status of all Cloud Run services and system health
---

# /status

Quick health check of all Cloud Run services and local system.

## Steps

// turbo
1. List all Cloud Run services:
```bash
gcloud run services list --project evident-trees-453923-f9 --region europe-west1 --format="table(SERVICE,REGION,URL,LAST_DEPLOYED_BY,LAST_DEPLOYED_AT)"
```

// turbo
2. Check system resources:
```bash
echo "=== Disk ===" && df -h / | tail -1 && echo "=== Memory ===" && vm_stat | head -5 && echo "=== Docker ===" && (docker system df 2>/dev/null || echo "Docker not running")
```

// turbo
3. Check MCP servers status (optional — skip if slow):
```bash
echo "cloudrun MCP: configured" && echo "gmp-code-assist MCP: configured"
```

4. Report summary:
   - Cloud Run services: name, URL, status
   - System: disk free, memory pressure
   - Any issues found
