---
name: weda-connector
description: "连接腾讯云微搭低代码平台，支持双向数据交互。OpenClaw可调用微搭API读写数据，微搭可通过Webhook触发OpenClaw任务。"
---

# 微搭连接器 (WeDa Connector)

## 功能概述

- **调用微搭 API**: 读取/写入微搭应用数据
- **调用微搭数据源**: 操作数据模型
- **调用微搭工作流**: 触发业务流程
- **接收微搭事件**: 通过 Webhook 接收微搭推送

## 环境变量配置

在 `openclaw.json` 或环境变量中配置：

```json
{
  "secrets": {
    "providers": {
      "weda": {
        "source": "env",
        "env": "WEDA_API_KEY"
      }
    }
  }
}
```

环境变量：
- `WEDA_BASE_URL`: 微搭 API 基础地址
- `WEDA_API_KEY`: 微搭 API 密钥
- `WEDA_ENV_ID`: 微搭环境 ID

## 工具清单

### 1. weda_api_call - 调用微搭自定义 API

调用微搭中定义的自定义 API。

**参数：**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| apiName | string | 是 | API 标识名 |
| methodName | string | 是 | 方法标识名 |
| params | object | 否 | 请求参数 |

**示例：**

```json
{
  "apiName": "orderApi",
  "methodName": "getOrderList",
  "params": {
    "status": "pending",
    "page": 1,
    "pageSize": 20
  }
}
```

### 2. weda_data_query - 查询微搭数据模型

直接查询微搭数据模型（数据表）。

**参数：**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| modelName | string | 是 | 数据模型名称 |
| action | string | 是 | 操作类型: query/create/update/delete |
| where | object | 否 | 查询条件 |
| data | object | 否 | 创建/更新数据 |
| page | number | 否 | 页码，默认1 |
| pageSize | number | 否 | 每页条数，默认20 |

**示例 - 查询：**

```json
{
  "modelName": "Customer",
  "action": "query",
  "where": {
    "status": "active"
  },
  "page": 1,
  "pageSize": 10
}
```

**示例 - 创建：**

```json
{
  "modelName": "Order",
  "action": "create",
  "data": {
    "orderNo": "ORD20240318001",
    "customer": "张三",
    "amount": 199.99
  }
}
```

### 3. weda_workflow_trigger - 触发微搭工作流

触发微搭中定义的工作流。

**参数：**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| workflowKey | string | 是 | 工作流标识 |
| variables | object | 否 | 工作流变量 |

**示例：**

```json
{
  "workflowKey": "approveOrder",
  "variables": {
    "orderId": "ORD001",
    "approver": "manager"
  }
}
```

### 4. weda_webhook_receive - 接收微搭事件

（内部工具）处理微搭推送的 Webhook 事件。

**参数：**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| event | string | 是 | 事件类型 |
| payload | object | 是 | 事件数据 |
| signature | string | 否 | 签名验证 |

## 使用示例

### 场景1：读取微搭订单数据

```
请帮我查询微搭中状态为"待处理"的订单列表
```

AI 将调用：
```json
{
  "tool": "weda_data_query",
  "params": {
    "modelName": "Order",
    "action": "query",
    "where": {
      "status": "pending"
    }
  }
}
```

### 场景2：创建客户记录

```
在微搭中创建一个新客户，姓名李四，电话13800138000
```

AI 将调用：
```json
{
  "tool": "weda_data_query",
  "params": {
    "modelName": "Customer",
    "action": "create",
    "data": {
      "name": "李四",
      "phone": "13800138000"
    }
  }
}
```

### 场景3：触发审批流程

```
触发订单审批工作流，订单ID是ORD001
```

AI 将调用：
```json
{
  "tool": "weda_workflow_trigger",
  "params": {
    "workflowKey": "orderApproval",
    "variables": {
      "orderId": "ORD001"
    }
  }
}
```

## 安全说明

1. API 密钥通过环境变量或 Secret 文件管理，不要硬编码
2. Webhook 接收端点需要验证签名
3. 建议使用 HTTPS 传输
4. 定期轮换 API 密钥

## 参考资料

- `references/weda-api-examples.md` - 微搭 API 调用示例
- `references/openclaw-webhook-guide.md` - Webhook 接收指南
