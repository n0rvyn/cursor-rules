# Cursor Project Rules for Epoch

> **Version**: 2.0 🆕  
> **Last Updated**: 2025-11-08  
> **Status**: Active ✅  
> **Major Change**: 三层架构重构（Token 节省 84%）

---

## 📁 Rules Structure (3-Layer Architecture)

本目录包含 Epoch 项目的 Cursor AI Project Rules。这些规则采用**三层架构**，根据使用频率和场景自动加载，**大幅降低 Token 消耗**。

### 🎯 Why 3-Layer Architecture?

**问题**：
- 旧系统：8 个规则文件，~50,000 tokens，**全部 always-applied**
- 上下文占用：36%（200K 模型）
- AI 响应慢，成本高

**解决方案**：
- **Layer 1（核心规则）**: 3 个文件，~7,800 tokens，always-applied
- **Layer 2（场景检查清单）**: 7 个文件，~1,300 tokens/个，auto-attach（根据编辑的文件自动加载）
- **Layer 3（详细参考）**: 8 个文件，manual load（需要时手动引用）

**效果**：
- Token 消耗降低 **84%**（从 ~50,000 降至 ~7,800）
- 上下文占用降至 **~6%**（vs 36%）
- 可用窗口增加 **56K tokens**

---

## 📚 Files Overview

### Layer 1: 核心规则（Always Applied）⭐⭐⭐⭐⭐

| File | Priority | Token | Description |
|------|----------|-------|-------------|
| `000-critical-rules.mdc` | 1 | ~5,200 | 三大铁律、绝对禁止、必须遵守、辨证思考铁律、任务执行红线 |
| `001-project-context.mdc` | 2 | ~1,300 | 项目状态、当前 Week、关键决策文档索引、最近变更 |
| `002-ai-checklist.mdc` | 3 | ~1,300 | AI 自检清单、任务执行流程、文档更新规范 |
| `003-structured-decision-workflow.mdc` | 4 | ~680 | 结构化决策流程、复杂问题分析、方案对比标准 🆕 |

**总计**: ~8,480 tokens（每次会话自动加载）

> **🆕 新增**：结构化决策流程（2025-11-08）
> - 用于处理复杂问题、多方案对比、架构级决策
> - 包含 4 步标准流程：疑点识别 → 方案矩阵 → 逐项讨论 → 综合整合
> - 详细版见 `208-decision-support-detailed.mdc`

### Layer 2: 场景检查清单（Auto-Attach）🎯

| File | Priority | Token | Globs | 触发条件 |
|------|----------|-------|-------|---------|
| `100-firebase-checklist.mdc` | 100 | ~1,300 | `**/*Firebase*.swift` | 编辑 Firebase 文件时 |
| `101-healthkit-checklist.mdc` | 101 | ~1,300 | `**/*HealthKit*.swift` | 编辑 HealthKit 文件时 |
| `102-subscription-checklist.mdc` | 102 | ~1,000 | `**/*Subscription*.swift` | 编辑订阅文件时 |
| `103-sync-checklist.mdc` | 103 | ~800 | `**/*Sync*.swift` | 编辑同步文件时 |
| `104-testing-checklist.mdc` | 104 | ~600 | `**/*Test*.swift` | 编辑测试文件时 |
| `105-data-model-checklist.mdc` | 105 | ~800 | `**/*Model*.swift` | 编辑数据模型文件时 |
| `106-auth-checklist.mdc` | 106 | ~600 | `**/*Auth*.swift` | 编辑认证文件时 |

**特点**：
- ✅ 只在需要时加载（根据编辑的文件自动触发）
- ✅ 包含核心约束、操作前检查清单、常见错误
- ✅ 节省 token（不编辑相关文件时不加载）

### Layer 3: 详细参考（Manual Load）📖

