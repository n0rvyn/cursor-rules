---
description: "Epoch 项目工作流程 - 详细参考"
scopes: [chat, edit]
tags: [workflow, documentation, build-test, detailed-reference]
priority: 201
globs: []
alwaysApply: false
---

# Epoch 项目工作流程（详细参考）

> **注意**：本文件为详细参考，不会自动加载。  
> **核心规则**：见 `000-critical-rules.mdc`  
> **AI 工作流程**：见 `002-ai-checklist.mdc`

---

## 1️⃣ 每次新会话开始时

**必须执行**：
1. ✅ 读取 `docs/00-AI-CONTEXT.md` - 了解项目背景和当前阶段
2. ✅ 读取 `docs/08-guidelines/coding-standards.md` - 了解编码规范
3. ✅ 读取 `docs/DIRECTORY-STRUCTURE.md` - 了解文档结构
4. ✅ 检查 `docs/09-roadmap/mvp-plan.md` - 确认当前开发范围

**可选执行**：
- 如果上次会话有 Golden Context，读取 `.cursor/docs/[最新]_session-summary.md`
- 如果涉及特定模块，查看相关的 `docs/04-implementation/` 文档

---

## ⚠️ **铁律：永远不要在没有计划的情况下写代码！** ⭐⭐⭐⭐⭐

**这是项目最重要的规则之一！**

### 违反后果：
- ❌ 破坏项目有序推进
- ❌ 引入未经讨论的设计
- ❌ 增加技术债务
- ❌ 文档与代码不同步

### 正确流程：
```
用户提问 
  → 分析问题（属于哪个Week）
  → 提出方案（2-3选1）
  → 用户决策
  → 制定详细计划文档
  → 用户批准
  → 开始实施
```

### 什么算"有计划"：
- ✅ 已有 Week Plan 文档（`.cursor/plans/week-X-*.plan.md`）
- ✅ 或在 `mvp-plan.md` 中明确定义的任务
- ✅ 或用户明确批准的紧急修复

### 什么算"没有计划"：
- ❌ 用户提了需求，你直接开始写代码
- ❌ 发现了问题，直接开始重构
- ❌ "我觉得应该加个功能"就开始写

### 如果用户催促"快点实施"：
1. 礼貌解释："为了确保质量，我需要先制定计划"
2. 承诺时间："计划只需要5分钟，但能避免返工"
3. 如果是紧急修复：至少口头确认方案，事后补文档

---

## 2️⃣ 创建新Week Plan前（新增）⭐

**必须执行**：

1. ⭐ **读取Plan Checklist**
   - 文件：`.cursor/PLAN-CHECKLIST.md`
   - 完成所有4个Phase的检查
   
2. ⭐ **关键验证**（3个必查）
   ```bash
   # 验证1：MVP Plan任务覆盖
   grep -A 20 "Week X:" docs/09-roadmap/mvp-plan.md
   
   # 验证2：数据结构不重复
   grep -r "关键字段名" Epoch/Models/
   
   # 验证3：ADR约束遵守
   grep "关键词" docs/03-decisions/
   ```

3. ⭐ **交叉验证**（防止遗漏）
   - [ ] MVP Plan所有任务都在Week Plan中？
   - [ ] 自动化功能（自动填充、同步）没遗漏？
   - [ ] 数据结构与现有代码一致？

---

## 3️⃣ 开发代码前

**必须检查**：

1. ⭐ **查看关键决策文档索引**
   - 参考 `00-project-overview.md` 的"关键决策文档索引"
   - 确认要实现的功能是否涉及以下领域：
     - 订阅/Premium → 读 ADR-011
     - 离线同步 → 读 ADR-010
     - 数据缓存 → 读 data-caching-strategy.md
     - 认证 → 读 ADR-009
     - 数据模型 → 读 swiftdata-schema.md
     - **Firebase 数据** → 读 firebase-schema.md ⭐⭐⭐⭐⭐
     - 测试 → 读 testing-strategy.md

1.5. ⭐ Firebase 实现检查清单（强制）

**如果涉及 Firebase 数据保存/读取，必须完成：**

- [ ] **Step 1**: 读取 `docs/04-implementation/firebase-schema.md`
  - 确认数据表结构
  - 确认字段定义
  - 确认文档 ID 生成规则

- [ ] **Step 2**: 验证路径格式
  - ✅ 路径段数为偶数（collection/document）
  - ✅ 使用文档定义的路径（不随意发明）
  - ❌ 避免使用奇数段路径（如 users/{userId}/trainingPlans/framework）

