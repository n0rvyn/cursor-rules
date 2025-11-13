---
description: "HealthKit & WorkoutKit 集成规范 - 详细参考"
scopes: [chat, edit]
tags: [healthkit, workoutkit, ios, health-apps, epoch, detailed-reference]
priority: 203
globs: []
alwaysApply: false
---

# HealthKit & WorkoutKit 集成规范（详细参考）

> **注意**：本文件为详细参考，不会自动加载。  
> **HealthKit 检查清单**：见 `101-healthkit-checklist.mdc`  
> **核心约束**：见 `000-critical-rules.mdc` 的"三大铁律"

---

> **Epoch 项目特殊要求**：HealthKit 策略为"读取记录 + 写入计划"  
> 详见：`docs/03-decisions/001-healthkit-read-only.md`

---

## 🎯 Epoch 项目约束

### HealthKit 数据策略
- ✅ **读取训练记录**：从 HealthKit 读取用户的历史训练数据
- ✅ **写入训练计划**：使用 WorkoutKit 写入未来的训练计划
- ❌ **禁止修改记录**：永不修改或删除 HealthKit 中已完成的训练记录
- ❌ **禁止复制数据**：不在 Firebase 中完整复制 HealthKit 数据，只存 `healthKitWorkoutId`

### WorkoutKit 支持
- **MVP 阶段**：暂不实现 WorkoutKit 功能
- **V1.1**：实现训练计划同步到 Apple Watch
- **参考**：`docs/04-implementation/healthkit-integration.md`

### 性能要求
- **HealthKit 查询**：<100ms（使用缓存）
- **后台同步**：不阻塞 UI
- **增量同步**：只查询增量数据，不全量查询

---

## 🏥 HealthKit Integration

### Authorization Management

