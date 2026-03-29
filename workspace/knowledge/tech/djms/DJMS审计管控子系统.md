# 审计管控子系统（DJMS-SJ）
> 道简网络运行系统版本：V1.0更新日期：2026-03-24

## 1. 审计管控子系统概述
### 1.1 定位与职责
审计管控子系统是道简网络运行系统（DJRS）管控层的核心组成部分，承担着**独立监督与评价**的关键职能，是企业治理与合规的重要保障系统。
**核心职责**：
- 建立内部审计制度体系
- 开展财务审计与合规审计
- 实施运营审计与管理审计
- 跟踪审计发现整改落实
- 提供管理改进建议

### 1.2 模块架构
审计管控子系统包含以下七大核心模块：

|lark-table rows="8" cols="4" header-row="true" column-widths="183,183,183,183"|
|lark-tr|
|lark-td|序号|/lark-td|
|lark-td|模块名称|/lark-td|
|lark-td|编码|/lark-td|
|lark-td|核心价值|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|1|/lark-td|
|lark-td|财务审计|/lark-td|
|lark-td|1.5.1|/lark-td|
|lark-td|财务真实性与合规性|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|2|/lark-td|
|lark-td|合规审计|/lark-td|
|lark-td|1.5.2|/lark-td|
|lark-td|法规与制度遵循|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|3|/lark-td|
|lark-td|运营审计|/lark-td|
|lark-td|1.5.3|/lark-td|
|lark-td|业务效率与效果|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|4|/lark-td|
|lark-td|专项审计|/lark-td|
|lark-td|1.5.4|/lark-td|
|lark-td|特定事项深度审查|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|5|/lark-td|
|lark-td|审计管理|/lark-td|
|lark-td|1.5.5|/lark-td|
|lark-td|审计计划与流程管控|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|6|/lark-td|
|lark-td|整改跟踪|/lark-td|
|lark-td|1.5.6|/lark-td|
|lark-td|问题整改闭环管理|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|7|/lark-td|
|lark-td|外部对接|/lark-td|
|lark-td|1.5.7|/lark-td|
|lark-td|外部审计协调配合|/lark-td|
|/lark-tr|
|/lark-table|

---

## 2. 一级流程：审计管控总流程
### 2.1 审计管控全景图
```
【审计管控总流程】

年度审计计划制定
      ↓
审计项目立项准备
      ↓
审计实施（现场审计）
      ↓
审计发现问题汇总
      ↓
审计报告编制
      ↓
审计报告审批发布
      ↓
整改通知下达
      ↓
整改跟踪验证
      ↓
审计档案归档
      ↓
审计结果应用
```

### 2.2 模块关联图
```
┌─────────────────────────────────────────────────────────────┐
│                    审计管控子系统核心流程                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐               │
│  │财务审计 │───→│合规审计 │←──→│运营审计 │               │
│  └────┬────┘    └────┬────┘    └────┬────┘               │
│       │              │              │                        │
│       └──────────────┴──────────────┘                        │
│                    ↓                                           │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐               │
│  │专项审计 │←──→│审计管理 │←──→│整改跟踪 │               │
│  └────┬────┘    └────┬────┘    └────┬────┘               │
│       │              │              │                        │
│       └──────────────┴──────────────┘                        │
│                    ↓                                           │
│              ┌─────────┐                                   │
│              │外部对接 │                                   │
│              └─────────┘                                   │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. 各模块详细流程
### 3.1 财务审计（1.5.1）
#### 3.1.1 模块职责
- 财务报表真实性审计
- 资金使用合规性审计
- 成本核算准确性审计
- 税务合规性审计
- 资产完整性审计

#### 3.1.2 一级流程：财务审计
```
【财务审计一级流程】

审计计划立项
      ↓
审计准备
├─ 审计方案编制
├─ 资料清单准备
└─ 审计人员分工
      ↓
现场审计实施
├─ 账务凭证抽查
├─ 银行对账核查
├─ 资产盘点验证
└─ 往来账项核对
      ↓
审计发现问题汇总
      ↓
与被审计单位沟通确认
      ↓
审计报告编制
      ↓
审计报告审批发布
      ↓
