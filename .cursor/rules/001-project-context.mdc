---
description: "项目状态与当前阶段（每次会话必读）"
scopes: [chat, edit]
tags: [project-status, current-week]
priority: 2
globs: ["**/*.swift"]
alwaysApply: true
---

# 项目状态与当前阶段

> **重要性**: ⭐⭐⭐⭐⭐ 最高优先级  
> **加载方式**: Always Applied  
> **更新频率**: 每周或每次重大变更后  

---

## 📊 当前阶段

| 项目 | 状态 | 备注 |
|---|---|---|
| **当前阶段** | 🚀 规则治理重构中 | 优化文档系统 |
| **当前 Week** | Week 8 / 12 | 规则系统重构（Phase 1-8） |
| **下一步** | 实战验证规则系统 | Week 8 实际开发验证（Phase 9） |
| **技术栈** | Swift 6.2 + iOS 26（兼容 iOS 18） | - |

---

## 🎯 Week 8 当前任务

### 主要任务
1. ✅ Phase 0: 验证 Auto-attach 机制
2. ✅ Phase 0: 测量实际 Token 消耗
3. 🚧 Phase 1-8: 执行规则治理计划
4. ⏳ Phase 9: 实战验证（1-2周）

### 预期成果
- Token 消耗降低 84%（从 ~50,000 降至 ~7,800）
- 上下文占用从 36% 降至 ~6%
- 可用窗口增加 56K tokens

---

## 🎯 项目定位

**基于 AI 的跑步训练教练 iOS App**

### 核心特点
- 🏃 从 HealthKit 读取训练记录，写入训练计划（**读记录+写计划**）
- 🤖 AI 生成个性化训练计划（遵循 UESCA 认证教练原则）
- 🎯 支持 5 种目标类型：比赛、距离、习惯养成、健康、纯享受
- ☁️ 用 Firebase 存储用户创建的内容
- 📊 自动分析训练数据，提供反馈

---

## 📚 关键决策文档索引（Critical ADRs）

> ⭐ 开发以下功能前，**必须先阅读**对应的 ADR 文档  
> 这些文档包含完整的决策过程、实现方案和关键约束

### § 1. 订阅与 Premium 功能

**何时必读**：实现任何 AI API 调用功能、处理用户额度限制、验证 Premium 状态

**文档位置**：
- 📄 `docs/03-decisions/ADR-011-subscription-implementation.md`（完整策略）
- 📄 `docs/01-product/subscription-tiers.md`（产品定义）

**核心约束**：
```markdown
⚠️ 所有 AI 功能调用前必须验证 Premium 状态

| 功能 | 免费用户 | Pro 用户 |
|---|---|---|
| AI 计划生成 | 1次/月 | 无限 |
| AI 即时反馈 | 3次/月 | 无限 |
| 对话式调整 | ❌ 不支持 | 无限 |
| 历史数据 | 90天 | 无限期 |
```

### § 2. 离线同步与冲突解决

**何时必读**：实现数据同步逻辑、处理多设备数据冲突、实现离线功能

**文档位置**：
- 📄 `docs/03-decisions/ADR-010-offline-sync-strategy.md`（完整策略）

**核心约束**：
```markdown
🔴 冲突解决规则（Critical）：

⚠️ **MVP 阶段（Week 1-12）**：
- 所有数据类型统一使用 **Last Write Wins**
- 基于毫秒级时间戳 (lastModifiedMs) 判断

离线优先原则：
1. 读取优先本地（<100ms）
2. 写入先存本地（不阻塞用户）
3. 后台自动同步（检测网络后上传）
4. 使用 PendingSyncOperation 队列管理未同步数据
```

### § 3. 数据缓存分层策略

**何时必读**：实现数据查询逻辑、处理历史数据访问、实现自动清理机制

**文档位置**：
- 📄 `docs/04-implementation/data-caching-strategy.md`（完整策略）

**核心约束**：
```markdown
三层缓存架构（必须遵守）：

| Layer | 范围 | 存储 | 权限 | 性能 |
|---|---|---|---|---|
| Layer 1 | 0-14天 | SwiftData 本地 | 所有用户 | <100ms |
| Layer 2 | 15-90天 | Firebase 云端 | 所有用户 | <500ms |
| Layer 3 | 91天+ | Firebase 归档 | ⚠️ 仅 Premium | <1s |
```

### § 4. 认证与安全

**何时必读**：实现 Backend API 调用、处理用户认证、验证 Token 和 Custom Claims

**文档位置**：
- 📄 `docs/03-decisions/ADR-009-backend-auth-strategy.md`（完整策略）

**核心约束**：
```markdown
Token 验证流程：

1. 所有 Backend 请求必须带 Firebase ID Token
   Header: Authorization: Bearer <token>

2. Custom Claims 检查：
   guard let isPremium = user.customClaims['premium'] as? Bool

3. MVP 阶段简化（Week 1-3）：
   - Backend 跳过 Token 验证
   - Week 4+ 启用完整验证
```

### § 5. SwiftData 数据模型架构

