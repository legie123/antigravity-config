# Proiecte — Documentație

> Referință rapidă pentru toate proiectele. Actualizat manual la fiecare proiect nou.

---

## Dragons Delivery
| Proprietate | Valoare |
|-------------|---------|
| **Tip** | Site static (HTML/CSS/JS) |
| **Container** | `nginx:alpine` |
| **Status** | ✅ Live |
| **Cloud Run URL** | https://dragons-delivery-657910053930.europe-west1.run.app |
| **Cloud Run Service** | `dragons-delivery` |
| **GitHub Repo** | `legie123/dragons-delivery` |
| **Local Path** | TBD (verifică) |
| **Deploy** | `gcloud run deploy dragons-delivery --source . --region europe-west1 --allow-unauthenticated --memory 128Mi --cpu 1 --max-instances 3 --cpu-throttling` |
| **CI/CD** | GitHub → Cloud Build → Cloud Run |

---

## DS APP V2
| Proprietate | Valoare |
|-------------|---------|
| **Tip** | Node.js app |
| **Container** | `node:alpine` |
| **Status** | 🔧 In development |
| **Cloud Run URL** | — |
| **Local Path** | TBD |
| **Deploy** | `gcloud run deploy ds-app-v2 --source . --region europe-west1 --allow-unauthenticated --memory 256Mi --cpu 1 --max-instances 10 --cpu-throttling` |

---

## TRADE AI
| Proprietate | Valoare |
|-------------|---------|
| **Tip** | Trading bot (Node.js) |
| **Container** | `node:alpine` |
| **Status** | 🔧 In development |
| **Cloud Run URL** | — |
| **Local Path** | TBD |
| **Note** | Necesită API keys în env vars, NU în cod |

---

## openclaw-monitor
| Proprietate | Valoare |
|-------------|---------|
| **Tip** | Node.js monitoring service |
| **Container** | `node:alpine` |
| **Status** | 🔧 In development |
| **Cloud Run URL** | — |
| **Local Path** | TBD |

---

## START ANTy'profi
| Proprietate | Valoare |
|-------------|---------|
| **Tip** | — |
| **Status** | 📁 Stored/Archived |

---

## Adăugare Proiect Nou
Când creezi un proiect nou, adaugă o secțiune aici cu tabelul de mai sus.
Folosește `/new-project` workflow pentru scaffold automat.
