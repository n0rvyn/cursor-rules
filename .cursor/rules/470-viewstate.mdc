---
description: "470: View state machine"
scopes: [chat, edit]
tags: [viewstate]
priority: 470
alwaysApply: false
globs: ["**/*.swift"]
---

# View State Machine
- Expose enum:

  ```swift
  enum ViewState { case loading, empty, error(String), content }
  ```

* Every network-backed screen must implement the four states.
* No “white screen waiting” → show `ProgressView()` for `.loading`.
* Error view must include Retry action.
