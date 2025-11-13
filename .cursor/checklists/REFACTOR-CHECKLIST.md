# Refactor 检查清单

> **Purpose**: 确保重构代码时保持功能不变，降低风险
> **触发场景**: 重构代码时（>5 个文件或 >200 行变更）

---

## 🎯 核心原则

**重构铁律**: 保持行为不变，小步快跑，可随时回滚

- ✅ 分阶段重构 → 每步验证 → 频繁提交
- ❌ 一次改太多 → 测试失败 → 难以定位问题

---

## ⚠️ 重构前必读（用户规则）

根据项目用户规则：

> **Ask before refactoring >200 LOC or >5 files**
> 
> - 重构超过 200 行代码 → **必须先征得用户批准**
> - 重构超过 5 个文件 → **必须先征得用户批准**
> - 创建新功能 → 可以直接实施（如果在计划内）

**禁止行为**：
- ❌ 纯美化重构（只为了"好看"，没有实际收益）
- ❌ 违反编码标准的重命名（如去掉 `Cached` 前缀）
- ❌ 边重构边加新功能（混在一起）

---

## ✅ Phase 1: 重构前评估（必须明确）

### 1.1 重构目的

- [ ] **重构的具体目的是什么？**
  ```markdown
  ✅ 好的理由：
  - 提升性能：当前查询 5 秒，优化后预期 <1 秒
  - 提高可读性：函数 500 行，难以维护，拆分后每个 <50 行
  - 提升扩展性：当前硬编码 3 种类型，需要支持 10+ 种
  - 消除重复代码：相同逻辑在 5 个文件重复，提取为公共方法
  
  ❌ 差的理由：
  - "代码看起来不好"（太主观）
  - "我觉得应该改一下"（没有具体收益）
  - "顺便重构一下"（不是主要目标）
  ```

- [ ] **为什么现在重构？**
  ```markdown
  ✅ 好的时机：
  - 即将新增功能，当前结构无法支持
  - 发现性能瓶颈，影响用户体验
  - 代码复杂度过高，导致 bug 频发
  - 测试覆盖充足（≥70%），重构风险低
  
  ❌ 差的时机：
  - 功能未完成，急着重构
  - 测试覆盖不足（<50%），风险高
  - 临近发版，时间紧张
  - 没有具体问题，纯粹"看不惯"
  ```

### 1.2 影响范围评估

- [ ] **影响多少文件？**
  ```bash
  # 列出需要修改的文件
  ls -la Epoch/ViewModels/*.swift
  ls -la Epoch/Services/*.swift
  
  # 统计数量
  find Epoch -name "*.swift" | wc -l
  ```

- [ ] **影响多少行代码？**
  ```bash
  # 统计总行数
  find Epoch -name "*.swift" -exec wc -l {} + | tail -1
  
  # 或使用 cloc
  cloc Epoch/ViewModels/
  ```

- [ ] **影响多少功能？**
  ```markdown
  列出受影响的功能模块：
  - 训练日志列表
  - 训练计划生成
  - 数据同步
  - ...
  ```

### 1.3 测试覆盖评估

- [ ] **当前测试覆盖率是多少？**
  ```bash
  # 运行测试并查看覆盖率
  xcodebuild test -scheme Epoch -enableCodeCoverage YES \
    -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
  
  # 查看报告
  open ~/Library/Developer/Xcode/DerivedData/.../Logs/Test/*.xcresult
  ```

- [ ] **测试覆盖率是否足够？**
  ```markdown
  ⚠️ 重构风险评估：
  - 覆盖率 ≥70% → ✅ 低风险，可以重构
  - 覆盖率 50-70% → 🟡 中风险，建议先补测试
  - 覆盖率 <50% → 🔴 高风险，不建议重构
  ```

### 1.4 用户批准（必须 ⭐⭐⭐⭐⭐）

- [ ] **是否需要用户批准？**
  ```markdown
  满足以下任一条件 → **必须先征得用户批准**：
  - [ ] 重构 >200 行代码
  - [ ] 重构 >5 个文件
  - [ ] 重构核心功能（数据层、认证、同步）
  - [ ] 可能影响现有功能
  
  不满足 → 可以直接重构，但仍需记录
  ```

- [ ] **用户已批准**（提供证据）
  ```markdown
  批准方式：
  - Chat 记录："同意重构"
  - 计划文档：Week X Plan 包含重构任务
  - Issue/PR：创建了重构 Issue，用户已确认
  ```

---

## ✅ Phase 2: 重构策略设计

### 2.1 分阶段重构

**必须将大重构拆分为小阶段**：

