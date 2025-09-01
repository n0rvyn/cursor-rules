---
description: "001: Global coding conventions & context order"
scopes: [chat, edit]
tags: [coding-style, conventions]
priority: 1
globs: ["**/*.py", "**/*.ts"]
alwaysApply: true
---

## 📐 Coding Style
- Python follows PEP 8, TS/JS follows Airbnb style guide
- Functions use `snake_case`, classes use `PascalCase`
- Never swallow exceptions: explicitly raise/return errors
- Use descriptive variable names (no single letters except loop counters)

## 🎯 AI Interaction Guidelines
- No apologies or conversational fluff - focus on solutions
- No inventions: Only implement explicitly requested features
- Verify information against provided context before coding
- Ask for clarification when requirements are ambiguous
- Provide complete single-file edits to avoid fragmented diffs

## 📚 Context Precedence
1. Rule files (lower numbers have higher priority)
2. Existing source code patterns
3. Referenced documentation (@docs/, @README.md)
4. Chat prompts and user requests

## 🚫 Prohibited Actions
- Don't suggest whitespace-only changes
- Don't create new APIs without explicit approval
- Don't modify multiple files simultaneously without review
- Don't assume missing dependencies or configurations

> Never invent APIs out of thin air; ask for clarification when information is missing.
