# swimlane-diagram 安装与使用

## 技能路径

本仓库当前是技能集合仓库，`swimlane-diagram` 位于子目录中：

- `swimlane-diagram`

安装时请指向这个子目录，而不是仓库根目录。

仓库地址：

- `https://github.com/daojian5888/Skill`

## 安装方式

如果你使用 Codex 的 GitHub 技能安装方式，请安装该仓库下的：

- `swimlane-diagram`

也就是说，目标不是整个仓库，而是仓库中的技能目录。

## 安装后包含的内容

安装完成后，技能目录中会包含：

- `SKILL.md`
- `agents/openai.yaml`
- `references/svg-swimlane-style.md`
- `references/enterprise-swimlane-template.md`
- `references/bpmn-like-layout-rules.md`
- `references/plantuml-swimlane-patterns.md`
- `references/mermaid-swimlane-patterns.md`
- `assets/enterprise-swimlane-skeleton.svg`

## 默认行为

这个技能的默认行为不是输出 Mermaid，而是：

- 直接输出正式的 `SVG` 泳道图成品

只有在用户明确要求时，才会降级输出：

- `PlantUML`
- `Mermaid`

## 推荐用法

### 1. 直接生成正式泳道图

- `用 $swimlane-diagram 把这段流程做成标准 SVG 泳道图`
- `用 $swimlane-diagram 参考 draw.io 风格生成成品图`
- `用 $swimlane-diagram 按企业管理模板出图`

### 2. 用于企业管理流程

- `用 $swimlane-diagram 把合同审批流程画成成品图`
- `用 $swimlane-diagram 把采购流程做成泳道图`
- `用 $swimlane-diagram 把交付管理流程整理成标准图`

### 3. 输出兼容源码

- `用 $swimlane-diagram 输出 PlantUML 版本`
- `用 $swimlane-diagram 输出 Mermaid 版本`

## 适用场景

特别适合：

- 企业管理流程
- SOP 流程说明
- 审批流
- 交付流
- 客户流程
- 跨部门协同流程
- 需要沉淀到 Obsidian / 知识库 / 文档中的正式流程图

## 与普通流程图技能的区别

普通技能通常默认输出 Mermaid 或简单流程图源码。

`swimlane-diagram` 的区别在于：

- 默认输出 `SVG` 成品图
- 强调正式业务图的视觉质量
- 有企业管理模板约束
- 有图形质量检查要求
- 更适合长期形成统一风格的流程体系

## 使用建议

为了获得更稳定的结果，建议输入内容尽量包含：

- 参与角色
- 流程顺序
- 是否有审批 / 决策节点
- 是否有异常分支
- 最终结束状态

如果输入本身是企业制度文档、流程说明文件、SOP 或你知识库中的流程条目，这个技能的效果会更好。

## 相关文档

- [技能简介](./README-技能简介.md)
- [中文详细介绍](./swimlane-diagram-中文介绍.md)
- [技能目录](./swimlane-diagram)
