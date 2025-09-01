---
description: "007: Issue fixing rules to prevent overcomplicated fixes"
scopes: [chat, edit]
tags: [issue-fixing, problem-solving, minimal-changes]
priority: 7
globs:
  - "**/*.swift"
  - "**/*.ts"
  - "**/*.js"
  - "**/*.py"
  - "**/*.go"
alwaysApply: true
---

# Issue Fixing Rules - Prevent Overcomplicated Fixes

## 🎯 Golden Rule

> **"Fix problems, not patterns. Understand before changing. Test before committing."**

## 🚫 What NOT to Do

### ❌ Mistake 1: Assume Patterns Are Wrong
```
❌ WRONG: "I see @MainActor + ObservableObject, this must be wrong"
❌ WRONG: "This looks suspicious, let me fix it"
❌ WRONG: "Let me rewrite multiple services to fix this pattern"
```

**Result**: Made unnecessary changes, had to revert them, wasted time.

### ❌ Mistake 2: Focus on Symptoms, Not Root Causes
```
❌ WRONG: "The pattern looks wrong, let me fix it"
❌ WRONG: "This violates best practices, must change"
❌ WRONG: "Let me apply the 'correct' pattern everywhere"
```

**Result**: Fixed things that weren't broken, ignored real issues.

### ❌ Mistake 3: Make Multiple Changes Simultaneously
```
❌ WRONG: "Let me fix all these services at once"
❌ WRONG: "I'll change the entire architecture in one go"
❌ WRONG: "Let me refactor everything to follow the 'right' pattern"
```

**Result**: Complex debugging, multiple reverts, unclear cause-and-effect.

## ✅ What TO Do

### ✅ Step 1: Verify the Problem Actually Exists
```
✅ RIGHT: "Let me verify this is actually causing issues"
✅ RIGHT: "Let me build and test first"
✅ RIGHT: "Let me reproduce the reported problem"
```

**Example**:
- ❌ **Assumption**: `@MainActor + ObservableObject` mixing is always wrong
- ✅ **Investigation**: Check if services are actually used for UI binding
- ✅ **Discovery**: Most services aren't used for UI binding, so the pattern is fine

### ✅ Step 2: Understand the Architecture Intent
```
✅ RIGHT: "Why was this designed this way?"
✅ RIGHT: "What does this service actually need?"
✅ RIGHT: "What are the dependencies and requirements?"
```

**Example**:
- ❌ **Surface Analysis**: "Mixing @MainActor with ObservableObject is wrong"
- ✅ **Deep Analysis**: "Why does EnvironmentalService need @MainActor?"
- ✅ **Discovery**: "It needs to access ModelContainer.mainContext which is @MainActor"

### ✅ Step 3: Test Minimal Changes First
```
✅ RIGHT: "Let me make one small change and test"
✅ RIGHT: "Let me test if this actually breaks anything first"
✅ RIGHT: "Let me change one service, test, then proceed"
```

**Example**:
- ❌ **Over-Engineering**: Changed 5+ services simultaneously
- ✅ **Minimal Approach**: Change one service, test, then proceed

## 🔍 Investigation Framework

### Before Making ANY Changes

1. **Build and Test the Current State**
   ```bash
   xcodebuild -project Runetic.xcodeproj -scheme Runetic -destination 'platform=iOS,id=DEVICE_ID' build
   ```
   - Does it build successfully?
   - Does basic functionality work?
   - Are there runtime errors?

2. **Understand the Current Architecture**
   - What are the dependencies between services?
   - Why was this pattern chosen?
   - What would breaking this pattern cost?

3. **Verify the Reported Issue**
   - Can you reproduce the problem?
   - Is it actually causing issues?
   - Is it a real problem or just "looks wrong"?

### When Investigating "Suspicious" Patterns

| Pattern | Action | Investigation Questions |
|---------|--------|-------------------------|
| **@MainActor + ObservableObject** | **Investigate First** | Is it used for UI binding? What does it need @MainActor for? |
| **Multiple imports** | **Verify Usage** | Are these imports actually used? Why were they added? |
| **Complex patterns** | **Understand Intent** | Why was this designed this way? What problem does it solve? |
| **Deprecated APIs** | **Test Impact** | Does it actually break functionality? What's the migration cost? |

## 📋 Prevention Checklist

### Before Making Any Changes
- [ ] **Verify the issue actually exists** (build, test, reproduce)
- [ ] **Understand why the current pattern exists** (dependencies, requirements)
- [ ] **Test the simplest fix first** (one change at a time)
- [ ] **Consider the impact** (what might break, how many files affected)
- [ ] **Document the reasoning** (why this change is necessary)

### When You're Unsure
- [ ] **Ask for clarification** rather than making assumptions
- [ ] **Start with investigation** rather than implementation
- [ ] **Test incrementally** rather than making multiple changes
- [ ] **Document your findings** for future reference

## 🎓 Specific Lessons

### Lesson 1: Actor Isolation is Complex
```swift
// What we learned: @MainActor chains are legitimate
EnvironmentalService (@MainActor) → CPRIManager (@MainActor) → UI Binding
```

**Rule**: Don't assume actor isolation patterns are wrong without understanding the dependency chain.

### Lesson 2: ObservableObject != UI Binding
```swift
// What we learned: Services can be ObservableObject without being used for UI
class SomeService: ObservableObject {
    // This doesn't mean it's used in @ObservedObject
}
```

**Rule**: Check actual usage before assuming ObservableObject means UI binding.

### Lesson 3: Preview Containers are Different
```swift
// What we learned: Preview containers can violate single container rule
#Preview {
    .modelContainer(for: [...], inMemory: true) // ❌ Creates separate container
}

// Fixed:
#Preview {
    .modelContainer(ModelContainer.shared) // ✅ Uses shared container
}
```

**Rule**: Preview containers should follow the same architectural rules as the main app.

## 🛠️ Investigation Tools

### Build Testing
```bash
# Always test builds before and after changes
xcodebuild -project Runetic.xcodeproj -scheme Runetic -destination 'platform=iOS,id=DEVICE_ID' build
```

### Usage Analysis
```bash
# Find actual usage patterns
grep -r "@ObservedObject.*ServiceName" .
grep -r "@StateObject.*ServiceName" .
grep -r "ServiceName()" .
```

### Dependency Tracing
```bash
# Follow the call chain to understand relationships
grep -r "ServiceName\." .
grep -r "ServiceName.shared" .
```

## 🎯 Summary

**Remember**: The goal is to solve real problems, not to make the code look "correct" according to some abstract standard.

**Key Principles**:
1. **Investigate before implementing**
2. **Understand before changing**
3. **Test before committing**
4. **One change at a time**
5. **Document your reasoning**

**When in doubt**: Ask questions, investigate further, and remember that sometimes the "suspicious" pattern is actually the right solution for the specific problem it's solving.