#!/bin/bash
# OpenClaw 守护进程 - 每分钟检查一次，自动恢复

LOG="$HOME/workspace/agent/logs/guardian.log"
mkdir -p "$HOME/workspace/agent/logs"

# 检查 Gateway 是否运行
check_gateway() {
    if ! pgrep -f "openclaw gateway" > /dev/null 2>&1; then
        echo "[$(date)] Gateway not running, restarting..." >> "$LOG"
        nohup openclaw gateway > /dev/null 2>&1 &
        sleep 3
        
        if pgrep -f "openclaw gateway" > /dev/null; then
            echo "[$(date)] Gateway restarted successfully" >> "$LOG"
        else
            echo "[$(date)] Failed to restart Gateway!" >> "$LOG"
        fi
    fi
}

# 检查配置是否有效
check_config() {
    if ! openclaw config show > /dev/null 2>&1; then
        echo "[$(date)] Config invalid! Attempting restore..." >> "$LOG"
        
        BACKUP="$HOME/workspace/agent/openclaw.json.bak"
        if [ -f "$BACKUP" ]; then
            cp "$HOME/workspace/agent/openclaw.json" "$HOME/workspace/agent/openclaw.json.broken.$(date +%s)"
            cp "$BACKUP" "$HOME/workspace/agent/openclaw.json"
            pkill -f "openclaw gateway"
            sleep 2
            nohup openclaw gateway > /dev/null 2>&1 &
            echo "[$(date)] Config restored and Gateway restarted" >> "$LOG"
        fi
    fi
}

# 检查健康状态
check_health() {
    if ! openclaw health > /dev/null 2>&1; then
        echo "[$(date)] Health check failed!" >> "$LOG"
    fi
}

# 主循环
while true; do
    check_gateway
    check_config
    check_health
    sleep 60
done