```markdown
示例：重构 HealthKitService（500 行 → 拆分为 3 个 Service）

### 阶段 1：提取 WorkoutService（2 小时）
- 目标：将 Workout 相关方法提取到独立 Service
- 文件：2 个（新增 WorkoutService, 修改 HealthKitService）
- 行数：~150 行
- 可独立验证：✅
- 可回滚：✅

### 阶段 2：提取 PermissionService（1 小时）
- 目标：将权限相关方法提取到独立 Service
- 文件：2 个
- 行数：~100 行
- 可独立验证：✅
- 可回滚：✅

### 阶段 3：重构 HealthKitService（1 小时）
- 目标：清理 HealthKitService，只保留协调逻辑
- 文件：1 个
- 行数：~250 行
- 可独立验证：✅
- 可回滚：✅
```

- [ ] **每个阶段独立完整**（不依赖后续阶段）
- [ ] **每个阶段可独立验证**（有测试覆盖）
- [ ] **每个阶段可回滚**（不破坏主分支）

### 2.2 保持行为不变

**核心约束**：重构不能改变功能

- [ ] **输入输出不变**
  ```swift
  // 重构前
  func fetchWorkouts() async throws -> [TrainingLog]
  
  // 重构后
  func fetchWorkouts() async throws -> [TrainingLog]  // ✅ 签名不变
  ```

- [ ] **功能逻辑不变**
  ```swift
  // 重构前：计算配速
  let pace = distance / duration
  
  // 重构后：提取为方法，逻辑不变
  func calculatePace(distance: Double, duration: Double) -> Double {
      return distance / duration  // ✅ 逻辑不变
  }
  ```

- [ ] **边界情况处理不变**
  ```swift
  // 重构前：处理空数组
  guard !workouts.isEmpty else { return [] }
  
  // 重构后：逻辑不变
  guard !workouts.isEmpty else { return [] }  // ✅ 边界处理不变
  ```

### 2.3 回滚方案

- [ ] **每个阶段独立提交**（方便回滚）
  ```bash
  # 阶段 1 提交
  git add Epoch/Services/WorkoutService.swift
  git commit -m "refactor: extract WorkoutService from HealthKitService (Phase 1/3)"
  
  # 阶段 2 提交
  git add Epoch/Services/PermissionService.swift
  git commit -m "refactor: extract PermissionService from HealthKitService (Phase 2/3)"
  
  # 如果阶段 2 出问题，可以只回滚到阶段 1
  git revert HEAD
  ```

- [ ] **保持主分支稳定**（重构在 feature 分支）
  ```bash
  # 创建重构分支
  git checkout -b refactor/healthkit-service-extraction
  
  # 完成所有阶段后，合并到主分支
  git checkout dev
  git merge refactor/healthkit-service-extraction
  ```

---

## ✅ Phase 3: 重构执行

### 3.1 执行前检查

- [ ] **先运行所有测试**（确保当前通过）
  ```bash
  xcodebuild test -scheme Epoch -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
  ```

- [ ] **记录当前状态**
  ```bash
  # 创建快照
  git add .
  git commit -m "snapshot: before refactoring HealthKitService"
  
  # 或创建标签
  git tag refactor-start-healthkit-$(date +%Y%m%d)
  ```

### 3.2 小步快跑

**每次只改一点，立即验证**：

```markdown
示例：提取 WorkoutService

Step 1：创建 WorkoutServiceProtocol（5 分钟）
- 新增文件：WorkoutServiceProtocol.swift
- 定义接口
- 编译通过 ✅

Step 2：创建 WorkoutService 实现（10 分钟）
- 新增文件：WorkoutService.swift
- 复制方法到新 Service
- 编译通过 ✅

Step 3：创建 Mock（5 分钟）
- 新增文件：MockWorkoutService.swift
- 实现 Protocol
- 编译通过 ✅

Step 4：修改 HealthKitService 使用新 Service（10 分钟）
- 注入 WorkoutService
- 替换方法调用
- 编译通过 ✅
- 测试通过 ✅

Step 5：删除旧方法（5 分钟）
- 删除 HealthKitService 中的 Workout 方法
- 编译通过 ✅
- 测试通过 ✅
```

- [ ] **每步都编译通过**（不要积累错误）
- [ ] **每步都运行测试**（不要等到最后）
- [ ] **每步都可回滚**（小步提交）

### 3.3 频繁提交

**提交策略**：

```bash
# 每完成一个小步，就提交
git add Epoch/Services/WorkoutServiceProtocol.swift
git commit -m "refactor: add WorkoutServiceProtocol interface"

git add Epoch/Services/WorkoutService.swift
git commit -m "refactor: implement WorkoutService"

git add Epoch/Tests/Mocks/MockWorkoutService.swift
git commit -m "test: add MockWorkoutService"

# 好处：
# - 可以精确回滚到任意步骤
# - Commit 历史清晰，易于 Code Review
# - 出问题时易于定位
```

---

