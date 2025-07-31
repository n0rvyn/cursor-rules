# iOS Project Technical Context: Stride

## Core Technologies
-   **Platform:** iOS 17+
-   **Language:** Swift 5.9+
-   **UI:** SwiftUI (100%). No UIKit is to be used.
-   **Data Persistence:** SwiftData. Use the `@Model` macro for data models.
-   **Concurrency:** Swift Structured Concurrency (`async/await`). Avoid completion handlers.

## Architecture: MVVM (Model-View-ViewModel)
-   **Model:** These are the SwiftData `@Model` classes (e.g., `RunLog.swift`). They represent the raw data and contain no business logic.
-   **View:** SwiftUI views. Views should be as small and dumb as possible. They are responsible for layout and presentation only. Strive to create small, reusable child views.
-   **ViewModel:** Standard Swift classes that conform to `ObservableObject`. They act as the bridge between the Model and the View, containing presentation logic, state, and actions (e.g., `func addRun()`).

## Testing Framework
-   **Unit & Integration Tests:** `XCTest`. All ViewModels and business logic must have unit test coverage.
-   **UI Tests:** `XCTest` for critical user flows.

## Coding Conventions & Best Practices
1.  **Swift API Design Guidelines:** Adhere STRICTLY to the official guidelines (https://www.swift.org/documentation/api-design-guidelines/).
2.  **Immutability:** Prefer `let` over `var` wherever possible.
3.  **State Management:** Use `@State` for transient, view-local state only. Use `@StateObject` or `@ObservedObject` for ViewModels. Use `@Environment` for environment-wide values.
4.  **Error Handling:** Use Swift's `throw` and `Result` type for error handling. Avoid optional returns for error conditions.
5.  **Dependencies:** No external dependencies at this time. Use only Apple's native frameworks.