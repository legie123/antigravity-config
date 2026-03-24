---
description: Prevent infinite loops and repeated failures
---

# Anti-Loop Policy

## Rules
1. **Max 2 retries** — if the same command fails twice, stop and report BLOCKED.
2. **No identical retry** — never re-run a command with the exact same arguments after it failed.
3. **Error dedup** — if the same error message appears twice, stop immediately.
4. **Escalate** — after hitting a loop, report BLOCKED with full details.
5. **Change strategy** — if retry is needed, modify the approach (different args, different tool, or skip).

## Exact Stop Conditions
- A command returns the same non-zero exit code twice in a row.
- The same error string appears in output across 2 consecutive runs.
- The same file edit is attempted and rejected by the tool 2 times.
- A tool call returns the same error message on 2 consecutive invocations.
- The assistant produces identical output text that triggers a loop-detection flag.

## Detection Signals
- Same exit code from the same command 2+ times.
- Same error string in stdout/stderr across consecutive runs.
- Same file edit attempted and rejected 2+ times.
- Tool call returning the same error message consecutively.

## Response
When a loop is detected, immediately stop all work and output exactly:

```
BLOCKED — Loop detected
Command: <exact command that was repeated>
Error: <exact error message>
Attempts: <number of times attempted>
Last exit code: <exit code or N/A>
Action: Stopping. Manual intervention required.
```

## Post-Loop Actions
1. Do NOT attempt the same command again.
2. Do NOT attempt a workaround without user approval.
3. Log the loop event in the current task summary.
4. Wait for user input before proceeding.
