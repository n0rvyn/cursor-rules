---
description: "Swift 6.2 + iOS 18-26 编码规范 - 详细参考"
scopes: [chat, edit]
tags: [swift, ios, coding-standards, swiftui, detailed-reference]
priority: 202
globs: []
alwaysApply: false
---

# Swift 6.2 + iOS 18-26 编码规范（详细参考）

> **注意**：本文件为详细参考，不会自动加载。  
> **核心命名规范**：见 `000-critical-rules.mdc` 的"必须遵守"部分

---

> **完整规范见**: `docs/08-guidelines/coding-standards.md`（2000+ 行）  
> 本文档仅包含核心要点和快速参考

---

## 🎯 版本支持策略

| 版本 | 支持级别 | 说明 |
|------|---------|------|
| **iOS 26** | 🟢 主力支持 | 使用最新特性（Liquid Glass、Apple Intelligence） |
| **iOS 18** | 🟡 兼容支持 | 降级适配，覆盖更多用户 |
| **iOS 17** | 🔴 不支持 | WorkoutKit 不稳定，Observable 宏有问题 |

**技术栈版本**：
- Swift: 6.2
- iOS: 18.0+ (推荐 26.0)
- Xcode: 16.0+
- SwiftUI: iOS 18+
- SwiftData: iOS 18+

---

## 📐 命名规范

### Epoch 项目约定

```swift
// ✅ SwiftData Model - 前缀 Cached
@Model class CachedTrainingLog { }
@Model class CachedTrainingPlan { }

// ✅ Firebase DTO - 后缀 DTO
struct TrainingLogDTO: Codable { }
struct TrainingPlanDTO: Codable { }

// ✅ Mapper - 后缀 Mapper
struct TrainingLogMapper { }

// ✅ Protocol - 后缀 Protocol
protocol HealthKitServiceProtocol { }
protocol FirebaseServiceProtocol { }

// ✅ Mock - 前缀 Mock
class MockHealthKitService: HealthKitServiceProtocol { }

// ✅ Actor - 后缀 Actor（可选）
actor DataSyncActor { }
```

### 基本命名规则

```swift
// ✅ 类型 - UpperCamelCase
class TrainingLogViewModel { }
struct UserProfile { }
enum GoalType { }

// ✅ 变量和常量 - lowerCamelCase
let userName = "John"
var isLoading = false
var trainingLogs: [TrainingLog] = []  // 集合用复数

// ✅ 函数 - lowerCamelCase + 动词开头
func fetchTrainingLogs() async throws -> [TrainingLog]
func generatePlan(for user: User) async throws
func isValid() -> Bool  // 布尔返回值用 is/has 前缀

// ✅ 布尔值命名
var isLoading = false
var hasCompletedOnboarding = true
var shouldShowAlert = false
var canEditPlan = true

// ✅ 文件命名（与类型名一致）
TrainingLogView.swift
CachedTrainingLog.swift
TrainingLogDTO.swift
MockHealthKitService.swift
```

---

## 🧵 并发编程（Swift 6.2）

### @MainActor 使用规范

**规则：所有 ViewModel 和 UI 代码必须显式标记 @MainActor**

```swift
// ✅ 正确 - ViewModel 显式标记 @MainActor
@MainActor
@Observable
final class TrainingLogViewModel {
    var trainingLogs: [TrainingLog] = []
    var isLoading = false
    
    // 自动在主线程执行
    func fetchLogs() async {
        isLoading = true
        defer { isLoading = false }
        
        // 后台操作自动在非主线程执行
        let logs = try await healthKitService.fetchLogs()
        trainingLogs = logs  // 回到主线程更新 UI
    }
}

// ✅ 正确 - View 自动在主线程
struct TrainingLogView: View {
    @State private var viewModel: TrainingLogViewModel
    
    var body: some View {
        List(viewModel.trainingLogs) { log in
            TrainingLogRow(log: log)
        }
    }
}

// ❌ 错误 - ViewModel 没有 @MainActor
@Observable
final class TrainingLogViewModel {
    var trainingLogs: [TrainingLog] = []  // 编译警告
}
```

### Actor 隔离

