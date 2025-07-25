---
description: "450: Layout RTL"
scopes: [chat, edit]
tags: [layout, rtl]
priority: 450
alwaysApply: false
globs: ["**/*.swift"]
---

# Right-to-Left
- No `.padding(.leading / .trailing)` hard-codes – use `.padding(.horizontal)` or `LayoutDirection` checks.
- Verify RTL in previews:

  ```swift
  SomeView()
     .environment(\.layoutDirection, .rightToLeft)
  ```

* Icons that convey direction should adopt `flipsForRightToLeftLayoutDirection`.

