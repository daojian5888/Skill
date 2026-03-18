# 微搭端完整代码

## 1. 创建统一的数据处理 API

### API 名称: `openclawDataBridge`

**用途**: 作为 OpenClaw 和微搭之间的数据桥梁，统一处理所有数据操作。

#### 方法1: `queryData` - 查询数据

```javascript
// openclawDataBridge.queryData
const fetch = require('node-fetch');

module.exports = async function (params, context) {
  const { modelName, where, page = 1, pageSize = 20, orderBy } = params;
  
  try {
    const db = context.database;
    const collection = db.collection(modelName);
    
    // 构建查询
    let query = collection.where(where || {});
    
    // 排序
    if (orderBy) {
      query = query.orderBy(orderBy.field, orderBy.direction || 'asc');
    }
    
    // 分页
    const total = await query.count();
    const result = await query
      .skip((page - 1) * pageSize)
      .limit(pageSize)
      .get();
    
    return {
      success: true,
      data: result.data,
      pagination: {
        page,
        pageSize,
        total: total.total,
        totalPages: Math.ceil(total.total / pageSize)
      }
    };
  } catch (error) {
    console.error('[WeDa] Query error:', error);
    return {
      success: false,
      error: error.message,
      code: 'QUERY_ERROR'
    };
  }
};
```

#### 方法2: `createData` - 创建数据

```javascript
// openclawDataBridge.createData
module.exports = async function (params, context) {
  const { modelName, data } = params;
  
  try {
    const db = context.database;
    const collection = db.collection(modelName);
    
    // 添加创建时间
    const dataWithTime = {
      ...data,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    };
    
    const result = await collection.add(dataWithTime);
    
    // 触发 OpenClaw Webhook (异步)
    notifyOpenClaw('dataCreated', {
      modelName,
      id: result.id,
      data: dataWithTime
    }, context).catch(console.error);
    
    return {
      success: true,
      id: result.id,
      data: dataWithTime
    };
  } catch (error) {
    console.error('[WeDa] Create error:', error);
    return {
      success: false,
      error: error.message,
      code: 'CREATE_ERROR'
    };
  }
};
```

#### 方法3: `updateData` - 更新数据

```javascript
// openclawDataBridge.updateData
module.exports = async function (params, context) {
  const { modelName, id, data, where } = params;
  
  try {
    const db = context.database;
    const collection = db.collection(modelName);
    
    // 添加更新时间
    const dataWithTime = {
      ...data,
      updatedAt: new Date().toISOString()
    };
    
    let result;
    if (id) {
      // 通过ID更新
      result = await collection.doc(id).update(dataWithTime);
    } else if (where) {
      // 通过条件更新
      result = await collection.where(where).update(dataWithTime);
    } else {
      throw new Error('Either id or where condition is required');
    }
    
    // 触发 OpenClaw Webhook
    notifyOpenClaw('dataUpdated', {
      modelName,
      id,
      where,
      changes: data
    }, context).catch(console.error);
    
    return {
      success: true,
      updated: result.updated || result.matched
    };
  } catch (error) {
    console.error('[WeDa] Update error:', error);
    return {
      success: false,
      error: error.message,
      code: 'UPDATE_ERROR'
    };
  }
};
```

#### 方法4: `deleteData` - 删除数据

```javascript
// openclawDataBridge.deleteData
module.exports = async function (params, context) {
  const { modelName, id, where } = params;
  
  try {
    const db = context.database;
    const collection = db.collection(modelName);
    
    let result;
    if (id) {
      result = await collection.doc(id).remove();
    } else if (where) {
      result = await collection.where(where).remove();
    } else {
      throw new Error('Either id or where condition is required');
    }
    
    // 触发 OpenClaw Webhook
    notifyOpenClaw('dataDeleted', {
      modelName,
      id,
      where
    }, context).catch(console.error);
    
    return {
      success: true,
      deleted: result.deleted || result.removed
    };
  } catch (error) {
    console.error('[WeDa] Delete error:', error);
    return {
      success: false,
      error: error.message,
      code: 'DELETE_ERROR'
    };
  }
};
```

## 2. 创建 OpenClaw 通知模块

### API 名称: `openclawNotifier`

```javascript
// openclawNotifier.sendEvent
const fetch = require('node-fetch');

// 配置
const OPENCLAW_CONFIG = {
  WEBHOOK_URL: 'http://your-openclaw-server:18789/hooks',
  HOOK_TOKEN: null // 从环境变量获取
};

module.exports = async function (params, context) {
  const { eventType, data, options = {} } = params;
  
  // 获取 token
  const token = context.env.OPENCLAW_HOOK_TOKEN || OPENCLAW_CONFIG.HOOK_TOKEN;
  
  if (!token) {
    return {
      success: false,
      error: 'OPENCLAW_HOOK_TOKEN not configured'
    };
  }
  
  // 构建 webhook payload
  const payload = {
    type: 'event',
    event: eventType,
    payload: {
      ...data,
      _source: 'weda',
      _envId: context.env.WEDA_ENV_ID
    },
    timestamp: Date.now(),
    _meta: {
      retryCount: options.retryCount || 0,
      requestId: generateRequestId()
    }
  };
  
  try {
    const response = await fetchWithRetry(
      () => fetch(OPENCLAW_CONFIG.WEBHOOK_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
          'X-WeDa-Event': eventType
        },
        body: JSON.stringify(payload)
      }),
      options.maxRetries || 3
    );
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${await response.text()}`);
    }
    
    const result = await response.json();
    
    // 记录成功日志
    await logEvent(context, {
      type: 'webhook_success',
      eventType,
      requestId: payload._meta.requestId,
      timestamp: new Date().toISOString()
    });
    
    return {
      success: true,
      requestId: payload._meta.requestId,
      openclawResponse: result
    };
    
  } catch (error) {
    console.error('[WeDa] OpenClaw webhook failed:', error);
    
    // 记录失败日志
    await logEvent(context, {
      type: 'webhook_failed',
      eventType,
      requestId: payload._meta.requestId,
      error: error.message,
      timestamp: new Date().toISOString()
    });
    
    return {
      success: false,
      error: error.message,
      requestId: payload._meta.requestId
    };
  }
};

