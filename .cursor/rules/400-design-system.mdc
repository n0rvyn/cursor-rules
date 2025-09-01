---
description: "400: Comprehensive design system guidelines for colors, typography, spacing, and components"
scopes: [chat, edit]
tags: [design-system, colors, typography, spacing, components]
priority: 400
globs: ["**/*.swift"]
alwaysApply: false
---

# Design System Guidelines

## 🎨 Colors

### Color Tokens
- ❌ **Never hard-code RGB/Hex** in view code
- ✅ **Use semantic tokens** from `Color.App.*`
- **New color?** → Add to **Assets.xcassets** + expose via `Color+Tokens.swift`
- **System foreground**: `.primary / .secondary / .tertiary` (no `.black / .white`)
- **Dark-mode** comes "for free" via asset catalog; never branch on `colorScheme`

### Color Usage Examples
```swift
// ✅ Correct
Text("Hello")
    .foregroundColor(Color.App.primary)
    .background(Color.App.surface)

// ❌ Wrong
Text("Hello")
    .foregroundColor(.black)
    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
```

**Reference**: `@Color+Tokens.swift`

---

## 📝 Typography

### Font Tokens
- **Use SF system fonts**; custom fonts only with explicit design-review sign-off
- **Prefer text styles** (`.largeTitle`, `.headline`, `.body`, …) over fixed point sizes
- **`Font.App.*` tokens** map role → style:

| Role            | Token                    |
|-----------------|--------------------------|
| Page title      | `Font.App.largeTitle`    |
| Section title   | `Font.App.headline`      |
| Body            | `Font.App.body`          |
| Caption         | `Font.App.caption`       |

### Typography Requirements
- **All new screens** must pass Dynamic-Type overflow checks (Accessibility → Large Type)
- **Use semantic font roles** instead of hardcoded sizes

### Typography Examples
```swift
// ✅ Correct
Text("Page Title")
    .font(Font.App.largeTitle)

Text("Section Header")
    .font(Font.App.headline)

Text("Body content")
    .font(Font.App.body)

// ❌ Wrong
Text("Page Title")
    .font(.system(size: 28, weight: .bold))
```

**Reference**: `@Font+Tokens.swift`

---

## 📏 Spacing

### Spacing Grid
- **All padding/margin values** ∈ {4, 8, 16, 24, 32, 40 …}
- **Use `Spacing.*` constants** – never magic numbers
- **`VStack / HStack` spacing** defaults:

```swift
VStack(spacing: Spacing.medium) { 
    // Content
}
```

### Spacing Guidelines
- **Section separators** ≥ `Spacing.large`
- **Consistent spacing** across all components
- **No hardcoded spacing values**

### Spacing Examples
```swift
// ✅ Correct
VStack(spacing: Spacing.medium) {
    Text("Title")
    Text("Content")
}
.padding(Spacing.large)

// ❌ Wrong
VStack(spacing: 12) {
    Text("Title")
    Text("Content")
}
.padding(20)
```

**Reference**: `@Spacing.swift`

---

## 🧩 Components

### Component Architecture
- **Shared visual treatments** live in `ViewModifier` or `ButtonStyle`
- **Zero duplicated modifier chains**
- **Primary button** = `PrimaryButtonStyle`. Variants inherit & override colors only
- **Define repeated text decorations** as `.primaryTitleStyle()` etc. via modifiers

### Primary Button Style (Source of Truth)
```swift
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.App.headline)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(Color.App.brandPrimary)
            .foregroundStyle(.white)
            .cornerRadius(Spacing.xSmall)
            .opacity(configuration.isPressed ? 0.85 : 1)
    }
}
```

### Component Usage Examples
```swift
// ✅ Correct
Button("Action") {
    // Action
}
.buttonStyle(PrimaryButtonStyle())

Text("Title")
    .modifier(PrimaryTitleStyle())

// ❌ Wrong
Button("Action") {
    // Action
}
.font(.headline)
.padding(.vertical, 12)
.padding(.horizontal, 24)
.background(Color.blue)
.foregroundColor(.white)
.cornerRadius(8)
```

---

## 🎯 Design System Principles

### Consistency
- **Use design tokens** for all visual properties
- **Maintain visual consistency** across the app
- **Follow established patterns** for similar components

### Maintainability
- **Centralized design tokens** in dedicated files
- **Reusable components** and modifiers
- **Clear documentation** for all design decisions

### Accessibility
- **Support Dynamic Type** for all text
- **Ensure color contrast** meets accessibility standards
- **Test with accessibility tools** regularly

### Scalability
- **Design for growth** - easy to add new colors, fonts, spacing
- **Component variants** should inherit from base styles
- **Token-based approach** allows easy theme changes

---

## 📚 Implementation Checklist

### Before Creating New UI
- [ ] **Check existing design tokens** for colors, fonts, spacing
- [ ] **Use semantic tokens** instead of hardcoded values
- [ ] **Follow component patterns** from existing code
- [ ] **Test with Dynamic Type** accessibility settings

### When Adding New Design Elements
- [ ] **Add to design system** (tokens, components, modifiers)
- [ ] **Document usage patterns** and examples
- [ ] **Update style guide** if needed
- [ ] **Test across different contexts** (light/dark mode, accessibility)

### Code Review Checklist
- [ ] **No hardcoded colors** (use `Color.App.*`)
- [ ] **No hardcoded fonts** (use `Font.App.*`)
- [ ] **No magic spacing numbers** (use `Spacing.*`)
- [ ] **Reusable components** instead of duplicated code
- [ ] **Accessibility compliance** verified