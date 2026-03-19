#!/bin/bash
# OpenClaw 健康检查和自动恢复脚本

LOG_FILE="$HOME/workspace/agent/logs/health-check.log"
CONFIG_FILE="$HOME/workspace/agent/openclaw.json"
BACKUP_FILE="$HOME/workspace/agent/openclaw.json.bak"

echo "[$(date)] Running health check..." >> "$LOG_FILE"

# 检查配置是否有效
if [ ! -s "$CONFIG_FILE" ] || [ $(wc -c < "$CONFIG_FILE") -lt 1000 ]; then
    echo "[$(date)] WARNING: Config file is empty or too small!" >> "$LOG_FILE"
    
    if [ -f "$BACKUP_FILE" ] && [ -s "$BACKUP_FILE" ]; then
        echo "[$(date)] Restoring from backup..." >> "$LOG_FILE"
        cp "$CONFIG_FILE" "$CONFIG_FILE.corrupted.$(date +%s)"
        cp "$BACKUP_FILE" "$CONFIG_FILE"
        echo "[$(date)] Config restored from backup." >> "$LOG_FILE"
        
        # 重启服务
        pkill -f "openclaw gateway" 2>/dev/null
        sleep 2
        nohup openclaw gateway > /dev/null 2>&1 &
        echo "[$(date)] Gateway restarted." >> "$LOG_FILE"
    fi
fi

# 检查 Gateway 是否在运行
if ! pgrep -f "openclaw gateway" > /dev/null; then
    echo "[$(date)] WARNING: Gateway is not running!" >> "$LOG_FILE"
    nohup openclaw gateway > /dev/null 2>&1 &
    echo "[$(date)] Gateway started." >> "$LOG_FILE"
fi

# 检查健康状态
if ! openclaw health > /dev/null 2>&1; then
    echo "[$(date)] WARNING: Health check failed!" >> "$LOG_FILE"
fi

echo "[$(date)] Health check completed." >> "$LOG_FILE"
