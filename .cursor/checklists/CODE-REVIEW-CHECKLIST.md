# Code Review 检查清单

> **Purpose**: 确保每次代码提交都经过完整的质量检查
> **触发场景**: 提交代码前的自检（比 WEEKLY_VERIFICATION 更细粒度）

---

## 🎯 核心原则

**提交前必须完整自检，不要依赖事后修复**

- ✅ 自检通过 → 提交代码 → CI 验证
- ❌ 快速提交 → 发现问题 → 再次修复

---

## ✅ Phase 1: 架构层面检查

### 1.1 MVVM 模式

- [ ] **View**: 只负责 UI 展示，无业务逻辑
  ```swift
  // ✅ 正确：View 只调用 ViewModel 方法
  struct TrainingLogView: View {
      @State private var viewModel: TrainingLogViewModel
      
      var body: some View {
          List(viewModel.logs) { log in
              TrainingLogRow(log: log)
          }
          .task {
              await viewModel.loadLogs()
          }
      }
  }
  
  // ❌ 错误：View 中有业务逻辑
  struct TrainingLogView: View {
      var body: some View {
          List {
              ForEach(logs) { log in
                  // ❌ 计算逻辑放在 View 里
                  let pace = log.distance / log.duration
                  Text("\(pace)")
              }
          }
      }
  }
  ```

- [ ] **ViewModel**: 标记 `@MainActor`，包含业务逻辑
  ```swift
  // ✅ 正确
  @MainActor
  @Observable
  final class TrainingLogViewModel {
      private let service: HealthKitServiceProtocol
      var logs: [TrainingLog] = []
      
      init(service: HealthKitServiceProtocol) {
          self.service = service
      }
      
      func loadLogs() async {
          logs = try await service.fetchLogs()
      }
  }
  
  // ❌ 错误：缺少 @MainActor
  @Observable
  final class TrainingLogViewModel { ... }
  ```

- [ ] **Model**: SwiftData Model 使用 `Cached` 前缀
  ```swift
  // ✅ 正确
  @Model
  final class CachedTrainingLog {
      var id: String
      var userId: String
      // ...
  }
  
  // ❌ 错误：缺少 Cached 前缀
  @Model
  final class TrainingLog { ... }
  ```

### 1.2 依赖注入

- [ ] **Service 注入**: ViewModel 通过构造函数接收 Protocol
  ```swift
  // ✅ 正确：依赖注入 Protocol
  @MainActor
  final class TrainingLogViewModel {
      private let healthKitService: HealthKitServiceProtocol
      private let syncService: SyncServiceProtocol
      
      init(
          healthKitService: HealthKitServiceProtocol,
          syncService: SyncServiceProtocol
      ) {
          self.healthKitService = healthKitService
          self.syncService = syncService
      }
  }
  
  // ❌ 错误：直接实例化具体类
  @MainActor
  final class TrainingLogViewModel {
      private let healthKitService = HealthKitService()  // ❌ 硬编码
  }
  ```

- [ ] **Environment 传递**: View 通过 `.environment()` 传递依赖
  ```swift
  // ✅ 正确
  ContentView()
      .environment(\.healthKitService, HealthKitService())
      .environment(\.modelContext, modelContext)
  
  // ❌ 错误：在 View 中直接创建
  struct ContentView: View {
      let service = HealthKitService()  // ❌
  }
  ```

### 1.3 Protocol 抽象

- [ ] **所有 Service 有 Protocol**
  ```swift
  // ✅ 正确：Protocol + 实现 + Mock
  protocol HealthKitServiceProtocol {
      func fetchWorkouts() async throws -> [TrainingLog]
  }
  
  actor HealthKitService: HealthKitServiceProtocol {
      func fetchWorkouts() async throws -> [TrainingLog] { ... }
  }
  
  final class MockHealthKitService: HealthKitServiceProtocol {
      var workoutsToReturn: [TrainingLog] = []
      func fetchWorkouts() async throws -> [TrainingLog] {
          return workoutsToReturn
      }
  }
  
  // ❌ 错误：没有 Protocol，直接实现
  actor HealthKitService {
      func fetchWorkouts() async throws -> [TrainingLog] { ... }
  }
  ```

