#!/bin/bash
# 修复 WebSocket 事件序列间隙 - 完整方案

echo "========================================="
echo "  WebSocket Event Gap 修复工具"
echo "========================================="

# 1. 检查 Gateway 状态
echo ""
echo "[1/4] 检查 Gateway 状态..."
GATEWAY_COUNT=$(pgrep -c -f "openclaw-gateway")
if [ "$GATEWAY_COUNT" -eq 1 ]; then
    echo "  ✅ Gateway 正常运行 (1个实例)"
    HEALTH=$(curl -s http://127.0.0.1:18789/health 2>/dev/null)
    echo "  Health: $HEALTH"
elif [ "$GATEWAY_COUNT" -gt 1 ]; then
    echo "  ⚠️  发现 $GATEWAY_COUNT 个 Gateway 实例，正在修复..."
    pkill -9 -f "openclaw-gateway"
    sleep 2
    nohup openclaw gateway > /dev/null 2>&1 &
    sleep 3
    echo "  ✅ 已重启为单实例"
else
    echo "  ❌ Gateway 未运行，正在启动..."
    nohup openclaw gateway > /dev/null 2>&1 &
    sleep 3
    echo "  ✅ Gateway 已启动"
fi

# 2. 检查会话文件
echo ""
echo "[2/4] 检查会话存储..."
SESSION_DIR="$HOME/workspace/agent/agents/main/sessions"
if [ -d "$SESSION_DIR" ]; then
    SESSION_COUNT=$(find "$SESSION_DIR" -name "*.jsonl" 2>/dev/null | wc -l)
    echo "  会话文件数: $SESSION_COUNT"
else
    echo "  会话目录不存在"
fi

# 3. 清理旧会话文件（可选）
echo ""
echo "[3/4] 清理临时文件..."
rm -f ~/workspace/agent/.guardian.pid 2>/dev/null
find /tmp -name "gateway*.log" -mtime +1 -delete 2>/dev/null
echo "  ✅ 已清理"

# 4. 检查浏览器连接
echo ""
echo "[4/4] 当前连接状态:"
echo "  Gateway PID: $(pgrep -f 'openclaw-gateway')"
echo "  Health: $(curl -s http://127.0.0.1:18789/health 2>/dev/null)"

echo ""
echo "========================================="
echo "  修复完成！"
echo "========================================="
echo ""
echo "【用户操作】请在浏览器中执行："
echo "  1. 刷新页面 (Ctrl/Cmd + R)"
echo "  2. 如仍有问题，清除浏览器缓存后刷新"
echo "  3. 或点击 'New session' 开始新会话"
echo ""