| File | Priority | Description | 何时查阅 |
|------|----------|-------------|---------|
| `200-project-overview-detailed.mdc` | 200 | 项目概述、完整背景 | 新会话开始、不了解项目时 |
| `201-workflow-detailed.mdc` | 201 | 工作流程详解 | 不确定工作流程时 |
| `202-swift-standards-detailed.mdc` | 202 | Swift/iOS 编码规范 | 编写代码前、确认规范时 |
| `203-healthkit-integration-detailed.mdc` | 203 | HealthKit/WorkoutKit 集成详解 | 实现 HealthKit 功能时 |
| `204-anti-overengineering-detailed.mdc` | 204 | 防止过度设计详解 | 设计新功能、评估复杂度时 |
| `205-quality-assurance-detailed.mdc` | 205 | 质量保证详解 | 提交代码前、质量检查时 |
| `206-product-principles-detailed.mdc` | 206 | 产品设计原则详解 | 产品决策、优先级判断时 |
| `207-task-execution-detailed.mdc` | 207 | 任务执行红线详解 | 执行复杂任务、确认验收标准时 |
| `208-decision-support-detailed.mdc` | 208 | 结构化决策详解（8维评估、渐进式展示、案例库）🆕 v1.1 | 需要深入决策支持、方案评估时 |

**特点**：
- ✅ 不自动加载（节省 token）
- ✅ 包含完整的背景、示例、边界情况
- ✅ 在 Chat 中提及文件名即可加载

> **🆕 新增**：结构化决策详细参考（2025-11-08）
> - 完整的 8 维评估矩阵（技术可行性、成本、时间、风险等）
> - 基于 ADR 方法论的决策框架
> - Epoch 项目历史案例参考（Onboarding 简化、数据缓存分层等）
> - 常见陷阱与误区（过度设计、忽略证据等）
> 
> **✨ v1.1 更新**（2025-11-08）：
> - 添加"渐进式展示原则"（默认简洁，可选详细）
> - 添加"简化版模板"（次要疑点节省 48% 篇幅）
> - 明确展开/折叠评估表格的场景指导

---

## 🎯 Rule Hierarchy

```
User Rules (全局，跨项目)
    ↓
Layer 1: 核心规则（Always Applied，~7,800 tokens）
    ↓
Layer 2: 场景检查清单（Auto-Attach，按需加载）
    ↓
Layer 3: 详细参考（Manual Load，需要时引用）
    ↓
Project Documentation (docs/ 目录)
    ↓
Existing Code Patterns (实际代码)
```

### Token 消耗对比

| 场景 | 旧系统 | 新系统 | 节省 |
|------|-------|-------|------|
| **普通编辑**（如 View） | ~50,000 | ~7,800 | **84%** ↓ |
| **编辑 Firebase 文件** | ~50,000 | ~9,100 | **82%** ↓ |
| **编辑 HealthKit 文件** | ~50,000 | ~9,100 | **82%** ↓ |
| **上下文占用**（200K 模型） | 36% | ~6% | **30%** ↓ |

---

## 📖 Quick Reference

### For New Contributors

**First Time Setup:**
1. Read `000-critical-rules.mdc` - 核心铁律（必读）
2. Read `001-project-context.mdc` - 项目当前状态
3. Read `002-ai-checklist.mdc` - AI 工作流程

**Before Writing Code:**
1. 核心规则会自动加载（Layer 1）
2. 场景规则会根据你编辑的文件自动加载（Layer 2）
3. 需要详细参考时，在 Chat 中提及文件名（Layer 3）

**Before Committing:**
1. Run Build-Check-Fix cycle（`002-ai-checklist.mdc`）
2. Update `file-structure.md` and changelog
3. Review 质量检查清单

### For AI Assistants

**Every Session Start:**
```markdown
✅ 自动加载 Layer 1（核心规则，~7,800 tokens）
✅ 在回复开头确认："✅ 已读取核心铁律 + 当前 Week X/12"
```

**When Editing Files:**
```markdown
✅ Layer 2 场景规则自动加载（根据文件模式）
例如：编辑 FirebaseService.swift → 自动加载 100-firebase-checklist.mdc
```

**When Need Details:**
```markdown
✅ 在 Chat 中提及文件名，手动加载 Layer 3
例如："请参考 203-healthkit-integration-detailed.mdc"
```

