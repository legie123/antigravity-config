---
description: Rules for browser tool usage
---

# Browser Usage Policy

## When to Use the Browser Tool
- Visual verification of UI changes.
- Testing web applications after deployment.
- Capturing screenshots for walkthroughs.
- Checking responsive layout behavior.

## When NOT to Use the Browser Tool
- Reading static documentation (use `read_url_content` instead).
- Fetching API responses (use `run_command` with `curl`).
- Downloading files (use `run_command` with `curl` or `wget`).

## Rules
1. **Minimize browser sessions** — open only when visual verification is needed.
2. **Close when done** — do not leave browser sessions running.
3. **No login flows** — if a page requires authentication, report BLOCKED.
4. **Screenshot evidence** — capture a screenshot after every visual check.
5. **Timeout** — if a page takes more than 15 seconds to load, report BLOCKED.
6. **No parallel browser sessions** — one at a time.
