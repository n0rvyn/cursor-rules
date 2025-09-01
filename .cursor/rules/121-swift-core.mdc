---
description: "121: Core Swift development principles and modern iOS best practices"
scopes: [chat, edit]
tags: [swift, ios, core-principles, modern-practices]
priority: 121
globs:
  - "**/*.swift"
  - "**/*.swiftui"
  - "**/*.xib"
  - "**/*.storyboard"
  - "**/*.xcassets"
  - "**/*.xcconfig"
alwaysApply: false
---

# Core Swift & SwiftUI Development Principles

You are an expert Swift and iOS/macOS developer. Your primary goal is to produce code that is clean, modern, maintainable, and idiomatic. Adhere to the following principles in all code generation, modification, and refactoring tasks.

## 🎯 Swift Language & API Design

### Swift API Design Guidelines
- **Strictly follow Apple's official Swift API Design Guidelines** (https://www.swift.org/documentation/api-design-guidelines/)
- **Pay close attention to naming conventions, clarity at the point of use, and fluency**
- **Immutability**: Prefer `let` over `var`. Use immutable value types (`struct`, `enum`) wherever possible
- **Safety**: NEVER use force unwrapping (`!`) or force casting (`as!`). Use optional binding (`if let`, `guard let`), nil-coalescing (`??`), and safe casting (`as?`) instead

### Error Handling
- **Use Swift's `throws` and `do-try-catch` mechanism** for recoverable errors
- **Define custom, specific `Error` types**. Avoid returning `nil` or using magic values to indicate failure
- **Propagate errors with `throws`** and handle using `do/catch`
- **Avoid silently ignoring errors**

### Type Safety & Performance
- **Make types explicit** for local variables with non-trivial initializers
- **Add explicit types for all closure parameters and return types**
- **Break up heavy expressions** - no single line should create more than one collection AND transform it
- **Split method chains longer than 3 calls** into intermediate, named `let` constants
- **Maximum closure nesting depth is 2** - extract inner closures into named helper functions

## 🚀 Modern SwiftUI Practices (iOS 17+ / macOS 14+)

### State Management
- **Use the `@Observable` macro** for view models and observable state. Do not use the legacy `ObservableObject` protocol with `@Published`
- **In views, declare observable dependencies as simple `let` constants** (e.g., `let viewModel: MyViewModel`)
- **Use `@State` exclusively for transient, view-local UI state**
- **Minimize view body computations** and use `@MainActor` for UI updates

### Navigation
- **Use `NavigationStack`** for stack-based navigation flows
- **Use `NavigationSplitView`** for master-detail interfaces
- **Employ type-safe navigation** using the `.navigationDestination(for:destination:)` modifier

### Data Persistence
- **Use SwiftData (`@Model`)** for on-device persistence when applicable
- **Use `@Query`** for data fetching in views
- **Implement proper model relationships** and use `@Relationship` for connections

### Concurrency
- **Use `async/await`** for all asynchronous operations
- **Use `Task`** to start new asynchronous work from a synchronous context
- **Annotate UI-updating code with `@MainActor`**
- **Use structured concurrency** for better performance and safety

## 🏗️ Architecture & Code Structure

### Protocol-Oriented Programming (POP)
- **Design components around protocols** to promote flexibility and testability
- **Use protocols for dependency injection** to enable easier testing and mocking

### Dependency Injection
- **Inject dependencies through initializers**. Avoid singletons and global state
- **Use protocols for external dependencies** to enable testing

### Code Organization
- **Keep functions short and focused** on a single task
- **Favor `struct` over `class`** when possible
- **Prioritize code clarity and readability** over premature optimization or overly clever solutions
- **Write code for humans first**

### Documentation
- **Add `///` doc comments** for all public APIs (types, methods, properties)
- **Document the "why" not just the "what"** in comments
- **Use meaningful variable names** (no single letters except loop counters)

## 🎨 SwiftUI Best Practices

### View Composition
- **Do not build complex views in a single `body` property**. Extract logical sections into smaller, reusable sub-views
- **Prefer composing a view from multiple `let` building blocks** before arranging them in the final `VStack`, `HStack`, or `Group`
- **Extract conditional branches** (`if/else`, `switch`) into helper methods that return `some View`
- **Avoid very long modifier chains**. Group them logically and consider breaking them into steps

### Performance
- **Use `LazyVStack` and `LazyHStack`** for large lists
- **Implement proper `Identifiable` conformance** for list items
- **Use `ForEach` with stable identifiers**
- **Leverage SwiftUI's declarative nature** for optimal performance

### Accessibility
- **Support Dynamic Type** for all text elements
- **Add accessibility labels and hints** where appropriate
- **Test with accessibility tools** regularly
- **Ensure color contrast** meets accessibility standards

## 📝 Code Formatting & Style

### Formatting Standards
- **Adhere to a consistent line length**, typically 100-120 characters
- **Use SwiftFormat or similar tool** for consistent formatting
- **Keep lines under 80 characters** when possible
- **Use consistent indentation** (2 or 4 spaces)

### Naming Conventions
- **Use descriptive variable names**: `userInput` not `ui`
- **Follow Swift naming conventions**: camelCase for variables, PascalCase for types
- **Use meaningful function names** that describe what they do
- **Avoid abbreviations** unless they're widely understood

## 🧪 Testing & Quality

### Testing Approach
- **Use XCTest for unit tests** and aim for high coverage of business logic
- **Inject dependencies for easier mocking**
- **Test view models independently** of SwiftUI views
- **Use `@MainActor` for UI-related tests**

### Code Quality
- **Run tests via `xcodebuild test`** or Xcode CI pipelines
- **Use shellcheck for linting** when working with scripts
- **Make scripts idempotent** when possible (safe to run multiple times)

## 🔧 Development Tools

### Swift Package Manager
- **Use Swift Package Manager** for dependencies
- **Keep dependencies up to date** and monitor for security vulnerabilities

### Build & Test
- **Always test builds** before and after changes
- **Use proper build commands** for the target platform
- **Monitor build performance** and optimize as needed

---

**Remember**: These principles work together to create maintainable, performant, and user-friendly iOS applications. Always prioritize clarity, safety, and modern Swift practices.