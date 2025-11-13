---
description: "HealthKit & WorkoutKit 集成 - 检查清单"
scopes: [chat, edit]
tags: [healthkit, workoutkit, checklist]
priority: 101
globs: ["**/*HealthKit*.swift"]
alwaysApply: false
---

# HealthKit 检查清单

> **触发条件**: 编辑 HealthKit 相关文件时自动加载  
> **详细参考**: `docs/04-implementation/healthkit-integration.md`, `docs/03-decisions/001-healthkit-read-only.md`

---

## ⚠️ 操作前必须完成

### 1. 确认 Epoch 项目的 HealthKit 策略

- [ ] **铁律**: HealthKit 中的训练记录是唯一真相源
- [ ] **允许**: 读取用户的历史训练数据
- [ ] **允许**: 使用 WorkoutKit 写入未来的训练计划（V1.1）
- [ ] **禁止**: 修改或删除 HealthKit 中已完成的训练记录
- [ ] **禁止**: 在 Firebase 中完整复制 HealthKit 数据，只存 `healthKitWorkoutId`

### 2. 读取关键文档

- [ ] `docs/03-decisions/001-healthkit-read-only.md`（策略决策）
- [ ] `docs/04-implementation/healthkit-integration.md`（实现细节）

---

## 🔴 核心约束

### HealthKit 数据策略 ⭐⭐⭐⭐⭐

#### 1. 永不修改已完成的训练记录

```swift
❌ 永不调用：
- HKHealthStore.delete()
- HKWorkout 的任何修改操作

✅ 只允许：
- HKHealthStore.execute(query)（读取）
- WorkoutKit 写入未来计划（V1.1）
```

#### 2. 不在 Firebase 中完整复制 HealthKit 数据

```swift
❌ 错误：
struct TrainingLogDTO {
    let healthKitWorkoutId: String
    let distance: Double  // ❌ 复制了 HealthKit 数据
    let duration: TimeInterval  // ❌ 复制了 HealthKit 数据
    let heartRate: Double  // ❌ 复制了 HealthKit 数据
}

✅ 正确：
struct TrainingLogDTO {
    let healthKitWorkoutId: String  // ⭐ 只存 ID
    let userNotes: String?  // ✅ 用户添加的数据
    let rpe: Int?  // ✅ 用户添加的数据（可选）
}
```

**原因**：
- HealthKit 是唯一真相源
- 避免数据不一致
- 遵守 Apple 隐私政策

#### 3. WorkoutKit 支持（V1.1 功能）

```markdown
⚠️ **MVP 阶段**：暂不实现 WorkoutKit 功能
📅 **V1.1**：实现训练计划同步到 Apple Watch
```

---

## 📊 HealthKit 集成模式

### Authorization Management

#### 1. Request Authorization Once

**Up-front authorization** or just-in-time on user-initiated paths:
```swift
// ✅ 在 Onboarding 或用户主动请求时
func requestHealthKitAuthorization() async throws {
    guard HKHealthStore.isHealthDataAvailable() else {
        throw HealthKitError.notAvailable
    }
    
    let typesToRead: Set<HKObjectType> = [
        HKObjectType.workoutType(),
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        // ... 其他类型
    ]
    
    try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
}

// ❌ 在热路径/后台查询中请求授权
```

#### 2. Include All Required Types (Epoch 专用)

```swift
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
```

### Query Patterns

#### 1. 使用现代 Query API（iOS 18+）

```swift
// ✅ iOS 18+ HKSampleQueryDescriptor（推荐）
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
```

#### 2. Epoch 增量同步策略

```swift
// ✅ 只查询增量数据
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
```

#### 3. 性能要求

**Epoch 项目要求**：
- **HealthKit 查询**: <100ms（使用缓存）
- **后台同步**: 不阻塞 UI
- **增量同步**: 只查询增量数据，不全量查询

---

## ❌ 常见错误

### 错误 1：全量查询 HealthKit 数据

```swift
// ❌ 错误：每次都查询所有数据
func fetchAllWorkouts() async throws -> [HKWorkout] {
    let descriptor = HKSampleQueryDescriptor(
        sampleType: HKObjectType.workoutType(),
        predicate: nil,  // ❌ 查询所有
        sortDescriptors: []
    )
    // ...
}

// ✅ 正确：使用增量同步
func syncWorkouts() async throws {
    let lastSyncDate = UserDefaults.standard.object(forKey: "lastSyncDate") as? Date ?? Date.distantPast
    let newWorkouts = try await fetchIncrementalWorkouts(since: lastSyncDate)
    // 只处理新数据
    UserDefaults.standard.set(Date(), forKey: "lastSyncDate")
}
```

### 错误 2：在 Firebase 中复制 HealthKit 数据

```swift
// ❌ 错误：完整复制
struct TrainingLogDTO {
    let healthKitWorkoutId: String
    let distance: Double  // ❌
    let duration: TimeInterval  // ❌
}

// ✅ 正确：只存用户添加的数据
struct TrainingLogDTO {
    let healthKitWorkoutId: String  // ⭐ 只存 ID
    let userNotes: String?  // ✅ 用户添加
    let rpe: Int?  // ✅ 用户添加
}
```

### 错误 3：修改 HealthKit 记录

```swift
// ❌ 永不允许
try await healthStore.delete(workout)
```

---

## 📋 操作步骤模板

### 首次授权

```swift
// Step 1: 检查可用性
guard HKHealthStore.isHealthDataAvailable() else {
    throw HealthKitError.notAvailable
}

// Step 2: 检查授权状态
let authStatus = healthStore.authorizationStatus(for: HKObjectType.workoutType())
guard authStatus != .sharingAuthorized else {
    return  // 已授权
}

// Step 3: 请求授权
try await requestHealthKitAuthorization()
```

### 增量同步

```swift
// Step 1: 获取上次同步时间
let lastSyncDate = UserDefaults.standard.object(forKey: "lastSyncDate") as? Date ?? Date.distantPast

// Step 2: 查询增量数据
let newWorkouts = try await fetchIncrementalWorkouts(since: lastSyncDate)

// Step 3: 处理新数据
for workout in newWorkouts {
    try await processWorkout(workout)
}

// Step 4: 更新同步时间
UserDefaults.standard.set(Date(), forKey: "lastSyncDate")
```

### 缓存频繁访问的数据

```swift
// ✅ 使用 SwiftData 缓存最近 14 天
actor HealthKitCacheService {
    func getCachedWorkouts(limit: Int = 14) throws -> [CachedTrainingLog] {
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

---

## 🔗 详细参考

| 文档 | 内容 |
|------|------|
| `docs/03-decisions/001-healthkit-read-only.md` | ⭐ HealthKit 策略决策（必读） |
| `docs/04-implementation/healthkit-integration.md` | 完整实现细节 |
| `203-healthkit-integration-detailed.mdc` | 详细参考 |

---

**最后更新**: 2025-11-08  
**Token 估算**: ~1,300 tokens  
**加载方式**: Auto-attach（globs 匹配时）  
**优先级**: 101