```swift
// ✅ Service 层使用 Actor 隔离
actor HealthKitService: HealthKitServiceProtocol {
    private let healthStore = HKHealthStore()
    private var lastSyncDate: Date?
    private var cachedWorkoutIds: Set<String> = []
    
    func fetchWorkouts(limit: Int) async throws -> [TrainingLog] {
        // Actor 自动保证线程安全
        let workouts = try await healthStore.fetchWorkouts()
        lastSyncDate = Date()
        return workouts.map { TrainingLogMapper.toSwiftData($0) }
    }
}

// 使用时需要 await
let service = HealthKitService()
let logs = await service.fetchWorkouts(limit: 20)
```

### Sendable 协议

```swift
// ✅ 值类型自动 Sendable
struct TrainingLog: Sendable {
    let id: String
    let distance: Double
    let date: Date
}

// ✅ 引用类型需要保证线程安全
final class TrainingLogManager: @unchecked Sendable {
    private let queue = DispatchQueue(label: "com.epoch.logmanager")
    private var logs: [TrainingLog] = []
    
    func addLog(_ log: TrainingLog) {
        queue.async {
            self.logs.append(log)
        }
    }
}
```

---

## 🎨 SwiftUI 最佳实践

### 状态管理

```swift
// ✅ iOS 17+ Observable 宏
@MainActor
@Observable
final class TrainingLogViewModel {
    var trainingLogs: [TrainingLog] = []
    var isLoading = false
}

struct TrainingLogView: View {
    @State private var viewModel = TrainingLogViewModel()
    
    var body: some View {
        // 自动观察 viewModel 变化
        Text("\(viewModel.trainingLogs.count) logs")
    }
}

// ✅ 简单局部状态用 @State
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingAlert = false
}

// ✅ 环境值
struct TrainingLogView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
}
```

### View 组织

```swift
// ✅ 提取复杂子视图
struct TrainingLogCard: View {
    let log: TrainingLog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            headerView
            statsView
            notesView
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
    }
    
    private var headerView: some View {
        HStack {
            Text(log.formattedDate)
                .font(.headline)
            Spacer()
            Text("RPE \(log.rpe)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    // ... 更多子视图
}

// ❌ 避免：所有代码写在一个 body 里（难以维护）
```

### 性能优化

```swift
// ✅ 使用 LazyVStack 处理大列表
ScrollView {
    LazyVStack(spacing: 12) {
        ForEach(viewModel.trainingLogs) { log in
            TrainingLogCard(log: log)
        }
    }
}

// ✅ 提供稳定的 Identifiable
struct TrainingLog: Identifiable {
    let id: String  // 稳定且唯一
    // ...
}
```

---

## 🏗️ 架构模式

### MVVM 模式

```swift
// ✅ ViewModel
@MainActor
@Observable
final class TrainingLogViewModel {
    // MARK: - Properties
    private let healthKit: HealthKitServiceProtocol
    private let firebaseService: FirebaseServiceProtocol
    private let modelContext: ModelContext
    
    var trainingLogs: [CachedTrainingLog] = []
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Initialization
    init(
        healthKit: HealthKitServiceProtocol = HealthKitService(),
        firebaseService: FirebaseServiceProtocol = FirebaseService(),
        modelContext: ModelContext
    ) {
        self.healthKit = healthKit
        self.firebaseService = firebaseService
        self.modelContext = modelContext
    }
    
    // MARK: - Public Methods
    func fetchRecentLogs() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let logs = try await healthKit.fetchWorkouts(limit: 20)
            trainingLogs = logs
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

// ✅ View（只负责 UI）
struct TrainingLogView: View {
    @State private var viewModel: TrainingLogViewModel
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("训练日志")
        }
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.trainingLogs) { log in
                    TrainingLogCard(log: log)
                }
            }
            .padding()
        }
    }
}
```

### Protocol-Oriented Programming

```swift
// ✅ 定义 Protocol
protocol HealthKitServiceProtocol {
    func fetchWorkouts(limit: Int) async throws -> [TrainingLog]
    func saveWorkout(_ workout: TrainingLog) async throws
}

// ✅ 真实实现
actor HealthKitService: HealthKitServiceProtocol {
    func fetchWorkouts(limit: Int) async throws -> [TrainingLog] {
        // 真实 HealthKit 查询
    }
}

// ✅ Mock 实现（测试用）
class MockHealthKitService: HealthKitServiceProtocol {
    var mockWorkouts: [TrainingLog] = []
    
    func fetchWorkouts(limit: Int) async throws -> [TrainingLog] {
        return mockWorkouts
    }
}

// ✅ 依赖注入
@MainActor
@Observable
final class TrainingLogViewModel {
    private let healthKit: HealthKitServiceProtocol
    
    init(healthKit: HealthKitServiceProtocol = HealthKitService()) {
        self.healthKit = healthKit
    }
}
```