## ✅ Phase 4: 重构验收

### 4.1 测试验收

- [ ] **所有测试通过**
  ```bash
  xcodebuild test -scheme Epoch -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
  ```

- [ ] **测试覆盖率不降低**
  ```bash
  # 对比重构前后的覆盖率
  # 要求：覆盖率 ≥ 重构前
  ```

- [ ] **没有新增失败测试**

### 4.2 手动回归测试

**必须手动测试受影响的功能**：

```markdown
测试清单：重构 HealthKitService 后

- [ ] HealthKit 权限请求 → ✅ 正常
- [ ] 训练记录同步 → ✅ 正常
- [ ] 训练日志列表显示 → ✅ 正常
- [ ] Onboarding 自动填充 → ✅ 正常
- [ ] 首页本周概览 → ✅ 正常

边界情况：
- [ ] 首次安装（无数据） → ✅ 不崩溃
- [ ] 权限拒绝 → ✅ 友好提示
- [ ] 网络断开 → ✅ 降级处理
```

### 4.3 性能对比

- [ ] **性能不能退步**
  ```markdown
  对比重构前后的性能：
  
  指标 1：启动时间
  - 重构前：1.8 秒
  - 重构后：1.7 秒 ✅ 提升 5%
  
  指标 2：数据加载时间
  - 重构前：3.2 秒
  - 重构后：3.1 秒 ✅ 基本持平
  
  指标 3：内存占用
  - 重构前：120 MB
  - 重构后：115 MB ✅ 降低 4%
  ```

- [ ] **如果性能退步，必须解释原因**
  ```markdown
  示例：
  - 数据加载时间从 3.2 秒增加到 3.5 秒
  - 原因：新增了数据验证逻辑（提高数据正确性）
  - 用户已确认：可接受的权衡
  ```

### 4.4 文档更新

- [ ] **更新 file-structure.md**（如果文件结构变化）
  ```markdown
  新增：
  - Epoch/Services/WorkoutService.swift ✅ 已完成
    - 职责：HealthKit Workout 相关操作
    - 依赖：HealthKit
  
  修改：
  - Epoch/Services/HealthKitService.swift 🔄 已重构（2025-11-08）
    - 变更：拆分为 WorkoutService + PermissionService
  ```

- [ ] **更新 Changelog**
  ```markdown
  ## 2025-11-08 15:00 - 重构 HealthKitService
  
  ### 🔧 重构变更
  | 文件 | 变更类型 | 变更内容 | 原因 |
  |------|---------|---------|------|
  | HealthKitService.swift | 重构 | 拆分为 3 个 Service | 提高可维护性 |
  | WorkoutService.swift | 新增 | Workout 操作 | 职责分离 |
  | PermissionService.swift | 新增 | 权限管理 | 职责分离 |
  
  ### 📊 重构效果
  - 代码行数：500 行 → 3 个文件共 400 行
  - 测试覆盖率：75% → 80% ✅
  - 性能：无明显变化
  - 可维护性：✅ 提升
  ```

- [ ] **更新 ADR**（如果涉及架构变更）
  ```markdown
  可能需要更新的 ADR：
  - ADR-001: HealthKit 集成策略
  - ADR-002: Service 架构设计
  ```

---

## ✅ Phase 5: 清理与总结

### 5.1 代码清理

- [ ] **删除注释掉的旧代码**
  ```swift
  // ❌ 不要留下注释掉的代码
  // func oldMethod() {
  //     // 旧逻辑
  // }
  
  // ✅ Git 可以找回，直接删除
  ```

- [ ] **删除无用的 import**
  ```swift
  // 重构后可能不再需要某些 import
  // import OldFramework  // ❌ 删除
  ```

- [ ] **更新注释**
  ```swift
  // ❌ 过时的注释
  // TODO: 重构这个方法（已重构，删除）
  
  // ✅ 更新为准确的注释
  /// Fetches workouts using the new WorkoutService
  ```

### 5.2 重构总结

创建重构总结文档：

