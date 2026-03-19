#!/bin/bash
# OpenClaw 超级守护进程 - 修复版（防止重复启动）

LOG="$HOME/workspace/agent/logs/super-guardian.log"
PIDFILE="$HOME/workspace/agent/.guardian.pid"
mkdir -p "$HOME/workspace/agent/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG"
}

# 防止重复运行
if [ -f "$PIDFILE" ]; then
    OLDPID=$(cat "$PIDFILE" 2>/dev/null)
    if [ -n "$OLDPID" ] && kill -0 "$OLDPID" 2>/dev/null; then
        log "Guardian already running (PID: $OLDPID), exiting..."
        exit 0
    fi
fi
echo $$ > "$PIDFILE"

# 检查 Gateway 是否真正在运行（精确匹配，避免误判）
is_gateway_running() {
    local count=$(pgrep -f "openclaw-gateway" | wc -l)
    if [ "$count" -eq 1 ]; then
        return 0  # 正在运行且只有一个实例
    elif [ "$count" -gt 1 ]; then
        log "WARNING: Multiple Gateway instances detected ($count), fixing..."
        # 保留最老的进程，终止其他的
        local first=$(pgrep -f "openclaw-gateway" | sort -n | head -1)
        for pid in $(pgrep -f "openclaw-gateway" | sort -n | tail -n +2); do
            kill -15 $pid 2>/dev/null
            sleep 1
            kill -9 $pid 2>/dev/null
        done
        return 0
    else
        return 1  # 没有运行
    fi
}

# 启动 Gateway（确保只有一个实例）
start_gateway() {
    if is_gateway_running; then
        return 0
    fi
    
    log "Starting Gateway..."
    # 清理可能存在的僵尸进程
    pkill -9 -f "openclaw-gateway" 2>/dev/null
    sleep 1
    
    nohup openclaw gateway > /dev/null 2>&1 &
    sleep 5
    
    if is_gateway_running; then
        log "Gateway started successfully (PID: $(pgrep -f 'openclaw-gateway'))"
        return 0
    else
        log "ERROR: Failed to start Gateway!"
        return 1
    fi
}

# 健康检查（带超时）
health_check() {
    timeout 3 curl -s http://127.0.0.1:18789/health > /dev/null 2>&1
}

# 主循环
log "Super Guardian (Fixed) started [PID: $$]"

while true; do
    # 检查 Gateway 是否运行
    if ! is_gateway_running; then
        log "Gateway not running, restarting..."
        start_gateway
    elif ! health_check; then
        log "Gateway health check failed, restarting..."
        pkill -9 -f "openclaw-gateway" 2>/dev/null
        sleep 2
        start_gateway
    fi
    
    sleep 10
done
