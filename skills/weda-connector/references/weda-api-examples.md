# 微搭 API 对接示例

## 微搭端配置

### 1. 创建自定义 API（HTTP 方式）

在微搭控制台：
1. 进入「数据源」→「新建 APIs」
2. 选择「自定义 API」
3. 选择「HTTP 请求」方式

#### 配置示例：查询数据

**API 标识**: `queryCustomers`
**方法标识**: `list`

**HTTP 配置：**
```
请求方法: POST
请求地址: https://{env}.api.tcloudbasegateway.com/v1/envs/{envId}/databases/customer/query
请求头:
  Content-Type: application/json
  Authorization: Bearer {apiKey}
请求体:
  {
    "query": {
      "status": "{{params.status}}"
    },
    "limit": {{params.pageSize}},
    "offset": {{(params.page - 1) * params.pageSize}}
  }
```

### 2. 创建自定义 API（自定义代码方式）

#### 示例：调用 OpenClaw Webhook

**API 标识**: `notifyOpenClaw`
**方法标识**: `sendEvent`

**自定义代码：**
```javascript
const fetch = require('node-fetch');

module.exports = async function (params, context) {
  const { eventType, data } = params;
  
  // OpenClaw Webhook 配置
  const OPENCLAW_WEBHOOK_URL = 'http://your-openclaw-server:18789/hooks';
  const OPENCLAW_HOOK_TOKEN = context.env.OPENCLAW_HOOK_TOKEN;
  
  try {
    const response = await fetch(OPENCLAW_WEBHOOK_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${OPENCLAW_HOOK_TOKEN}`
      },
      body: JSON.stringify({
        type: 'event',
        event: eventType,
        payload: data,
        timestamp: Date.now()
      })
    });
    
    if (!response.ok) {
      throw new Error(`OpenClaw webhook failed: ${response.status}`);
    }
    
    return {
      success: true,
      message: 'Event sent to OpenClaw'
    };
  } catch (error) {
    console.error('OpenClaw webhook error:', error);
    return {
      success: false,
      error: error.message
    };
  }
};
```

#### 示例：OpenClaw 调用后处理

**API 标识**: `processOpenClawRequest`
**方法标识**: `handle`

**自定义代码：**
```javascript
module.exports = async function (params, context) {
  const { action, modelName, data, where } = params;
  
  // 获取数据模型
  const db = context.database;
  const collection = db.collection(modelName);
  
  try {
    let result;
    
    switch (action) {
      case 'query':
        result = await collection.where(where || {}).limit(100).get();
        break;
        
      case 'create':
        result = await collection.add(data);
        break;
        
      case 'update':
        result = await collection.where(where || {}).update(data);
        break;
        
      case 'delete':
        result = await collection.where(where || {}).remove();
        break;
        
      default:
        throw new Error(`Unknown action: ${action}`);
    }
    
    return {
      success: true,
      data: result
    };
  } catch (error) {
    return {
      success: false,
      error: error.message
    };
  }
};
```

## 在微搭页面中使用

### 调用 OpenClaw Webhook

```javascript
// 页面按钮点击事件
export default async function({event, data}) {
  const result = await $w.cloud.callDataSource({
    name: 'notifyOpenClaw',
    methodName: 'sendEvent',
    params: {
      eventType: 'orderCreated',
      data: {
        orderId: 'ORD001',
        customer: '张三',
        amount: 199.99
      }
    }
  });
  
  if (result.success) {
    $w.utils.showToast({
      title: '已通知 AI 助手',
      icon: 'success'
    });
  }
}
```

### 接收 OpenClaw 查询

```javascript
// 页面加载时查询数据
export default async function({event, data}) {
  const result = await $w.cloud.callDataSource({
    name: 'queryCustomers',
    methodName: 'list',
    params: {
      status: 'active',
      page: 1,
      pageSize: 20
    }
  });
  
  $w.page.setData({
    customerList: result.data
  });
}
```

## 数据模型设计建议

### 同步记录表 (sync_logs)

用于记录 OpenClaw 和微搭之间的数据同步状态：

| 字段 | 类型 | 说明 |
|------|------|------|
| syncId | string | 同步记录ID |
| source | string | 来源: openclaw / weda |
| target | string | 目标: openclaw / weda |
| entityType | string | 实体类型: order/customer/... |
| entityId | string | 实体ID |
| action | string | 操作: create/update/delete |
| status | string | 状态: pending/success/failed |
| requestData | object | 请求数据 |
| responseData | object | 响应数据 |
| createdAt | datetime | 创建时间 |
| updatedAt | datetime | 更新时间 |

## 错误处理

### 重试机制

```javascript
async function callWithRetry(apiCall, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await apiCall();
    } catch (error) {
      if (i === maxRetries - 1) throw error;
      await new Promise(r => setTimeout(r, 1000 * Math.pow(2, i)));
    }
  }
}
```

### 超时处理

```javascript
const fetchWithTimeout = (url, options, timeout = 10000) => {
  return Promise.race([
    fetch(url, options),
    new Promise((_, reject) =>
      setTimeout(() => reject(new Error('Request timeout')), timeout)
    )
  ]);
};
```