**何时必读**：创建或修改 SwiftData Model、实现数据关系、处理数据迁移

**文档位置**：
- 📄 `docs/04-implementation/swiftdata-schema.md`（完整架构）

**核心约束**：
```markdown
双 Model 架构（强制）：

Firebase DTO (struct, Codable) ↔ Mapper ↔ SwiftData Model (class, @Model)

关键规则：
1. 关系设计必须指定：@Relationship(deleteRule: .cascade)
2. 所有 Model 必须支持软删除：var deletedAt: Date?
3. 查询时过滤已删除：predicate: deletedAt == nil
4. 命名规范：
   - SwiftData Model: Cached{Entity}
   - Firebase DTO: {Entity}DTO
   - Mapper: {Entity}Mapper
```

### § 6. Firebase 数据结构与安全规则 ⭐⭐⭐⭐⭐

**何时必读**：创建或修改 Firebase 数据保存/读取、修改 Firestore 路径、出现 "Permission denied" 错误

**文档位置**：
- 📄 `docs/04-implementation/firebase-schema.md`（完整结构定义）
- 📄 `backend/firestore.rules`（安全规则文件）

**核心约束**：
```markdown
Firestore 路径规则（强制）：

1. 路径格式：collection/document/collection/document
   ✅ 正确：trainingPlans/{planId}（2段）
   ✅ 正确：users/{userId}/settings/profile（4段）
   ❌ 错误：users/{userId}/trainingPlans/framework（3段 - 奇数）

2. 扁平结构优先（性能考虑）：
   | 表名 | 路径 | 查询方式 |
   |---|---|---|
   | trainingPlans | trainingPlans/{planId} | where('userId', '==', uid) |
   | trainingGoals | trainingGoals/{goalId} | where('userId', '==', uid) |
   | trainingLogs | trainingLogs/{logId} | where('userId', '==', uid) |

3. 所有文档必须包含 userId 字段：
   - 用于 Security Rules 校验
   - 用于 GDPR 删除查询
   - 用于多设备同步过滤
```

### § 7. 测试策略与覆盖率

**何时必读**：编写单元测试、实现 Protocol 和 Mock、评估测试覆盖率

**文档位置**：
- 📄 `docs/09-roadmap/testing-strategy.md`（完整策略）

**核心约束**：
```markdown
测试覆盖率要求（强制）：

| 模块 | 最低覆盖率 | 说明 |
|---|-----|---|
| 数据层核心 (SwiftData CRUD, Mapper) | 100% | 🔴 必须 |
| 数据层整体 | ≥80% | 🟡 推荐 |
| 业务逻辑 (计算、验证) | ≥75% | 🔴 必须 |
| ViewModel | ≥70% | 🟡 推荐 |
| View (UI) | ≥30% | 🟢 可选 |
```

---

## 📝 最近变更（最近 3 条）

> **来源**: `docs/07-changelog/2025-11.md`

### 2025-11-08 - 规则治理计划启动

**Phase 0 验证完成**：
- ✅ Auto-attach 机制验证通过（globs + alwaysApply: false 工作正常）
- ✅ Token 消耗测量：~72,000 tokens（36% 占用）
- ✅ 辨证思考铁律建立（AI 错误案例总结）

**Phase 1-8 执行中**：
- 重构规则系统为三层架构
- 预期 token 节省 84%

### 2025-11-07 - Week 6-7 修复完成

**修复内容**：
- 修复 WeekPlanView 显示 bug
- 修复时区处理问题
- 真机测试通过

**教训**：
- 任务执行红线的重要性（不能跳过步骤）
- 编译验证必须看到 BUILD SUCCEEDED

### 2025-11-04 - Onboarding 5-Step 重构

**重大改进**：
- 从 9 步简化到 5 步（降低用户门槛）
- 自动填充 HealthKit 数据
- 预览计划功能

**产品原则**：
- MVP 原则：先丑后美
- 数据驱动：用户真的需要吗？
- 迭代思维：小步快跑

---

## 🚧 当前堵点

> **状态**: 无堵点

### 之前的堵点（已解决）

#### 1. 规则文档 Token 消耗过高 ✅
- **问题**: 8 个规则文件，~50,000 tokens，占用 36% 上下文
- **影响**: AI 响应速度慢，成本高
- **解决**: 正在实施规则治理计划（Phase 1-8）
- **预期**: Token 降至 ~7,800（84% 节省）

---

## 🔗 相关规则文件

- **000-critical-rules.mdc**: 核心铁律、辨证思考、任务执行红线
- **001-project-context.mdc**: 本文件（项目状态）
- **002-ai-checklist.mdc**: AI 自检清单
- **003-structured-decision-workflow.mdc**: 结构化决策流程 🆕
- **100-106**: 场景检查清单（自动加载）
- **200-208**: 详细参考（手动加载）
- **208-decision-support-detailed.mdc**: 结构化决策详细参考 🆕

---

**最后更新**: 2025-11-08  
**版本**: 1.0  
**Token 估算**: ~1,300 tokens  
**加载方式**: Always Applied  
**优先级**: 2

