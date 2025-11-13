# Bug Fix 检查清单

> **Purpose**: 确保每次 bug 修复都经过完整的分析和验证流程
> **触发场景**: 修复 bug、处理编译错误、解决崩溃、性能问题

---

## 🎯 核心原则

**铁律**: 理解根本原因后再修复，不要盲目试错

- ✅ 分析根因 → 设计方案 → 验证修复
- ❌ 看到错误 → 直接改代码 → "应该好了"

---

## ✅ Phase 1: 问题识别（必须先做）

### 1.1 准确描述问题

- [ ] **错误现象**: 具体描述问题是什么
  ```markdown
  ✅ 好："进入 Tab 2 时 App 崩溃，Console 报错 'Index out of range'"
  ❌ 差："Tab 2 不工作"
  ```

- [ ] **复现步骤**: 清晰的 1→2→3 步骤
  ```markdown
  1. 打开 App
  2. 登录测试账号
  3. 点击 Tab 2
  4. 观察：App 崩溃
  ```

- [ ] **错误日志**: 完整的错误信息（不要只截取一部分）
  ```swift
  // ✅ 好：完整的 stack trace
  Fatal error: Index out of range
  File: WeekPlanViewModel.swift, line 45
  Thread 0 Crashed:
  ...
  
  // ❌ 差："有个 index 错误"
  ```

- [ ] **影响范围**: 哪些功能受影响？
  ```markdown
  - 主要影响：Tab 2 训练计划页面
  - 次要影响：首页的"本周概览"组件
  - 不受影响：Tab 1、Tab 3
  ```

### 1.2 环境信息

- [ ] iOS 版本：18.x / 26.x
- [ ] 设备类型：iPhone 15 Pro / Simulator
- [ ] App 版本：v0.x.x
- [ ] 数据状态：空数据 / 有数据 / 特定数据集

---

## ✅ Phase 2: 根因分析（禁止跳过）⭐⭐⭐⭐⭐

### 2.1 识别根本原因（不是表面症状）

**方法：5 Why 分析法**

```markdown
现象：App 崩溃
Why 1: 为什么崩溃？→ 数组越界
Why 2: 为什么越界？→ 访问 weekPlans[2]，但数组只有 1 个元素
Why 3: 为什么数组少？→ Firebase 只写入了 Week 1，没有 Week 2
Why 4: 为什么没写入？→ Backend Stage 2 没执行
Why 5: 为什么没执行？→ ⭐ 根因：Stage 2 生成逻辑遗漏
```

- [ ] **根本原因已识别**（不是"不知道"）
- [ ] **有证据支持**（日志 / 代码分析 / 调试结果）

### 2.2 检查同类错误（防止遗漏）

- [ ] 同一个文件是否有类似问题？
  ```bash
  # 搜索相同的模式
  grep -n "weekPlans\[" Epoch/ViewModels/WeekPlanViewModel.swift
  ```

- [ ] 同一个模块是否有相似逻辑？
  ```bash
  # 搜索所有使用该数组的地方
  grep -r "weekPlans\[" Epoch/
  ```

- [ ] 其他文件是否有相同的 bug？

### 2.3 查阅相关 ADR（是否违反了架构约束？）

- [ ] 检查是否有相关的 ADR
  ```bash
  # 搜索相关的 ADR
  grep -r "weekPlans\|detailedWeeks" docs/03-decisions/
  ```

- [ ] 检查是否违反了约束
  ```markdown
  示例：
  - ADR-014 要求：Backend 必须生成前 2 周
  - 实际情况：只生成了 1 周
  - 结论：违反了 ADR 约束
  ```

### 2.4 时间线追溯（什么时候引入的？）

- [ ] 查找引入 bug 的 commit
  ```bash
  # Git blame 找到代码作者
  git blame Epoch/ViewModels/WeekPlanViewModel.swift -L 45,45
  
  # 查看 commit 历史
  git log --oneline -- Epoch/ViewModels/WeekPlanViewModel.swift
  ```

- [ ] 理解当时的上下文
  ```bash
  # 查看完整 commit
  git show <commit-hash>
  ```

---

## ✅ Phase 3: 修复方案（至少 2 个方案对比）

### 3.1 方案设计

**必须提供至少 2 个方案**，并对比优缺点：

```markdown
#### 方案 A: 修复 Backend Stage 2 逻辑 ⭐ 推荐

**优点**：
- 根本解决问题（不是 workaround）
- 符合 ADR-014 的设计意图
- 保持架构一致性

**缺点**：
- 需要修改 Backend 代码
- 需要重新部署 Backend

**风险**：
- Backend 修改可能引入新 bug
- 部署需要时间

**实施成本**：2-3 小时

---

#### 方案 B: 在 iOS 端做防御性检查

**优点**：
- 快速修复（只改 iOS）
- 不需要等 Backend 部署
- 降低崩溃风险

**缺点**：
- 治标不治本（Backend 问题仍然存在）
- iOS 逻辑变复杂
- 可能掩盖其他问题

**风险**：
- 如果 Backend 问题扩散，iOS workaround 不够

**实施成本**：30 分钟

---

#### 推荐：方案 A + 方案 B（短期+长期）

**短期（30 分钟）**：
- 先实施方案 B，防止崩溃
- 提供友好提示："训练计划生成中..."

**长期（2-3 小时）**：
- 实施方案 A，根本解决
- 修复后移除方案 B 的 workaround
```

