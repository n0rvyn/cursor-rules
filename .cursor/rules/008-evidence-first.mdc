---
description: "008: Evidence-first decision making and citation requirements"
scopes: [chat, edit]
tags: [evidence-first, citations, decision-making]
priority: 8
globs:
  - "**/*.swift"
  - "**/*.ts"
  - "**/*.js"
  - "**/*.py"
  - "**/*.go"
alwaysApply: true
---

# Evidence-First Decision Making

## 🎯 Core Principle

> **"Every decision must be backed by evidence from existing code, documentation, or verified sources."**

## 📋 Evidence Requirements

### Before Proposing Any Solution
1. **Find Existing Code**: Show 2-3 examples of similar implementations
2. **Cite Sources**: Provide file paths and line numbers
3. **Explain Patterns**: Describe how existing code works
4. **Justify Deviations**: Explain why existing patterns won't work

### Evidence Quality Standards
- **Primary Evidence**: Existing working code in the project
- **Secondary Evidence**: Official documentation (Apple, framework docs)
- **Tertiary Evidence**: Community best practices (with verification)
- **Never Accept**: Assumptions, "common knowledge", or unsupported claims

## 🔍 Evidence Collection Process

### Step 1: Search for Existing Patterns
```bash
# Find similar implementations
grep -r "similar_pattern" .
grep -r "related_functionality" .
codebase_search "How does X work in this project?"
```

### Step 2: Analyze Existing Code
- **File Path**: `Runetic/Services/ExampleService.swift`
- **Lines**: `45-67`
- **Pattern**: How the existing code solves similar problems
- **Dependencies**: What it requires and provides

### Step 3: Document Evidence
```
EVIDENCE FOUND:
- File: Runetic/Services/DataService.swift:23-45
- Pattern: Uses @MainActor + ObservableObject for UI binding
- Context: Service needs to update UI when data changes
- Dependencies: ModelContainer.mainContext (requires @MainActor)
```

## 📚 Citation Format

### Code Citations
```
// Based on existing pattern in Runetic/Services/HealthKitDataFetcher.swift:45-67
// Following the same approach as Runetic/Views/WorkoutListView.swift:23-34
// Using pattern established in Runetic/Models/SwiftDataModels.swift:12-28
```

### Documentation Citations
```
// Apple Documentation: https://developer.apple.com/documentation/swiftui/observableobject
// SwiftData Guide: https://developer.apple.com/documentation/swiftdata
// WWDC 2023 Session: "Meet SwiftData"
```

### Pattern Citations
```
// Similar to existing pattern in:
// - Runetic/Services/EnvironmentalService.swift:15-30
// - Runetic/Services/CPRIManager.swift:22-40
// - Runetic/Managers/DataManager.swift:45-60
```

## 🚫 Prohibited Without Evidence

### Don't Assume
- ❌ "This pattern is wrong" (without showing why)
- ❌ "This is the standard way" (without documentation)
- ❌ "This will cause problems" (without evidence)
- ❌ "This is better" (without comparison)

### Don't Invent
- ❌ New patterns without existing examples
- ❌ New APIs without documentation
- ❌ New architectures without justification
- ❌ New conventions without precedent

## ✅ Required With Evidence

### Always Show
- ✅ Existing working code that solves similar problems
- ✅ File paths and line numbers for all references
- ✅ Explanation of how existing patterns work
- ✅ Justification for any deviations from existing patterns

### Always Cite
- ✅ Official documentation for all API usage
- ✅ Existing project patterns for all architectural decisions
- ✅ Verified sources for all best practices
- ✅ Specific examples for all recommendations

## 🔍 Evidence Verification

### Code Evidence Checklist
- [ ] **File exists**: Can I find the referenced file?
- [ ] **Lines exist**: Do the referenced lines contain the claimed code?
- [ ] **Pattern works**: Does the existing code actually work as described?
- [ ] **Context matches**: Is the existing code solving a similar problem?

### Documentation Evidence Checklist
- [ ] **Source exists**: Can I access the referenced documentation?
- [ ] **Content matches**: Does the documentation say what's claimed?
- [ ] **Version current**: Is the documentation for the current version?
- [ ] **Context relevant**: Is the documentation relevant to the current problem?

## 📋 Evidence Templates

### Existing Code Analysis
```
EXISTING PATTERN ANALYSIS:
- File: [file_path]
- Lines: [line_numbers]
- Pattern: [description of how it works]
- Context: [why this pattern was chosen]
- Dependencies: [what it requires/provides]
- Similarity: [how it relates to current problem]
```

### Solution Justification
```
SOLUTION JUSTIFICATION:
- Based on: [existing code/documentation]
- Pattern: [how existing code works]
- Adaptation: [how we're adapting it for current problem]
- Evidence: [why this approach is appropriate]
```

### Deviation Justification
```
DEVIATION JUSTIFICATION:
- Existing pattern: [what exists]
- Why it won't work: [specific reasons]
- Alternative approach: [what we're doing instead]
- Evidence: [why alternative is better]
```

## 🎯 Quality Gates

### Before Implementation
- [ ] **Evidence collected**: Found existing similar patterns
- [ ] **Sources cited**: All references include file paths/URLs
- [ ] **Patterns understood**: Can explain how existing code works
- [ ] **Justification complete**: Can explain why approach is appropriate

### During Implementation
- [ ] **Following evidence**: Implementation matches cited patterns
- [ ] **Maintaining consistency**: Using same approaches as existing code
- [ ] **Documenting decisions**: Adding comments explaining choices

### After Implementation
- [ ] **Verification complete**: Solution works as expected
- [ ] **Pattern consistency**: Follows established project patterns
- [ ] **Documentation updated**: Changes are properly documented

## 🚨 Violation Consequences

### Missing Evidence
- **First violation**: Request evidence before proceeding
- **Repeated violations**: Require evidence for all future decisions
- **Pattern violations**: Require explicit approval for any deviations

### False Evidence
- **Incorrect citations**: Correct immediately and verify all other citations
- **Misleading patterns**: Explain actual pattern and adjust solution
- **Outdated references**: Update to current documentation/patterns

## 📚 Resources

### Project Evidence Sources
- **Existing Code**: `Runetic/` directory
- **Architecture Docs**: `memory-bank/MEMORY-architecture.md`
- **Pattern Examples**: `memory-bank/DEVELOPER_QUICK_REFERENCE.md`
- **Issue History**: `memory-bank/ISSUE_FIXING_RULES.md`

### External Evidence Sources
- **Apple Documentation**: https://developer.apple.com/documentation/
- **SwiftData Guide**: https://developer.apple.com/documentation/swiftdata
- **SwiftUI Documentation**: https://developer.apple.com/documentation/swiftui
- **WWDC Sessions**: https://developer.apple.com/videos/

---

**Remember**: Evidence-first approach prevents overengineering, ensures consistency, and builds on proven patterns rather than inventing new solutions.