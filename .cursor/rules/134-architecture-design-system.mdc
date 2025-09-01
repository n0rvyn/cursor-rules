---
description: "134: Architecture and design system guidelines"
scopes: [chat, edit]
tags: [architecture, design-system, separation]
priority: 134
globs:
  - "*.swift"
alwaysApply: true
---

# Architecture and Design System Guidelines

You are organizing code structure and implementing UI components. Follow these guidelines to maintain proper architecture and design system usage.

## File Organization

**Design System Components**: Place all design system elements in `DesignSystem/`:
- Style tokens and constants
- Generic UI patterns and components
- Reusable modifiers and extensions
- Color, typography, and spacing definitions
- Animation and interaction patterns

**Business Logic Views**: Keep business-specific views in `Views/`:
- Data-driven views (e.g., WorkoutCardView)
- Feature-specific components
- Business logic implementations
- Import design system styles as needed

## Design System Structure

**Style Tokens**: Define reusable design tokens:
```swift
// DesignSystem/Colors.swift
extension Color {
    static let primary = Color("PrimaryColor")
    static let secondary = Color("SecondaryColor")
    static let background = Color("BackgroundColor")
    static let surface = Color("SurfaceColor")
}

// DesignSystem/Typography.swift
extension Font {
    static let displayLarge = Font.system(size: 32, weight: .bold)
    static let headline = Font.system(size: 18, weight: .semibold)
    static let body = Font.system(size: 16, weight: .regular)
}

// DesignSystem/Spacing.swift
extension CGFloat {
    static let spacingXS: CGFloat = 4
    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 16
    static let spacingL: CGFloat = 24
}
```

**Generic UI Patterns**: Create reusable components:
```swift
// DesignSystem/Components/Button.swift
struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, .spacingM)
                .padding(.vertical, .spacingS)
                .background(Color.primary)
                .cornerRadius(8)
        }
    }
}

// DesignSystem/Components/Card.swift
struct CardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(.spacingM)
            .background(Color.surface)
            .cornerRadius(12)
            .shadow(radius: 2)
    }
}
```

## Business Logic Views

**Feature-Specific Views**: Implement business logic in Views:
```swift
// Views/WorkoutCardView.swift
struct WorkoutCardView: View {
    let workout: Workout

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: .spacingS) {
                Text(workout.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(workout.description)
                    .font(.body)
                    .foregroundColor(.secondary)

                HStack {
                    Text("Duration: \(workout.duration)")
                    Spacer()
                    Text("Calories: \(workout.calories)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }
}
```

## Code Removal Documentation

**Removal Comments**: Always document code removals:
```swift
// Removed duplicate color definition - consolidated in DesignSystem/Colors.swift
// Removed unused import - no longer needed after refactoring
// Removed deprecated API usage - replaced with modern equivalent
// Removed hardcoded values - moved to design system tokens
```

**Removal Guidelines**:
1. Understand why the code existed
2. Verify it's safe to remove
3. Update any references
4. Add explanatory comment
5. Update documentation if needed

## Import Patterns

**Design System Usage**: Import design system in business views:
```swift
// Views/SomeBusinessView.swift
import SwiftUI
// Design system styles are available through extensions

struct SomeBusinessView: View {
    var body: some View {
        VStack(spacing: .spacingM) {
            Text("Business Content")
                .font(.headline)
                .foregroundColor(.primary)

            PrimaryButton(title: "Action") {
                // Business logic
            }
        }
        .padding(.spacingL)
        .background(Color.background)
    }
}
```

## Architecture Principles

**Separation of Concerns**:
- Design system: Reusable UI patterns
- Business views: Feature-specific logic
- Clear boundaries between layers
- Consistent import patterns

**Maintainability**:
- Centralized design tokens
- Reusable components
- Clear documentation
- Consistent patterns