**Request Authorization Once:**
- **Up-front authorization** or just-in-time on user-initiated paths
- **Never inside hot/background query paths**
- **Reference**: [HKHealthStore.requestAuthorization](https://developer.apple.com/documentation/healthkit/hkhealthstore/1614175-requestauthorization)

**Include All Required Types (Epoch 专用):**
```swift
// Epoch 项目需要的 HealthKit 数据类型
let typesToRead: Set<HKObjectType> = [
    // 训练数据（核心）
    HKObjectType.workoutType(),
    HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
    HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
    
    // 心率数据
    HKObjectType.quantityType(forIdentifier: .heartRate)!,
    HKObjectType.quantityType(forIdentifier: .restingHeartRate)!,
    HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
    
    // iOS 18+ 新增字段
    HKObjectType.quantityType(forIdentifier: .workoutEffortScore),  // RPE
    HKObjectType.quantityType(forIdentifier: .heartRateRecoveryOneMinute)
]

// Epoch 需要写入的数据类型（WorkoutKit - V1.1）
let typesToWrite: Set<HKSampleType> = [
    HKObjectType.workoutType()  // 训练计划
]
```

**Info.plist Configuration:**
```xml
<!-- Info.plist -->
<key>NSHealthShareUsageDescription</key>
<string>Epoch 需要读取您的训练记录，以生成个性化的训练计划和分析您的训练进度。</string>

<key>NSHealthUpdateUsageDescription</key>
<string>Epoch 需要将训练计划写入 HealthKit，以便在 Apple Watch 上显示和提醒。</string>
```
- **Reference**: [Info.plist HealthKit keys](https://developer.apple.com/documentation/bundleresources/information_property_list/nshealthshareusagedescription)

**Entitlements:**
- **`com.apple.developer.healthkit`** - Basic HealthKit access
- **`com.apple.developer.healthkit.access`** - When needed for specific access
- **`com.apple.developer.healthkit.background-delivery`** - If observers run in background
- **Do not add undocumented entitlements**
- **Reference**: [HealthKit entitlements](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_healthkit)

---

## 📊 Data Querying Patterns

### Availability & Authorization Checks

```swift
// Always check availability first
guard HKHealthStore.isHealthDataAvailable() else {
    // Handle unavailable case (e.g., iPad without HealthKit)
    throw HealthKitError.notAvailable
}

// Check cached authorization state
let authStatus = healthStore.authorizationStatus(for: type)
guard authStatus == .sharingAuthorized else {
    if authStatus == .notDetermined {
        // Request authorization
        try await requestAuthorization()
    } else {
        // Handle denied case
        throw HealthKitError.authorizationDenied
    }
    return
}
```

### Query Types & Units

**Query Types:**
- **`HKSampleQuery`** - For sample data ([doc](https://developer.apple.com/documentation/healthkit/hksamplequery))
- **`HKStatisticsQuery`** - For aggregated data ([doc](https://developer.apple.com/documentation/healthkit/hkstatisticsquery))
- **`HKWorkoutRouteQuery`** - For workout routes ([doc](https://developer.apple.com/documentation/healthkit/hkworkoutroutequery))

**Correct Units (Epoch 专用):**
- **Heart Rate**: `count()/min` (beats per minute)
- **HRV SDNN**: `secondUnit(milli)` (milliseconds)
- **Distance**: `meter`
- **Energy**: `kilocalorie`
- **RPE (Workout Effort Score)**: dimensionless (1-10)

### Modern Query Patterns (iOS 18+)

```swift
// ✅ iOS 18+ HKSampleQueryDescriptor (推荐)
func fetchRecentWorkouts(limit: Int = 20) async throws -> [HKWorkout] {
    let descriptor = HKSampleQueryDescriptor(
        sampleType: HKObjectType.workoutType(),
        predicate: HKQuery.predicateForWorkouts(with: .running),  // 只查询跑步
        sortDescriptors: [
            NSSortDescriptor(
                key: HKSampleSortIdentifierStartDate,
                ascending: false
            )
        ],
        limit: limit
    )
    
    let results = try await descriptor.result(for: healthStore)
    return results as? [HKWorkout] ?? []
}

// ✅ Epoch 增量同步策略
func fetchIncrementalWorkouts(since date: Date) async throws -> [HKWorkout] {
    let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
        HKQuery.predicateForWorkouts(with: .running),
        HKQuery.predicateForSamples(
            withStart: date,
            end: nil,
            options: .strictStartDate
        )
    ])
    
    let descriptor = HKSampleQueryDescriptor(
        sampleType: HKObjectType.workoutType(),
        predicate: predicate,
        sortDescriptors: [
            NSSortDescriptor(
                key: HKSampleSortIdentifierStartDate,
                ascending: false
            )
        ]
    )
    
    let results = try await descriptor.result(for: healthStore)
    return results as? [HKWorkout] ?? []
}

// ⚠️ iOS 17 兼容版本（使用 continuation）
func fetchWorkoutsLegacy(limit: Int = 20) async throws -> [HKWorkout] {
    return try await withCheckedThrowingContinuation { continuation in
        let query = HKSampleQuery(
            sampleType: HKObjectType.workoutType(),
            predicate: HKQuery.predicateForWorkouts(with: .running),
            limit: limit,
            sortDescriptors: [
                NSSortDescriptor(
                    key: HKSampleSortIdentifierStartDate,
                    ascending: false
                )
            ]
        ) { _, samples, error in
            if let error = error {
                continuation.resume(throwing: error)
            } else {
                continuation.resume(returning: samples as? [HKWorkout] ?? [])
            }
        }
        healthStore.execute(query)
    }
}
```

### Background Observers (V1.1 功能)

```swift
// ⚠️ MVP 阶段暂不实现，V1.1 再启用

// Use HKObserverQuery for real-time updates
let observerQuery = HKObserverQuery(
    sampleType: HKObjectType.workoutType(),
    predicate: HKQuery.predicateForWorkouts(with: .running)
) { _, completionHandler, error in
    // Handle new workout data
    Task {
        await self.syncNewWorkouts()
        completionHandler()
    }
}

// Enable background delivery
healthStore.enableBackgroundDelivery(
    for: HKObjectType.workoutType(),
    frequency: .immediate
) { success, error in
    if success {
        print("✅ Background delivery enabled")
    } else {
        print("❌ Failed to enable background delivery: \(error?.localizedDescription ?? "unknown")")
    }
}

// Remember to stop/disable on shutdown
healthStore.disableBackgroundDelivery(for: HKObjectType.workoutType())
healthStore.stop(observerQuery)
```

---

## 🏃 WorkoutKit Integration (V1.1 功能)

> **⚠️ MVP 阶段暂不实现 WorkoutKit 功能**  
> V1.1 将实现训练计划同步到 Apple Watch

### Feature Detection

```swift
// Always check support first
guard #available(iOS 17.0, *), WorkoutScheduler.isSupported else {
    // Handle unsupported case
    print("WorkoutKit not supported on this device")
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
    print("✅ WorkoutKit authorized")
case .denied:
    // Handle denied case
    print("❌ WorkoutKit authorization denied")
case .notDetermined:
    // Request authorization
    print("⚠️ WorkoutKit authorization not determined")
}
```

### Workout Scheduling

```swift
// Schedule workouts with proper error handling
func scheduleWeekPlan(week: WeekPlan) async throws {
    guard #available(iOS 17.0, *), WorkoutScheduler.isSupported else {
        throw WorkoutKitError.notSupported
    }
    
    do {
        // Convert WeekPlan to WorkoutPlan
        let workoutPlan = convertToWorkoutPlan(week)
        
        try await WorkoutScheduler.shared.schedule(
            workoutPlan,
            at: DateComponents(hour: 6, minute: 0)  // 早上 6:00 提醒
        )
        
        print("✅ Workout scheduled successfully")
    } catch {
        print("❌ Failed to schedule workout: \(error)")
        throw WorkoutKitError.scheduleFailed(error)
    }
}
```

**Entitlements:** No extra WorkoutKit-specific entitlement required beyond HealthKit; rely on Xcode capabilities.

---

## 🔒 Security & Privacy

### Data Protection (Epoch 特定要求)

- ✅ **HealthKit 数据不上传到服务器** - 只在本地分析
- ✅ **AI 分析时只传必要字段** - 距离、配速、RPE、notes（不传心率等敏感数据）
- ✅ **用户可以随时删除所有数据**
- ❌ **Never log sensitive health values** in production logs
- ❌ **Never store HealthKit raw data** in Firebase

### Privacy承诺（写入隐私政策）

```markdown
Epoch 隐私承诺：
1. HealthKit 数据只在本地处理，不上传到服务器
2. AI 分析只使用必要的训练指标（距离、配速、RPE），不包含心率等敏感数据
3. 所有数据加密存储
4. 用户可以随时删除所有数据
5. 不会向第三方分享您的健康数据
```

### Concurrency Safety

```swift
// Keep UI-affecting updates on the main actor
@MainActor
func updateUI(with workouts: [HKWorkout]) {
    // Update UI safely
    self.trainingLogs = workouts.map { TrainingLogMapper.fromHealthKit($0) }
}

// Avoid blocking semaphores in hot paths
func processHealthData() async {
    // Use async/await instead of blocking operations
    let workouts = try await fetchRecentWorkouts()
    await MainActor.run {
        updateUI(with: workouts)
    }
}
```

---

## 🧪 Testing Patterns

### Mock HealthKit Data

```swift
// Create mock data for testing
class MockHealthKitService: HealthKitServiceProtocol {
    var mockWorkouts: [HKWorkout] = []
    
    func fetchRecentWorkouts(limit: Int) async throws -> [HKWorkout] {
        return Array(mockWorkouts.prefix(limit))
    }
    
    func fetchIncrementalWorkouts(since date: Date) async throws -> [HKWorkout] {
        return mockWorkouts.filter { $0.startDate > date }
    }
}
```

### Unit Testing

```swift
func testFetchRecentWorkouts() async throws {
    // Given: Mock HealthKit service
    let mockService = MockHealthKitService()
    mockService.mockWorkouts = [
        createMockWorkout(distance: 5000, duration: 1800),
        createMockWorkout(distance: 10000, duration: 3600)
    ]
    
    let viewModel = TrainingLogViewModel(healthKit: mockService)
    
    // When: Fetch workouts
    try await viewModel.fetchRecentLogs()
    
    // Then: Should have 2 logs
    XCTAssertEqual(viewModel.trainingLogs.count, 2)
    XCTAssertEqual(viewModel.trainingLogs[0].distance, 5000)
}

// Helper function to create mock workout
func createMockWorkout(distance: Double, duration: TimeInterval) -> HKWorkout {
    let distanceQuantity = HKQuantity(unit: .meter(), doubleValue: distance)
    let start = Date()
    let end = start.addingTimeInterval(duration)
    
    return HKWorkout(
        activityType: .running,
        start: start,
        end: end,
        duration: duration,
        totalEnergyBurned: nil,
        totalDistance: distanceQuantity,
        metadata: nil
    )
}
```

---

## 📊 Performance Optimization

### Query Optimization (Epoch 专用)

```swift
// ✅ 使用增量同步，避免全量查询
func syncWorkouts() async throws {
    let lastSyncDate = UserDefaults.standard.object(forKey: "lastSyncDate") as? Date ?? Date.distantPast
    let newWorkouts = try await fetchIncrementalWorkouts(since: lastSyncDate)
    
    // Only process new workouts
    for workout in newWorkouts {
        try await processWorkout(workout)
    }
    
    // Update last sync date
    UserDefaults.standard.set(Date(), forKey: "lastSyncDate")
}

// ✅ 使用 predicate 限制查询范围
func fetchWorkoutsInDateRange(from startDate: Date, to endDate: Date) async throws -> [HKWorkout] {
    let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
        HKQuery.predicateForWorkouts(with: .running),
        HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: .strictStartDate
        )
    ])
    
    let descriptor = HKSampleQueryDescriptor(
        sampleType: HKObjectType.workoutType(),
        predicate: predicate,
        sortDescriptors: [
            NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        ]
    )
    
    let results = try await descriptor.result(for: healthStore)
    return results as? [HKWorkout] ?? []
}

// ✅ 缓存频繁访问的数据（使用 SwiftData）
actor HealthKitCacheService {
    func getCachedWorkouts(limit: Int = 14) throws -> [CachedTrainingLog] {
        // 从 SwiftData 读取最近 14 天的缓存
        let descriptor = FetchDescriptor<CachedTrainingLog>(
            predicate: #Predicate { log in
                log.date > Date().addingTimeInterval(-14 * 24 * 3600)
            },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        return try modelContext.fetch(descriptor)
    }
}
```

### Memory Management

```swift
// ✅ Release query objects when done
func fetchWorkouts() async throws -> [HKWorkout] {
    let workouts = try await fetchRecentWorkouts(limit: 20)
    // Query is automatically released after completion
    return workouts
}

// ✅ Use weak references in completion handlers
class HealthKitManager {
    func setupObserver() {
        let query = HKObserverQuery(...) { [weak self] _, completion, error in
            self?.handleNewData()
            completion()
        }
        healthStore.execute(query)
    }
}

// ✅ Implement proper cleanup in deinit
actor HealthKitService {
    private var activeQueries: [HKQuery] = []
    
    deinit {
        // Stop all active queries
        for query in activeQueries {
            healthStore.stop(query)
        }
    }
}
```

---

## 🚨 Error Handling

### Epoch Custom Error Types

```swift
enum HealthKitError: Error, LocalizedError {
    case notAvailable
    case authorizationDenied
    case queryFailed(Error)
    case dataCorrupted
    case incrementalSyncFailed
    
    var errorDescription: String? {
        switch self {
        case .notAvailable:
            return LocalizedString.Errors.healthKitNotAvailable
        case .authorizationDenied:
            return LocalizedString.Errors.healthKitAuthDenied
        case .queryFailed(let error):
            return LocalizedString.Errors.healthKitQueryFailed(error.localizedDescription)
        case .dataCorrupted:
            return LocalizedString.Errors.healthKitDataCorrupted
        case .incrementalSyncFailed:
            return LocalizedString.Errors.healthKitSyncFailed
        }
    }
}

enum WorkoutKitError: Error, LocalizedError {
    case notSupported
    case scheduleFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .notSupported:
            return LocalizedString.Errors.workoutKitNotSupported
        case .scheduleFailed(let error):
            return LocalizedString.Errors.workoutKitScheduleFailed(error.localizedDescription)
        }
    }
}
```

### Common Error Scenarios

```swift
func handleHealthKitError(_ error: Error) {
    switch error {
    case let hkError as HKError:
        switch hkError.code {
        case .errorHealthDataUnavailable:
            // HealthKit 不可用（如 iPad）
            showAlert(LocalizedString.Errors.healthKitNotAvailable)
        case .errorAuthorizationDenied:
            // 用户拒绝授权
            showAuthorizationPrompt()
        case .errorDatabaseInaccessible:
            // 数据库不可访问（设备锁定）
            showAlert(LocalizedString.Errors.deviceLocked)
        default:
            // 其他错误
            showAlert(hkError.localizedDescription)
        }
    default:
        // 其他错误
        showAlert(error.localizedDescription)
    }
}
```

---

## 🔗 相关文档

### Epoch 项目文档
- **ADR-001**: `docs/03-decisions/001-healthkit-read-only.md` - HealthKit 策略决策
- **HealthKit 集成**: `docs/04-implementation/healthkit-integration.md` - 详细实现文档
- **数据模型**: `docs/04-implementation/swiftdata-schema.md` - SwiftData 模型设计

### Apple 官方文档
- **HealthKit Documentation**: https://developer.apple.com/documentation/healthkit
- **WorkoutKit**: https://developer.apple.com/documentation/workoutkit
- **HKHealthStore**: https://developer.apple.com/documentation/healthkit/hkhealthstore
- **HKSampleQueryDescriptor**: https://developer.apple.com/documentation/healthkit/hksamplequerydescriptor

---

**Remember**: HealthKit and WorkoutKit integration requires careful attention to user privacy, proper authorization handling, and efficient data processing. For Epoch project, always follow the "read records + write plans" strategy and never modify completed workout data.

---

**最后更新**: 2025-11-03  
**版本**: 1.0  
**Epoch 专用约束**: HealthKit 只读训练记录，WorkoutKit 写入计划（V1.1）

