#!/bin/bash
# 事件序列间隙分析器 - 诊断 WebSocket 事件丢失问题

LOG="$HOME/workspace/agent/logs/event-gap.log"
mkdir -p "$HOME/workspace/agent/logs"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] === Event Gap Analysis ===" | tee -a "$LOG"

# 检查 Gateway 运行时间
echo "Gateway uptime:" | tee -a "$LOG"
for pid in $(pgrep -f "openclaw-gateway"); do
    echo "  PID $pid: $(ps -o etime= -p $pid)" | tee -a "$LOG"
done

# 检查会话状态
echo "Active sessions:" | tee -a "$LOG"
openclaw status 2>&1 | grep -E "Sessions|session" | head -5 | tee -a "$LOG"

# 检查网络连接数
echo "WebSocket connections:" | tee -a "$LOG"
ss -tn 2>/dev/null | grep :18789 | wc -l | xargs -I {} echo "  Active connections: {}" | tee -a "$LOG"

# 检查错误日志
echo "Recent errors:" | tee -a "$LOG"
openclaw logs --lines 50 2>&1 | grep -iE "(error|fail|disconnect|gap|seq|websocket)" | tail -5 | tee -a "$LOG"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Analysis complete" | tee -a "$LOG"
echo "" | tee -a "$LOG"