整改跟踪
```

#### 3.1.3 财务审计重点领域
|lark-table rows="6" cols="4" header-row="true" column-widths="183,183,183,183"|
|lark-tr|
|lark-td|审计领域|/lark-td|
|lark-td|审计内容|/lark-td|
|lark-td|审计方法|/lark-td|
|lark-td|频次|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|收入审计|/lark-td|
|lark-td|收入确认/完整性/截止性|/lark-td|
|lark-td|凭证抽查/对账单核对|/lark-td|
|lark-td|半年度|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|成本审计|/lark-td|
|lark-td|成本归集/分摊/截止性|/lark-td|
|lark-td|成本明细账抽查|/lark-td|
|lark-td|半年度|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|费用审计|/lark-td|
|lark-td|费用报销合规性/预算执行|/lark-td|
|lark-td|凭证抽查/访谈|/lark-td|
|lark-td|季度|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|资金审计|/lark-td|
|lark-td|资金使用合规性/安全性|/lark-td|
|lark-td|银行对账单核对|/lark-td|
|lark-td|季度|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|税务审计|/lark-td|
|lark-td|税务申报合规/风险|/lark-td|
|lark-td|税务申报表审核|/lark-td|
|lark-td|年度|/lark-td|
|/lark-tr|
|/lark-table|

---

### 3.2 合规审计（1.5.2）
#### 3.2.1 模块职责
- 法规遵循情况审计
- 内部控制有效性审计
- 制度执行情况审计
- 授权审批合规性审计
- 舞弊风险识别与防范

#### 3.2.2 一级流程：合规审计
```
【合规审计一级流程】

合规审计计划立项
      ↓
合规风险识别
├─ 法规清单梳理
├─ 内控缺陷识别
└─ 历史违规分析
      ↓
审计方案制定
      ↓
现场合规测试
├─ 制度文件检查
├─ 流程执行验证
└─ 访谈与观察
      ↓
发现问题汇总分析
      ↓
合规审计报告编制
      ↓
整改建议提出
      ↓
跟踪整改落实
```

#### 3.2.3 合规审计重点检查清单
|lark-table rows="6" cols="3" header-row="true" column-widths="244,244,244"|
|lark-tr|
|lark-td|合规领域|/lark-td|
|lark-td|主要检查内容|/lark-td|
|lark-td|责任部门|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|劳动合规|/lark-td|
|lark-td|劳动合同/社保公积金/工时制度/加班审批|/lark-td|
|lark-td|行政人事|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|财务合规|/lark-td|
|lark-td|发票管理/资金使用/报销审批|/lark-td|
|lark-td|财务部|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|合同合规|/lark-td|
|lark-td|合同审批流程/章证管理/履约监控|/lark-td|
|lark-td|商务部|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|信息安全|/lark-td|
|lark-td|数据保护/保密制度/权限管理|/lark-td|
|lark-td|运维部|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|施工安全|/lark-td|
|lark-td|安全操作规程/特种作业/安全培训|/lark-td|
|lark-td|运维部|/lark-td|
|/lark-tr|
|/lark-table|

---

### 3.3 运营审计（1.5.3）
#### 3.3.1 模块职责
- 业务流程效率审计
- 项目管理规范性审计
- 采购管理合规性审计
- 供应商管理有效性审计
- 客户满意度与服务质量审计

#### 3.3.2 一级流程：运营审计
```
【运营审计一级流程】

运营审计立项
      ↓
运营数据收集与分析
├─ 销售数据分析
├─ 项目数据分析
├─ 采购数据分析
└─ 服务数据分析
      ↓
现场审计验证
├─ 流程穿行测试
├─ 制度文件检查
└─ 人员访谈
      ↓
问题与改进点识别
      ↓
运营审计报告
      ↓
管理建议提出
      ↓
跟踪改进效果
```

#### 3.3.3 运营审计关键指标
|lark-table rows="6" cols="4" header-row="true" column-widths="183,183,183,183"|
|lark-tr|
|lark-td|运营领域|/lark-td|
|lark-td|审计指标|/lark-td|
|lark-td|异常判断|/lark-td|
|lark-td|审计频次|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|销售|/lark-td|
|lark-td|毛利率/折扣率/逾期应收|/lark-td|
|lark-td|超出标准20%|/lark-td|
|lark-td|季度|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|采购|/lark-td|
|lark-td|采购价格偏离/独家采购占比|/lark-td|
|lark-td|价格偏高>10%|/lark-td|
|lark-td|季度|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|项目|/lark-td|
|lark-td|项目利润率/超期率/超预算率|/lark-td|
|lark-td|利润率<-5%|/lark-td|
|lark-td|季度|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|服务|/lark-td|
|lark-td|响应时间/一次解决率/客户投诉|/lark-td|
|lark-td|SLA不达标>5%|/lark-td|
|lark-td|季度|/lark-td|
|/lark-tr|
|/lark-table|

---

### 3.4 专项审计（1.5.4）
#### 3.4.1 模块职责
- 舞弊调查专项审计
- 离任审计
- 信息系统审计
- 重大投资项目审计
- 举报线索专项调查

#### 3.4.2 一级流程：专项审计
```
【专项审计一级流程】