- [ ] **Step 3**: 检查 Security Rules
  - 打开 `backend/firestore.rules`
  - 确认对应 collection 有 match 规则
  - 确认使用 `isOwner(userId)` 校验

- [ ] **Step 4**: 确认 DTO 字段完整
  - ✅ 包含 `userId` 字段（用于 Security Rules）
  - ✅ 包含 `id` 字段（文档主键）
  - ✅ 所有必需字段都已定义

- [ ] **Step 5**: 使用标准 FirebaseService 方法
  - ✅ 优先使用 `saveTrainingPlan()` 等专用方法
  - ⚠️ 避免直接调用 `saveData(path:data:)`（容易出错）
  - ✅ 使用 Mapper 转换（DTO ↔ Dictionary）

**常见错误（Week 6 教训）**：
```markdown
❌ 错误：未查阅 firebase-schema.md，随意发明路径
   示例：path: "users/\(userId)/trainingPlans/framework"
   问题：奇数段路径无效 + 未定义在 schema 中

✅ 正确：查阅文档，使用标准路径
   示例：firebaseService.saveTrainingPlan(dto) → trainingPlans/{planId}
```

---

2. 是否有相关的实现文档？
   - 查看 `docs/04-implementation/file-structure.md`
   - 查看相关的技术规格文档

3. 是否有相关的 ADR？
   - 查看 `docs/03-decisions/` 目录
   - ⭐ 使用 `00-project-overview.md` 的索引快速定位
   - 理解为什么这样设计（避免走回头路）

4. 是否符合编码规范？
   - 命名：SwiftData Model 用 `Cached` 前缀，Firebase DTO 用 `DTO` 后缀
   - 并发：ViewModel 必须标记 `@MainActor`
   - 测试：Service 必须有 Protocol 和 Mock
   - 本地化：UI 文本使用 `LocalizedString.xxx`

---

## 4️⃣ 修改代码后

**必须更新**：

### A. 更新文件结构文档
`docs/04-implementation/file-structure.md`
- 标记新增/修改的文件
- 说明文件职责
- 更新状态：⬜ 未开始 → ✅ 已完成

### B. 记录到 Changelog
`docs/07-changelog/YYYY-MM.md`

**格式**：
```markdown
## YYYY-MM-DD HH:MM - 简短描述

### 🔧 代码变更
| 文件 | 变更类型 | 变更内容 | 原因 |
|------|---------|---------|------|
| `TrainingLogView.swift` | 新增 | 训练日志列表视图 | 实现 MVP Phase 1 功能 |
| `HealthKitService.swift` | 修改 | 优化增量同步逻辑 | 解决性能问题 #45 |

### 📄 文档变更
| 文件 | 变更类型 | 变更内容 |
|------|---------|---------|
| `swiftdata-schema.md` | 修改 | 添加软删除字段说明 |

### 🎯 提交信息
- Commit: `feat(log): add training log list view`
- Branch: `feature/training-log-view`
```

### C. 架构级变更创建 ADR
如果变更涉及以下内容，必须创建 ADR：
- 新增/修改数据模型的关系
- 修改认证/授权策略
- 修改数据同步策略
- 引入新的第三方库
- 修改项目结构

**流程**：
1. 先创建临时文档到 `.cursor/docs/YYYY-MM-DD_HHmmss_描述.md`
2. 讨论并确认方案
3. 整理为 ADR 移到 `docs/03-decisions/ADR-XXX-简短描述.md`
4. 更新 changelog
5. 使用 ADR 模板：`docs/03-decisions/_template.md`

### D. ⭐ 完成 Week 级别任务后更新主计划（强制）

**⚠️ 重要**：完成 Week X 的任务后，**必须**更新主计划！

**文件**：`docs/09-roadmap/mvp-plan.md`

**更新内容**：

1. **当前进度区域**（文件顶部）
   ```markdown
   - 更新"当前阶段"（例如：✅ Week 3 完成 → 🚀 准备 Week 4）
   - 更新"当前周次"（例如：Week 3 / 12）
   - 更新"完成进度"（例如：25% (3/12 weeks完成)）
   - 更新"下个里程碑"（例如：Week 4: 用户能登录）
   - 更新"本周任务"（列出 Week 4 的任务）
   - 添加到"已完成里程碑"列表
   ```

