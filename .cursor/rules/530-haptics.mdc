---
description: "530: Haptics"
scopes: [chat, edit]
tags: [haptics]
priority: 530
alwaysApply: true
globs: ["**/*.swift"]
---

# Haptics
- Key completions only:

  | Scenario                | Generator                              |
  |-------------------------|----------------------------------------|
  | Task success            | `UINotificationFeedbackGenerator(.success)` |
  | Warning                 | `UINotificationFeedbackGenerator(.warning)` |
  | Selection change        | `UISelectionFeedbackGenerator`         |
  | Subtle tap (toggle)     | `UIImpactFeedbackGenerator(style: .light)` |

- Never trigger on every scroll or keystroke.
- Abstract in helper: `Haptics.shared.play(.success)`.

