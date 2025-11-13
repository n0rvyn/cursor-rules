---
description: "核心铁律（每次会话必读）"
scopes: [chat, edit]
tags: [critical-rules, iron-rules, dialectical-thinking]
priority: 1
globs: ["**/*.swift"]
alwaysApply: true
---

# 核心铁律

> **重要性**: ⭐⭐⭐⭐⭐ 最高优先级  
> **加载方式**: Always Applied  
> **适用范围**: 所有会话  

---

## 三大铁律（绝不妥协）

### 1. 永不修改已完成的训练记录 ⭐⭐⭐⭐⭐

**触发条件**：任何涉及 HealthKit 数据读写的操作

**⚠️ 操作前必须检查**：
- [ ] 是否调用了 `HKHealthStore.delete()`？❌ **绝对禁止**
- [ ] 是否修改了 `HKWorkout` 的任何属性？❌ **绝对禁止**
- [ ] 是否只读取 `HKWorkout` 数据？✅ **允许**
- [ ] 是否只写入未来的训练计划（`WorkoutKit`）？✅ **允许**

**核心原则**：
- HealthKit 中的训练结果是**唯一真相源**
- 已完成的记录**永不修改**，只能读取和分析

**详细背景**：`docs/03-decisions/001-healthkit-read-only.md`

---

### 2. AI 必须遵循 UESCA 原则 ⭐⭐⭐⭐⭐

**触发条件**：生成训练计划、提供训练建议、分析训练强度时

**⚠️ 生成计划前必读**：`docs/05-prompts/uesca-principles.md`

**快速检查清单**：
- [ ] 质量训练每周最多 2 次（1次"hard" + 1次"threshold"）
- [ ] 高强度训练间隔至少 48 小时
- [ ] 从易到难，循序渐进（先建立有氧基础）
- [ ] 渐进引入（新手从 0-1 次开始，逐步增加到 2 次）
- [ ] 基于个体反馈动态调整（不是固定比例）

**❌ 常见错误**（必须避免）：
- 一周安排 3 次或更多高强度训练（质量训练）
- 连续两天安排高强度训练（违反 48 小时间隔）
- 新手一开始就安排间歇训练（未建立有氧基础）
- 固守 80/20 比例而不考虑个体反馈（应该灵活调整）

**核心原则**：
- "从易到难"（Easy Before Hard）- 先建立有氧基础再引入强度
- 循序渐进，避免过度训练
- 不是固定比例，而是基于个体反馈的动态调整

**详细参考**：
- `docs/05-prompts/uesca-principles.md`（完整 UESCA 原则）
- `docs/05-prompts/training-philosophies.md`（训练哲学）

---

### 3. 性能指标必须达标 ⭐⭐⭐⭐⭐

**触发条件**：实现任何涉及性能的功能时

**⚠️ 实现前必须检查**：
- [ ] 启动性能 <2s（从点击 App 图标到首屏显示）
- [ ] AI 反馈 <5s（从用户提交到显示结果）
- [ ] 缓存读取 <100ms（SwiftData 本地查询）

**验收标准**：
```swift
// 启动性能测试
// 目标：<2s
let launchStart = Date()
// ... App 启动流程
let launchTime = Date().timeIntervalSince(launchStart)
assert(launchTime < 2.0, "启动超时")

// AI 反馈测试
// 目标：<5s
let feedbackStart = Date()
let response = try await aiService.generateFeedback(log)
let feedbackTime = Date().timeIntervalSince(feedbackStart)
assert(feedbackTime < 5.0, "AI 反馈超时")

// 缓存读取测试
// 目标：<100ms
let cacheStart = Date()
let logs = try await repository.fetchLogs()
let cacheTime = Date().timeIntervalSince(cacheStart)
assert(cacheTime < 0.1, "缓存读取超时")
```

**常见性能瓶颈**：
- ❌ 主线程做耗时操作（网络请求、大量计算）
- ❌ 启动时同步加载大量数据（应该异步 + 懒加载）
- ❌ 未使用缓存分层策略（频繁访问云端数据）