2. **对应 Week 的任务区域**
   ```markdown
   - 标记所有任务为 [x] ✅
   - 在标题添加完成标记（例如：### Week 3: 核心数据流 ✅）
   - 添加完成状态行（**状态**: ✅ 已完成（YYYY-MM-DD））
   - 添加评分（**评分**: 9/10）
   - 添加完成度（**完成度**: 95% (18/19 任务)）
   - 添加详细报告链接
   - 添加 Commit 信息
   ```

3. **关键里程碑追踪**（文件底部）
   ```markdown
   - 标记已完成的里程碑为 [x] ✅
   - 标注下一个目标（🎯 下一个）
   ```

**⚠️ 规则**：
- 主计划（`mvp-plan.md`）是**项目的权威来源**
- Cursor plan mode 生成的详细计划（`.cursor/plans/*.md`）只是**辅助工具**
- 验收时必须**两者都更新**！
- 不更新主计划 = 验收不通过 ❌

### E. ⭐ Week验收清单（强制）

**目的**：快速验证Week功能可用，不阻塞进度

**时间**：5-10分钟

#### 必须执行（3项）：

**1. Build验证** ✅ (第7节已规定)
```bash
xcodebuild -scheme Epoch -destination 'generic/platform=iOS' build
```
→ 必须：`BUILD SUCCEEDED`

**2. 真机烟雾测试** ✅ (新增)
- 安装到iPhone（通过Xcode或直接Run）
- 快速测试本周新功能（5分钟）
  - 能打开新功能？
  - 能完成基本操作？
  - 有无崩溃？
- 记录结果：✅ 通过 / ❌ 崩溃或功能不可用

**3. 更新MVP Plan** ✅ (上方D部分已规定)
- 标记Week状态：✅ 已完成 / 🚧 有已知问题

#### 如果发现问题：

**Option A - 立即修复**（推荐：崩溃、数据丢失等严重问题）：
1. 修复Bug
2. 重新Build验证
3. 重新真机测试

**Option B - 记录延后**（推荐：非阻塞性问题）：
1. 在MVP Plan的Week标题下记录已知问题
2. 创建Issue文档：`.cursor/docs/YYYY-MM-DD_WeekX-known-issues.md`
3. 评估优先级后决定是否继续下一个Week

#### 验收通过标准：

**Must Have**（必须满足，否则不能进入下一个Week）：
- ✅ Build成功（0个编译错误）
- ✅ 新功能能打开/运行（不崩溃）
- ✅ 核心流程可用（如Week 5的9步表单能完成）

**Nice to Have**（可以有问题，不阻塞）：
- ⭐ 边界情况处理完善
- ⭐ 用户体验优化
- ⭐ 性能优化
- ⭐ UI细节打磨

**原则**：MVP阶段 = **功能可用** > **完美无缺**

#### 验收记录：

在 `.cursor/docs/YYYY-MM-DD_WeekX_Final_Completion.md` 中记录：

```markdown
## 验收结果

- [x] Build验证通过
- [x] 真机烟雾测试通过
- [x] MVP Plan已更新

**已知问题**：
- Issue #1: [描述] - 优先级P2，Week X+1修复
```

---

## 5️⃣ 修改项目文档后

**必须更新**：
1. 更新 `docs/完整目录树.md`
   - 如果新增了文档，添加到目录树
   - 如果删除了文档，从目录树移除

2. 记录到 `docs/07-changelog/YYYY-MM.md`
   - 在"📄 文档变更"部分添加条目

---

## 6️⃣ 技术验证或临时分析

**创建临时文档**：
1. 在 `.cursor/docs/` 创建文档
2. 使用命名规范: `YYYY-MM-DD_HHmmss_描述.md`
3. 使用模板：

```markdown
# [临时] 技术验证/方案分析 - 简短描述

> **创建时间**: YYYY-MM-DD HH:MM:SS  
> **创建者**: Cursor AI  
> **状态**: 🔄 进行中 / ✅ 已完成 / ❌ 已废弃  
> **相关Issue/PR**: #123  

---

## 🎯 目的
简述为什么创建这个临时文档。

## 📊 验证/分析内容
[详细内容]

## ✅ 结论
[结论和建议]

## 📝 后续行动
- [ ] 如果方案被采纳 → 整理为 ADR 移到 `docs/03-decisions/`
- [ ] 如果是重要经验 → 移到 `docs/09-lessons-learned/`
- [ ] 如果废弃 → 标记状态为 ❌，保留供参考
```

---

## 7️⃣ Build-Check-Fix Cycle（必须遵守）

### 标准工作流
```
Write Code → xcodebuild build → Check errors → Fix → Repeat → Commit
```

