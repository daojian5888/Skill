#!/bin/bash
# 安全的配置修改脚本
# 用法: ./safe-config-set.sh <key> <value> [--json]

CONFIG_FILE="$HOME/workspace/agent/openclaw.json"
BACKUP_DIR="$HOME/workspace/agent/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ $# -lt 2 ]; then
    echo "Usage: $0 <key> <value> [--json]"
    echo "Example: $0 gateway.port 18789"
    echo "Example: $0 agents.defaults.model.primary 'minimax/MiniMax-M2.5' --json"
    exit 1
fi

KEY="$1"
VALUE="$2"
IS_JSON=false

if [ "$3" = "--json" ]; then
    IS_JSON=true
fi

# 先备份
mkdir -p "$BACKUP_DIR"
cp "$CONFIG_FILE" "$BACKUP_DIR/openclaw.json.pre-change.$TIMESTAMP.bak"
echo "[BACKUP] Created: $BACKUP_DIR/openclaw.json.pre-change.$TIMESTAMP.bak"

# 验证当前配置有效
if ! openclaw config show > /dev/null 2>&1; then
    echo "[ERROR] Current config is invalid! Aborting."
    exit 1
fi

# 执行修改
if [ "$IS_JSON" = true ]; then
    openclaw config set "$KEY" "$VALUE" --json
else
    openclaw config set "$KEY" "$VALUE"
fi

# 验证新配置
if openclaw config show > /dev/null 2>&1; then
    echo "[SUCCESS] Config updated successfully!"
    # 成功后更新 .bak 文件
    cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
else
    echo "[ERROR] New config is invalid! Restoring backup..."
    cp "$BACKUP_DIR/openclaw.json.pre-change.$TIMESTAMP.bak" "$CONFIG_FILE"
    echo "[RESTORED] Config restored from backup."
    exit 1
fi
