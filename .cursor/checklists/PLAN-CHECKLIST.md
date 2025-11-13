# Week Plan 创建检查清单

> 每次创建新Week的Plan时，**必须**完成此checklist

---

## 📚 相关 Checklist 快速参考

**执行阶段使用的 Checklist**：
- 🐛 **FIX-CHECKLIST.md** - 修复 bug 时使用（根因分析 + 三级验证）
- 📝 **CODE-REVIEW-CHECKLIST.md** - 提交代码前使用（架构 + 质量 + 测试）
- 🔄 **REFACTOR-CHECKLIST.md** - 重构代码时使用（>5 文件或 >200 行）
- 🎯 **DECISION-CHECKLIST.md** - 做决策时使用（轻量版决策流程）

**验收阶段使用的 Checklist**：
- ✅ **WEEKLY_VERIFICATION_CHECKLIST.md** - Week 完成后使用（Build + 测试 + 文档）

**使用时机**：
- 创建 Plan 时 → 使用本 Checklist
- 执行 Plan 时 → 根据任务类型使用对应的 Checklist
- Week 完成后 → 使用 WEEKLY_VERIFICATION_CHECKLIST

---

## ✅ Phase 1: 文档研读（必须先做）

### 1.1 查阅MVP Plan

**文件**：`docs/09-roadmap/mvp-plan.md`

- [ ] 找到对应Week的任务清单
- [ ] 确认该Week的"里程碑"是什么
- [ ] 检查是否有特殊注意事项（如：风险提示）

**验证方法**：
```bash
# 搜索该Week的任务
grep -A 20 "Week X:" docs/09-roadmap/mvp-plan.md
```

---

### 1.2 查阅相关ADR

**文件**：`docs/03-decisions/README.md`

- [ ] 识别该Week涉及的功能领域
- [ ] 查找对应的ADR文档
- [ ] 阅读ADR中的"核心约束"部分

**常见对应关系**：
| Week功能 | 相关ADR |
|---------|---------|
| 数据模型 | ADR-002, swiftdata-schema.md |
| HealthKit | ADR-001, healthkit-integration.md |
| Firebase | ADR-009, ADR-010, firebase-schema.md |
| AI功能 | ADR-005, ai-prompt-templates.md |
| 订阅 | ADR-011 |
| Onboarding | onboarding-flow.md, uesca-principles.md |

---

### 1.3 查阅实现文档

**目录**：`docs/04-implementation/`

- [ ] 查找相关的技术规格文档
- [ ] 确认数据结构定义
- [ ] 检查是否有已存在的代码模式

**关键文件**：
- `swiftdata-schema.md` - 数据模型定义
- `file-structure.md` - 已有文件结构
- `healthkit-integration.md` - HealthKit集成模式
- `firebase-schema.md` - Firebase数据结构

---

## ✅ Phase 2: 交叉验证（防止遗漏）

### 2.1 功能完整性检查

- [ ] MVP Plan中列出的**所有**任务都在Week Plan中吗？
- [ ] 是否有自动化功能（如：自动填充、自动同步）？
- [ ] 是否有"隐含"的任务（如：测试、文档更新）？

**方法**：
```bash
# 列出MVP Plan该Week的所有任务
grep -A 15 "### Week X:" docs/09-roadmap/mvp-plan.md | grep "^\- \["
```

---

### 2.2 数据结构一致性检查

- [ ] 新增的字段是否与现有Model冲突？
- [ ] 是否有重复的字段定义？
- [ ] 数据类型是否与文档一致？

**💡 提示**：如果发现数据结构问题，在实施阶段使用 **FIX-CHECKLIST.md** 进行根因分析

**验证方法**：
```bash
# 搜索相关字段是否已存在
grep -r "字段名" Epoch/Models/
grep "字段名" docs/04-implementation/swiftdata-schema.md
```

**示例**（Week 5的教训）：
```swift
// ❌ 错误：在TrainingGoalDTO中重复定义
var experienceLevel: String?  // 已在UserProfileDTO中！

// ✅ 正确：检查现有定义
grep "experienceLevel" Epoch/Models/
// 发现：UserProfileDTO.swift:16 已有定义
```

