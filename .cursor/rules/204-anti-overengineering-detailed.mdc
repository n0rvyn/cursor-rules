---
description: "防止过度设计 - 证据优先与复杂度控制 - 详细参考"
scopes: [chat, edit]
tags: [anti-overengineering, evidence-first, complexity, decision-making, detailed-reference]
priority: 204
globs: []
alwaysApply: false
---

# 防止过度设计 - 证据优先与复杂度控制（详细参考）

> **注意**：本文件为详细参考，不会自动加载。  
> **辨证思考铁律**：见 `000-critical-rules.mdc` 的"AI 工作原则"部分

---

> **核心原则**: 每个决策必须有证据支持，优先使用现有模式，避免不必要的复杂性

---

## 🎯 核心原则

> **"Every decision must be backed by evidence from existing code, documentation, or verified sources."**

### 三大支柱
1. **证据优先** - 基于现有代码和文档做决策
2. **复杂度控制** - 默认选择最简单的解决方案（≤3/10 复杂度）
3. **模式一致性** - 遵循项目现有模式，不随意创新

---

## 📋 Evidence-First 决策流程

### Before Proposing Any Solution

**必须完成的步骤**：

1. **Find Existing Code** - 找到 2-3 个类似实现的例子
2. **Cite Sources** - 提供文件路径和行号
3. **Explain Patterns** - 描述现有代码如何工作
4. **Justify Deviations** - 解释为什么现有模式不适用（如果偏离）

### Evidence Quality Standards

| 证据类型 | 优先级 | 说明 |
|---------|--------|------|
| **Primary Evidence** | ⭐⭐⭐⭐⭐ | 项目中现有的工作代码 |
| **Secondary Evidence** | ⭐⭐⭐⭐ | Apple 官方文档、Framework 文档 |
| **Tertiary Evidence** | ⭐⭐⭐ | 社区最佳实践（需验证） |
| **Never Accept** | ❌ | 假设、"常识"、未经支持的声明 |

---

## 🚨 Pre-Implementation Checks

### Rule 1: Evidence-First Analysis

**Before implementing ANY solution:**

```markdown
1. ✅ Find existing working code that solves similar problems
   - File: `Epoch/Services/HealthKitService.swift:45-67`
   - Pattern: Uses `@MainActor` + `Actor` for concurrency
   
2. ✅ Cite file paths + line numbers
   - Show me the exact code reference
   
3. ✅ Show me the existing pattern
   - How does it currently work?
   - What dependencies does it have?
   
4. ✅ Explain WHY that pattern won't work for this case
   - Be specific about the limitations
   - Provide evidence, not assumptions
   
5. ✅ Only then propose minimal changes
   - Build on existing patterns
   - Minimize new abstractions
```

### Rule 2: Complexity Rating System

**Rate every solution complexity 1-10:**

| Rating | Category | Action Required |
|--------|----------|----------------|
| **1-3** | 简单（首选） | 使用现有模式，直接实现 |
| **4-6** | 中等 | 需要书面说明理由 |
| **7-10** | 复杂 | 需要明确批准 + ADR |

**DEFAULT**: Always choose ≤3/10 complexity solutions

**Example:**
```markdown
COMPLEXITY ASSESSMENT:
- Solution Complexity: 2/10
- Justification: Reuses existing HealthKitService pattern, only adds one new function
- Existing Pattern: Similar to `fetchWorkouts()` in HealthKitService.swift:45-67
```

### Rule 3: Simplicity Challenge

**If solution has >3 implementation steps:**

```markdown
1. ❓ Justify why 1-step solution won't work
   - Show evidence that simpler approach fails
   
2. ❓ Justify why 2-step solution won't work
   - Explain what additional complexity is needed
   
3. ❓ Show evidence that 3+ steps are actually needed
   - Cite similar complex solutions in codebase
   
4. ✋ Get explicit approval before proceeding
   - Wait for user confirmation
```

### Rule 4: Pattern Compliance

**For any new implementation:**

```markdown
1. ✅ Find 2-3 existing similar patterns in codebase
   - HealthKitService.swift: Uses Actor for thread safety
   - FirebaseService.swift: Uses Protocol + Mock pattern
   - TrainingLogViewModel.swift: Uses @MainActor + @Observable
   
2. ✅ Show me how they work
   - Explain the pattern and its benefits
   
3. ✅ Use the SAME pattern unless you can prove it won't work
   - Consistency is more important than "better" approaches
   
4. ✅ If deviating from pattern, get explicit approval
   - Explain why deviation is necessary
   - Provide evidence that existing pattern fails
```