**Before Implementation:**
- ⭐ 检查 `001-project-context.mdc` 的"关键决策文档索引"
- ⭐ 阅读相关的完整 ADR（如 ADR-011 订阅、ADR-010 同步）
- ✅ 场景规则会自动提示需要阅读的文档
- ✅ 遵循辨证思考铁律（`000-critical-rules.mdc`）

**During Implementation:**
- ✅ 遵循任务执行红线（逐项完成、失败必停）
- ✅ 保护现有行为（Preserve existing behavior）
- ✅ 保持变更最小化（Minimal changes）

---

## 🔄 Rule Updates

### When to Update Rules

- ✅ When project architecture changes → Update `001-project-context.mdc`
- ✅ When new patterns are established → Update relevant Layer 2 checklist
- ✅ When common issues are identified → Strengthen Layer 1 constraints
- ✅ When technology stack changes → Update `202-swift-standards-detailed.mdc`

### How to Update Rules

1. **Propose Change**: Create temporary doc in `.cursor/docs/`
2. **Discuss**: Review with team
3. **Update Rule**: Modify relevant `.cursor/rules/*.mdc` file
4. **Document**: Add to changelog (`docs/07-changelog/YYYY-MM.md`)
5. **Version Bump**: Update version in file header

---

## 📚 Related Documentation

### Project Documentation (Main Source of Truth)
- **`docs/00-AI-CONTEXT.md`** - Project background and current status
- **`docs/02-architecture.md`** - Complete technical architecture
- **`docs/03-decisions/`** - ADRs (Architecture Decision Records)
- **`docs/08-guidelines/coding-standards.md`** - Full coding standards (2000+ lines)
- **`docs/09-lessons-learned/`** - 经验教训（含辨证思考铁律背景）

### Cursor Configuration
- **`.cursorrules`** - ⚠️ Deprecated（已弃用）
- **`.cursor/rules/`** - **✅ Current**（本目录，三层架构）
- **User Rules** - Global rules configured in Cursor settings

---

## 🚨 Critical Reminders

### 三大铁律（绝不妥协）

1. **永不修改已完成的训练记录**
   - HealthKit 数据是唯一真相源
   - 只写入未来的训练计划（WorkoutKit）

2. **AI 必须遵循 UESCA 原则**
   - 见 `docs/05-prompts/uesca-principles.md`
   - 80/20 训练强度比例

3. **性能指标必须达标**
   - 启动 <2s
   - AI 反馈 <5s
   - 缓存读取 <100ms

### 辨证思考铁律 ⭐⭐⭐⭐⭐（新增）

> **背景**: 2025-11-08 规则治理讨论中的重大教训  
> **完整背景**: `docs/09-lessons-learned/2025-11-08_dialectical-thinking-lesson.md`

**核心原则**：
1. **区分"不知道"和"知道不存在"**
   - ❌ "我找不到文档，所以不存在"
   - ✅ "我找不到文档，建议测试验证"

2. **优先实验验证**
   - 证据层级：实验 > 文档 > 推测
   - 找不到文档时，设计实验验证

3. **承认错误**
   - 发现错误立即承认
   - 说明原因，避免重复

4. **用户也可能错**
   - 辨证看待，不盲目服从或反对
   - 发现错误礼貌但明确指出

5. **禁止模棱两可**
   - 不用"可能"、"大概"、"应该"
   - 明确说"我不知道，建议验证"

### 任务执行红线 🔴

**⚠️ 绝对禁止违反**:

1. **逐项执行**: 每个步骤必须完成并验收后才能继续
2. **失败必停**: 任何失败或未完成时，立即停止，等待明确允许
3. **验收明确**: 编译=xcodebuild 通过，部署=服务 running，测试=明确结果
4. **等待允许**: 不能自己决定"先做其他的"或"这步可以跳过"

**记住**：
> "任何步骤失败或未完成时，立即停止，等待明确允许。"

---

## 🔗 External Resources