---

### 2.3 依赖检查

- [ ] 该Week的功能是否依赖前几周的成果？
- [ ] 前几周是否已完成必要的准备工作？
- [ ] 是否需要先完成某个ADR的实现？

**示例**：
- Week 5依赖Week 4的Profile编辑功能
- Week 6依赖Week 5的Onboarding数据

---

## ✅ Phase 3: Plan内容验证

### 3.1 任务列表完整性

- [ ] 是否包含数据结构扩展？
- [ ] 是否包含UI实现？
- [ ] 是否包含测试验证？
- [ ] 是否包含文档更新？
- [ ] 是否包含代码审查任务？（使用 **CODE-REVIEW-CHECKLIST.md**）
- [ ] 如果涉及重构（>5 文件），是否单独列出？（使用 **REFACTOR-CHECKLIST.md**）

---

### 3.2 参考文档引用

- [ ] 是否引用了相关的ADR？
- [ ] 是否引用了实现文档的具体行号？
- [ ] 是否引用了现有代码示例？

**模板**：
```markdown
## 📚 参考文档

### ADR
- ADR-XXX: 决策标题（`docs/03-decisions/ADR-XXX.md`）
- 关键约束：具体内容

### 实现文档
- `swiftdata-schema.md:行号` - 数据模型定义
- `现有文件.swift:行号` - 代码模式参考

### 现有代码
- `Epoch/Views/XXX.swift` - 可复用的UI模式
```

---

### 3.3 时间估算合理性

- [ ] 是否参考了Week 1-4的实际耗时？
- [ ] 是否考虑了复杂度评估？
- [ ] 是否预留了Bug修复时间？

**参考数据**：
| Week | 计划时间 | 实际时间 | 偏差 |
|------|---------|---------|------|
| Week 3 | 5天 | 2-3天 | -40% |
| Week 4 | 5天 | 2天 | -60% |

---

### 3.4 验收标准明确性

- [ ] 是否有具体的测试场景？
- [ ] 是否有"必须完成"和"加分项"的区分？
- [ ] 是否有真机测试要求？

---

## ✅ Phase 4: 端到端流程与自动化验证

### 4.1 端到端流程图

- [ ] 画出完整数据流：用户操作 → iOS → Backend → Firebase → iOS → UI
- [ ] 检查每个环节是否有对应的实施任务
- [ ] 特别检查：数据回流路径（Firebase → SwiftData → UI刷新）

**示例**（Week 7教训）：
```
Onboarding → Backend Stage 1 → Firebase写入框架
         ↓（遗漏！）
      Backend Stage 2 → Firebase写入detailedWeeks
         ↓
   PlanSyncService监听 → SwiftData更新 → UI刷新
```

---

### 4.2 自动化功能清单（⚠️ 最容易遗漏）

逐项检查以下类型的自动化：

**数据自动填充**：
- [ ] HealthKit自动填充（如Onboarding Step 2）
- [ ] UserProfile自动填充（如用户设置）
- [ ] 历史数据自动加载

**自动生成/触发**：
- [ ] Onboarding后自动生成计划
- [ ] 周期性生成（如每周日生成下周）
- [ ] 条件触发（如RPE过高触发调整）

**自动同步**：
- [ ] Firebase → SwiftData（实时监听）
- [ ] SwiftData → Firebase（离线队列）
- [ ] HealthKit → SwiftData（Observer Query）

**自动检测/提醒**：
- [ ] 周日晚提醒生成下周
- [ ] 训练未完成提醒
- [ ] 异常数据检测

**工具**：搜索关键词
```bash
grep -r "自动\|监听\|定时\|Observer\|Listener" docs/
```

---

### 4.3 数据完整性三要素

对每个涉及的数据字段检查：

**1. 生成逻辑**（谁写入？）
- [ ] 列出所有新增/修改的字段
- [ ] 每个字段有明确的写入代码
- [ ] 写入时机明确（Onboarding? 用户操作? Backend生成?）

