---
name: swimlane-diagram
description: "Generate real swimlane diagram deliverables from process descriptions, SOPs, meeting notes, requirements, or business workflows. Use when the user wants a polished visual swimlane diagram like a draw.io or presentation-ready process chart, with vertical lanes, headers, aligned shapes, decision diamonds, and clean connectors. Default to SVG output and treat SVG as the primary deliverable; use PlantUML or Mermaid only when the user explicitly asks for editable source formats."
---

# Swimlane Diagram

Create actual swimlane diagram deliverables, not pseudo-diagram source by default.

This skill is optimized for business swimlane diagrams used in management systems, SOPs, approvals, delivery workflows, and enterprise process documentation.

Primary target:

- polished `SVG` swimlane diagram

Secondary targets, only when explicitly requested:

- `PlantUML`
- `Mermaid`

If the user asks for a swimlane diagram without specifying format, default to SVG and make it look like a clean business diagram suitable for presentations, SOPs, or internal documentation.

For enterprise-management workflows, prefer the standard template in [references/enterprise-swimlane-template.md](references/enterprise-swimlane-template.md).

## What The User Usually Means

When a user asks for:

- 流程图
- 泳道图
- 标准泳道图
- 像 draw.io 一样的图
- 像 PPT 里那样的流程图

they usually want a rendered diagram, not text source pretending to be a diagram.

Treat visual quality as a core requirement.

If the user is asking in Chinese, produce Chinese labels by default.

## Default Output Contract

Unless the user asks for another format, produce:

1. `角色与泳道`
2. `关键假设`
3. `SVG 泳道图`
4. `补充说明`

If the user asks for editable text source:

- use `PlantUML` when they want standard structured source
- use `Mermaid` only when they explicitly want Obsidian-native compatibility

If the user asks for "直接给我图", "做成品图", "像 draw.io 一样", or gives a picture reference, do not switch to text-source output.

## Visual Standard To Target

Match the visual logic of a standard business swimlane diagram:

- vertical swimlanes
- fixed lane headers
- one dominant top-to-bottom process flow
- aligned shapes
- clear decision diamonds
- clean connector routing
- ample whitespace
- no decorative clutter

The result should feel like a real diagram artifact, not code rendered into a graph.

For the standard template, also require:

- action nodes on a consistent width grid
- key milestones aligned by rows when they are comparable
- branch labels placed away from node text
- data/store symbols only when the process actually has a pool, record, database, or archive object

## Core Workflow

### 1. Normalize the process first

Extract:

- lanes
- ordered actions
- decision points
- handoffs
- start node
- end node

If the source is incomplete, make the minimum defensible assumptions and state them briefly.

### 2. Choose lanes deliberately

Use 2-6 lanes in most diagrams.

- Prefer stable owners: role, team, or system.
- Avoid one-off lanes unless ownership change matters.
- Merge similar actors when splitting them adds clutter.

### 3. Simplify before drawing

Do not draw from raw notes directly.

- remove commentary
- merge repetitive micro-steps
- shorten labels
- separate main path from exception path
- preserve only structurally important decisions

### 4. Draw as a layout problem, not just a logic problem

When generating SVG:

- use equal-width vertical lanes
- place lane headers in a top band
- align nodes to a lane grid
- keep the main path mostly vertical
- keep handoffs horizontal and short
- keep rejection branches local
- do not let connectors zig-zag unnecessarily
- keep connector bends to the minimum needed
- route branches as `horizontal then vertical` by default
- avoid running lines through text or shape interiors

### 5. Finish as a template-quality artifact

Before finalizing:

- check that labels are centered
- check that arrows end at shape boundaries, not shape centers
- check that comparable nodes have equal widths
- check that data-store symbols are visually correct
- check that no connector overlaps text
- check that the final result looks like a reusable template, not a one-off sketch

## SVG Rules

Use SVG as the default final artifact.

Read [references/svg-swimlane-style.md](references/svg-swimlane-style.md) before drawing when the user expects a polished diagram.
Read [references/enterprise-swimlane-template.md](references/enterprise-swimlane-template.md) when the user is building management-process diagrams similar to the repository's enterprise-management materials.
Use [assets/enterprise-swimlane-skeleton.svg](assets/enterprise-swimlane-skeleton.svg) as the default layout skeleton when a ready-made frame helps.

Always follow these rules:

- output a complete `<svg>` document
- use a white background
- draw lane boundaries explicitly
- draw lane headers explicitly
- use rounded rectangles for actions
- use diamonds for decisions
- use terminator shapes for start/end when needed
- use consistent stroke width
- keep typography centered and readable
- keep labels short enough to fit the shapes
- use restrained colors only
- use one fill color per node family unless the user explicitly wants a richer palette

## Preferred Visual Style

Default style:

- background: white
- borders: dark gray or black
- lane header fill: very light gray
- activity nodes: light blue-gray
- decision nodes: light warm yellow
- data/storage nodes only when the source truly includes a data object
- connectors: simple black or dark gray arrows

Do not add visual effects such as:

- gradients
- shadows
- icons
- excessive colors

## Geometry Heuristics

Default geometric intent:

- lane width: uniform
- header height: fixed
- node width and height: consistent per node type
- vertical spacing: consistent
- decision nodes centered within lane flow
- cross-lane arrows should be horizontal when possible

If the flow gets too dense:

- split it into a main diagram and an exception diagram
- or reduce detail and keep only structurally important steps

## Editable Source Fallbacks

If the user explicitly asks for editable source:

- prefer PlantUML first
- use Mermaid only for Obsidian-native compatibility

When using source formats, clearly state that they are compatibility outputs, not the preferred rendered deliverable.

## Boundaries

- Do not default to Mermaid.
- Do not present raw diagram source as if it were the final visual.
- Do not generate tangled graphs with many backtracking arrows.
- Do not prioritize completeness over visual clarity.
- Do not output a pseudo-swimlane when the user clearly wants a rendered swimlane.
- Do not leave obvious geometry defects such as misaligned widths, overlapping labels, or incorrect data-store symbols.

## References

- SVG visual rules and starter layout: [references/svg-swimlane-style.md](references/svg-swimlane-style.md)
- Enterprise-management template rules: [references/enterprise-swimlane-template.md](references/enterprise-swimlane-template.md)
- BPMN-like business layout rules: [references/bpmn-like-layout-rules.md](references/bpmn-like-layout-rules.md)
- PlantUML structured fallback: [references/plantuml-swimlane-patterns.md](references/plantuml-swimlane-patterns.md)
- Mermaid compatibility notes: [references/mermaid-swimlane-patterns.md](references/mermaid-swimlane-patterns.md)