- [ ] **Mock 已创建**（用于测试）
  ```markdown
  位置：Epoch/Tests/Mocks/Mock{ServiceName}.swift
  
  示例：
  - MockHealthKitService.swift
  - MockFirebaseService.swift
  - MockSyncService.swift
  ```

### 1.4 ADR 遵循

- [ ] **数据模型**: 是否符合 SwiftData Schema？
  ```bash
  # 检查文档
  cat docs/04-implementation/swiftdata-schema.md
  ```

- [ ] **Firebase 结构**: 是否符合 Firebase Schema？
  ```bash
  # 检查文档
  cat docs/04-implementation/firebase-schema.md
  ```

- [ ] **认证策略**: 是否符合 ADR-009？
- [ ] **同步策略**: 是否符合 ADR-010？
- [ ] **订阅验证**: 是否符合 ADR-011？

---

## ✅ Phase 2: 代码质量检查

### 2.1 函数职责单一

- [ ] **函数不超过 50 行**（复杂函数必须拆分）
  ```swift
  // ✅ 正确：拆分为多个小函数
  func loadData() async {
      await loadProfile()
      await loadLogs()
      await syncData()
  }
  
  private func loadProfile() async { ... }
  private func loadLogs() async { ... }
  private func syncData() async { ... }
  
  // ❌ 错误：单个函数 200 行
  func loadData() async {
      // 50 行加载 profile
      // 50 行加载 logs
      // 50 行同步数据
      // 50 行更新 UI
  }
  ```

- [ ] **每个函数只做一件事**
  ```swift
  // ✅ 正确：职责明确
  func calculatePace(distance: Double, duration: Double) -> Double {
      return distance / duration
  }
  
  // ❌ 错误：函数做了太多事
  func processWorkout(_ workout: HKWorkout) -> TrainingLog {
      // 计算配速
      // 保存到数据库
      // 上传到 Firebase
      // 发送通知
      // 更新统计
  }
  ```

### 2.2 命名清晰

- [ ] **不要使用缩写**（除非是通用缩写）
  ```swift
  // ✅ 正确
  let trainingLog: TrainingLog
  let userProfile: UserProfile
  func fetchWorkouts() async throws
  
  // ❌ 错误
  let log: TL  // 不清楚是什么
  let prof: UP  // 不清楚是什么
  func getWO() async throws  // 不清楚做什么
  
  // ✅ 可接受的通用缩写
  let id: String  // ID 是通用缩写
  let url: URL  // URL 是通用缩写
  let dto: TrainingLogDTO  // DTO 是通用术语
  ```

- [ ] **布尔值使用 is/has/should 前缀**
  ```swift
  // ✅ 正确
  let isLoading: Bool
  let hasData: Bool
  let shouldRefresh: Bool
  
  // ❌ 错误
  let loading: Bool  // 不清楚是状态还是动作
  let data: Bool  // 不清楚含义
  ```

- [ ] **函数名动词开头**
  ```swift
  // ✅ 正确
  func fetchWorkouts()
  func saveLog()
  func calculatePace()
  func validateInput()
  
  // ❌ 错误
  func workouts()  // 是获取还是什么？
  func log()  // 是保存还是查看？
  ```

### 2.3 无硬编码

- [ ] **魔法数字**: 提取为常量
  ```swift
  // ✅ 正确
  private enum Constants {
      static let maxRetries = 3
      static let timeout: TimeInterval = 30
      static let defaultPageSize = 20
  }
  
  func retry() async {
      for _ in 0..<Constants.maxRetries { ... }
  }
  
  // ❌ 错误
  func retry() async {
      for _ in 0..<3 { ... }  // 3 是什么意思？
  }
  ```

- [ ] **魔法字符串**: 提取为常量
  ```swift
  // ✅ 正确
  enum UserDefaultsKey {
      static let userId = "user_id"
      static let lastSyncTime = "last_sync_time"
  }
  
  UserDefaults.standard.string(forKey: UserDefaultsKey.userId)
  
  // ❌ 错误
  UserDefaults.standard.string(forKey: "user_id")  // 容易拼写错误
  ```