### 3.2 选择理由（必须有证据支持）

- [ ] **为什么选择这个方案？**
  ```markdown
  ✅ 好："选择方案 A，因为 ADR-014 明确要求 Backend 生成 2 周，
      iOS 不应该做 workaround。参考 Week 7 计划第 23 条任务。"
  
  ❌ 差："方案 A 看起来更好"
  ```

- [ ] **是否引入新问题？（副作用分析）**
  ```markdown
  副作用检查：
  - 是否影响现有功能？→ 检查相关代码
  - 是否引入新依赖？→ 评估依赖风险
  - 是否降低性能？→ 评估性能影响
  ```

- [ ] **是否需要更新文档？**
  - [ ] ADR（如果涉及架构变更）
  - [ ] 实现文档（如果改变了数据流）
  - [ ] Changelog（必须记录）

---

## ✅ Phase 4: 验证（三级验证 ⭐⭐⭐⭐⭐）

### 4.1 编译验证

```bash
cd /Users/norvyn/Code/Projects/Epoch
xcodebuild -scheme Epoch -destination 'generic/platform=iOS' build
```

**要求**：**BUILD SUCCEEDED** with **0 errors**

- [ ] 编译通过
- [ ] 0 个编译错误
- [ ] 0 个新增警告（或解释原因）

### 4.2 单元测试

- [ ] 相关的单元测试通过
  ```bash
  xcodebuild test -scheme Epoch -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
  ```

- [ ] 如果是新 bug，补充测试用例
  ```swift
  // 示例：补充边界测试
  func test_weekPlans_emptyArray_shouldNotCrash() {
      viewModel.weekPlans = []
      XCTAssertNoThrow(viewModel.loadCurrentWeek())
  }
  ```

### 4.3 回归测试

**必须验证原有功能不受影响**：

- [ ] **相关功能**: 手动测试受影响的功能模块
  ```markdown
  测试清单：
  - Tab 2 训练计划页面 → ✅ 正常显示
  - 首页本周概览 → ✅ 正常显示
  - Onboarding 生成计划 → ✅ 正常触发
  ```

- [ ] **不相关功能**: 快速烟雾测试
  ```markdown
  - Tab 1 首页 → ✅ 正常
  - Tab 3 设置 → ✅ 正常
  - 登录/登出 → ✅ 正常
  ```

### 4.4 真机测试

- [ ] 在真实设备上验证修复
  ```markdown
  设备：iPhone 15 Pro (iOS 18.1)
  场景：
  1. 清除 App 数据
  2. 重新登录
  3. 完成 Onboarding
  4. 等待计划生成
  5. 进入 Tab 2
  预期：不崩溃，显示 2 周计划
  结果：✅ 通过
  ```

- [ ] 测试边界情况
  ```markdown
  - 空数据状态 → ✅
  - 网络断开 → ✅
  - 首次使用 → ✅
  ```

---

## ✅ Phase 5: 防复发（必须执行）

### 5.1 文档更新

- [ ] **Changelog 记录**（必须）
  ```markdown
  文件：docs/07-changelog/2025-11.md
  
  ## 2025-11-08 14:30 - 修复 Tab 2 崩溃
  
  ### 🐛 Bug 修复
  | 问题 | 根因 | 修复方案 | 文件 |
  |------|------|---------|------|
  | Tab 2 崩溃 | Backend Stage 2 遗漏 | 补充生成逻辑 | backend/generatePlan.js |
  
  ### 📝 经验教训
  - 数据生成逻辑必须完整验证（Firebase + SwiftData + UI 三级）
  - 参考：`.cursor/docs/2025-11-08_Week7_Lessons.md`
  ```

- [ ] **实现文档更新**（如果改变了数据流）
  ```markdown
  文件：docs/04-implementation/backend-api.md
  
  修改：generateInitialPlan 返回值说明
  + 新增：detailedWeeks[0,1] 生成逻辑说明
  ```

- [ ] **ADR 更新**（如果违反了 ADR）
  ```markdown
  如果发现 ADR 约束不合理：
  1. 创建新 ADR 更新决策
  2. 标记旧 ADR 为"已弃用"
  3. 记录变更原因
  ```

### 5.2 规则/Checklist 更新

- [ ] **检查是否是规则遗漏导致的**
  ```markdown
  示例：
  - Week 7 遗漏了"服务启动"检查
  - 解决：在 PLAN-CHECKLIST.md 增加 Phase 4.4
  ```

- [ ] **更新对应的 Checklist**
  ```markdown
  文件：.cursor/PLAN-CHECKLIST.md
  新增：Phase 4.4 关键服务启动检查
  ```

### 5.3 测试补充