专项审计立项
├─ 舞弊举报
├─ 离任申请
├─ 管理指令
└─ 风险预警触发
      ↓
审计方案紧急制定
      ↓
现场专项审计
├─ 数据分析与比对
├─ 凭证与文件核查
├─ 人员访谈
└─ 外部取证（如需）
      ↓
专项审计发现问题
      ↓
与被审计方沟通确认
      ↓
专项审计报告
      ↓
根据性质上报/移交
      ↓
整改/处理跟踪
```

#### 3.4.3 专项审计类型与触发条件
|lark-table rows="6" cols="4" header-row="true" column-widths="183,183,183,183"|
|lark-tr|
|lark-td|审计类型|/lark-td|
|lark-td|触发条件|/lark-td|
|lark-td|启动时间|/lark-td|
|lark-td|报告范围|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|舞弊调查|/lark-td|
|lark-td|收到举报线索|/lark-td|
|lark-td|立即启动|/lark-td|
|lark-td|总经理/董事会|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|离任审计|/lark-td|
|lark-td|高管/核心岗位离职|/lark-td|
|lark-td|离职前完成|/lark-td|
|lark-td|总经理|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|信息系统|/lark-td|
|lark-td|系统重大变更/安全事件|/lark-td|
|lark-td|事件后5日内|/lark-td|
|lark-td|管理层|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|投资审计|/lark-td|
|lark-td|重大投资完成后|/lark-td|
|lark-td|项目结束后3月|/lark-td|
|lark-td|董事会|/lark-td|
|/lark-tr|
|/lark-tr|
|lark-td|Risk预警触发|/lark-td|
|lark-td|指标异常超标|/lark-td|
|lark-td|预警后1周内|/lark-td|
|lark-td|管理层|/lark-td|
|/lark-tr|
|/lark-table|

---

### 3.5 审计管理（1.5.5）
#### 3.5.1 模块职责
- 年度审计计划制定
- 审计项目立项管理
- 审计资源配置
- 审计质量管控
- 审计人员管理

#### 3.5.2 一级流程：审计管理
```
【审计管理一级流程】

年度风险评估
      ↓
年度审计计划制定
      ↓
审计项目立项
      ↓
审计资源配置
├─ 内部审计团队
└─ 外部审计支持（如需）
      ↓
审计项目实施
      ↓
审计质量检查
      ↓
审计档案管理
      ↓
审计结果汇报
      ↓
审计效果评估
```

#### 3.5.3 年度审计计划制定流程
```
风险评估确定重点领域
      ↓
审计需求收集
├─ 管理层需求
├─ 董事会需求
├─ 监管合规需求
└─ 上年遗留问题
      ↓
审计资源评估
      ↓
审计项目优先级排序
      ↓
年度审计计划初稿
      ↓
管理层/董事会审批
      ↓
年度审计计划发布
      ↓
季度计划细化执行
```

---

### 3.6 整改跟踪（1.5.6）
#### 3.6.1 模块职责
- 审计发现整改通知
- 整改方案审核
- 整改过程跟踪
- 整改结果验证
- 未整改问题升级处理

#### 3.6.2 一级流程：整改跟踪
```
【整改跟踪一级流程】

审计报告发布
      ↓
整改通知书下达
      ↓
被审计单位整改方案制定
      ↓
整改方案审核确认
      ↓
整改实施跟踪
├─ 定期进度收集
├─ 现场整改验证
└─ 整改问题支持
      ↓
整改结果验收
      ↓
整改闭环确认
      ↓
未整改升级处理
```

#### 3.6.3 整改跟踪时限要求
|lark-table rows="5" cols="4" header-row="true" column-widths="183,183,183,183"|
|lark-tr|
|lark-td|问题级别|/lark-td|
|lark-td|整改时限|/lark-td|
|lark-td|跟踪频次|/lark-td|
|lark-td|升级机制|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|重大问题|/lark-td|
|lark-td|30天内|/lark-td|
|lark-td|每周跟踪|/lark-td|
|lark-td|超期上报总经理|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|重要问题|/lark-td|
|lark-td|60天内|/lark-td|
|lark-td|每两周跟踪|/lark-td|
|lark-td|超期上报分管副总|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|一般问题|/lark-td|
|lark-td|90天内|/lark-td|
|lark-td|每月跟踪|/lark-td|
|lark-td|超期纳入考核|/lark-td|
|/lark-tr|
|/lark-tr|
|lark-td|建议项|/lark-td|
|lark-td|下次审计前|/lark-td|
|lark-td|下次审计时|/lark-td|
|lark-td|参照执行|/lark-td|
|/lark-tr|
|/lark-table|

---

### 3.7 外部对接（1.5.7）
#### 3.7.1 模块职责
- 外部审计机构协调
- 审计资料准备配合
- 审计发现沟通跟进
- 外部审计意见整改
- 监管检查配合

#### 3.7.2 一级流程：外部审计对接
```
【外部审计对接一级流程】