- [ ] **UI 文本**: 使用本地化
  ```swift
  // ✅ 正确：使用类型安全的本地化 Key
  Text(LocalizedString.Common.ok)
  Button(LocalizedString.HealthKit.requestButton) { }
  
  // ❌ 错误：硬编码文本
  Text("确定")
  Button("请求授权") { }
  ```

### 2.4 代码清理

- [ ] **无注释掉的代码**
  ```swift
  // ❌ 错误
  func loadData() {
      // let oldData = fetchOldData()  // 旧逻辑，已废弃
      // processOldData(oldData)
      
      let newData = fetchNewData()
      processNewData(newData)
  }
  
  // ✅ 正确：删除注释掉的代码（Git 可以找回）
  func loadData() {
      let newData = fetchNewData()
      processNewData(newData)
  }
  ```

- [ ] **无 print() 调试代码**
  ```swift
  // ❌ 错误
  func loadData() {
      print("开始加载")  // ❌ 调试代码
      let data = fetchData()
      print("数据：\(data)")  // ❌ 调试代码
  }
  
  // ✅ 正确：使用统一的 Logger
  func loadData() {
      logger.debug("Starting data load")
      let data = fetchData()
      logger.debug("Loaded \(data.count) items")
  }
  ```

- [ ] **无 TODO 未处理**
  ```swift
  // ❌ 错误：留下未处理的 TODO
  func syncData() {
      // TODO: 实现同步逻辑
  }
  
  // ✅ 正确：实现逻辑或创建 Issue
  func syncData() async throws {
      try await syncService.sync()
  }
  
  // 🟡 可接受：创建 Issue 后可以留 TODO
  func advancedAnalytics() {
      // TODO: Implement advanced analytics (Issue #123)
      // Planned for Week 10
  }
  ```

### 2.5 错误处理

- [ ] **不使用 try!**（除非绝对安全）
  ```swift
  // ❌ 错误：使用 try!
  let data = try! JSONEncoder().encode(log)  // ❌ 可能崩溃
  
  // ✅ 正确：使用 do-catch
  do {
      let data = try JSONEncoder().encode(log)
      return data
  } catch {
      logger.error("Failed to encode log: \(error)")
      return nil
  }
  
  // 🟡 可接受：初始化静态资源（绝对不会失败）
  private static let decoder: JSONDecoder = {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      return decoder
  }()
  ```

- [ ] **所有 async throws 有错误处理**
  ```swift
  // ✅ 正确：完整的错误处理
  func loadData() async {
      do {
          let logs = try await service.fetchLogs()
          self.logs = logs
          self.error = nil
      } catch {
          logger.error("Failed to load logs: \(error)")
          self.error = "无法加载训练记录，请稍后重试"
      }
  }
  
  // ❌ 错误：没有错误处理
  func loadData() async {
      let logs = try! await service.fetchLogs()  // ❌ 崩溃风险
      self.logs = logs
  }
  ```

---

## ✅ Phase 3: Swift 规范检查

### 3.1 并发标记

- [ ] **ViewModel**: 标记 `@MainActor`
  ```swift
  // ✅ 正确
  @MainActor
  @Observable
  final class TrainingLogViewModel { }
  
  // ❌ 错误：缺少 @MainActor
  @Observable
  final class TrainingLogViewModel { }
  ```

- [ ] **Service**: 标记 `actor`
  ```swift
  // ✅ 正确：使用 actor 隔离
  actor HealthKitService: HealthKitServiceProtocol {
      private let healthStore = HKHealthStore()
      
      func fetchWorkouts() async throws -> [TrainingLog] { ... }
  }
  
  // ❌ 错误：使用 class 没有并发保护
  class HealthKitService: HealthKitServiceProtocol { ... }
  ```

### 3.2 异步处理

- [ ] **使用 async/await**（不用闭包）
  ```swift
  // ✅ 正确：async/await
  func loadData() async throws {
      let profile = try await profileService.fetch()
      let logs = try await logService.fetch()
      updateUI(profile: profile, logs: logs)
  }
  
  // ❌ 错误：使用闭包（旧写法）
  func loadData(completion: @escaping (Result<Void, Error>) -> Void) {
      profileService.fetch { result in
          // 闭包嵌套地狱
      }
  }
  ```

