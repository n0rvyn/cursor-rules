---
description: "010: HealthKit and WorkoutKit integration patterns for iOS health apps"
scopes: [chat, edit]
tags: [healthkit, workoutkit, ios, health-apps, integration]
priority: 11
globs:
  - "**/*.swift"
  - "**/*.swiftui"
alwaysApply: false
---

# HealthKit & WorkoutKit Integration Patterns

You are working with HealthKit and WorkoutKit integration in an iOS health/fitness app. Follow these patterns for secure, efficient, and user-friendly health data handling.

## 🏥 HealthKit Integration

### Authorization Management
**Request Authorization Once:**
- **Up-front authorization** or just-in-time on user-initiated paths
- **Never inside hot/background query paths**
- **Reference**: [HKHealthStore.requestAuthorization](https://developer.apple.com/documentation/healthkit/hkhealthstore/1614175-requestauthorization)

**Include All Required Types:**
```swift
let typesToRead: Set<HKObjectType> = [
    HKObjectType.workoutType(),
    HKObjectType.quantityType(forIdentifier: .heartRate)!,
    HKObjectType.quantityType(forIdentifier: .restingHeartRate)!,
    HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
    HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
    HKObjectType.quantityType(forIdentifier: .stepCount)!,
    HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
    HKObjectType.categoryType(forIdentifier: .mindfulSession)!,
    // iOS 18+ types (if available)
    HKObjectType.quantityType(forIdentifier: .workoutEffortScore),
    HKObjectType.quantityType(forIdentifier: .heartRateRecoveryOneMinute)
]
```

**Info.plist Configuration:**
- **`NSHealthShareUsageDescription`** - Explain why you need to read health data
- **`NSHealthUpdateUsageDescription`** - Explain why you need to write health data
- **Reference**: [Info.plist HealthKit keys](https://developer.apple.com/documentation/bundleresources/information_property_list/nshealthshareusagedescription)

**Entitlements:**
- **`com.apple.developer.healthkit`** - Basic HealthKit access
- **`com.apple.developer.healthkit.access`** - When needed for specific access
- **`com.apple.developer.healthkit.background-delivery`** - If observers run in background
- **Do not add undocumented entitlements**
- **Reference**: [HealthKit entitlements](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_healthkit)

### Data Querying Patterns
**Availability & Authorization Checks:**
```swift
// Always check availability first
guard HKHealthStore.isHealthDataAvailable() else {
    // Handle unavailable case
    return
}

// Check cached authorization state
guard healthStore.authorizationStatus(for: type) == .sharingAuthorized else {
    // Request authorization or handle denied case
    return
}
```

**Query Types & Units:**
- **`HKSampleQuery`** - For sample data ([doc](https://developer.apple.com/documentation/healthkit/hksamplequery))
- **`HKStatisticsQuery`** - For aggregated data ([doc](https://developer.apple.com/documentation/healthkit/hkstatisticsquery))
- **`HKWorkoutRouteQuery`** - For workout routes ([doc](https://developer.apple.com/documentation/healthkit/hkworkoutroutequery))

**Correct Units:**
- **Heart Rate**: `count()/min` (beats per minute)
- **HRV SDNN**: `secondUnit(milli)` (milliseconds)
- **Distance**: `meter`
- **Energy**: `kilocalorie`

**Modern Query Patterns:**
```swift
// Prefer async/await with continuations
func fetchHeartRateData() async throws -> [HKQuantitySample] {
    return try await withCheckedThrowingContinuation { continuation in
        let query = HKSampleQuery(
            sampleType: HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            predicate: nil,
            limit: HKObjectQueryNoLimit,
            sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]
        ) { _, samples, error in
            if let error = error {
                continuation.resume(throwing: error)
            } else {
                continuation.resume(returning: samples as? [HKQuantitySample] ?? [])
            }
        }
        healthStore.execute(query)
    }
}

// iOS 18+ HKSampleQueryDescriptor (preferred)
func fetchHeartRateDataModern() async throws -> [HKQuantitySample] {
    let descriptor = HKSampleQueryDescriptor(
        sampleType: HKQuantityType.quantityType(forIdentifier: .heartRate)!,
        predicate: nil,
        sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]
    )
    return try await descriptor.result(for: healthStore)
}
```

**Background Observers:**
```swift
// Use HKObserverQuery for real-time updates
let observerQuery = HKObserverQuery(
    sampleType: HKQuantityType.quantityType(forIdentifier: .heartRate)!,
    predicate: nil
) { _, completionHandler, error in
    // Handle new data
    completionHandler()
}

// Enable background delivery
healthStore.enableBackgroundDelivery(
    for: HKQuantityType.quantityType(forIdentifier: .heartRate)!,
    frequency: .immediate
) { success, error in
    // Handle result
}

// Remember to stop/disable on shutdown
healthStore.disableBackgroundDelivery(for: type)
healthStore.stop(observerQuery)
```

## 🏃 WorkoutKit Integration

### Feature Detection
```swift
// Always check support first
guard #available(iOS 17.0, *), WorkoutScheduler.isSupported else {
    // Handle unsupported case
    return
}
```

### Authorization
```swift
// Request authorization once and cache state
let authStatus = await WorkoutScheduler.shared.requestAuthorization()
switch authStatus {
case .authorized:
    // Proceed with workout scheduling
case .denied:
    // Handle denied case
case .notDetermined:
    // Request authorization
}
```

### Workout Scheduling
```swift
// Schedule workouts with proper error handling
do {
    try await WorkoutScheduler.shared.schedule(
        plan,
        at: DateComponents(hour: 9, minute: 0) // 9:00 AM
    )
} catch {
    // Handle scheduling errors
    print("Failed to schedule workout: \(error)")
}
```

**Entitlements:** No extra WorkoutKit-specific entitlement required beyond HealthKit; rely on Xcode capabilities.

## 📱 WidgetKit Integration

### Timeline Providers
```swift
// Timeline providers must not trigger HealthKit prompts
// Consume data already authorized by the app
struct HealthWidgetProvider: TimelineProvider {
    func getTimeline(in context: Context, completion: @escaping (Timeline<HealthEntry>) -> Void) {
        // Use cached/authorized data only
        // Do not request new HealthKit authorization
    }
}
```

**MainActor Usage:**
```swift
// Use @MainActor when interacting with shared singletons/state
@MainActor
class WidgetDataManager {
    func updateWidgetData() {
        // Update shared state safely
    }
}
```

## 🔒 Security & Privacy

### Data Protection
- **Never log sensitive health values** in production logs
- **Use proper data encryption** for stored health data
- **Implement data retention policies**
- **Follow Apple's privacy guidelines**

### Concurrency Safety
```swift
// Keep UI-affecting updates on the main actor
@MainActor
func updateUI(with healthData: [HKQuantitySample]) {
    // Update UI safely
}

// Avoid blocking semaphores in hot paths
func processHealthData() async {
    // Use async/await instead of blocking operations
}
```

## 🧪 Testing Patterns

### Mock HealthKit Data
```swift
// Create mock data for testing
class MockHealthStore: HKHealthStore {
    override func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool, Error?) -> Void) {
        // Mock authorization response
        completion(true, nil)
    }
}
```

### Unit Testing
```swift
func testHeartRateQuery() async throws {
    // Test with mock data
    let mockSamples = createMockHeartRateSamples()
    let result = try await healthService.fetchHeartRateData()
    XCTAssertEqual(result.count, mockSamples.count)
}
```

## 📊 Performance Optimization

### Query Optimization
- **Use appropriate predicates** to limit data scope
- **Implement pagination** for large datasets
- **Cache frequently accessed data**
- **Use background queues** for heavy processing

### Memory Management
- **Release query objects** when done
- **Use weak references** in completion handlers
- **Implement proper cleanup** in deinit

## 🚨 Error Handling

### Common Error Scenarios
```swift
enum HealthKitError: Error {
    case notAvailable
    case notAuthorized
    case queryFailed(Error)
    case dataCorrupted
}

func handleHealthKitError(_ error: Error) {
    switch error {
    case let hkError as HKError:
        switch hkError.code {
        case .errorHealthDataUnavailable:
            // Handle unavailable case
        case .errorAuthorizationDenied:
            // Handle denied case
        default:
            // Handle other errors
        }
    default:
        // Handle other errors
    }
}
```

---

**Remember**: HealthKit and WorkoutKit integration requires careful attention to user privacy, proper authorization handling, and efficient data processing. Always follow Apple's guidelines and test thoroughly with real health data.