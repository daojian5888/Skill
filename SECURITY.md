# OpenClaw 安全配置加固指南

## 🛡️ 已实施的加固措施

### 1. 自动备份机制

- **备份脚本**: `scripts/backup-config.sh`
- **备份位置**: `~/workspace/agent/backups/`
- **保留策略**: 最近 30 个备份
- **触发时机**: 建议每次修改配置前手动执行

### 2. 安全配置修改

- **脚本**: `scripts/safe-config-set.sh`
- **特性**:
  - 修改前自动创建时间戳备份
  - 修改后验证配置有效性
  - 配置无效时自动回滚

### 3. 健康检查和自动恢复

- **脚本**: `scripts/health-check.sh`
- **功能**:
  - 检测配置文件是否损坏（空文件或过小）
  - 自动从备份恢复
  - 自动重启 Gateway 服务

## 🔧 使用规范

### 修改配置的正确方式

```bash
# 方法1: 使用安全脚本
./scripts/safe-config-set.sh gateway.port 18789

# 方法2: 先备份再修改
./scripts/backup-config.sh
openclaw config set some.key value

# 方法3: 使用 openclaw 自带备份
openclaw backup create --only-config
```

### 手动恢复配置

```bash
# 如果配置损坏
openclaw config restore ~/workspace/agent/backups/openclaw.json.YYYYMMDD_HHMMSS.bak

# 或者使用备份文件
cp openclaw.json.bak openclaw.json
openclaw gateway restart
```

## ⚠️ 禁止操作

1. **不要直接编辑 openclaw.json**（除非你知道自己在做什么）
2. **不要使用 `echo > openclaw.json`** 清空配置
3. **不要在未备份的情况下批量修改配置**
4. **不要将配置备份文件提交到 Git**

## 📋 检查清单

每次修改配置前：
- [ ] 已创建备份
- [ ] 使用 `safe-config-set.sh` 或先备份
- [ ] 修改后运行 `openclaw config show` 验证
- [ ] 修改后运行 `openclaw health` 确认服务正常

## 🚨 紧急恢复

如果服务崩溃且配置损坏：

```bash
# 1. 查找最近的备份
ls -lt ~/workspace/agent/backups/*.bak | head -5

# 2. 恢复配置
cp ~/workspace/agent/backups/openclaw.json.YYYYMMDD_HHMMSS.bak \
   ~/workspace/agent/openclaw.json

# 3. 重启服务
openclaw gateway restart

# 4. 验证
openclaw health
```