- [ ] **评估测试覆盖不足**
  ```markdown
  问题：为什么测试没发现这个 bug？
  
  原因分析：
  - 缺少集成测试（Backend → Firebase → iOS）
  - 缺少边界测试（空数组、单个元素）
  
  补充计划：
  - 新增：test_generatePlan_shouldReturn2Weeks()
  - 新增：test_weekPlans_edgeCase_emptyArray()
  ```

- [ ] **创建测试用例**
  ```swift
  // 新增测试用例
  func test_weekPlans_preventIndexOutOfRange() {
      // Given: Backend 只返回 1 周（bug 场景）
      mockService.weekPlansToReturn = [weekPlan1]
      
      // When: 尝试访问第 2 周
      let result = viewModel.getWeek(index: 1)
      
      // Then: 不崩溃，返回 nil 或默认值
      XCTAssertNotNil(result)
  }
  ```

### 5.4 经验记录

- [ ] **创建 Lessons Learned 文档**（重大 bug 或教训）
  ```markdown
  文件：docs/09-lessons-learned/YYYY-MM-DD_简短描述.md
  
  # [教训] Week 7 - 数据流验证不完整
  
  ## 问题
  Tab 2 崩溃，因为 Backend Stage 2 遗漏，iOS 查询到空数组
  
  ## 根因
  Plan 创建时只验证了 Firebase，没验证 SwiftData + UI 三级
  
  ## 教训
  1. 数据验证必须端到端（Firebase → SwiftData → UI）
  2. 服务启动逻辑必须在 Plan 中明确（不能假设）
  3. 边界测试必须覆盖空数组情况
  
  ## 改进措施
  1. ✅ PLAN-CHECKLIST.md 新增 Phase 4.4 服务启动检查
  2. ✅ PLAN-CHECKLIST.md 新增 Phase 4.5 数据流完整性检查
  3. ✅ 补充集成测试：Backend → iOS 端到端
  
  ## 参考
  - Commit: abc1234
  - 修复 PR: #XX
  ```

---

## 🚫 禁止行为（必须避免）

### ❌ 1. 盲目试错

**错误示例**：
```swift
// ❌ 错误：看到崩溃就注释掉
// let currentWeek = weekPlans[currentIndex]  // 注释掉，不崩溃了

// ❌ 错误：随便改个值试试
let currentWeek = weekPlans[0]  // 改成 0，不崩溃了
```

**正确做法**：
```swift
// ✅ 正确：理解根因后，做防御性检查
guard currentIndex < weekPlans.count else {
    logger.warning("Index \(currentIndex) out of range, weekPlans count: \(weekPlans.count)")
    return nil  // 或加载默认值
}
let currentWeek = weekPlans[currentIndex]
```

### ❌ 2. 删除功能来"修复"

**错误示例**：
```swift
// ❌ 错误：函数报错就删掉
// func loadCurrentWeek() { ... }  // 删除整个函数

// ❌ 错误：替换为空实现
func loadCurrentWeek() {
    // TODO: 稍后修复
}
```

**正确做法**：
- 理解函数的作用
- 修复具体问题
- 保持功能完整性

### ❌ 3. 跳过验证

**错误示例**：
```markdown
"修复了编译错误，应该没问题了" ← ❌ 没有运行 xcodebuild
"逻辑看起来对了" ← ❌ 没有真机测试
"只改了一行代码，不需要测试" ← ❌ 没有回归测试
```

**正确做法**：
- 每次修复都完整验证（Phase 4 的 4 个步骤）
- 不要假设"应该没问题"

### ❌ 4. 不记录原因

**错误示例**：
```swift
// ❌ 错误：注释不说明原因
// let week = weekPlans[0]  // 修改

// ❌ 错误：只说"修复 bug"
let week = weekPlans.first  // 修复 bug
```

**正确做法**：
```swift
// ✅ 正确：说明原因和相关信息
// Fix: Prevent index out of range when Backend only returns 1 week
// Root cause: Backend Stage 2 generation logic missing (Issue #123)
// Short-term: Use .first as defensive check
// Long-term: Fix Backend to generate 2 weeks (see ADR-014)
let week = weekPlans.first
```

---

## 📋 快速自检清单

在提交修复前，确认：

- [ ] ✅ Phase 1: 问题准确描述（现象 + 步骤 + 日志 + 影响）
- [ ] ✅ Phase 2: 根因已识别（5 Why + 同类检查 + ADR 对照）
- [ ] ✅ Phase 3: 至少 2 个方案对比 + 有证据支持的推荐
- [ ] ✅ Phase 4: 三级验证通过（编译 + 测试 + 回归 + 真机）
- [ ] ✅ Phase 5: 防复发措施（文档 + 规则 + 测试 + 经验）
- [ ] ❌ 禁止：盲目试错、删除功能、跳过验证、不记录原因

---

## 📊 使用记录

| 日期 | Bug 描述 | 根因 | 修复方案 | 验证结果 | 教训文档 |
|------|---------|------|---------|---------|---------|
| 2025-11-08 | Tab 2 崩溃 | Backend Stage 2 遗漏 | 补充生成逻辑 | ✅ 通过 | Week7_Lessons.md |
| ... | ... | ... | ... | ... | ... |

---

**版本**: v1.0  
**创建时间**: 2025-11-08  
**维护者**: Epoch Team

