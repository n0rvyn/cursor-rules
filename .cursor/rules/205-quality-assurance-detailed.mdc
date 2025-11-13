---
description: "质量保证 - 防幻觉与行为保护 - 详细参考"
scopes: [chat, edit]
tags: [quality-assurance, anti-hallucination, behavior-preservation, safety, detailed-reference]
priority: 205
globs: []
alwaysApply: false
---

# 质量保证 - 防幻觉与行为保护（详细参考）

> **注意**：本文件为详细参考，不会自动加载。  
> **辨证思考铁律**：见 `000-critical-rules.mdc` 的"AI 工作原则"部分

---

> **核心原则**: 保护现有功能，防止回归；验证所有信息，防止幻觉

---

## 🛡️ Anti-Hallucination Measures

### Core Principles

```markdown
1. **Verify Information**: Always cross-check against provided context before coding
2. **File-by-File Changes**: Complete one file before moving to next, ask for review
3. **Single Chunk Edits**: Provide all file edits in one block to avoid fragmentation
4. **Explicit Confirmation**: Ask before major architectural changes
5. **Reference Existing Patterns**: Check existing code before creating new approaches
```

### Quality Gates

```markdown
✅ **Limit Change Size**: Single modification ≤ 120 effective lines
✅ **Type Check First**: Ensure compilation passes before suggesting
✅ **Test-Driven Approach**: Write failing tests first, then implement
✅ **Grep Before Create**: Search existing codebase before introducing new APIs
```

### Self-Validation Process

```markdown
1. **Chain-of-Thought**: For complex problems, reason through step-by-step first
2. **Context Verification**: Re-read requirements before final code generation
3. **Risk Assessment**: End responses with `SELF-CHECK:` noting potential issues
```

**Example of Self-Check:**
```markdown
SELF-CHECK:
✅ Verified pattern exists in HealthKitService.swift:45-67
✅ Complexity: 2/10 (simple, reusing existing pattern)
⚠️ Potential Issue: Need to handle iOS 18 compatibility
✅ Mitigation: Added #available check
```

---

## 🚨 Immediate Stop Conditions

**Stop and ask for clarification when:**

- ❌ Context seems contradictory or incomplete
- ❌ Multiple valid interpretations of requirements exist
- ❌ Proposed changes would break existing functionality
- ❌ Dependencies or configurations are assumed but not confirmed
- ❌ No existing pattern found for the requested feature
- ❌ Complexity rating >6/10 without explicit approval

**Example:**
```markdown
⛔ STOP: Unclear Requirement

User requested: "Add caching to workout fetching"

CLARIFICATION NEEDED:
1. What should be cached? (Raw HKWorkout data? Converted TrainingLog?)
2. Cache duration? (Session? 24h? 7 days?)
3. Cache invalidation? (Manual? Time-based? Event-based?)
4. Existing pattern? (Check if other services use caching)

BEFORE PROCEEDING:
- Please clarify the caching requirements
- Or point me to existing caching pattern in the codebase
```

---

## 🔒 Behaviour-Preservation Rules

### No Regressions

```markdown
✅ **New features or bug-fixes MUST NOT break public APIs or observable behaviour**
✅ **All existing tests must continue to pass**
✅ **No changes to function signatures without explicit approval**
✅ **No removal of existing functionality without documentation**
```

### Minimal Patch

```markdown
✅ **Touch only the lines strictly required**
✅ **Large rewrites are PROHIBITED unless explicitly requested**
✅ **Prefer wrapper functions or targeted refactors**
✅ **No whitespace-only changes**
✅ **No cosmetic renames unless they fix bugs or improve clarity significantly**
```

**Example of Minimal Patch:**

```swift
// ❌ BAD: Rewriting entire function
func fetchWorkouts() async throws -> [HKWorkout] {
    // Completely rewritten implementation
    // Changes 50 lines when only 2 lines needed fixing
}

// ✅ GOOD: Minimal change
func fetchWorkouts() async throws -> [HKWorkout] {
    // Existing code unchanged...
    
    // Only fix the specific issue
    let descriptor = HKSampleQueryDescriptor(  // Changed line 1
        sampleType: HKObjectType.workoutType(),  // Changed line 2
        predicate: predicate,
        sortDescriptors: sortDescriptors
    )
    
    // Existing code unchanged...
}
```