### Official Documentation
- **Swift API Design Guidelines**: https://www.swift.org/documentation/api-design-guidelines/
- **Apple Developer Documentation**: https://developer.apple.com/documentation/
- **SwiftData**: https://developer.apple.com/documentation/swiftdata
- **HealthKit**: https://developer.apple.com/documentation/healthkit
- **Cursor Rules Documentation**: https://docs.cursor.com/context/rules-for-ai

### Community Resources
- **Swift Evolution**: https://github.com/apple/swift-evolution
- **WWDC Videos**: https://developer.apple.com/videos/

---

## 📝 Maintenance Log

| Date | Change | Version | Author |
|------|--------|---------|--------|
| 2025-11-03 | Initial rule set created | 1.0 | AI + Developer |
| | - Created 6 rule files | | |
| | - Migrated from `.cursorrules` | | |
| 2025-11-07 | Added product and task execution rules | 1.1 | AI + Developer |
| | - Added `06-product-principles.md` | | |
| | - Added `07-task-execution-redline.md` | | |
| 2025-11-08 | 🆕 三层架构重构（Major Change） | 2.0 | AI + Developer |
| | - **Token 节省 84%**（~50K → ~7.8K） | | |
| | - Phase 0 验证（Auto-attach 机制） | | |
| | - 辨证思考铁律建立 | | |
| | - Layer 1: 3 核心规则（Always） | | |
| | - Layer 2: 7 场景检查清单（Auto） | | |
| | - Layer 3: 8 详细参考（Manual） | | |
| | - 上下文占用从 36% 降至 ~6% | | |

---

## ❓ FAQ

### Q1: 为什么要三层架构？

**A**: 旧系统 8 个规则文件全部 always-applied，导致 ~50,000 tokens 占用（36% 上下文）。新系统根据使用频率分层，**token 节省 84%**。

### Q2: Auto-attach 是如何工作的？

**A**: 
- Layer 2 文件使用 `globs` 模式（如 `**/*Firebase*.swift`）
- 当你编辑匹配文件时，Cursor **自动加载**对应的规则
- 不编辑时不加载，节省 token

**示例**：
```markdown
编辑 Epoch/Services/FirebaseService.swift
  ↓
Cursor 自动加载 100-firebase-checklist.mdc
  ↓
AI 看到 Firebase 核心约束和检查清单
```

### Q3: 如何手动加载 Layer 3 详细参考？

**A**: 在 Chat 中提及文件名即可：
```markdown
"请参考 203-healthkit-integration-detailed.mdc"
"我需要查看 HealthKit 集成的详细文档"
```

### Q4: 三层架构会影响 AI 的规则遵守吗？

**A**: 
- ✅ **不会**。核心铁律（Layer 1）仍然 always-applied
- ✅ **更好**。场景规则按需加载，更专注相关约束
- ✅ **更快**。减少 token 负担，AI 响应更快

### Q5: 我需要更新所有文档吗？

**A**: 
- **Layer 1（核心规则）**: 重大变更时更新
- **Layer 2（场景检查清单）**: 新增约束或常见错误时更新
- **Layer 3（详细参考）**: 完整背景、示例、边界情况

### Q6: 辨证思考铁律是什么？

**A**: 2025-11-08 建立的 AI 工作原则，要求：
1. 区分"不知道"和"知道不存在"
2. 优先实验验证（不纯推测）
3. 承认错误
4. 用户也可能错（辨证看待）
5. 禁止模棱两可

**背景**: 见 `docs/09-lessons-learned/2025-11-08_dialectical-thinking-lesson.md`

### Q7: 如何验证三层架构有效？

**A**: 
1. 开启新会话，检查 token 占用（应该 ~6%）
2. 编辑 Firebase 文件，确认 100-firebase-checklist.mdc 自动加载
3. 编辑 View 文件，确认只加载核心规则（不加载场景规则）

---

**For questions or suggestions, update this README or discuss with the team.**

---

**Last Updated**: 2025-11-08  
**Maintained By**: Epoch Development Team  
**Version**: 2.0（三层架构）
