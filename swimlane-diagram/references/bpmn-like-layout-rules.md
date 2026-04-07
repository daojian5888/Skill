# BPMN-Like Layout Rules

Use this reference when the user wants the diagram to feel closer to draw.io or BPMN-style business process documentation.

## Visual Goal

The diagram should read like a process artifact used in operations, consulting, delivery, or internal process documentation.

It should feel:

- ordered
- restrained
- stage-aware
- easy to scan left-to-right or top-to-bottom
- explicit about ownership and handoffs

It should not feel:

- like a raw engineering flowchart
- like a tangled graph
- like a literal transcription of notes

## Structural Rules

- Keep one dominant happy path.
- Put exceptions near the decision that creates them.
- Do not send rejection paths across half the diagram.
- Keep each swimlane internally coherent.
- Keep gateways sparse.
- If a process has many approvals, group them into stages instead of alternating endlessly between lanes.

## Stage Heuristic

When useful, mentally structure the process into:

1. initiation
2. review / decision
3. execution
4. closure

Even if the final diagram does not label those stages explicitly, the node ordering should reflect them.

## Node Heuristic

- Start / end nodes should be visually distinct.
- Action nodes should be short verb phrases.
- Gateway nodes should contain only the decision question.
- Avoid labels longer than one short line when possible.

## Handoff Heuristic

Every cross-lane move should answer a real ownership change.

Do not move lanes unless:

- another role takes responsibility
- a system action actually matters
- an approval or notification changes who owns the next step

## Exception Path Heuristic

If a rejection or retry path exists:

- branch locally
- return quickly or terminate
- do not let it dominate the diagram

If exceptions are numerous, split them into a second diagram.

## Styling Heuristic

- White background
- Light fill tones
- Dark gray borders
- Accent color only for gateways or emphasis
- No heavy gradients
- No ornamental icons

## Preferred Mental Model

Think:

- swimlane ownership from BPMN
- polished business layout from draw.io
- restrained styling from formal documentation

Not:

- generic developer flowchart
- mind map
- free-form graph
