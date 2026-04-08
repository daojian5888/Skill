# Mermaid Swimlane Compatibility Notes

Mermaid does not provide a strong formal swimlane notation comparable to standard cross-functional diagrams.

Use Mermaid only when:

- the user explicitly needs Obsidian-native rendering
- editability inside Markdown is more important than formal presentation quality

## Rules

- Treat Mermaid as a compatibility format.
- Keep lane count low.
- Keep branching minimal.
- Do not claim it is a formal standard swimlane representation.
- Prefer one main path and short exception branches.

## Minimal Template

```mermaid
flowchart LR
  subgraph L1[员工]
    a1([提交申请])
    a2([接收结果])
  end

  subgraph L2[主管]
    b1([审核申请])
    b2{是否通过}
  end

  subgraph L3[财务]
    c1([复核预算])
  end

  a1 --> b1 --> b2
  b2 -- 是 --> c1 --> a2
```

This is acceptable as a lightweight Markdown diagram, not as the preferred formal swimlane output.