**2. 读取逻辑**（谁使用？）
- [ ] 每个字段有至少一个读取点
- [ ] 不要创建"孤儿字段"（定义了但没人用）

**3. 同步逻辑**（如何保持一致？）
- [ ] Firebase ↔ SwiftData 同步机制明确
- [ ] 冲突解决策略定义（Last Write Wins? Merge?）
- [ ] 离线处理策略明确

**Week 7教训**：
```markdown
❌ 错误：detailedWeeks字段定义了，但生成逻辑遗漏
   - firebase-schema.md定义：detailedWeeks: [...]
   - ADR-014要求：generateInitialPlan应返回detailedWeeks
   - 实际实现：只生成weeklyFramework，detailedWeeks遗漏

✅ 正确：三要素全部检查
   - 生成：Backend Stage 2生成detailedWeeks ✅
   - 读取：WeekCalendarView读取显示 ✅
   - 同步：PlanSyncService实时监听更新 ✅
```

---

### 4.4 关键服务启动检查 ⭐⭐⭐⭐⭐（新增）

**目的**：防止"孤儿服务"（代码存在但从未启动）

对每个新增的Service，明确回答：

**1. 启动时机**：
- [ ] 何时启动？（App启动？用户登录？特定操作后？）
- [ ] 在哪个文件启动？（EpochApp.swift? ContentView.swift? 某ViewModel?）
- [ ] 启动代码已写入Plan？

**2. 停止时机**：
- [ ] 何时停止？（App退出？用户登出？后台？）
- [ ] 停止逻辑是否实现？

**3. 验证方法**：
- [ ] 如何验证Service已启动？（Console日志关键词？）
- [ ] 如何验证Service正常工作？（数据查询？API调用？）

**Post-Week 7教训**：
```markdown
❌ 错误：PlanSyncService实现了，但没有启动逻辑
   - 代码：PlanSyncService.swift ✅
   - 启动：❌ 没有任何地方调用 startListening()
   - 结果：Firebase有数据，iOS端查不到（数据流断裂）

✅ 正确：明确启动集成点
   - 创建Service ✅
   - 在ContentView.task中启动 ✅
   - 验证日志："✅ PlanSyncService: Started listening" ✅
   - 验证数据：SwiftData能查到数据 ✅
```

**检查清单**：
```bash
# 搜索Service启动代码
grep -r "ServiceName()" Epoch/
grep -r "\.start\|\.configure\|\.initialize" Epoch/

# 如果搜索结果为空 → 服务未启动！
```

---

### 4.5 数据流完整性检查 ⭐⭐⭐⭐⭐（新增）

**目的**：确保数据能从源头流到UI

画出完整数据流，验证每个环节：

**数据写入 → 数据传输 → 数据存储 → 数据显示**

**示例检查表**：
```markdown
数据：detailedWeeks（训练详细周）

1. ✅ 数据写入
   - 谁写入：Backend Stage 2
   - 写到哪：Firebase trainingPlans/{planId}.detailedWeeks
   - 何时写：Onboarding完成后自动链式触发
   - 验证：Firebase Console能看到数据

2. ✅ 数据传输
   - 传输方式：PlanSyncService.addSnapshotListener
   - 何时传输：用户登录后启动监听，数据变化时实时传输
   - 验证：Console日志 "✅ Synced 2 weeks to SwiftData"

3. ✅ 数据存储
   - 存到哪：SwiftData CachedWeekPlan
   - 存储逻辑：PlanSyncService.syncDetailedWeeks()
   - 验证：SwiftData查询返回非空

4. ✅ 数据显示
   - 谁显示：HomeTabView / PlanTabView
   - 查询逻辑：HomeViewModel.fetchTodayWorkout()
   - 验证：UI显示内容
```

**关键检查点**：
- [ ] 每个环节都有对应的实施任务吗？
- [ ] 数据回流路径（Firebase → iOS）是否完整？
- [ ] 是否有"数据黑洞"（写入了但没人读）？
- [ ] 是否有"数据幻想"（UI读取但没人写入）？