### 3.3 命名规范

- [ ] **SwiftData Model**: `Cached` 前缀
  ```swift
  // ✅ 正确
  @Model final class CachedTrainingLog { }
  @Model final class CachedUserProfile { }
  
  // ❌ 错误
  @Model final class TrainingLog { }  // 与 DTO 冲突
  ```

- [ ] **Firebase DTO**: `DTO` 后缀
  ```swift
  // ✅ 正确
  struct TrainingLogDTO: Codable { }
  struct UserProfileDTO: Codable { }
  
  // ❌ 错误
  struct TrainingLog: Codable { }  // 与 SwiftData Model 冲突
  ```

- [ ] **Mapper**: `Mapper` 后缀
  ```swift
  // ✅ 正确
  struct TrainingLogMapper {
      static func toCached(_ dto: TrainingLogDTO) -> CachedTrainingLog { }
      static func toDTO(_ cached: CachedTrainingLog) -> TrainingLogDTO { }
  }
  ```

- [ ] **Mock**: `Mock` 前缀
  ```swift
  // ✅ 正确
  final class MockHealthKitService: HealthKitServiceProtocol { }
  final class MockFirebaseService: FirebaseServiceProtocol { }
  ```

---

## ✅ Phase 4: 测试覆盖检查

### 4.1 核心逻辑测试

- [ ] **数据层核心**: 100% 覆盖
  ```swift
  // CRUD 操作必须有测试
  func test_insert_shouldSaveLog() { }
  func test_fetch_shouldReturnLogs() { }
  func test_update_shouldModifyLog() { }
  func test_delete_shouldRemoveLog() { }
  
  // Mapper 转换必须有测试
  func test_toCached_shouldConvertCorrectly() { }
  func test_toDTO_shouldConvertCorrectly() { }
  ```

- [ ] **业务逻辑**: ≥75% 覆盖
  ```swift
  // 计算逻辑必须有测试
  func test_calculatePace_normalInput_shouldReturnCorrectValue() { }
  func test_calculatePace_zeroDuration_shouldReturnNil() { }
  
  // 验证逻辑必须有测试
  func test_validateEmail_validEmail_shouldReturnTrue() { }
  func test_validateEmail_invalidEmail_shouldReturnFalse() { }
  ```

### 4.2 边界情况测试

- [ ] **空数据**
  ```swift
  func test_loadLogs_emptyArray_shouldShowEmptyState() { }
  ```

- [ ] **nil 值**
  ```swift
  func test_saveProfile_nilName_shouldUseDefault() { }
  ```

- [ ] **极值**
  ```swift
  func test_calculatePace_veryLongDistance_shouldNotOverflow() { }
  func test_calculatePace_veryShortDuration_shouldHandleCorrectly() { }
  ```

### 4.3 错误处理测试

- [ ] **网络错误**
  ```swift
  func test_fetchLogs_networkError_shouldReturnError() async { }
  ```

- [ ] **权限错误**
  ```swift
  func test_requestHealthKit_permissionDenied_shouldShowAlert() async { }
  ```

- [ ] **数据格式错误**
  ```swift
  func test_parseJSON_invalidFormat_shouldThrowError() { }
  ```

### 4.4 Mock 使用

- [ ] **所有测试使用 Mock**（不依赖真实 API）
  ```swift
  // ✅ 正确：使用 Mock
  func test_loadLogs_shouldFetchFromService() async {
      let mockService = MockHealthKitService()
      mockService.logsToReturn = [log1, log2]
      
      let viewModel = TrainingLogViewModel(service: mockService)
      await viewModel.loadLogs()
      
      XCTAssertEqual(viewModel.logs.count, 2)
  }
  
  // ❌ 错误：使用真实 Service
  func test_loadLogs() async {
      let service = HealthKitService()  // ❌ 依赖真实 HealthKit
      let viewModel = TrainingLogViewModel(service: service)
      await viewModel.loadLogs()
  }
  ```

---

## ✅ Phase 5: 文档同步检查

### 5.1 file-structure.md

