#!/bin/bash
# OpenClaw 超级守护进程 - 解决网关断开连接问题

LOG="$HOME/workspace/agent/logs/super-guardian.log"
mkdir -p "$HOME/workspace/agent/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG"
}

# 检查并启动网关
ensure_gateway() {
    if ! pgrep -f "openclaw gateway" > /dev/null 2>&1; then
        log "Gateway not running, starting..."
        nohup openclaw gateway > /dev/null 2>&1 &
        sleep 5
        
        if pgrep -f "openclaw gateway" > /dev/null; then
            log "Gateway started successfully (PID: $(pgrep -f 'openclaw gateway' | head -1))"
        else
            log "ERROR: Failed to start Gateway!"
            # 尝试从备份恢复
            if [ -f "$HOME/workspace/agent/openclaw.json.bak" ]; then
                log "Restoring config from backup..."
                cp "$HOME/workspace/agent/openclaw.json" "$HOME/workspace/agent/openclaw.json.broken.$(date +%s)"
                cp "$HOME/workspace/agent/openclaw.json.bak" "$HOME/workspace/agent/openclaw.json"
                nohup openclaw gateway > /dev/null 2>&1 &
            fi
        fi
    fi
}

# 保活心跳 - 防止 WebSocket 断开
keepalive() {
    while true; do
        if curl -s -o /dev/null http://127.0.0.1:18789/health; then
            : # Gateway is healthy
        else
            log "Health check failed!"
        fi
        sleep 30
    done
}

# 主循环
log "Super Guardian started"

# 启动保活进程
keepalive &
KEEPALIVE_PID=$!

while true; do
    ensure_gateway
    sleep 10
done