**工具**：
```bash
# 搜索数据写入点
grep -r "\.set\|\.update\|\.add" backend/

# 搜索数据读取点
grep -r "FetchDescriptor\|\.fetch\|\.get" Epoch/

# 对比：写入的字段 vs 读取的字段
```

---

### 4.6 依赖关系检查

**新旧代码集成**：
- [ ] 列出本Week新增的Service/ViewModel
- [ ] 检查是否有调用方（不要创建"孤儿代码"）
- [ ] 检查是否有Protocol + Mock（测试需要）

**Week 7教训**：
```markdown
❌ PlanSyncService创建了，但WeekPlanViewModel没使用
   - 新增：PlanSyncService.swift ✅
   - 集成：❌ 没有任何ViewModel调用
   - 结果：代码是"死代码"，无法发挥作用

✅ 正确：验证集成
   - 创建Service后，立即检查调用方
   - 确认ViewModel已注入Service
   - 确认UI能触发Service方法
```

**前置条件**：
- [ ] 本Week依赖哪些前Week功能？
- [ ] 这些功能是否已完成？（不要假设）
- [ ] 如果未完成：计划中包含补齐任务

---

## ✅ Phase 5: 验收标准预定义

### 5.1 端到端测试场景（必须3个）

**💡 提示**：如果测试失败，使用 **FIX-CHECKLIST.md** 进行问题排查

为本Week定义**至少3个**端到端测试场景：

**场景1：正常流程（Happy Path）**
- [ ] 步骤清晰（1→2→3）
- [ ] 预期结果明确（Firebase数据? UI显示?）
- [ ] 验证方法具体（截图? Console日志?）

**场景2：边界情况（Edge Case）**
- [ ] 识别边界条件（空数据? 首次使用? 网络慢?）
- [ ] 预期行为定义
- [ ] 不崩溃是底线

**场景3：错误处理（Error Handling）**
- [ ] 常见错误（网络断开? 权限拒绝? 数据格式错误?）
- [ ] 友好提示（不要技术错误信息）
- [ ] 降级方案（如读取缓存）

**示例**（Post-Week 7）：
```markdown
场景1：Onboarding流程
1. 完成9步Onboarding
2. 点击"完成"
3. 等待3分钟
预期：Firebase trainingPlans/{planId} 包含detailedWeeks[0,1]

场景2：周日自动生成
1. 系统时间=周日19:00
2. 打开App
3. 等待5秒
预期：Console输出"🎯 Generating week 3..." + Firebase新增Week 3

场景3：网络断开
1. 关闭WiFi
2. 进入Tab 2
3. 查看本周计划
预期：显示缓存数据 + "离线模式"提示（不崩溃）
```

---

### 5.2 数据验证清单（端到端）⭐⭐⭐⭐⭐

**必须验证完整数据流**，不能只验证一端！

**Firebase → SwiftData → UI 三级验证**：

**Level 1: Firebase数据存在**
- [ ] 列出涉及的所有collection
- [ ] 为每个collection定义验证查询
- [ ] 准备Firebase Console验证截图模板

**Level 2: SwiftData数据同步** ← **Post-Week 7教训：这一级经常被忽略！**
- [ ] 列出涉及的所有Model
- [ ] 定义SwiftData查询验证逻辑
- [ ] 验证数据量一致（Firebase 2条 = SwiftData 2条）
- [ ] 验证数据内容一致（字段值相同）

**Level 3: UI数据显示**
- [ ] 列出所有相关的View
- [ ] 验证UI能显示数据
- [ ] 验证数据更新时UI自动刷新

**Post-Week 7教训**：
```markdown
❌ 错误验收（只验证Firebase）：
1. ✅ 打开Firebase Console
2. ✅ 看到detailedWeeks有2个week
3. ✅ 验收通过 ← 错误！

✅ 正确验收（端到端三级）：
1. ✅ Firebase验证
   - Firebase Console看到detailedWeeks[0,1]
   
2. ✅ SwiftData验证 ← 缺失的一环！
   - Console搜索 "Synced 2 weeks to SwiftData"
   - 或查询：FetchDescriptor<CachedWeekPlan>
   
3. ✅ UI验证
   - 打开Tab 1 → 看到今日训练
   - 打开Tab 2 → 看到本周计划
```

