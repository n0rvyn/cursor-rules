# System Design Patterns: Stride

## Pattern: Data Entry Form
This is our standard pattern for any view that involves creating or editing a model.

**1. View (`SomeFormView.swift`)**
-   The view uses a `Form` or `VStack`.
-   It is initialized with its `ViewModel`.
-   UI controls (`TextField`, `DatePicker`) are bound to `@State` properties published by the ViewModel.
-   It contains a "Save" button that is disabled if the ViewModel's validation property is false. The button calls a `save()` action on the ViewModel.

**2. ViewModel (`SomeFormViewModel.swift`)**
-   Conforms to `ObservableObject`.
-   Uses `@Published` properties for each form field (e.g., `@Published var distance: String = ""`).
-   Contains a `@Published var isSaveDisabled: Bool` property that computes its state based on validation rules.
-   Includes a `save()` method that validates the data, creates a Model object, and handles saving it (e.g., to SwiftData).

This pattern ensures that validation logic is kept out of the View and is easily testable.