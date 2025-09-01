---
description: "006: Anti-overengineering rules to prevent overcomplicated solutions"
scopes: [chat, edit]
tags: [anti-overengineering, complexity, evidence-first]
priority: 6
globs:
  - "**/*.swift"
  - "**/*.ts"
  - "**/*.js"
  - "**/*.py"
  - "**/*.go"
alwaysApply: true
---

# Anti Over-Engineering Rules

## 🚨 MANDATORY PRE-IMPLEMENTATION CHECKS

### Rule 1: Evidence-First Analysis
```
Before proposing ANY solution, you MUST:
1. Find existing working code that solves similar problems
2. Cite file paths + line numbers 
3. Show me the existing pattern
4. Explain WHY that pattern won't work for this case
5. Only then propose minimal changes
```

### Rule 2: Complexity Rating System
```
Rate every solution complexity 1-10:
- 1-3: Simple (preferred) - uses existing patterns
- 4-6: Moderate - requires justification
- 7-10: Complex - requires explicit approval

DEFAULT: Always choose ≤3/10 complexity solutions
```

### Rule 3: Simplicity Challenge
```
If solution has >3 implementation steps:
1. Justify why 1-step solution won't work
2. Justify why 2-step solution won't work  
3. Show evidence that 3+ steps are actually needed
4. Get explicit approval before proceeding
```

### Rule 4: Pattern Compliance
```
For any new implementation:
1. Find 2-3 existing similar patterns in codebase
2. Show me how they work
3. Use the SAME pattern unless you can prove it won't work
4. If deviating from pattern, get explicit approval
```

## 🎯 VIOLATION TRACKING

When AI violates these rules:
1. Update memory with specific violation
2. Reference violation ID in future conversations
3. Use violation as evidence for stricter enforcement

## 📋 PROMPT TEMPLATES

### Investigation Phase Template
```
Before we implement anything:

EXISTING SOLUTIONS ANALYSIS:
- How does [similar feature] currently work?
- Show me the code (file + lines)
- Why won't this pattern work for our case?

COMPLEXITY ASSESSMENT:
- Rate this solution complexity 1-10: ___
- Justify if >3/10

RULE COMPLIANCE:
- Which user rule applies: ___
- How does this solution follow that rule: ___
```

### Implementation Gate Template
```
IMPLEMENTATION CHECKPOINT:
✅ Found existing patterns? (yes/no + evidence)  
✅ Complexity ≤3/10? (rating + justification)
✅ Follows user rules? (quote specific rule)
✅ User approval obtained? (yes/no)

Only proceed if ALL ✅ are yes.
```

## 🚫 PROHIBITED ACTIONS

- Don't create complex architectures without evidence they're needed
- Don't implement solutions with >3 steps without justification
- Don't deviate from existing patterns without explicit approval
- Don't rate solutions >3/10 complexity without strong justification
- Don't propose solutions without showing existing similar code first

## ✅ REQUIRED ACTIONS

- Always show existing working code before proposing changes
- Always rate solution complexity 1-10
- Always justify complexity >3/10
- Always find 2-3 existing similar patterns
- Always get explicit approval for complex solutions