**示例验收脚本**：
```markdown
## 验收清单：训练计划生成

### 1. Firebase数据验证
```bash
# Firebase Console查询
db.collection('trainingPlans')
  .where('userId', '==', 'test-user')
  .get()
```
验证项：
- ✅ userId字段存在
- ✅ weeklyFramework数组长度=16
- ✅ detailedWeeks数组长度>=2
- ✅ detailedWeeks[0].workouts长度=7

### 2. SwiftData数据验证（必须！）
在Xcode Console中运行：
```swift
let descriptor = FetchDescriptor<CachedWeekPlan>(
    predicate: #Predicate { plan in
        plan.userId == "test-user"
    }
)
let weekPlans = try? modelContext.fetch(descriptor)
print("✅ SwiftData查询结果：\(weekPlans?.count ?? 0) 条")
```
验证项：
- ✅ weekPlans.count >= 2
- ✅ weekPlans[0].workouts.count == 7
- ✅ 数据与Firebase一致

### 3. UI数据验证
真机测试：
- ✅ 进入Tab 1 → 今日训练卡片显示内容
- ✅ 进入Tab 2 → 本周计划显示7天训练
- ✅ 数据非"空状态"或"加载中"
```

---

### 5.3 性能基准（如果适用）

- [ ] 定义性能目标（启动时间? API响应? 查询速度?）
- [ ] 定义测量方法（Instruments? Console日志?）
- [ ] 定义及格线（如AI生成<3分钟）

---

## ✅ Phase 6: 最终检查与报告生成

### 6.1 完整性自查

回答以下问题：

1. **功能完整性**：MVP Plan该Week的所有任务都覆盖了吗？
   - [ ] 是
   - [ ] 否 → 哪些遗漏了？

2. **自动化功能**：Phase 4.2的所有自动化类型都检查了吗？
   - [ ] 是
   - [ ] 否 → 哪些可能遗漏了？

3. **数据完整性**：Phase 4.3的三要素（生成/读取/同步）都有了吗？
   - [ ] 是
   - [ ] 否 → 哪里缺失了？

4. **ADR遵循**：是否逐条对照了ADR的"实施方式"章节？
   - [ ] 是
   - [ ] 否 → 哪些约束违反了？

5. **端到端测试**：是否定义了3个测试场景？
   - [ ] 是
   - [ ] 否 → 补充场景

---

### 6.2 生成检查报告（必须）

完成以上所有Phase后，**必须**生成检查报告：

**文件**：`.cursor/docs/YYYY-MM-DD_WeekX_Plan_Check_Report.md`

