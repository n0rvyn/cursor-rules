---
description: "Epoch 项目概述 - 详细参考"
scopes: [chat, edit]
tags: [project-overview, epoch, ios, detailed-reference]
priority: 200
globs: []
alwaysApply: false
---

# Epoch 项目概述（详细参考）

> **注意**：本文件为详细参考，不会自动加载。  
> **核心规则**：见 `000-critical-rules.mdc`  
> **场景检查清单**：见 `100-XXX-checklist.mdc`  
> **项目状态**：见 `001-project-context.mdc`

---

> ⭐⭐⭐⭐⭐ **重要性：最高** - AI 助手的"入职文档"

---

## ✅ 首次会话检查清单

**重要**：每次新会话开始时，请先完成以下步骤，然后在回答开头确认。

### 必须执行的步骤

1. **读取本文档**（`00-project-overview.md`）- 了解项目背景和状态
2. **⭐ 检查主计划** - `docs/09-roadmap/mvp-plan.md` - 确认当前 Week X / 12，本周任务清单
3. **确认当前阶段** - 查看"项目状态"了解进度和下一步
4. **浏览关键决策文档索引** - 知道有哪 6 个关键领域
5. **查看最新 Changelog** - `docs/07-changelog/2025-11.md` 了解最近变更

### 推荐的确认格式

请在回答开头使用以下格式确认初始化完成：

```
✅ 已读取项目概述 - 当前 Week 3 / 12（数据流打通阶段）
✅ 已了解 6 个关键决策领域（订阅/同步/缓存/认证/数据模型/测试）
✅ 已查看最新变更（2025-11）

---

[开始回答用户问题]
```

💡 **提示**：遵循此检查清单可以确保你的回答基于最新的项目状态和约束。

---

## 📊 项目状态

| 项目 | 状态 | 备注 |
|------|------|------|
| **当前阶段** | 🚀 Week 3 启动 - 数据流打通 | Week 3 / 12 |
| **下一步** | Firebase SDK集成 + SwiftData缓存层 | Week 3-4 |
| **技术栈** | Swift 6.2 + iOS 26（兼容 iOS 18） | - |

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

## ⚠️ 三大铁律（绝不妥协）

1. **永不修改已完成的训练记录**
   - HealthKit 中的训练结果是唯一真相源
   - 只允许写入未来的训练计划（WorkoutKit）
   - 详见：[ADR-001](../../docs/03-decisions/001-healthkit-read-only.md)

2. **AI 必须遵循 UESCA 原则**
   - 见 `docs/05-prompts/uesca-principles.md`
   - 训练强度遵循 80/20 原则（80% 低强度，20% 高强度）
   - 循序渐进，避免过度训练

3. **性能指标必须达标**
   - 启动 <2s
   - AI 反馈 <5s
   - 缓存读取 <100ms

---

## 📚 关键决策文档索引（Critical ADRs）

> ⭐ 开发以下功能前，**必须先阅读**对应的 ADR 文档  
> 这些文档包含完整的决策过程、实现方案和关键约束

---

### § 1. 订阅与 Premium 功能

**何时必读**：
- 实现任何 AI API 调用功能
- 处理用户额度限制
- 验证 Premium 状态
- 实现收据验证或订阅管理

**文档位置**：
- 📄 `docs/03-decisions/ADR-011-subscription-implementation.md`（完整策略，7k字）
- 📄 `docs/01-product/subscription-tiers.md`（产品定义）

**核心约束**：
```markdown
⚠️ 所有 AI 功能调用前必须验证 Premium 状态

| 功能 | 免费用户 | Pro 用户 |
|------|---------|---------|
| AI 计划生成 | 1次/月 | 无限 |
| AI 即时反馈 | 3次/月 | 无限 |
| 对话式调整 | ❌ 不支持 | 无限 |
| 历史数据 | 90天 | 无限期 |

- Custom Claims: `user.customClaims['premium']`
- Premium 状态缓存：1 小时
- 收据验证：App Store Server API v2
```

---

### § 2. 离线同步与冲突解决

**何时必读**：
- 实现数据同步逻辑
- 处理多设备数据冲突
- 实现离线功能
- 设计 PendingSync 队列

**文档位置**：
- 📄 `docs/03-decisions/ADR-010-offline-sync-strategy.md`（完整策略）

