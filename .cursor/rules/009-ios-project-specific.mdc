---
description: "009: iOS 26/Swift 6 project-specific rules and WWDC 2025 features"
scopes: [chat, edit]
tags: [ios, swift6, wwdc2025, project-specific]
priority: 9
globs:
  - "**/*.swift"
  - "**/*.swiftui"
  - "**/*.xib"
  - "**/*.storyboard"
  - "**/*.xcassets"
  - "**/*.xcconfig"
alwaysApply: true
---

# iOS 26/Swift 6 Project-Specific Rules

You are working on an iOS 26/Swift 6 project with WWDC 2025 preview APIs. Follow these project-specific guidelines for optimal development.

## 🎯 Platform Targets & Build Assumptions

### Development Environment
- **Xcode 26 Beta 5** toolchain
- **Swift 6** language mode
- **App targets**: iOS 26 (iPhone) and watchOS 26 exclusively
- **No backwards-compatibility layers** are maintained

### WWDC 2025 Preview APIs Available
- **ModelActor** for SwiftData concurrency
- **@Transient** for computed properties
- **SwiftData v2** semantics and enhanced relationships
- **Enhanced SwiftUI** navigation and state management

## 🏗️ Architecture Rules

### Single ModelContainer
- **Use `ModelContainer.shared`** created in `RunParseApp`
- **No additional containers** are permitted
- **All SwiftData operations** must use the shared container

### SwiftDataManager Pattern
- **Implement as `@MainActor enum`** providing static helpers
- **Operate on `ModelContainer.shared.mainContext`**
- **Thread-safe access** to shared data context

### Model Relationships
- **`SwiftDataTrainingPlan.steps`** declared with `@Relationship(deleteRule: .cascade, inverse: \SwiftDataWorkoutStep.trainingPlan)`
- **Other relationships** retain existing inverse & cascade rules
- **Use SwiftData v2** relationship patterns

## 🧵 Threading & Isolation

### Service Classes
All service classes must be annotated `@MainActor`:
- `WorkoutService`
- `TrainingPlanManager`
- `WeightDeltaService`
- `HRVSleepAggregator`
- `HRVDataFilter`
- `HealthKitDataFetcher`
- `AchievementService`

### SwiftData Operations
- **Any SwiftData write** must occur inside `await MainActor.run { … }`
- **Or on a `@MainActor` context**
- **Thread-safe data access** patterns

### Queries & Predicates
- **Use 2025 API**: `@Query(sort: [SortDescriptor(...])` instead of key-path shorthand
- **Modern SwiftData** query patterns
- **Enhanced relationship** handling

## 🎨 UI & Design System

### Color Helper
- **`Color(hex:)` extension** resides in `Utilities/Color+Hex.swift`
- **Data models must not import SwiftUI**
- **Separation of concerns** between data and UI

### SwiftUI Patterns
- **Use `@Observable`** for view models (not legacy `ObservableObject`)
- **Modern navigation** with `NavigationStack` and `NavigationSplitView`
- **Type-safe navigation** using `.navigationDestination(for:destination:)`

## 🔧 Build & Development

### Build Commands
**Preferred command (iPhone 16 Pro, iOS 26 Beta 4):**
```bash
xcodebuild \
  -project RunParse.xcodeproj \
  -scheme RunParse \
  -destination 'platform=iOS,id=BB06EE47-904A-47D1-B053-F6A3B32BE6FF' \
  build && swift test
```

**Fallback:** If UDID unavailable, target latest available iOS simulator automatically

**Outside macOS:** Run `swift build && swift test` to compile package and execute unit tests

### Development Workflow
1. **Edit** ➜ 2. **Run Build & Test recipe** ➜ 3. **Fix compile/test failures** ➜ 4. **Commit**
- **AI must complete the loop**; unfinished red builds are not allowed

## 🚫 Behavior Preservation

### Change-Safety Rules
- **No regressions** – all refactors must keep existing features, functions, and visual styles intact
- **Minimal patches** – touch only necessary lines; avoid whitespace-only diffs
- **No stubs or placeholder code** – implement real functionality only
- **Comment every deletion** with a brief rationale
- **Avoid superficial changes** (e.g., variable renames) unless they serve a clear purpose

### Design System Boundaries
- **All style tokens, modifiers, and generic UI patterns** live in `DesignSystem/`
- **Business-specific or data-driven views** (e.g., `WorkoutCardView`) stay in `Views/`
- **Import but never mutate or extend** `DesignSystem/`

## 🎯 Feature & Style Addition

### Restriction Policy
- **Do not add new features, UI styles, or visual modifiers** unless explicitly requested in the prompt or ticket
- **Follow explicit requirements** only
- **No speculative enhancements**

### API Preference
- **When multiple approaches exist**, prefer APIs, patterns, and frameworks introduced at **WWDC 2025**
- **Unless backward-compatibility requirements** dictate otherwise
- **Modern Swift patterns** over legacy approaches

## 📝 Code Conventions

### Formatting
- **English comments**; any Chinese notes must be wrapped in `<!-- zh-note: … -->`
- **No multiple blank lines** inside functions; none at file start/end; no trailing whitespace
- **One-file focus** per edit session; avoid sweeping multi-file rewrites

### Documentation
- **Follow workspace "Always Applied Rules"** and user-specific directives
- **Don't invent APIs**; confirm ambiguity when requirements are unclear
- **Reference Apple documentation** for all API usage

## 🔍 Quality Assurance

### Testing Requirements
- **All changes must pass** build and test suite
- **No regressions** in existing functionality
- **Swift 6 compliance** for all new code
- **iOS 26 compatibility** verification

### Performance Standards
- **Main thread blocking** ≤ 16ms
- **SwiftData operations** optimized for iOS 26
- **Memory management** following Swift 6 patterns
- **Concurrency safety** with proper actor isolation

---

**Remember**: This project uses cutting-edge iOS 26 and Swift 6 features. Always prioritize modern patterns, thread safety, and the latest Apple APIs while maintaining backward compatibility within the iOS 26 ecosystem.