**格式**：
```markdown
# Week X Plan检查报告

> **检查时间**: YYYY-MM-DD HH:MM
> **检查人**: Cursor AI
> **Plan文件**: `.cursor/plans/week-x-xxx.plan.md`

---

## Phase 1: 文档交叉验证

### 1.1 ADR对照
- ✅ ADR-014: 所有deliverables已覆盖
  - ✅ generateInitialPlan返回detailedWeeks[0,1]
  - ✅ Backend链式触发Stage 2
- ✅ 无遗漏

### 1.2 MVP Plan对照
- ✅ Week X任务清单：20个任务全部在Plan中
- ✅ 无推迟任务

### 1.3 Firebase Schema对照
- ✅ 使用标准路径：trainingPlans/{planId}
- ✅ detailedWeeks结构符合定义

---

## Phase 2: 交叉验证

### 2.1 功能完整性
- ✅ 所有MVP Plan任务已覆盖
- ✅ 自动化功能已列出：3个（自动生成前2周、周日生成下周、实时同步）

### 2.2 数据结构一致性
- ✅ 无重复字段
- ✅ 与SwiftData Schema一致

---

## Phase 3: Plan内容验证

- ✅ 包含数据结构扩展
- ✅ 包含UI实现
- ✅ 包含测试验证
- ✅ 包含文档更新
- ✅ 引用ADR-014
- ✅ 时间估算：21小时（参考Week 1-7经验）

---

## Phase 4: 端到端流程与自动化

### 4.1 端到端流程图
✅ 已绘制：Onboarding → Backend Stage 1+2 → Firebase → PlanSyncService → SwiftData → UI

### 4.2 自动化功能清单
- ✅ Onboarding后自动生成前2周
- ✅ 周日18:00+自动生成下周
- ✅ Firebase实时同步到SwiftData
- ⚠️ 缺少：网络恢复后自动重试（可接受，Week 9补充）

### 4.3 数据完整性三要素
| 字段 | 生成逻辑 | 读取逻辑 | 同步逻辑 |
|------|---------|---------|---------|
| detailedWeeks | ✅ Backend Stage 2 | ✅ WeekCalendarView | ✅ PlanSyncService |
| blocks | ✅ AI生成 | ✅ StructuredWorkoutDetailView | ✅ PlanSyncService |

---

## Phase 5: 验收标准

### 5.1 端到端测试场景
- ✅ 场景1：Onboarding流程（Happy Path）
- ✅ 场景2：周日自动生成（边界情况）
- ✅ 场景3：网络断开（错误处理）

### 5.2 数据验证清单
- ✅ Firebase验证：5项检查已定义
- ✅ SwiftData验证：3个Model检查已定义

---

## Phase 6: 最终检查

### 完整性自查
- ✅ 功能完整性：100%
- ✅ 自动化功能：已检查所有类型
- ✅ 数据完整性：三要素齐全
- ✅ ADR遵循：逐条对照完成
- ✅ 端到端测试：3个场景已定义

---

## 🎯 风险提示

| 风险 | 影响 | 缓解措施 |
|------|------|---------|
| Backend链式触发超时4分钟 | 用户等待过久 | 保持202立即返回，后台执行 |
| 周日检测依赖系统时间 | 测试困难 | 提供Debug开关强制触发 |

---

## ✅ 最终结论

**状态**: ✅ 通过

**理由**：
- 所有Phase检查完成
- MVP Plan任务100%覆盖
- 自动化功能无遗漏
- 数据完整性三要素齐全
- 验收标准清晰可测

**建议**：批准执行
```

**验证方法**：
```bash
# 检查报告是否生成
ls -la .cursor/docs/*Plan_Check_Report.md
```

---

### 6.3 提交前审查

- [ ] 运行`grep`验证关键字段不重复
- [ ] 检查文件路径是否正确
- [ ] 时间估算是否合理（对比Week 1-7）
- [ ] 代码示例是否可编译（至少语法正确）
- [ ] **检查报告已生成并通过**

---

## 🚫 常见陷阱（必须避免）

基于Week 5的教训：

### 陷阱1：忽略现有实现

❌ **错误**：
```markdown
Task: 创建ProfileEditView（3个字段）
```

✅ **正确**：
```bash
# 先检查是否已存在
find Epoch -name "ProfileEditView.swift"
# 发现：已存在，且已实现3个字段！
```

---

### 陷阱2：重复数据结构

❌ **错误**：
```swift
// TrainingGoalDTO
var experienceLevel: String?  // 已在UserProfileDTO！
```

✅ **正确**：
```bash
# 先搜索字段是否已存在
grep -r "experienceLevel" Epoch/Models/
```

---

### 陷阱3：遗漏自动化功能

❌ **错误**：
```markdown
Task: 用户手动填写9步表单
```

✅ **正确**：
```markdown
Task: 
1. 从HealthKit自动填充（MVP Plan明确要求）
2. 用户可手动修改
```

---

## 📊 检查清单使用记录

| Week | 检查日期 | 检查人 | 遗漏问题数 | 状态 |
|------|---------|-------|-----------|------|
| Week 5 | 2025-11-03 | Claude | 2（自动填充+数据结构） | ✅ 已修正 |
| Week 6 | - | - | - | - |

---

**版本**: v1.0  
**创建时间**: 2025-11-03  
**维护者**: Epoch Team

