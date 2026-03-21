#!/bin/bash
# OpenClaw 健康检查与自动恢复脚本

LOG_FILE="/home/gem/workspace/agent/logs/health-check.log"
PID_FILE="/tmp/openclaw-health-check.pid"

# 防止重复运行
if [ -f "$PID_FILE" ]; then
  OLD_PID=$(cat "$PID_FILE" 2>/dev/null)
  if ps -p "$OLD_PID" > /dev/null 2>&1; then
    echo "$(date): 健康检查已在运行 (PID: $OLD_PID)" >> "$LOG_FILE"
    exit 0
  fi
fi
echo $$ > "$PID_FILE"

# 健康检查函数
check_health() {
  local response
  response=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:18789/__openclaw__/health 2>/dev/null)
  if [ "$response" = "200" ]; then
    return 0
  fi
  return 1
}

# 记录日志
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_FILE"
}

# 主检查逻辑
if ! check_health; then
  log "❌ 健康检查失败，尝试重启服务..."
  
  # 清理残留
  pkill -9 -f openclaw 2>/dev/null
  rm -f /tmp/openclaw*.lock /tmp/openclaw*.sock 2>/dev/null
  sleep 2
  
  # 启动服务
  cd /home/gem/workspace/agent || exit 1
  nohup node node_modules/openclaw/openclaw.mjs gateway run --port 18789 > logs/startup.log 2>&1 &
  sleep 10
  
  # 验证
  if check_health; then
    log "✅ 服务重启成功"
  else
    log "❌ 服务重启失败，请检查日志"
    tail -20 logs/startup.log >> "$LOG_FILE"
  fi
else
  log "✅ 健康检查通过"
fi

rm -f "$PID_FILE"