**核心约束**：
```markdown
🔴 冲突解决规则（Critical - 必须遵守）：

⚠️ **MVP 阶段（Week 1-12）**：
- 所有数据类型统一使用 **Last Write Wins**（简化实现）
- 基于毫秒级时间戳 (lastModifiedMs) 判断

📅 **V1.1 实现（未来）**：
| 数据类型 | 冲突策略 | 原因 |
|---------|---------|------|
| 训练记录 (Log) | Last Write Wins | 用户数据，以最新为准 |
| 训练计划 (Plan) | Server Wins | AI 生成，服务端权威 |
| 用户配置 (Profile) | Merge | 字段级合并 |

离线优先原则（所有阶段）：
1. 读取优先本地（<100ms）
2. 写入先存本地（不阻塞用户）
3. 后台自动同步（检测网络后上传）
4. 使用 PendingSyncOperation 队列管理未同步数据
```

---

### § 3. 数据缓存分层策略

**何时必读**：
- 实现数据查询逻辑
- 处理历史数据访问
- 实现自动清理机制
- 设计查询路由

**文档位置**：
- 📄 `docs/04-implementation/data-caching-strategy.md`（完整策略）

**核心约束**：
```markdown
三层缓存架构（必须遵守）：

| Layer | 范围 | 存储 | 权限 | 性能 |
|-------|------|------|------|------|
| Layer 1 | 0-14天 | SwiftData 本地 | 所有用户 | <100ms |
| Layer 2 | 15-90天 | Firebase 云端 | 所有用户 | <500ms |
| Layer 3 | 91天+ | Firebase 归档 | ⚠️ 仅 Premium | <1s |

查询路由规则：
- 优先查询 Layer 1（本地）
- Layer 3 查询前必须验证 Premium 状态
- 每天 0 点自动清理超过 14 天的本地记录
```

---

### § 4. 认证与安全

**何时必读**：
- 实现 Backend API 调用
- 处理用户认证
- 验证 Token 和 Custom Claims
- 实现 Firebase Auth 集成

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

4. Token 刷新：
   - 自动刷新（Firebase SDK）
   - 失败时重新登录
```

---

### § 5. SwiftData 数据模型架构

**何时必读**：
- 创建或修改 SwiftData Model
- 实现数据关系（@Relationship）
- 处理数据迁移
- 实现 DTO ↔ Model 转换

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

---

### § 5.5. Firebase 数据结构与安全规则 ⭐⭐⭐⭐⭐

**何时必读**：
- 创建或修改 Firebase 数据保存/读取
- 修改 Firestore 路径
- 出现 "Permission denied" 错误
- 实现 GDPR 删除功能

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
   |------|------|---------|
   | trainingPlans | trainingPlans/{planId} | where('userId', '==', uid) |
   | trainingGoals | trainingGoals/{goalId} | where('userId', '==', uid) |
   | trainingLogs | trainingLogs/{logId} | where('userId', '==', uid) |

3. 嵌套结构仅用于"1对1强依赖"：
   ✅ users/{userId}/settings/profile（设置属于用户）
   ❌ users/{userId}/trainingPlans/{planId}（计划可独立查询）

4. 所有文档必须包含 userId 字段：
   - 用于 Security Rules 校验
   - 用于 GDPR 删除查询
   - 用于多设备同步过滤

5. Security Rules 检查清单：
   - [ ] 每个 collection 都有对应的 match 规则
   - [ ] 使用 isOwner(userId) 检查所有权
   - [ ] create 时校验 request.resource.data.userId
   - [ ] read/write 时校验 resource.data.userId

6. firebase-schema.md 是权威定义：
   - 优先级：firebase-schema.md > 代码实现
   - 如果代码与文档冲突，以文档为准
   - 修改数据结构必须先更新 firebase-schema.md
```

**常见错误**：
```markdown
❌ 错误1：随意发明路径（未查阅 firebase-schema.md）
   示例：users/{userId}/trainingPlans/framework
   
❌ 错误2：忘记添加 Security Rules
   结果：Permission denied 错误
   
❌ 错误3：使用嵌套结构（应该用扁平 + where 查询）
   问题：查询性能差，GDPR 删除复杂
   
❌ 错误4：文档缺少 userId 字段
   结果：Security Rules 失效，数据泄露风险
```

---

### § 6. 测试策略与覆盖率

**何时必读**：
- 编写单元测试
- 实现 Protocol 和 Mock
- 评估测试覆盖率
- 设计测试架构

**文档位置**：
- 📄 `docs/09-roadmap/testing-strategy.md`（完整策略）

