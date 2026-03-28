# 🧠 Antigravity Architecture & Decisions Log

> Acest document explică *de ce* sistemul funcționează așa cum funcționează astăzi. Folosește-l ca referință arhitecturală fundamentală când adaugi logică nouă.

---

## Decizia 1: Sursa de Adevăr Supremă
**Data**: Martie 2026
**Decizie**: Un singur fișier `.gemini/GEMINI.md` este sursa absolută care aduce la un loc toate standardele ecosistemului (Deploy, GCP, NPM).
**De ce**: A salvat sute de prompturi extra cu AI. Agenții Antigravity citeau altfel local info parțială și rescriau structuri. Acum au un environment garantat per conversație.

## Decizia 2: Anti-Loop & Hardening Protocol
**Data**: Martie 2026
**Decizie**: Încheierea ciclurilor infinite ale LLM-ului de a tot folosi același script când ceva se strică (max 2 încercări). 
**De ce**: Reducea dramatic creditele LLM utilizate, prelungea timpii de execuție, polua logurile pe mașini, producea bug-uri la re-retries oarbe. Acum dă FAIL în față și cere ajutor uman.

## Decizia 3: Standardul de Securitate NGINX
**Data**: Martie 2026
**Decizie**: Peste orice Front-end (React/Vanilla JS HTML) montăm containerizarea `nginx:alpine` cu 7 reguli de Security Headers obligatorii (CSP, Strict-Transport-Security, Permissions-Policy).
**De ce**: Protecție "by-design". Proiectele urcate (ex: Dragons Delivery) iau notă A/A+ la Security Headers fără timp irosit zilnic pe implementări secvențiale pentru fiecare proiect nou.

## Decizia 4: Workflow-urile și Autonomia (Gradual Deploy)
**Data**: Martie 2026
**Decizie**: Transformarea acțiunilor repetitive ale sistemului Antigravity în Workflow-uri ce pot fi apelate rapid cu o comandă `/` (slash command). Implementarea skill-urilor `auto_report` sau `auto_deploy` în care agentul se verifică singur și raportează "DONE" sau face roll-back direct la erori `500`.
**De ce**: Eficiență a timpului utilizatorului (developer). Dezvoltatorul e pus în rol de director tehnic, delegând către sistem sarcina de build și release-management. Devine vital pe remote.

## Decizia 5: Scratch-Pad Playground (giant-aphelion)
**Data**: Martie 2026
**Decizie**: Crearea unui director temporar izolat sub numele dat de workspace (`giant-aphelion` care e acum The Optimization Lab) pentru drafting. 
**De ce**: Garanția stabilității. Scriind scripturile grele *doar* acolo prima oară, agenții Antigravity nu strică regulile native din `~/.agents/` printr-un simplu typo în markdown header în timpul creației / prototipării sistemelor noi.