### Comment Every Deletion

```markdown
✅ **Every deleted line/function MUST have a comment explaining why**
✅ **Format**: `// Removed: [reason]`
✅ **Include reference**: Link to issue/ADR if applicable
```

**Example:**
```swift
// Removed: Old HealthKit query pattern (pre-iOS 18)
// Replaced with HKSampleQueryDescriptor (iOS 18+ only)
// See: docs/03-decisions/ADR-XXX-healthkit-modernization.md
// Old code:
// let query = HKSampleQuery(...)
```

### When Unsure, Ask

```markdown
⚠️ **When unsure about impact, ask the user to run tests first**
⚠️ **When changing critical paths, explicitly state potential risks**
⚠️ **When refactoring, provide "before/after" comparison**
```

---

## 🎯 Quality Checklist

### Before Making Changes

- [ ] **Context Verified**: Re-read user requirements and existing code
- [ ] **Existing Pattern Found**: Located 2-3 similar implementations
- [ ] **Complexity Assessed**: Rated solution 1-10
- [ ] **Impact Analyzed**: Identified affected files and functions
- [ ] **Tests Identified**: Know which tests need to pass

### During Implementation

- [ ] **File-by-File**: Complete one file before moving to next
- [ ] **Single Chunk**: All changes for a file in one edit block
- [ ] **Minimal Diff**: Only change necessary lines
- [ ] **Comments Added**: Explain why, not just what
- [ ] **Deletions Justified**: Every deletion has a reason comment

### After Implementation

- [ ] **Self-Check**: Reviewed changes for potential issues
- [ ] **Compilation**: Code should compile without errors
- [ ] **Tests**: Existing tests should pass
- [ ] **Documentation**: Updated relevant docs (file-structure.md, changelog)
- [ ] **Risk Assessment**: Noted any potential issues

---

## 📋 Change Size Guidelines

### Small Change (✅ Preferred)

```markdown
- ≤ 5 files touched
- ≤ 50 lines changed per file
- ≤ 120 lines total effective change
- Single logical change
- Easy to review and test
```

### Medium Change (⚠️ Requires Justification)

```markdown
- 6-10 files touched
- 51-150 lines changed per file
- 121-500 lines total
- Multiple related changes
- Requires careful review
```

### Large Change (❌ Requires Explicit Approval)

```markdown
- >10 files touched
- >150 lines per file
- >500 lines total
- Architectural changes
- Must ask user before proceeding
```

**Example:**
```markdown
CHANGE SIZE ASSESSMENT:
- Files affected: 3 (HealthKitService.swift, TrainingLogViewModel.swift, TrainingLogView.swift)
- Lines changed: 35 (15 + 12 + 8)
- Total: 35 lines across 3 files
- Category: ✅ Small Change
- Justification: Adding incremental sync to existing HealthKit integration
```

---

## 🚫 Prohibited Actions

### Never Do This

```markdown
❌ Don't suggest whitespace-only changes
❌ Don't create new APIs without explicit approval
❌ Don't modify multiple files simultaneously without review
❌ Don't assume missing dependencies or configurations
❌ Don't invent APIs out of thin air
❌ Don't rewrite working code "just to make it better"
❌ Don't remove code just to silence errors
❌ Don't comment out code instead of fixing it
❌ Don't use placeholder/stub implementations in production code
```

### Especially for Epoch Project

```markdown
❌ NEVER modify or delete HealthKit training records
❌ NEVER hardcode API keys or sensitive data
❌ NEVER bypass dependency injection
❌ NEVER use force unwrap (!) without justification
❌ NEVER block the main thread with heavy operations
❌ NEVER skip error handling (no bare try!)
```

---

## ✅ Required Actions

### Always Do This

```markdown
✅ Always cross-check information against provided context
✅ Always show existing working code before proposing changes
✅ Always rate solution complexity 1-10
✅ Always justify complexity >3/10
✅ Always find 2-3 existing similar patterns
✅ Always comment deletions with reasons
✅ Always ask for approval before large refactors
✅ Always complete one file before moving to next
✅ Always test that code compiles
✅ Always preserve existing behavior
```

### Especially for Epoch Project

```markdown
✅ Always mark ViewModel with @MainActor
✅ Always use Protocol for Service dependencies
✅ Always provide Mock implementations for testing
✅ Always use LocalizedString for UI text
✅ Always update file-structure.md after changes
✅ Always record changes in changelog
✅ Always run xcodebuild to verify compilation
```

---

## 🧪 Testing Requirements

### Test-Driven Approach

```markdown
1. **Write Failing Test First**: Create test that exposes the issue/need
2. **Implement Minimal Fix**: Write just enough code to pass the test
3. **Refactor**: Clean up code while keeping tests green
4. **Verify**: Run full test suite to ensure no regressions
```

**Example:**
```swift
// Step 1: Write failing test
func testFetchIncrementalWorkouts() async throws {
    let service = HealthKitService()
    let since = Date().addingTimeInterval(-7 * 24 * 3600)
    let workouts = try await service.fetchIncrementalWorkouts(since: since)
    XCTAssertGreaterThan(workouts.count, 0)  // Fails - method doesn't exist
}