### 何时运行 xcodebuild
✅ **应该运行**：
- 完成一个完整的文件后
- 完成一组相关文件后（如 ViewModel + View）
- 修复编译错误后（验证修复有效）
- 提交代码前（最终验证）

❌ **不应该运行**：
- 写了几行代码后（太频繁）
- 只修改注释/文档时
- 修改 `.md` 文档时

### xcodebuild 命令

**标准构建**（首次或重大变更）：
```bash
xcodebuild -scheme Epoch -destination 'generic/platform=iOS' build
```

**快速检查**（只看错误，跳过警告）：
```bash
xcodebuild -scheme Epoch -destination 'generic/platform=iOS' build 2>&1 | grep -E "error:|BUILD FAILED|BUILD SUCCEEDED"
```

**并行构建**（加快速度）：
```bash
xcodebuild -scheme Epoch -destination 'generic/platform=iOS' -parallel-testing-enabled YES build
```

### 错误处理原则
1. ✅ 仔细阅读错误信息，理解根本原因
2. ✅ 优先修复编译错误，再处理警告
3. ✅ 每次只修复一类错误，避免引入新问题
4. ✅ 修复后立即验证（再次运行 xcodebuild）
5. ✅ 所有错误修复后才提交代码

**禁止行为**：
- ❌ 删除报错的函数来"修复"错误
- ❌ 注释掉报错的代码来"修复"错误
- ❌ 用空实现替换报错的函数来"修复"错误
- ❌ 不理解原因就盲目修改代码

---

## 8️⃣ Git 工作流

### 分支命名
```bash
# 功能分支
feature/healthkit-integration
feature/training-plan-view
feature/ai-feedback

# 修复分支
fix/sync-conflict-resolution
fix/healthkit-authorization

# 紧急修复（从 main 拉出）
hotfix/critical-crash
hotfix/data-loss-bug
```

### Commit 格式（Conventional Commits）
```bash
# 格式：<type>(<scope>): <subject>
feat(log): add training log list view
fix(sync): resolve delete conflict
docs: update architecture diagram
refactor(mapper): simplify DTO conversion
test(log): add unit tests for mapper

# Type: feat, fix, docs, style, refactor, perf, test, build, ci, chore
# Scope: log, plan, sync, auth, healthkit, firebase, ui, model
```

---

## 9️⃣ 会话结束时

### Golden Context 生成（可选）

当用户说"今天先到这"、"休息一下"、"结束"等关键词时，**AI 应主动询问**：

> "这次会话我们完成了 [简要总结]。需要我生成一个 Golden Context 总结吗？这样下次会话可以快速恢复上下文。"

如果用户同意，创建文件：`.cursor/docs/YYYY-MM-DD_HHmmss_session-summary.md`

**Golden Context 模板**：
```markdown
# Golden Context - YYYY-MM-DD 会话总结

## 🎯 本次目标
[用户本次想完成什么]

## ✅ 完成的工作
1. [具体完成项 1] - 影响文件: `FileA.swift`, `FileB.swift`
2. [具体完成项 2] - 创建了 ADR-XXX
3. ...

## 📝 关键决策
- [决策 1]：为什么这样做
- [决策 2]：理由和权衡

## 🚧 未完成/阻塞点
- [ ] [待办事项 1]
- [ ] [待办事项 2]
- ⚠️ [阻塞问题]: 原因

## 🔗 相关文档
- ADR-XXX: [链接]
- 修改的文件: file-structure.md 已更新
- Changelog: 已记录到 07-changelog/YYYY-MM.md

## 🚀 下次会话建议
1. 从 [某个任务] 开始
2. 注意 [某个坑/风险]
3. 参考 [某个文档]

---
**会话时间**: YYYY-MM-DD HH:MM - HH:MM  
**完成度**: X/Y 个任务  
**下次优先级**: [P0/P1/P2]
```

### 何时跳过 Golden Context
- ❌ 只是简单询问（没有代码变更）
- ❌ 会话时间 <15 分钟
- ✅ 但如果有关键决策，即使短会话也建议记录

---

## 🔄 定期维护

### 每周任务
```markdown
- [ ] 检查 `.cursor/docs/` 中的临时文档
  - 已采纳的 → 整理为 ADR
  - 已废弃的 → 标记状态，保留 1 个月后删除
  
- [ ] 检查 `docs/07-changelog/`
  - 确保当月的 changelog 完整
  
- [ ] 检查 `docs/04-implementation/file-structure.md`
  - 确保与实际代码结构一致
```

---

**最后更新**: 2025-11-03  
**版本**: 1.0

