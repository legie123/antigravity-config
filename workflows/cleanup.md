---
description: System cleanup — free disk, memory, and Docker resources
---

# /cleanup

Free up system resources on the Mac.

// turbo-all

## Steps

1. Kill memory-heavy processes (if not needed):
```bash
killall Safari 2>/dev/null; killall "Google Chrome" 2>/dev/null; echo "Browsers closed"
```

2. Clear npm cache:
```bash
rm -rf ~/.npm/_cacache/* && echo "npm cache cleared"
```

3. Docker cleanup (if Docker is running):
```bash
docker system prune -f 2>/dev/null && echo "Docker pruned" || echo "Docker not running, skipped"
```

4. Clear system caches:
```bash
rm -rf ~/Library/Caches/com.apple.dt.Xcode 2>/dev/null; rm -rf /tmp/antigravity_* 2>/dev/null; echo "Temp files cleared"
```

5. Check free space after cleanup:
```bash
echo "=== Disk After Cleanup ===" && df -h / | tail -1 && echo "=== Memory ===" && memory_pressure | head -1
```

6. Report:
   - Disk space freed
   - Memory state
   - Any errors