**核心约束**：
```markdown
测试覆盖率要求（强制）：

| 模块 | 最低覆盖率 | 说明 |
|------|-----------|------|
| 数据层核心 (SwiftData CRUD, Mapper) | 100% | 🔴 必须 |
| 数据层整体 | ≥80% | 🟡 推荐 |
| 业务逻辑 (计算、验证) | ≥75% | 🔴 必须 |
| ViewModel | ≥70% | 🟡 推荐 |
| View (UI) | ≥30% | 🟢 可选 |

Protocol-based Mock（强制）：
- 所有 Service 必须先定义 Protocol
- 生产实现：{Service}
- 测试实现：Mock{Service}
- Mock 前缀用于测试，不能在生产代码中使用
```

---

## 🏗 技术架构

### 数据流向
```
HealthKit (读+写) ←─── 读取历史数据、写入训练计划
    ↓
SwiftData (本地缓存) ←─── 最近14天训练日志、当前周计划
    ↓
Firebase Firestore (云端存储) ←─── AI Backend分析
```

### 核心技术栈
- **语言**: Swift 6.2
- **UI**: SwiftUI (iOS 18+，推荐 iOS 26+)
- **开发工具**: Xcode 16+
- **数据持久化**: SwiftData（替代 CoreData）
- **健康数据**: Apple HealthKit（读取记录+写入计划）
- **云存储**: Firebase Firestore
- **后端**: Node.js + Express（搬瓦工 VPS）
- **AI**: OpenAI/Claude API（可切换）

详见：`docs/02-architecture.md`

---

## 📂 关键文档索引

### 必读文档（每次会话开始时）
1. **`docs/00-AI-CONTEXT.md`** - AI 助手必读，项目背景
2. **`docs/08-guidelines/coding-standards.md`** - 2000+ 行编码规范
3. **`docs/完整目录树.md`** - 文档结构

### 架构与设计
- **`docs/02-architecture.md`** - 完整技术架构
- **`docs/03-decisions/`** - ADR（架构决策记录）
- **`docs/04-implementation/`** - 实现细节
  - `swiftdata-schema.md` - 数据模型
  - `healthkit-integration.md` - HealthKit 策略
  - `api-spec.md` - Backend API 规范

### 开发规范
- **`docs/08-guidelines/coding-standards.md`** - Swift 6.2 + iOS 26 规范
  - 命名规范：`Cached` 前缀（SwiftData），`DTO` 后缀（Firebase），`Mock` 前缀（测试）
  - Git 工作流：Conventional Commits
  - 本地化规范：类型安全的 `LocalizedString` 枚举

### 项目计划
- **`docs/09-roadmap/mvp-plan.md`** - MVP 开发计划（4周）
- **`docs/06-discussions/mvp-plan-update.md`** - 最新 MVP 更新

---

## 🚫 绝对禁止

```markdown
❌ 在 `/docs` 外创建正式架构文档
❌ 修改代码后不更新 changelog
❌ 硬编码 API Key 或敏感信息
❌ 绕过依赖注入直接实例化 Service
❌ 在主线程做耗时操作
❌ 使用 force unwrap (!) 除非绝对安全
❌ 修改或删除 HealthKit 中的训练记录
```

---

## ✅ 必须遵循

```markdown
✅ 所有 Service 使用 Protocol 抽象
✅ 所有异步操作使用 async/await
✅ 所有错误必须处理（不能简单 try!）
✅ 所有 UI 组件提取为独立 View（>50 行）
✅ 所有测试使用 Mock（不依赖真实 API）
✅ 所有 ViewModel 标记 @MainActor
```

---

## 📋 架构级变更定义

以下变更必须创建 ADR（`docs/03-decisions/`）：
- 新增/修改数据模型的关系
- 修改认证/授权策略
- 修改数据同步策略
- 引入新的第三方库
- 修改项目结构
- 修改部署方式

**流程**:
1. 先创建临时文档到 `.cursor/docs/`
2. 讨论并确认方案
3. 整理为 ADR 移到 `docs/03-decisions/`
4. 更新 changelog

---

## 🔗 相关规则文件

- `01-workflow.md` - 工作流程（文档更新、Build-Check-Fix）
- `02-swift-ios-standards.md` - Swift/iOS 编码规范精简版
- `03-healthkit-integration.md` - HealthKit/WorkoutKit 集成模式
- `04-anti-overengineering.md` - 防止过度设计（证据优先）
- `05-quality-assurance.md` - 质量保证（防幻觉、行为保护）

---

**最后更新**: 2025-11-03  
**版本**: 1.0  
**维护者**: Epoch 开发团队