外部审计机构进场通知
      ↓
内部对接协调安排
├─ 对接负责人指定
├─ 资料清单确认
└─ 时间安排协调
      ↓
审计资料准备与提供
      ↓
现场审计配合
├─ 访谈安排
├─ 资料调阅
└─ 问题答疑
      ↓
审计发现初步沟通
      ↓
审计报告沟通确认
      ↓
整改计划制定实施
      ↓
外部审计结案
```

---

## 4. 执行保障
### 4.1 审计管控指标体系
|lark-table rows="6" cols="4" header-row="true" column-widths="183,183,183,183"|
|lark-tr|
|lark-td|监控指标|/lark-td|
|lark-td|频次|/lark-td|
|lark-td|责任人|/lark-td|
|lark-td|达标标准|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|审计计划执行率|/lark-td|
|lark-td|季度|/lark-td|
|lark-td|审计负责人|/lark-td|
|lark-td|≥90%|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|整改完成率|/lark-td|
|lark-td|季度|/lark-td|
|lark-td|审计负责人|/lark-td|
|lark-td|≥85%|/lark-tr|
|lark-tr|
|lark-td|重大问题整改及时率|/lark-td|
|lark-td|季度|/lark-td|
|lark-td|审计负责人|/lark-td|
|lark-td|100%|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|审计报告质量|/lark-td|
|lark-td|每项目|/lark-td|
|lark-td|审计负责人|/lark-td|
|lark-td|无重大遗漏|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|外部审计配合满意度|/lark-td|
|lark-td|年度|/lark-td|
|lark-td|审计负责人|/lark-td|
|lark-td|≥90分|/lark-td|
|/lark-tr|
|/lark-table|

### 4.2 持续优化机制
1. **年度审计评审**：每年进行审计体系有效性评审
2. **季度审计复盘**：每季度进行审计项目复盘
3. **整改回头看**：对重大问题整改情况开展回头看检查
4. **持续改进**：吸收内外部审计意见持续完善管控体系

---

## 5. 相关附件清单
|lark-table rows="11" cols="4" header-row="true" column-widths="183,183,183,183"|
|lark-tr|
|lark-td|序号|/lark-td|
|lark-td|附件名称|/lark-td|
|lark-td|编号|/lark-td|
|lark-td|所属模块|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|1|/lark-td|
|lark-td|审计通知书模板|/lark-td|
|lark-td|SJ-01|/lark-td|
|lark-td|审计管理|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|2|/lark-td|
|lark-td|审计方案模板|/lark-td|
|lark-td|SJ-02|/lark-td|
|lark-td|审计管理|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|3|/lark-td|
|lark-td|审计工作底稿模板|/lark-td|
|lark-td|SJ-03|/lark-td|
|lark-td|审计管理|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|4|/lark-td|
|lark-td|审计报告模板|/lark-td|
|lark-td|SJ-04|/lark-td|
|lark-td|审计管理|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|5|/lark-td|
|lark-td|整改通知书模板|/lark-td|
|lark-td|SJ-05|/lark-td|
|lark-td|整改跟踪|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|6|/lark-td|
|lark-td|整改报告模板|/lark-td|
|lark-td|SJ-06|/lark-td|
|lark-td|整改跟踪|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|7|/lark-td|
|lark-td|审计档案清单|/lark-td|
|lark-td|SJ-07|/lark-td|
|lark-td|审计管理|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|8|/lark-td|舞弊举报处理流程|/lark-td|
|lark-td|SJ-08|/lark-td|
|lark-td|专项审计|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|9|/lark-td|
|lark-td|离任审计清单|/lark-td|
|lark-td|SJ-09|/lark-td|
|lark-td|专项审计|/lark-td|
|/lark-tr|
|lark-tr|
|lark-td|10|/lark-td|
|lark-td|外部审计配合清单|/lark-td|
|lark-td|SJ-10|/lark-td|
|lark-td|外部对接|/lark-td|
|/lark-tr|
|/lark-table|

---

*本文件为道简网络审计管控子系统（DJMS）V1.0版本*
*编制日期：2026-03-24*
*下次评审日期：2026-06-24*
