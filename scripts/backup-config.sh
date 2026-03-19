#!/bin/bash
# 配置文件自动备份脚本
# 每次修改配置前自动创建备份

BACKUP_DIR="$HOME/workspace/agent/backups"
CONFIG_FILE="$HOME/workspace/agent/openclaw.json"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"

# 保留最近30个备份
if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" "$BACKUP_DIR/openclaw.json.$TIMESTAMP.bak"
    echo "[$(date)] Config backed up to: $BACKUP_DIR/openclaw.json.$TIMESTAMP.bak"
fi

# 清理超过30个的旧备份
ls -t "$BACKUP_DIR"/openclaw.json.*.bak 2>/dev/null | tail -n +31 | xargs rm -f 2>/dev/null