// Step 2: Implement minimal fix
actor HealthKitService {
    func fetchIncrementalWorkouts(since date: Date) async throws -> [HKWorkout] {
        // Minimal implementation to pass test
    }
}

// Step 3: Refactor (if needed)
// Step 4: Run all tests
```

### Test Coverage Requirements

```markdown
✅ **Core business logic**: 70%+ coverage
✅ **Critical paths**: 100% coverage
✅ **New features**: Tests required before merge
✅ **Bug fixes**: Regression test required
```

---

## 📊 Risk Assessment Template

**Use this template at the end of significant changes:**

```markdown
SELF-CHECK & RISK ASSESSMENT:

✅ Evidence Verified:
- Found pattern in: `Epoch/Services/HealthKitService.swift:45-67`
- Complexity: 2/10 (minimal change)

✅ Behavior Preserved:
- No changes to existing function signatures
- All existing tests should pass
- No removal of functionality

✅ Change Size:
- Files affected: 2 (HealthKitService.swift, TrainingLogViewModel.swift)
- Lines changed: 28 total (18 + 10)
- Category: Small Change ✅

⚠️ Potential Risks:
- iOS 18 compatibility: Added #available check ✅
- Threading: Uses existing Actor pattern ✅
- Performance: Minimal impact (same query mechanism) ✅

✅ Documentation:
- Updated file-structure.md ✅
- Added to changelog ✅
- No ADR needed (not architectural change) ✅

🎯 Confidence Level: HIGH
- Based on existing proven pattern
- Minimal changes to critical paths
- Full test coverage planned
```

---

## 🔄 Continuous Improvement

### Learn from Mistakes

```markdown
When an issue is discovered:
1. **Document the Issue**: Add to `docs/09-lessons-learned/`
2. **Update Rules**: Strengthen relevant quality gates
3. **Add Test**: Prevent regression
4. **Share Knowledge**: Update team documentation
```

### Quality Metrics

```markdown
Track these metrics over time:
- Number of regressions introduced
- Test coverage percentage
- Build failure rate
- Code review feedback frequency
```

---

## 🔗 Related Rules

- **00-project-overview.md**: Epoch project constraints and principles
- **01-workflow.md**: Build-Check-Fix cycle requirements
- **02-swift-ios-standards.md**: Coding standards and conventions
- **04-anti-overengineering.md**: Evidence-first and complexity control

---

**Remember**: Quality comes from discipline. Always verify information, preserve existing behavior, keep changes minimal, and ask when unsure. Better to ask a "stupid" question than to introduce a subtle bug.

---

**最后更新**: 2025-11-03  
**版本**: 1.0  
**基于**: `025-preserve-behaviour.mdc` + `050-anti-hallucination.mdc`