- [ ] **新增文件已记录**
  ```markdown
  文件：docs/04-implementation/file-structure.md
  
  添加：
  - Epoch/ViewModels/TrainingLogViewModel.swift ✅ 已完成
    - 职责：训练日志列表逻辑
    - 依赖：HealthKitServiceProtocol, SyncServiceProtocol
  ```

- [ ] **修改文件更新状态**
  ```markdown
  修改：
  - Epoch/Services/HealthKitService.swift 🔄 已修改（2025-11-08）
    - 变更：新增增量同步方法
  ```

### 5.2 Changelog

- [ ] **记录到当月 Changelog**
  ```markdown
  文件：docs/07-changelog/2025-11.md
  
  ## 2025-11-08 14:30 - 实现训练日志列表功能
  
  ### 🔧 代码变更
  | 文件 | 变更类型 | 变更内容 | 原因 |
  |------|---------|---------|------|
  | TrainingLogViewModel.swift | 新增 | 日志列表 ViewModel | Week 3 任务 |
  | TrainingLogView.swift | 新增 | 日志列表 View | Week 3 任务 |
  | HealthKitService.swift | 修改 | 新增增量同步 | 性能优化 |
  
  ### 🎯 提交信息
  - Commit: feat(log): implement training log list view
  - Branch: feature/training-log-list
  ```

### 5.3 ADR（架构变更）

- [ ] **是否需要创建 ADR？**
  
  满足以下任一条件 → 必须创建 ADR：
  - [ ] 数据模型的新增/修改关系
  - [ ] 认证/授权策略变更
  - [ ] 数据同步策略变更
  - [ ] 引入新的第三方库
  - [ ] 修改项目结构
  - [ ] 修改部署方式

- [ ] **ADR 已创建**（如果需要）
  ```bash
  # 创建 ADR
  touch docs/03-decisions/ADR-015-training-log-incremental-sync.md
  
  # 添加到索引
  echo "- ADR-015: Training Log Incremental Sync" >> docs/03-decisions/README.md
  ```

### 5.4 代码注释

- [ ] **Public API 有文档注释**
  ```swift
  // ✅ 正确：Public 方法有注释
  /// Fetches training logs from HealthKit
  /// - Parameter since: Optional date to fetch logs after this date
  /// - Returns: Array of training logs
  /// - Throws: HealthKitError if permission denied or fetch failed
  public func fetchLogs(since: Date? = nil) async throws -> [TrainingLog]
  
  // 🟡 可接受：Private 方法可以没注释（如果方法名清晰）
  private func processLogs(_ logs: [HKWorkout]) -> [TrainingLog] { }
  ```

---

## ✅ Phase 6: 数据流完整性检查

> 仅适用于数据相关的变更

### 6.1 数据写入

- [ ] **数据写入逻辑存在**
  ```markdown
  检查点：
  - 谁写入？→ Backend generatePlan / iOS Onboarding
  - 写到哪？→ Firebase trainingPlans / SwiftData CachedWeekPlan
  - 何时写？→ Onboarding 完成 / 周日自动生成
  ```

### 6.2 数据读取

- [ ] **数据读取逻辑存在**
  ```markdown
  检查点：
  - 谁读取？→ HomeViewModel / PlanViewModel
  - 读什么？→ CachedWeekPlan / CachedWorkout
  - 何时读？→ View.task / 用户点击
  ```

### 6.3 数据同步

- [ ] **同步逻辑存在**
  ```markdown
  检查点：
  - Firebase → SwiftData：PlanSyncService.addSnapshotListener
  - SwiftData → Firebase：PendingSyncService.uploadQueue
  - 冲突解决：Last Write Wins (MVP)
  ```

### 6.4 UI 显示

- [ ] **UI 能显示数据**
  ```markdown
  检查点：
  - 哪个 View 显示？→ HomeTabView / PlanTabView
  - 查询逻辑：FetchDescriptor / @Query
  - 数据绑定：@Observable / @State
  ```

---

## ✅ Phase 7: 性能检查

### 7.1 主线程检查

- [ ] **无主线程阻塞操作**
  ```swift
  // ❌ 错误：主线程做网络请求
  @MainActor
  func loadData() {
      let data = URLSession.shared.data(from: url)  // ❌ 阻塞主线程
      updateUI(data)
  }
  
  // ✅ 正确：异步执行
  @MainActor
  func loadData() async {
      let data = try? await URLSession.shared.data(from: url)
      updateUI(data)
  }
  ```