**详细策略**：`docs/03-decisions/007-performance-optimization-strategy.md`

---

## 绝对禁止（5条）

### 1. 永不修改 HealthKit 训练记录
```swift
❌ 永不调用 HKHealthStore.delete()
❌ 永不修改 HKWorkout 的属性
✅ 只读取 HKWorkout 数据
✅ 只写入未来的训练计划（WorkoutKit）
```

### 2. 永不跳过计划中的步骤
```markdown
❌ 步骤失败后继续下一步（未经允许）
❌ 部分完成就标记"完成"
❌ 自己决定"先做其他的"
✅ 逐项完成并验收
✅ 失败时立即停止并报告
✅ 等待用户明确允许后才继续
```

### 3. 永不在没有 BUILD SUCCEEDED 的情况下声称"编译通过"
```bash
❌ 看 linter 没报错就说"编译通过"
❌ "应该没问题"就是"编译通过"
✅ 必须运行 xcodebuild
✅ 必须看到 BUILD SUCCEEDED
✅ 截图或复制输出作为证据
```

### 4. 永不擅自决定"先做其他的"（失败时必须停止）
```markdown
场景：Step 3 部署失败

❌ 错误：标记 "pending"，继续 Step 4
✅ 正确：
   1. 🛑 立即停止
   2. 报告："Step 3 失败（具体原因）"
   3. 询问："是否需要：A. 重试 / B. 检查问题 / C. 继续（说明风险）"
   4. ⏸️  等待明确指示
```

### 5. 永不在 /docs 外创建正式架构文档
```markdown
✅ 正式文档放 docs/03-decisions/ (ADR)
✅ 临时文档放 .cursor/docs/ (带时间戳)
❌ 不要在项目根目录创建 .md 文档
❌ 不要在 .cursor/ 下创建永久性文档
```

---

## 必须遵守（5条）

### 1. 编码前必须制定计划并等待批准
```markdown
流程：
1. 用户提需求
2. 分析问题（属于哪个 Week）
3. 提出方案（2-3 选 1）
4. 用户决策
5. 制定详细计划文档
6. 用户批准
7. 开始实施 ✅

❌ 禁止：听到需求就直接写代码
```

### 2. 代码变更后必须更新 file-structure.md + changelog
```markdown
必须更新：
1. docs/04-implementation/file-structure.md
   - 标记新增/修改的文件
   - 说明文件职责

2. docs/07-changelog/YYYY-MM.md
   - 使用统一格式
   - 记录变更原因

3. 如果是架构级变更 → 创建 ADR
```

### 3. 所有 ViewModel 必须标记 @MainActor
```swift
✅ 正确：
@MainActor
@Observable
final class TrainingLogViewModel {
    var trainingLogs: [TrainingLog] = []
}

❌ 错误：
@Observable  // 缺少 @MainActor
final class TrainingLogViewModel { }
```

### 4. 所有 Service 必须有 Protocol + Mock
```swift
✅ 正确：
protocol HealthKitServiceProtocol {
    func fetchWorkouts() async throws -> [TrainingLog]
}

actor HealthKitService: HealthKitServiceProtocol { }
class MockHealthKitService: HealthKitServiceProtocol { }

❌ 错误：直接创建具体类，没有 Protocol
```

### 5. 架构变更必须创建 ADR
```markdown
以下变更属于架构级，必须创建 ADR：
- 新增/修改数据模型的关系
- 修改认证/授权策略
- 修改数据同步策略
- 引入新的第三方库
- 修改项目结构
- 修改部署方式

流程：
1. 先创建临时文档到 .cursor/docs/
2. 讨论并确认方案
3. 整理为 ADR 移到 docs/03-decisions/
4. 更新 changelog
```

---

## AI 工作原则：辨证思考铁律 ⭐⭐⭐⭐⭐

> **背景**: 2025-11-08 规则治理计划讨论中，AI 犯了严重错误（基于"找不到文档"就否定方案，未经验证）  
> **完整背景**: 见 `docs/09-lessons-learned/2025-11-08_dialectical-thinking-lesson.md`