---

## 🌐 本地化规范

### 类型安全的本地化

```swift
// ✅ 正确 - 使用类型安全的 Key
Text(LocalizedString.Common.ok)
Button(LocalizedString.HealthKit.requestButton) { }

// ✅ 正确 - 带参数的本地化
Text(LocalizedString.HealthKit.workoutsList(count: 10))

// ❌ 错误 - 硬编码文本
Text("确定")
Button("请求授权") { }

// ❌ 错误 - 直接使用 NSLocalizedString
Text(NSLocalizedString("common.ok", comment: ""))
```

**完整规范见**: `docs/08-guidelines/coding-standards.md` 第 15 章

**💡 提示**：用户可见的文本（UI、日志、错误消息）尽量使用 `LocalizedString`，避免硬编码。这不是强制要求，但能提升代码质量。

---

## 🔒 安全与错误处理

### 可选值处理

```swift
// ✅ 正确 - 使用 if let / guard let
if let healthKitWorkoutId = log.healthKitWorkoutId {
    // 使用 healthKitWorkoutId
}

guard let targetDate = goal.targetDate else {
    return  // 或抛出错误
}

// ✅ 正确 - 使用 nil-coalescing
let distance = log.distance ?? 0.0

// ❌ 错误 - force unwrap（除非绝对安全）
let distance = log.distance!
```

### 错误处理

```swift
// ✅ 正确 - 使用 throws 和 do-catch
enum HealthKitError: Error, LocalizedError {
    case notAvailable
    case authorizationDenied
    
    var errorDescription: String? {
        switch self {
        case .notAvailable:
            return LocalizedString.Errors.healthKitNotAvailable
        case .authorizationDenied:
            return LocalizedString.Errors.healthKitAuthDenied
        }
    }
}

func fetchWorkouts() async throws -> [TrainingLog] {
    guard HKHealthStore.isHealthDataAvailable() else {
        throw HealthKitError.notAvailable
    }
    // ...
}

// 使用时
do {
    let workouts = try await fetchWorkouts()
} catch {
    print("Error: \(error.localizedDescription)")
}

// ❌ 错误 - 简单 try!（会崩溃）
let workouts = try! fetchWorkouts()
```

---

## 📋 代码审查清单

### 提交前自查

**代码质量**：
- [ ] 所有函数职责单一
- [ ] 没有硬编码的魔法数字
- [ ] 删除了所有 `print` 调试代码
- [ ] 没有注释掉的代码

**命名规范**：
- [ ] 类型遵循 UpperCamelCase
- [ ] 变量遵循 lowerCamelCase
- [ ] 布尔值使用 is/has/should 前缀
- [ ] SwiftData Model 使用 `Cached` 前缀
- [ ] Firebase DTO 使用 `DTO` 后缀

**并发编程**：
- [ ] ViewModel 标记了 `@MainActor`
- [ ] Service 层使用 Actor 隔离（如果有共享状态）
- [ ] 没有数据竞争风险
- [ ] 异步操作使用 async/await

**iOS 版本**：
- [ ] iOS 26 特性有降级方案
- [ ] 使用 `#available` 处理版本差异
- [ ] 在 iOS 18 真机测试过

**测试**：
- [ ] 核心逻辑有单元测试
- [ ] 测试覆盖率 ≥ 70%
- [ ] 所有测试通过

---

## 🔗 参考资源

### 项目文档
- **完整编码规范**: `docs/08-guidelines/coding-standards.md`（2000+ 行）
- **SwiftData Schema**: `docs/04-implementation/swiftdata-schema.md`
- **HealthKit 集成**: `docs/04-implementation/healthkit-integration.md`

### Apple 官方文档
- **Swift API Design Guidelines**: https://www.swift.org/documentation/api-design-guidelines/
- **SwiftUI Documentation**: https://developer.apple.com/documentation/swiftui
- **SwiftData Guide**: https://developer.apple.com/documentation/swiftdata
- **HealthKit Documentation**: https://developer.apple.com/documentation/healthkit

---

**最后更新**: 2025-11-03  
**版本**: 1.0  
**基于**: Swift 6.2, iOS 26 (兼容 iOS 18)