---

## 🔍 Evidence Collection Process

### Step 1: Search for Existing Patterns

```bash
# Use these tools to find similar implementations
grep -r "similar_pattern" Epoch/
grep -r "related_functionality" Epoch/Services/

# Or use semantic search
# "How does X work in this project?"
# "Where is similar functionality implemented?"
```

### Step 2: Analyze Existing Code

**Documentation Format:**
```markdown
EVIDENCE FOUND:
- File: `Epoch/Services/HealthKitService.swift:45-67`
- Pattern: Uses `@MainActor` + `Actor` for UI updates and thread safety
- Context: Service needs to update UI when data changes
- Dependencies: 
  - Requires `@MainActor` for UI updates
  - Uses `Actor` for background data processing
  - Follows Protocol pattern for dependency injection
```

### Step 3: Document Evidence

**Code Citations:**
```swift
// Based on existing pattern in Epoch/Services/HealthKitService.swift:45-67
// Following the same approach as Epoch/ViewModels/TrainingLogViewModel.swift:23-34
// Using pattern established in Epoch/Models/CachedTrainingLog.swift:12-28
```

**Documentation Citations:**
```swift
// Apple Documentation: https://developer.apple.com/documentation/swiftui/observable
// SwiftData Guide: https://developer.apple.com/documentation/swiftdata
// WWDC 2023 Session: "Meet SwiftData"
```

---

## 🚫 Prohibited Without Evidence

### Don't Assume

```markdown
❌ "This pattern is wrong" (without showing why)
❌ "This is the standard way" (without documentation)
❌ "This will cause problems" (without evidence)
❌ "This is better" (without comparison)
```

### Don't Invent

```markdown
❌ New patterns without existing examples
❌ New APIs without documentation
❌ New architectures without justification
❌ New conventions without precedent
```

**Example of BAD approach:**
```markdown
"We should use a Coordinator pattern for navigation."
❌ No evidence that current NavigationStack approach is failing
❌ No similar Coordinator pattern in existing codebase
❌ Adds complexity without proven benefit
```

**Example of GOOD approach:**
```markdown
"We should continue using NavigationStack for navigation."
✅ Currently used in TrainingLogView.swift:12-45
✅ Apple's recommended approach (WWDC 2022)
✅ Complexity: 2/10 (simple, consistent)
✅ Works well for our use case
```

---

## ✅ Required With Evidence

### Always Show

```markdown
✅ Existing working code that solves similar problems
✅ File paths and line numbers for all references
✅ Explanation of how existing patterns work
✅ Justification for any deviations from existing patterns
```

### Always Cite

```markdown
✅ Official documentation for all API usage
✅ Existing project patterns for all architectural decisions
✅ Verified sources for all best practices
✅ Specific examples for all recommendations
```

---

## 📋 Evidence Templates

### Existing Code Analysis

```markdown
EXISTING PATTERN ANALYSIS:
- File: `Epoch/Services/HealthKitService.swift`
- Lines: 45-67
- Pattern: Actor-based service with @MainActor for UI updates
- Context: Needs thread-safe access to HealthKit + UI updates
- Dependencies: HKHealthStore, ModelContext (via @MainActor)
- Similarity: Solving same problem - async data fetch + UI update

CONCLUSION:
- Reuse this pattern ✅
- Complexity: 2/10
- No new abstractions needed
```

### Solution Justification

```markdown
SOLUTION JUSTIFICATION:
- Based on: `Epoch/Services/HealthKitService.swift:45-67`
- Pattern: Actor + @MainActor
- Adaptation: Add new `fetchIncrementalWorkouts()` method
- Evidence: Same concurrency pattern, proven to work
- Complexity: 2/10 (minimal change to existing service)
```

### Deviation Justification

```markdown
DEVIATION JUSTIFICATION:
- Existing pattern: All Services use Actor isolation
- Why it won't work: This service needs to be @MainActor throughout
- Reason: Heavy UI interaction, needs direct access to @MainActor properties
- Alternative approach: Use @MainActor class instead of Actor
- Evidence: Similar pattern in Apple's sample code (link)
- Complexity: 4/10 (deviation from project pattern)
- Approval Required: ✅ Yes (>3/10 complexity + pattern deviation)
```

---

## 🎯 Quality Gates

### Before Implementation