### 知识边界原则

#### 1. 区分"不知道"和"知道不存在"

**问题本质**：
- "我找不到" ≠ "它不存在"
- 缺少证据 ≠ 反面证据

**正确做法**：
```markdown
❌ 错误："我找不到文档，所以这个功能不存在"
✅ 正确："我找不到文档，建议测试验证"
```

#### 2. 优先实验验证

**证据层级**（从高到低）：
1. ⭐⭐⭐ 实际测试结果
2. ⭐⭐ 官方文档明确说明
3. ⭐ 社区最佳实践（需验证）
4. ❌ 推测、假设

**决策流程**：
```
遇到不确定的问题
  ↓
找官方文档 → 找到 → 采纳
  ↓
找不到
  ↓
设计实验验证 → 得出结论（不要纯推测）
```

#### 3. 承认错误

**发现错误时**：
1. ✅ 立即承认："我错了，[具体错在哪]"
2. ✅ 说明原因："因为我[错误的假设/推理]"
3. ✅ 更新规则："我会记住[教训]，避免重复"

#### 4. 用户也可能错

**辨证思维**：
- 不要盲目服从用户
- 也不要盲目反对用户
- 辨证地分析，实事求是

**正确做法**：
```markdown
当用户可能错误时：
✅ 礼貌但明确地指出："我发现了一个潜在问题..."
✅ 提供证据："因为[具体原因/数据]"
✅ 建议验证："建议我们先测试一下[具体步骤]"

❌ 不要：因为"怕得罪用户"就不指出错误
```

#### 5. 禁止模棱两可

**禁用词汇**：
- ❌ "可能"、"大概"、"应该"、"也许"
- ❌ "需要进一步查证"（然后就不管了）
- ❌ "理论上"、"一般来说"

**替代表述**：
```markdown
情况 1：确实不知道
✅ "我不知道这个机制是否支持。建议通过 [具体测试步骤] 验证。"

情况 2：有证据但不完全确定
✅ "根据 [证据来源]，这个方案可行。但为了确保，建议先做 [小范围测试]。"

情况 3：需要用户提供信息
✅ "这取决于 [具体因素]。请告诉我 [需要的信息]，我才能给出准确建议。"
```

### 示例：Phase 0 经验教训

**AI 的错误**：
> "我查遍了 Cursor 官方文档，找不到任何证据证明 globs + alwaysApply: false 的组合会触发自动加载。"
> 
> 结论：方案不可行，你的计划是"过度设计"。

**用户的验证**：
- 实际测试：创建测试规则，机制**完全正常工作**
- 数据测量：Token 占用 36%，比预估严重，计划**非常必要**

**教训**：
- 缺少文档 ≠ 功能不存在
- 应该建议验证，而非直接否定
- 实验优先于推测

**完整背景**: 见 `docs/09-lessons-learned/2025-11-08_dialectical-thinking-lesson.md`

---

## 任务执行红线（核心原则）

> **完整版**: 见 `207-task-execution-detailed.mdc`

### 核心铁律（100字）

**铁律**：计划中的每个步骤必须逐项完成并验收，不得跳过。任何步骤失败或未完成时，立即停止所有工作，明确报告问题，等待用户明确允许后才能继续下一步。禁止擅自决定"先做其他的"或"这步可以跳过"。

### 四大原则（简化版）

#### 1️⃣ 必须逐项执行
```markdown
✅ 正确：Step 1 → 完成 → Step 2 → 完成 → Step 3
❌ 错误：Step 1 → 失败 → 跳过 → Step 2 继续
```

#### 2️⃣ 失败时必须停止
```markdown
任务失败 → 🛑 立即停止 → 报告 → 询问："A/B/C？" → ⏸️  等待指示

❌ 禁止：标记 "pending" 就继续下一步
```

#### 3️⃣ 验收标准明确
```bash
✅ 编译：必须看到 BUILD SUCCEEDED
✅ 部署：必须看到服务状态 Running
✅ 测试：必须有具体场景结果
```

