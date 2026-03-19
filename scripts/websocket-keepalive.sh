#!/bin/bash
# WebSocket 保活脚本 - 定期发送心跳防止连接断开

INTERVAL=${1:-30}  # 默认30秒
URL="ws://127.0.0.1:18789"

echo "[$(date)] WebSocket keepalive started (interval: ${INTERVAL}s)"

while true; do
    # 使用 curl 检查健康状态来保持连接活跃
    curl -s -o /dev/null http://127.0.0.1:18789/health
    if [ $? -ne 0 ]; then
        echo "[$(date)] WARNING: Gateway health check failed!"
    fi
    sleep $INTERVAL
done
