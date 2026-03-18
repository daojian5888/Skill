# 快速开始 - OpenClaw ↔ 微搭对接

## 部署步骤

### 第一步：OpenClaw 端配置

1. **启用 Webhook（如需要双向通信）**

编辑 `openclaw.json`：

```json
{
  "hooks": {
    "enabled": true,
    "token": "your-secure-token-32-chars-min",
    "path": "/hooks",
    "allowedAgentIds": ["hooks", "main"]
  }
}
```

生成 token：
```bash
openssl rand -base64 32
```

2. **重启 OpenClaw**

```bash
openclaw gateway restart
```

3. **确认 Skill 已加载**

```bash
openclaw skills list
```

应该能看到 `weda-connector`。

### 第二步：微搭端配置

1. **创建环境变量**

进入微搭控制台 → 环境变量：

```
OPENCLAW_HOOK_TOKEN = your-secure-token-32-chars-min
OPENCLAW_BASE_URL = http://your-openclaw-server:18789
```

2. **创建自定义 API**

创建 `openclawNotifier`，选择「自定义代码」方式。

复制 `weda-side-code.md` 中的代码。

3. **创建数据桥接 API**

创建 `openclawDataBridge`，包含方法：
- `queryData` - 查询数据
- `createData` - 创建数据
- `updateData` - 更新数据
- `deleteData` - 删除数据

4. **测试连接**

创建一个测试页面，添加按钮调用 `openclawNotifier.sendEvent`。

### 第三步：验证对接

**测试 OpenClaw → 微搭：**

在 OpenClaw 中发送：
```
帮我查询微搭中的订单列表
```

**测试微搭 → OpenClaw：**

在微搭页面点击测试按钮，查看 OpenClaw 是否收到事件。

## 常见问题

### Q: OpenClaw 无法连接到微搭？

- 检查微搭 API 的访问权限
- 确认环境变量配置正确
- 查看 OpenClaw 日志

### Q: 微搭无法连接到 OpenClaw？

- 检查 OpenClaw 是否开启 hooks
- 确认 token 配置一致
- 检查网络连通性

### Q: 数据同步延迟？

- 异步通知可能有延迟，属正常现象
- 可在微搭中添加同步状态标识

## 下一步

- 根据业务需求调整数据模型
- 添加更多事件类型
- 实现复杂的工作流集成