- [ ] **无大量计算在主线程**
  ```swift
  // ❌ 错误：主线程计算
  @MainActor
  func processLargeData() {
      for item in largeArray {  // ❌ 100万条数据
          // 复杂计算
      }
  }
  
  // ✅ 正确：后台线程计算
  func processLargeData() async -> [Result] {
      await Task.detached {
          largeArray.map { /* 复杂计算 */ }
      }.value
  }
  ```

### 7.2 查询优化

- [ ] **无 N+1 查询问题**
  ```swift
  // ❌ 错误：N+1 查询
  let plans = try modelContext.fetch(FetchDescriptor<CachedWeekPlan>())
  for plan in plans {
      let workouts = try modelContext.fetch(
          FetchDescriptor<CachedWorkout>(
              predicate: #Predicate { $0.planId == plan.id }
          )
      )  // ❌ 查询 N 次
  }
  
  // ✅ 正确：关联查询
  @Relationship(deleteRule: .cascade)
  var workouts: [CachedWorkout]  // SwiftData 自动关联
  
  let plans = try modelContext.fetch(FetchDescriptor<CachedWeekPlan>())
  // plans[0].workouts 自动加载
  ```

### 7.3 资源优化

- [ ] **图片资源优化**（使用 Assets.xcassets）
- [ ] **大文件懒加载**（不在启动时加载）
- [ ] **缓存复用**（避免重复计算）

---

## ✅ Phase 8: 编译与验证

### 8.1 编译验证

```bash
cd /Users/norvyn/Code/Projects/Epoch
xcodebuild -scheme Epoch -destination 'generic/platform=iOS' build
```

**要求**：
- [ ] **BUILD SUCCEEDED**
- [ ] **0 个编译错误**
- [ ] **0 个新增警告**（或解释原因）

### 8.2 Linter 检查

在 Cursor AI 中检查修改的文件：

- [ ] **0 个 linter 错误**
- [ ] **警告已处理**（或创建 TODO Issue）

### 8.3 测试通过

```bash
xcodebuild test -scheme Epoch -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
```

- [ ] **所有测试通过**
- [ ] **无新增失败测试**
- [ ] **覆盖率达标**（核心 100%，整体 ≥70%）

---

## 📋 快速自检清单

提交前必须完成：

- [ ] ✅ Phase 1: 架构检查（MVVM + 依赖注入 + Protocol + ADR）
- [ ] ✅ Phase 2: 代码质量（函数职责 + 命名 + 无硬编码 + 清理 + 错误处理）
- [ ] ✅ Phase 3: Swift 规范（并发标记 + async/await + 命名规范）
- [ ] ✅ Phase 4: 测试覆盖（核心逻辑 + 边界 + 错误 + Mock）
- [ ] ✅ Phase 5: 文档同步（file-structure + changelog + ADR + 注释）
- [ ] ✅ Phase 6: 数据流（写入 + 读取 + 同步 + UI）（如适用）
- [ ] ✅ Phase 7: 性能检查（主线程 + 查询 + 资源）
- [ ] ✅ Phase 8: 编译验证（build + linter + tests）

---

## 🚫 禁止提交

以下情况**禁止提交**代码：

- ❌ 有编译错误（哪怕"只差一点"）
- ❌ 有未处理的 TODO（没有对应 Issue）
- ❌ 有注释掉的代码（删除或解释原因）
- ❌ 有 print() 调试代码（改用 Logger）
- ❌ 硬编码 API Key 或敏感信息
- ❌ 核心逻辑没有测试（数据层必须 100%）
- ❌ 文档未更新（file-structure + changelog）

---

## 📊 使用记录

| 日期 | 提交内容 | 自检时间 | 发现问题数 | 状态 |
|------|---------|---------|-----------|------|
| 2025-11-08 | 训练日志列表 | 15 分钟 | 3（命名+测试+文档） | ✅ 已修复并提交 |
| ... | ... | ... | ... | ... |

---

**版本**: v1.0  
**创建时间**: 2025-11-08  
**维护者**: Epoch Team

