#!/bin/bash
# 一键状态检查脚本

echo "=========================================="
echo "     OpenClaw 状态检查报告"
echo "=========================================="
echo ""

# 检查 Gateway 进程
if pgrep -f "openclaw gateway" > /dev/null; then
    PID=$(pgrep -f "openclaw gateway" | head -1)
    echo "✅ Gateway 进程: 运行中 (PID: $PID)"
else
    echo "❌ Gateway 进程: 未运行"
fi

# 检查守护进程
if pgrep -f "guardian.sh" > /dev/null; then
    PID=$(pgrep -f "guardian.sh" | head -1)
    echo "✅ 守护进程: 运行中 (PID: $PID)"
else
    echo "⚠️ 守护进程: 未运行"
fi

# 检查配置
echo ""
echo "配置状态:"
if openclaw config show > /dev/null 2>&1; then
    echo "  ✅ 配置文件有效"
else
    echo "  ❌ 配置文件损坏"
fi

# 检查备份
echo ""
echo "备份状态:"
BACKUP_COUNT=$(ls ~/workspace/agent/openclaw.json*.bak* 2>/dev/null | wc -l)
echo "  📦 备份文件数量: $BACKUP_COUNT"

# 显示最近备份时间
NEWEST=$(ls -lt ~/workspace/agent/openclaw.json*.bak* 2>/dev/null | head -1 | awk '{print $6, $7, $8}')
if [ -n "$NEWEST" ]; then
    echo "  🕐 最新备份: $NEWEST"
fi

echo ""
echo "=========================================="