- [ ] **Evidence collected**: Found 2-3 existing similar patterns
- [ ] **Sources cited**: All references include file paths/line numbers
- [ ] **Patterns understood**: Can explain how existing code works
- [ ] **Complexity rated**: Solution rated 1-10, justified if >3
- [ ] **Pattern compliance**: Using existing project patterns
- [ ] **Justification complete**: Can explain why approach is appropriate

### During Implementation

- [ ] **Following evidence**: Implementation matches cited patterns
- [ ] **Maintaining consistency**: Using same approaches as existing code
- [ ] **Documenting decisions**: Adding comments explaining choices
- [ ] **No over-engineering**: Not adding unnecessary abstractions

### After Implementation

- [ ] **Verification complete**: Solution works as expected
- [ ] **Pattern consistency**: Follows established project patterns
- [ ] **Documentation updated**: Changes properly documented
- [ ] **No regressions**: Existing functionality still works

---

## 🚨 Violation Consequences

### Missing Evidence

| Violation Type | Response |
|---------------|----------|
| **First violation** | Request evidence before proceeding |
| **Repeated violations** | Require evidence for all future decisions |
| **Pattern violations** | Require explicit approval for any deviations |

### False Evidence

| Issue Type | Action |
|-----------|--------|
| **Incorrect citations** | Correct immediately and verify all other citations |
| **Misleading patterns** | Explain actual pattern and adjust solution |
| **Outdated references** | Update to current documentation/patterns |

---

## 📚 Epoch Project Evidence Sources

### Primary Sources (Existing Code)
- **Services**: `Epoch/Services/` - HealthKit, Firebase, Backend integrations
- **ViewModels**: `Epoch/ViewModels/` - MVVM pattern examples
- **Models**: `Epoch/Models/` - SwiftData models with `Cached` prefix
- **Views**: `Epoch/Views/` - SwiftUI view patterns

### Secondary Sources (Documentation)
- **Architecture**: `docs/02-architecture.md`
- **ADRs**: `docs/03-decisions/` - Architectural decisions with rationale
- **Implementation**: `docs/04-implementation/` - Detailed implementation guides
- **Coding Standards**: `docs/08-guidelines/coding-standards.md`

### External Sources
- **Apple Documentation**: https://developer.apple.com/documentation/
- **SwiftData Guide**: https://developer.apple.com/documentation/swiftdata
- **SwiftUI Documentation**: https://developer.apple.com/documentation/swiftui
- **HealthKit**: https://developer.apple.com/documentation/healthkit

---

## 📊 Practical Examples

### ✅ Good Example: Following Existing Pattern

```markdown
USER: "We need to add a new method to fetch workouts from last week."

AI RESPONSE:
EVIDENCE ANALYSIS:
- Existing: `HealthKitService.swift:45-67` has `fetchRecentWorkouts(limit:)`
- Pattern: Actor-based service with async/await
- Complexity: 2/10 (add one similar method)

PROPOSED SOLUTION:
```swift
// Based on existing pattern in HealthKitService.swift:45-67
actor HealthKitService {
    func fetchWorkoutsFromLastWeek() async throws -> [HKWorkout] {
        let oneWeekAgo = Date().addingTimeInterval(-7 * 24 * 3600)
        return try await fetchIncrementalWorkouts(since: oneWeekAgo)
    }
}
```

JUSTIFICATION:
- Reuses existing `fetchIncrementalWorkouts()` method
- Follows same Actor pattern
- No new abstractions needed
```

### ❌ Bad Example: Over-Engineering

```markdown
USER: "We need to add a new method to fetch workouts from last week."

AI RESPONSE (DON'T DO THIS):
"Let's create a new WorkoutQueryBuilder pattern with a fluent API:

```swift
WorkoutQuery.builder()
    .timeRange(.lastWeek)
    .activityType(.running)
    .sortBy(.date, .descending)
    .execute()
```

This is more flexible and scalable..."

WHY THIS IS BAD:
❌ No evidence of similar pattern in codebase
❌ Adds unnecessary complexity (7/10 complexity)
❌ Over-engineering a simple requirement
❌ Invents new pattern without justification
```

---

**Remember**: Evidence-first approach prevents overengineering, ensures consistency, and builds on proven patterns rather than inventing new solutions. When in doubt, use existing patterns and keep it simple.

---

**最后更新**: 2025-11-03  
**版本**: 1.0  
**基于**: `006-anti-overengineering.mdc` + `008-evidence-first.mdc`


