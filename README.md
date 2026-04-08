# Skill

面向真实业务场景的 Codex 技能仓库。

当前已整理为两层结构：

- `skills/`：技能本体
- `docs/`：介绍、安装和使用文档

## 当前收录

- [`skills/swimlane-diagram`](./skills/swimlane-diagram)

`swimlane-diagram` 专注于把企业管理、SOP、审批协同、交付运营等流程，产出为标准、清晰、可直接使用的泳道图成品。

## 核心特点

- 默认输出高质量 `SVG`，不是只给 Mermaid 草图
- 更接近正式业务流程图风格，适合制度、培训和汇报材料
- 面向企业管理流程优化，强调角色边界、分支清晰和连线规范
- 同时保留 `PlantUML` 与 `Mermaid` 作为显式兼容输出

## 仓库导航

- [文档总览](./docs/README.md)
- [技能总览](./skills/README.md)
- [swimlane-diagram](./skills/swimlane-diagram)

## 快速使用

- `用 $swimlane-diagram 把这个流程做成标准 SVG 泳道图`
- `用 $swimlane-diagram 按企业管理模板生成成品图`
- `用 $swimlane-diagram 参考 draw.io 风格出图`

## 说明

这个仓库现在采用“仓库入口 + 文档目录 + 技能目录”的结构，后续继续增加技能时，可以直接按相同方式扩展，不会再把说明文件堆在根目录。
