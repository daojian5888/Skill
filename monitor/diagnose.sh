#!/bin/bash
# OpenClaw 快速诊断工具

echo "=========================================="
echo "OpenClaw 系统诊断报告"
echo "时间: $(date)"
echo "=========================================="
echo ""

echo "【1. 服务状态检查】"
HEALTH=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:18789/__openclaw__/health 2>/dev/null)
if [ "$HEALTH" = "200" ]; then
  echo "✅ 服务运行正常 (HTTP 200)"
else
  echo "❌ 服务异常 (HTTP $HEALTH)"
fi
echo ""

echo "【2. 进程检查】"
ps aux | grep -E "openclaw|PID" | grep -v grep | head -5
echo ""

echo "【3. 端口检查】"
ss -tlnp 2>/dev/null | grep 18789 || echo "端口 18789 未监听"
echo ""

echo "【4. 模型配置】"
grep '"primary"' /home/gem/workspace/agent/openclaw.json
echo ""

echo "【5. 最近错误日志】"
tail -10 /home/gem/workspace/agent/logs/startup.log 2>/dev/null | grep -E "error|fail|Error|Fail" || echo "暂无错误"
echo ""

echo "【6. 磁盘空间】"
df -h /home/gem 2>/dev/null | tail -1
echo ""

echo "【7. 内存使用】"
free -h 2>/dev/null | head -2
echo ""

echo "=========================================="
echo "诊断完成"
echo "如需重启服务: sh /home/gem/workspace/agent/scripts/restart.sh"
echo "=========================================="
