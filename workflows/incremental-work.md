---
description: Reguli de lucru incremental - nu te bloca, faci pas cu pas
---

# Reguli de Lucru Incremental

Aceste reguli se aplică ÎNTOTDEAUNA în toate conversațiile.

## Principii Fundamentale

1. **Task-uri mici și incrementale** — Împarte fiecare lucru în pași mici, realizabili. NU încerca să rezolvi totul dintr-o dată.

2. **Un pas la un moment dat** — Termină un pas, confirmă că funcționează, apoi treci la următorul. Fără paralelism excesiv.

3. **Fără supraîncărcare** — Dacă un task e prea mare, sparge-l în bucăți mai mici.

4. **Comunicare clară** — Spune ce faci acum, ce urmează, și dacă ai nevoie de ceva.

5. **Prioritizare** — Întâi ce e esențial și funcțional, apoi polish și detalii.

## Reguli Concrete

- **NU edita mai mult de 2-3 fișiere simultan** — editează 1-2, verifică, apoi continuă
- **NU face planuri gigantice** — planuri scurte, execuție rapidă, feedback de la user
- **Dacă ceva e complex**, propune etape și lasă user-ul să aleagă ordinea
- **Dacă te blochezi pe ceva**, sari peste și revii mai târziu
- **Verifică după fiecare pas** — nu acumula schimbări neverificate
- **Dacă un edit eșuează**, nu repeta aceeași abordare — schimbă strategia

## DONE/BLOCKED/NEXT Criteria
- **DONE** – Edit applied, validated, and reported without errors.
- **BLOCKED** – Validation failed or manual intervention required.
- **NEXT** – Step completed successfully; ready for the following step.

## Fallback Matrix
| Situation          | Action |
|--------------------|--------|
| Validation fails   | Revert change, report `BLOCKED`, await guidance |
| Unexpected error   | Log error, create checkpoint, report `BLOCKED` |
| Missing dependency | Report `BLOCKED` with details, suggest install |

## Block vs Skip Rules
- **Block**: Changes affecting credentials, auth tokens, or MCP server configs.
- **Skip**: Non‑critical formatting, comments, whitespace adjustments.

## Safe‑to‑Continue Rules
- After a successful `DONE`, run a quick sanity check (e.g., `npm run lint` or JSON parse) before proceeding.
- If the check passes, automatically mark `NEXT`; otherwise, `BLOCKED`.