#### 4️⃣ 等待明确允许
```markdown
✅ 明确的允许："继续"、"执行"、"Option A"
❌ 不能推测："用户可能想..."
```

---

## 场景触发规则

> 当你编辑以下文件时，Cursor 会自动加载对应的场景规则

| 文件模式 | 自动加载的规则 | 内容 |
|---------|--------------|------|
| `*Firebase*.swift` / `*Firestore*.swift` | 100-firebase-checklist.mdc | Firebase 数据结构、Security Rules、GDPR |
| `*HealthKit*.swift` | 101-healthkit-checklist.mdc | HealthKit 读写策略、WorkoutKit 集成 |
| `*Subscription*.swift` / `*Premium*.swift` | 102-subscription-checklist.mdc | 订阅验证、Premium 功能、收据验证 |
| `*Sync*.swift` | 103-sync-checklist.mdc | 离线同步、冲突解决、PendingSync 队列 |
| `*Test*.swift` / `*Tests.swift` | 104-testing-checklist.mdc | 测试策略、Protocol Mock、覆盖率 |
| `*Model*.swift` / `Cached*.swift` | 105-data-model-checklist.mdc | SwiftData Schema、DTO 转换、软删除 |
| `*Auth*.swift` / `*Login*.swift` | 106-auth-checklist.mdc | Firebase Auth、Token 验证、Custom Claims |

**使用方式**：
- 场景规则会在你打开对应文件时**自动加载**
- 不需要手动引用
- 只在需要时加载，节省 token

---

## 详细参考索引

> 需要详细说明时，手动查阅以下文件（不会自动加载）

| 文件 | 内容 | 何时查阅 |
|------|------|---------|
| 200-project-overview-detailed.mdc | 项目概述、关键决策文档索引 | 新会话开始时 |
| 201-workflow-detailed.mdc | 工作流程、Build-Check-Fix | 不确定工作流程时 |
| 202-swift-standards-detailed.mdc | Swift/iOS 编码规范 | 编写代码前 |
| 203-healthkit-integration-detailed.mdc | HealthKit/WorkoutKit 集成详解 | 实现 HealthKit 功能时 |
| 204-anti-overengineering-detailed.mdc | 防止过度设计、证据优先 | 设计新功能时 |
| 205-quality-assurance-detailed.mdc | 质量保证、防幻觉 | 提交代码前 |
| 206-product-principles-detailed.mdc | 产品设计原则 | 产品决策时 |
| 207-task-execution-detailed.mdc | 任务执行详解、验收标准 | 执行复杂任务时 |
| 208-decision-support-detailed.mdc | 结构化决策详解（8维评估、ADR方法论、案例库）| 需要深入决策支持时 |

**访问方式**：
- 在 Chat 中提及文件名即可加载
- 例如："请参考 204-anti-overengineering-detailed.mdc"

---

## 快速检查清单

### 每次会话开始时
- [ ] ✅ 读取 000-critical-rules.mdc（本文件）
- [ ] ✅ 读取 001-project-context.mdc（项目状态）
- [ ] ✅ 在回复开头确认："✅ 已读取核心铁律 + 当前 Week X/12"

### 接到任务时
- [ ] 任务涉及特定领域？→ 场景规则会自动加载
- [ ] 不确定如何开始？→ 先看 002-ai-checklist.mdc
- [ ] 需要详细参考？→ 查阅 200-208 系列文件

### 执行计划时
- [ ] 每个步骤必须逐项完成（任务执行红线）
- [ ] 失败时立即停止并询问
- [ ] 编译验证必须看到 BUILD SUCCEEDED
- [ ] 真机测试必须生成清单并等待反馈

### 遇到不确定问题时
- [ ] 优先查找官方文档
- [ ] 找不到文档 → 设计实验验证
- [ ] 禁止纯推测（辨证思考铁律）
- [ ] 不确定时明确说"我不知道，建议验证"

---

**最后更新**: 2025-11-08  
**版本**: 1.0  
**Token 估算**: ~5,200 tokens  
**加载方式**: Always Applied  
**优先级**: 1（最高）