```markdown
文件：.cursor/docs/YYYY-MM-DD_Refactor_HealthKitService.md

# 重构总结：HealthKitService 拆分

## 目标
拆分 HealthKitService（500 行）为 3 个职责清晰的 Service，提高可维护性

## 执行过程

### 阶段 1：提取 WorkoutService
- 时间：2 小时
- 文件：2 个（新增 WorkoutService, 修改 HealthKitService）
- 提交：abc1234

### 阶段 2：提取 PermissionService
- 时间：1 小时
- 文件：2 个
- 提交：def5678

### 阶段 3：清理 HealthKitService
- 时间：1 小时
- 文件：1 个
- 提交：ghi9012

## 验收结果

### 测试
- 所有测试通过 ✅
- 覆盖率：75% → 80% ✅
- 无新增失败 ✅

### 性能
- 启动时间：1.8s → 1.7s ✅
- 内存占用：120MB → 115MB ✅

### 回归测试
- HealthKit 权限 ✅
- 训练记录同步 ✅
- 日志列表显示 ✅

## 效果评估

### 定量指标
- 代码行数：500 → 400（减少 20%）
- 文件数量：1 → 3
- 平均文件行数：500 → 133
- 测试覆盖率：+5%

### 定性指标
- ✅ 职责更清晰（每个 Service 只做一件事）
- ✅ 易于测试（Mock 更简单）
- ✅ 易于扩展（新增功能不影响其他 Service）

## 经验教训

### 做得好的地方
1. 分阶段重构，每步可验证
2. 频繁提交，易于回滚
3. 测试覆盖充足，重构风险低

### 可以改进的地方
1. 阶段 1 花费时间超预期（2h vs 1h）
2. Mock 创建可以更早（与实现同步）

## 参考
- Commit: abc1234, def5678, ghi9012
- Branch: refactor/healthkit-service-extraction
- PR: #XX
```

---

## 🚫 禁止行为（必须避免）

### ❌ 1. "顺便"重构

**错误示例**：
```markdown
任务：修复 Tab 2 崩溃 bug

✅ 正确做法：
1. 修复 bug
2. 提交代码
3. 如果需要重构，单独创建任务

❌ 错误做法：
1. 修复 bug
2. "顺便"重构 ViewModel（200 行）← ❌ 混在一起
3. "顺便"优化查询逻辑 ← ❌ 混在一起
4. 提交一个巨大的 commit ← ❌ 难以 Review
```

**规则**：
- 修 bug 就是修 bug，不要"顺便"重构
- 重构就是重构，不要"顺便"加新功能
- 一次 commit 只做一件事

### ❌ 2. 纯美化重构

**错误示例**：
```swift
// ❌ 纯美化：只是看不惯变量名
// 旧代码
let data = fetchData()

// 重构后
let fetchedData = fetchData()  // ❌ 没有实际收益

// ✅ 可以美化的情况：
// - 变量名不清晰，导致误解
// - 违反编码规范，影响一致性
```

**判断标准**：
```markdown
问：这次重构能带来什么收益？

✅ 可以重构：
- 提升性能
- 提高可读性（显著改善）
- 提升扩展性
- 消除重复代码
- 修复架构问题

❌ 不要重构：
- 只是"看起来更好"（主观）
- 只是"我更喜欢这样"（个人偏好）
- 没有具体收益（纯美化）
```

### ❌ 3. 边重构边加功能

**错误示例**：
```markdown
任务：重构 HealthKitService + 新增离线模式

❌ 错误做法：
1. 重构 HealthKitService
2. 同时新增离线模式功能
3. 一起提交

问题：
- 测试失败时，分不清是重构问题还是新功能问题
- 回滚困难（重构和新功能混在一起）
- Code Review 困难（变更太多）

✅ 正确做法：
1. 先重构 HealthKitService
2. 提交 + 验证
3. 再新增离线模式
4. 分别提交
```

### ❌ 4. 没测试就重构

**错误示例**：
```markdown
场景：重构一个没有测试的模块

❌ 错误做法：
1. 直接重构代码
2. 手动测试一下
3. "应该没问题"

风险：
- 没有测试保护，容易引入 bug
- 手动测试不全面，遗漏边界情况
- 重构后无法验证行为是否一致

✅ 正确做法：
1. 先补充测试（覆盖率 ≥70%）
2. 确保测试通过
3. 再进行重构
4. 测试仍然通过 ← 验证行为不变
```

---

## 📋 快速自检清单

重构前必须完成：

- [ ] ✅ Phase 1: 重构前评估（目的 + 时机 + 范围 + 测试 + 批准）
- [ ] ✅ Phase 2: 重构策略（分阶段 + 保持行为 + 回滚方案）
- [ ] ✅ Phase 3: 重构执行（测试 + 小步快跑 + 频繁提交）
- [ ] ✅ Phase 4: 重构验收（测试 + 回归 + 性能 + 文档）
- [ ] ✅ Phase 5: 清理总结（代码清理 + 重构总结）
- [ ] ❌ 禁止："顺便"重构、纯美化、边重构边加功能、没测试就重构

---

## 📊 使用记录

| 日期 | 重构内容 | 影响文件数 | 影响行数 | 用户批准 | 结果 |
|------|---------|-----------|---------|---------|------|
| 2025-11-08 | HealthKitService 拆分 | 5 个 | 500 行 | ✅ 已批准 | ✅ 成功 |
| ... | ... | ... | ... | ... | ... |

---

**版本**: v1.0  
**创建时间**: 2025-11-08  
**维护者**: Epoch Team

