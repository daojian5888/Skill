# SVG Swimlane Style

Use this reference when generating a real rendered swimlane diagram.

## Visual Goal

The SVG should resemble a clean draw.io-style or presentation-style swimlane chart:

- vertical lane columns
- header row at top
- ample whitespace
- aligned shapes
- readable labels
- simple connector routing

## Structural Template

Build the diagram in this order:

1. outer canvas
2. lane rectangles
3. lane header rectangles
4. node shapes
5. labels
6. connectors and arrowheads

## Default Canvas Rules

- white background
- width based on lane count
- height based on step count
- 40-60px outer padding

## Lane Rules

- equal-width columns
- visible vertical separators
- header area with light gray fill
- centered lane titles

## Node Rules

### Action node

- rounded rectangle
- light blue-gray fill
- dark border
- centered text

### Decision node

- diamond
- light warm fill
- dark border
- short decision text only

### Terminator node

- pill / rounded terminator
- subtle fill
- use for start/end when helpful

### Data object

- use only if the process explicitly has a document, database, or record artifact
- do not add data shapes unless they matter

## Connector Rules

- vertical arrows inside a lane
- horizontal arrows for lane handoff
- avoid diagonal connectors when possible
- use consistent arrowheads
- label only important branches such as `是` / `否`

## Typography Rules

- keep labels short
- center labels in shapes
- if labels wrap, use 2 lines max where possible
- lane title font can be slightly larger than node text

## Color Rules

- white background
- near-black border
- light neutral headers
- muted blue-gray for actions
- muted yellow for decisions
- muted green only if a data or result node truly needs emphasis

## Layout Heuristics

- keep the main path flowing downward
- place decision follow-up nodes directly below or adjacent
- keep rejection loops compact
- do not route arrows across multiple lanes unless necessary

## Minimal SVG Skeleton

```svg
<svg xmlns="http://www.w3.org/2000/svg" width="900" height="1200" viewBox="0 0 900 1200">
  <defs>
    <marker id="arrow" markerWidth="10" markerHeight="10" refX="8" refY="3" orient="auto">
      <path d="M0,0 L0,6 L9,3 z" fill="#222"/>
    </marker>
  </defs>

  <rect x="20" y="20" width="860" height="1160" fill="#fff" stroke="#222" stroke-width="2"/>

  <rect x="20" y="20" width="430" height="70" fill="#f3f4f6" stroke="#222" stroke-width="2"/>
  <rect x="450" y="20" width="430" height="70" fill="#f3f4f6" stroke="#222" stroke-width="2"/>

  <text x="235" y="62" text-anchor="middle" font-size="20">单元经理</text>
  <text x="665" y="62" text-anchor="middle" font-size="20">销售顾问</text>

  <rect x="150" y="160" rx="18" ry="18" width="140" height="72" fill="#dfe5f2" stroke="#222" stroke-width="2"/>
  <text x="220" y="203" text-anchor="middle" font-size="18">1. 线索获取</text>

  <line x1="220" y1="232" x2="220" y2="315" stroke="#222" stroke-width="2" marker-end="url(#arrow)"/>
</svg>
```

Use this skeleton as a layout mindset, not as a fixed template.