// 带重试的 fetch
async function fetchWithRetry(fetchFn, maxRetries = 3, delay = 1000) {
  let lastError;
  
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fetchFn();
    } catch (error) {
      lastError = error;
      if (i < maxRetries - 1) {
        await new Promise(r => setTimeout(r, delay * Math.pow(2, i)));
      }
    }
  }
  
  throw lastError;
}

// 生成请求ID
function generateRequestId() {
  return `weda_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
}

// 记录事件日志
async function logEvent(context, logData) {
  try {
    const db = context.database;
    await db.collection('sync_logs').add(logData);
  } catch (e) {
    console.error('[WeDa] Log error:', e);
  }
}
```

## 3. 在页面中使用

### 示例页面: 订单管理

```javascript
// 页面 data 定义
Page({
  data: {
    orderList: [],
    loading: false,
    page: 1,
    pageSize: 10,
    hasMore: true
  },
  
  // 加载订单列表
  async loadOrders() {
    this.setData({ loading: true });
    
    try {
      const result = await $w.cloud.callDataSource({
        name: 'openclawDataBridge',
        methodName: 'queryData',
        params: {
          modelName: 'Order',
          where: {
            status: 'pending'
          },
          page: this.data.page,
          pageSize: this.data.pageSize,
          orderBy: {
            field: 'createdAt',
            direction: 'desc'
          }
        }
      });
      
      if (result.success) {
        this.setData({
          orderList: [...this.data.orderList, ...result.data],
          hasMore: result.pagination.page < result.pagination.totalPages
        });
      } else {
        $w.utils.showToast({
          title: result.error || '加载失败',
          icon: 'error'
        });
      }
    } finally {
      this.setData({ loading: false });
    }
  },
  
  // 创建订单
  async createOrder(orderData) {
    const result = await $w.cloud.callDataSource({
      name: 'openclawDataBridge',
      methodName: 'createData',
      params: {
        modelName: 'Order',
        data: orderData
      }
    });
    
    if (result.success) {
      // 同时通知 OpenClaw
      await $w.cloud.callDataSource({
        name: 'openclawNotifier',
        methodName: 'sendEvent',
        params: {
          eventType: 'orderCreated',
          data: result.data
        }
      });
      
      $w.utils.showToast({
        title: '订单创建成功',
        icon: 'success'
      });
    }
    
    return result;
  },
  
  // 更新订单状态
  async updateOrderStatus(orderId, newStatus) {
    const result = await $w.cloud.callDataSource({
      name: 'openclawDataBridge',
      methodName: 'updateData',
      params: {
        modelName: 'Order',
        id: orderId,
        data: {
          status: newStatus
        }
      }
    });
    
    if (result.success) {
      $w.utils.showToast({
        title: '状态更新成功',
        icon: 'success'
      });
    }
    
    return result;
  }
});
```

## 4. 数据模型定义

### sync_logs (同步日志表)

```json
{
  "_id": "string",
  "type": "string",
  "eventType": "string",
  "requestId": "string",
  "error": "string",
  "timestamp": "datetime"
}
```

### Order (订单表)

```json
{
  "_id": "string",
  "orderNo": "string",
  "customer": "string",
  "amount": "number",
  "status": "string",
  "items": "array",
  "createdAt": "datetime",
  "updatedAt": "datetime"
}
```

## 5. 环境变量配置

在微搭控制台 → 环境变量中配置：

| 变量名 | 说明 | 示例 |
|--------|------|------|
| `OPENCLAW_HOOK_TOKEN` | OpenClaw Webhook Token | `abc123...xyz` |
| `WEDA_ENV_ID` | 微搭环境ID | `prod-xxx` |
| `OPENCLAW_BASE_URL` | OpenClaw 服务地址 | `http://xxx:18789` |

## 6. 安全配置

### IP 白名单

如果 OpenClaw 有 IP 限制，需要将微搭的出口 IP 加入白名单：
- 在微搭控制台查看当前环境的出口 IP
- 在 OpenClaw 服务器配置防火墙规则

### Token 安全

1. 定期轮换 `OPENCLAW_HOOK_TOKEN`
2. 不要在代码中硬编码 token
3. 使用微搭的环境变量功能存储敏感信息
