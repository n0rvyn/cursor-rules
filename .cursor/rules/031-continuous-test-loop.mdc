---
description: "031: Polyglot quality-gate workflow"
scopes: [chat, edit]
tags: [quality-gate, testing, linting]
priority: 31
alwaysApply: true
globs:
---

# 🛡️ Polyglot Quality‑Gate Workflow

## 1 Detect active language(s)
Scan the diff or staged files for dominant extensions and pick the first matching tool‑chain set below.

| Language | Formatter | Linter / Static | Type‑checker | Tests | Sec‑audit |
|----------|-----------|-----------------|--------------|-------|-----------|
| **JavaScript / TypeScript** | `prettier --check .` | `eslint .` :contentReference[oaicite:0]{index=0} | `tsc --noEmit` | `npm run test --silent` or `jest` :contentReference[oaicite:1]{index=1} | `npm audit --audit-level=moderate` |
| **Python** | `black --check .` | `flake8 .` :contentReference[oaicite:2]{index=2} | `mypy .` :contentReference[oaicite:3]{index=3} | `pytest -q` :contentReference[oaicite:4]{index=4} | `pip-audit .` |
| **Go** | `go fmt ./...` | `go vet ./...` :contentReference[oaicite:5]{index=5} | — | `go test ./... -race` | `govulncheck ./...` |
| **Swift / SPM** | `swiftformat --lint .` | `swiftlint lint` | `swift build` | `swift test` | `swift package audit` |
