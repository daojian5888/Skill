# OpenClaw Webhook 接收指南

## 配置 Webhook 接收

### 1. 修改 openclaw.json

```json
{
  "hooks": {
    "enabled": true,
    "token": "your-secure-random-token-min-32-chars",
    "path": "/hooks",
    "allowedAgentIds": ["hooks", "main"]
  }
}
```

**重要**：token 必须是强随机字符串，建议使用：
```bash
openssl rand -base64 32
```

### 2. 创建 Webhook 处理器 Skill

创建 `skills/weda-webhook-handler/SKILL.md`：

```markdown
---
name: weda-webhook-handler
description: "处理微搭推送的 Webhook 事件，根据事件类型执行相应操作"
---

## 事件处理

### orderCreated - 订单创建事件

当微搭中有新订单创建时触发。

**处理逻辑：**
- 解析订单数据
- 发送通知给相关人员
- 创建待办任务

### dataUpdated - 数据更新事件

当微搭中数据被更新时触发。

**处理逻辑：**
- 对比变更前后数据
- 记录变更日志
- 触发后续流程

### workflowCompleted - 工作流完成

当微搭工作流执行完成时触发。

**处理逻辑：**
- 获取工作流结果
- 更新 OpenClaw 中的状态
- 通知相关人员
```

## Webhook 处理脚本

创建 `skills/weda-webhook-handler/scripts/handler.js`：

```javascript
/**
 * 处理微搭 Webhook 事件
 * @param {Object} payload - Webhook 负载
 * @param {Object} context - 执行上下文
 */
async function handleWedAWebhook(payload, context) {
  const { event, payload: eventData, timestamp } = payload;
  
  console.log(`[WeDa Webhook] Received event: ${event}`, {
    timestamp: new Date(timestamp).toISOString()
  });
  
  switch (event) {
    case 'orderCreated':
      return await handleOrderCreated(eventData, context);
      
    case 'orderUpdated':
      return await handleOrderUpdated(eventData, context);
      
    case 'customerCreated':
      return await handleCustomerCreated(eventData, context);
      
    case 'workflowTrigger':
      return await handleWorkflowTrigger(eventData, context);
      
    default:
      console.warn(`[WeDa Webhook] Unknown event type: ${event}`);
      return { handled: false, reason: 'Unknown event type' };
  }
}

/**
 * 处理订单创建事件
 */
async function handleOrderCreated(data, context) {
  const { orderId, customer, amount, items } = data;
  
  // 1. 发送通知
  await context.tools.notification.send({
    title: '新订单通知',
    message: `收到新订单 ${orderId}，客户: ${customer}，金额: ¥${amount}`,
    priority: 'normal'
  });
  
  // 2. 创建待办任务
  await context.tools.task.create({
    title: `处理订单 ${orderId}`,
    description: `客户: ${customer}\n金额: ¥${amount}\n商品: ${items?.map(i => i.name).join(', ')}`,
    dueDate: new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString()
  });
  
  // 3. 记录到数据库
  await context.memory.set(`order:${orderId}`, {
    ...data,
    receivedAt: new Date().toISOString(),
    status: 'pending'
  });
  
  return {
    handled: true,
    actions: ['notification', 'taskCreated', 'dataStored']
  };
}

/**
 * 处理订单更新事件
 */
async function handleOrderUpdated(data, context) {
  const { orderId, changes, updatedBy } = data;
  
  // 获取原数据
  const original = await context.memory.get(`order:${orderId}`);
  
  // 记录变更历史
  await context.memory.set(`order:${orderId}:history`, {
    orderId,
    changes,
    updatedBy,
    updatedAt: new Date().toISOString(),
    original: original?.data
  });
  
  // 如果状态变为已付款，发送通知
  if (changes.status?.new === 'paid') {
    await context.tools.notification.send({
      title: '订单已付款',
      message: `订单 ${orderId} 已收到付款`,
      priority: 'high'
    });
  }
  
  return {
    handled: true,
    actions: ['historyRecorded', 'statusChecked']
  };
}

/**
 * 处理客户创建事件
 */
async function handleCustomerCreated(data, context) {
  const { customerId, name, phone, source } = data;
  
  // 新客户欢迎流程
  await context.tools.notification.send({
    title: '新客户注册',
    message: `新客户 ${name} 来自 ${source || '未知渠道'}`,
    priority: 'normal'
  });
  
  // 可以触发后续的 CRM 流程
  await context.agent.run({
    prompt: `新客户 ${name} (电话: ${phone}) 已注册，请为其制定跟进计划。`
  });
  
  return {
    handled: true,
    actions: ['notification', 'followUpPlanned']
  };
}

/**
 * 处理工作流触发
 */
async function handleWorkflowTrigger(data, context) {
  const { workflowKey, variables, callbackUrl } = data;
  
  // 执行工作流处理
  const result = await context.agent.run({
    prompt: `执行工作流 ${workflowKey}，参数: ${JSON.stringify(variables)}`
  });
  
  // 如果有回调地址，发送结果
  if (callbackUrl) {
    await fetch(callbackUrl, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        workflowKey,
        result: result.output,
        completedAt: new Date().toISOString()
      })
    });
  }
  
  return {
    handled: true,
    actions: ['workflowExecuted', 'callbackSent']
  };
}

module.exports = { handleWedAWebhook };
```

## 验证 Webhook 签名

如果微搭支持签名，添加验证：

```javascript
const crypto = require('crypto');

function verifyWebhookSignature(payload, signature, secret) {
  const expectedSignature = crypto
    .createHmac('sha256', secret)
    .update(JSON.stringify(payload))
    .digest('hex');
  
  return crypto.timingSafeEqual(
    Buffer.from(signature),
    Buffer.from(expectedSignature)
  );
}

// 在处理函数中使用
async function handleWedAWebhook(payload, headers, context) {
  const signature = headers['x-weda-signature'];
  const secret = context.env.WEDA_WEBHOOK_SECRET;
  
  if (!verifyWebhookSignature(payload, signature, secret)) {
    throw new Error('Invalid webhook signature');
  }
  
  // 继续处理...
}
```

## 测试 Webhook

### 使用 curl 测试

```bash
curl -X POST http://localhost:18789/hooks \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-webhook-token" \
  -d '{
    "type": "event",
    "event": "orderCreated",
    "payload": {
      "orderId": "ORD001",
      "customer": "张三",
      "amount": 199.99
    },
    "timestamp": 1710739200000
  }'
```

### 使用微搭测试

在微搭中创建一个测试按钮：

```javascript
export default async function({event, data}) {
  const result = await $w.cloud.callDataSource({
    name: 'notifyOpenClaw',
    methodName: 'sendEvent',
    params: {
      eventType: 'orderCreated',
      data: {
        orderId: 'TEST001',
        customer: '测试客户',
        amount: 99.99
      }
    }
  });
  
  console.log('Webhook result:', result);
}
```

## 日志和监控

建议记录所有 Webhook 事件：

```javascript
// 记录到文件或数据库
async function logWebhookEvent(event, payload, result) {
  const logEntry = {
    timestamp: new Date().toISOString(),
    event,
    payload: JSON.stringify(payload),
    result: JSON.stringify(result),
    source: 'weda'
  };
  
  // 写入日志文件
  await context.fs.appendFile(
    '/logs/weda-webhooks.log',
    JSON.stringify(logEntry) + '\n'
  );
}
```
