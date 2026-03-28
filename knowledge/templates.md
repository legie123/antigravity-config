# Templates Reutilizabile

> Copy-paste ready. Toate respectă regulile din GEMINI.md.

---

## Dockerfile — Site Static (nginx)

```dockerfile
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html/
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
```

---

## Dockerfile — Node.js App

```dockerfile
FROM node:alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 8080
CMD ["node", "server.js"]
```

---

## nginx.conf (static site, Cloud Run ready)

```nginx
worker_processes auto;
events { worker_connections 1024; }

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    sendfile on;
    keepalive_timeout 65;

    gzip on;
    gzip_types text/plain text/css application/javascript application/json image/svg+xml;
    gzip_min_length 256;

    server {
        listen 8080;
        server_name _;
        root /usr/share/nginx/html;
        index index.html;

        # Security headers
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-Content-Type-Options "nosniff" always;
        add_header X-XSS-Protection "1; mode=block" always;
        add_header Referrer-Policy "strict-origin-when-cross-origin" always;
        add_header Permissions-Policy "camera=(), microphone=(), geolocation=()" always;
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
        add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: https:;" always;

        # Cache static assets (7 days)
        location ~* \.(png|jpg|jpeg|gif|ico|svg|css|js|woff2|woff|ttf)$ {
            expires 7d;
            add_header Cache-Control "public, immutable";
        }

        # Cache HTML (5 min)
        location ~* \.html$ {
            expires 5m;
            add_header Cache-Control "public, must-revalidate";
        }

        location / {
            try_files $uri $uri/ /index.html;
        }
    }
}
```

---

## cloudbuild.yaml

```yaml
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'europe-west1-docker.pkg.dev/$PROJECT_ID/cloud-run-source-deploy/${_SERVICE_NAME}:$COMMIT_SHA', '.']

  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'europe-west1-docker.pkg.dev/$PROJECT_ID/cloud-run-source-deploy/${_SERVICE_NAME}:$COMMIT_SHA']

  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    entrypoint: gcloud
    args:
      - 'run'
      - 'deploy'
      - '${_SERVICE_NAME}'
      - '--image=europe-west1-docker.pkg.dev/$PROJECT_ID/cloud-run-source-deploy/${_SERVICE_NAME}:$COMMIT_SHA'
      - '--region=europe-west1'
      - '--allow-unauthenticated'
      - '--memory=128Mi'
      - '--cpu=1'
      - '--max-instances=3'
      - '--cpu-throttling'

substitutions:
  _SERVICE_NAME: 'my-service'

images:
  - 'europe-west1-docker.pkg.dev/$PROJECT_ID/cloud-run-source-deploy/${_SERVICE_NAME}:$COMMIT_SHA'
```

---

## .dockerignore

```
.git
.gitignore
.DS_Store
node_modules
npm-debug.log
.env
README.md
.agents
.gemini
cloudbuild.yaml
```

---

## .gcloudignore

```
.git
.gitignore
.DS_Store
node_modules
.env
.agents
.gemini
```

---

## .gitignore

```
node_modules/
.DS_Store
.env
.npm-cache/
dist/
```
