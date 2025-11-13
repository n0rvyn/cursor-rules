# Checklist 系统索引

> **快速参考**：所有 Checklist 的入口  
> **最后更新**：2025-11-08（目录结构扁平化）  

---

## 📂 目录结构

```
checklists/
├── INDEX.md                            ← 📖 本文件（快速索引）
├── README.md                            ← 📄 使用指南
│
├── FIX-CHECKLIST.md                     ← 🐛 修复 Bug
├── CODE-REVIEW-CHECKLIST.md             ← ✅ 代码审查
├── REFACTOR-CHECKLIST.md                ← 🔄 重构代码
├── DECISION-CHECKLIST.md                ← 🎯 架构决策
├── PLAN-CHECKLIST.md                    ← 📋 制定周计划
└── WEEKLY_VERIFICATION_CHECKLIST.md     ← 🎉 周验收
```

---

## 🎯 快速选择：我该用哪个？

### 场景 1：修复 Bug
```markdown
@checklists/FIX-CHECKLIST.md
```
**包含**：
- ✅ 问题识别（复现步骤 + 日志分析）
- ✅ 根因分析（5 Why + 三大铁律检查）
- ✅ 修复方案（至少2个对比）
- ✅ 三级验证（编译 + 规范 + 真机）
- ✅ 防复发（文档 + 测试）

---

### 场景 2：提交代码前
```markdown
@checklists/CODE-REVIEW-CHECKLIST.md
```
**包含**：
- ✅ 架构检查（MVVM + actor + @MainActor）
- ✅ 代码质量（命名规范 + 无硬编码 + 无主线程阻塞）
- ✅ Swift 规范（async/await + 错误处理）
- ✅ 测试覆盖（≥70%）
- ✅ 文档更新（file-structure.md + changelog）
- ✅ 数据流验证（Firebase → SwiftData → UI）
- ✅ 性能检查（启动 <2s + AI反馈 <5s + 查询 <100ms）
- ✅ 编译验证（BUILD SUCCEEDED）

---

### 场景 3：重构代码
```markdown
@checklists/REFACTOR-CHECKLIST.md
```
**包含**：
- ✅ 重构前评估（目的 + 时机 + 影响 + 风险）
- ✅ 范围判断（>200行 或 >5文件 → 必须征得用户批准）
- ✅ 重构策略（Extract Method / Encapsulate Field / ...）
- ✅ 小步快跑（一次只做一件事）
- ✅ 行为不变（重构前后测试100%通过）
- ✅ 性能对比（重构前后性能不退化）

---

### 场景 4：做架构决策
```markdown
@checklists/DECISION-CHECKLIST.md
```
**包含**：
- ✅ 决策级别判断（是否需要 ADR？）
- ✅ 方案对比（至少2-3个方案 + 证据支持）
- ✅ 8维度评估（技术可行性 + 成本 + 风险 + ...）
- ✅ Epoch 技术约束（三大铁律 + 技术栈限制）
- ✅ 证据优先（ADR > 测试数据 > 官方文档 > 推测）

---

### 场景 5：制定周计划
```markdown
@checklists/PLAN-CHECKLIST.md
```
**包含**：
- ✅ 研读 MVP Plan（理解本周目标）
- ✅ 识别关键疑点（2-5个）
- ✅ 交叉验证（ADR + file-structure.md + 技术文档）
- ✅ 任务拆解（每个任务 <4小时）
- ✅ 验收标准（具体可测量）
- ✅ 风险预判（技术 + 时间 + 依赖）

---

### 场景 6：周验收
```markdown
@checklists/WEEKLY_VERIFICATION_CHECKLIST.md
```
**包含**：
- ✅ Build 验证（BUILD SUCCEEDED）
- ✅ 编译验证（0 个编译错误）
- ✅ 代码审查（架构 + 质量 + 测试）
- ✅ 真机测试（核心功能 + 回归 + 性能）
- ✅ 文档更新（file-structure.md + changelog + ADR）
- ✅ 验收评分（通过标准 + 加分项）

---

## 🎯 Checklist 特点

所有 Checklist 都针对 **Epoch 项目**定制，包含：

| 特性 | 说明 |
|------|------|
| **技术栈** | Swift 6.2 + SwiftUI + SwiftData + Firebase |
| **三大铁律** | ✅ 每个 checklist 都检查（HealthKit 只读、UESCA 原则、性能指标） |
| **命名规范** | 🔴 强制（Cached/DTO/Mapper 命名约定） |
| **验证命令** | ✅ 具体可执行（xcodebuild、swift test 等） |
| **项目约束** | ✅ 包含 Epoch 特定的架构约束和最佳实践 |

---

## 🚀 快速上手

### 1️⃣ 新人 5 分钟入门

```markdown
1. 阅读本文件（INDEX.md）- 2分钟
2. 阅读 README.md - 3分钟
3. 试用一次：
   "请使用 @checklists/CODE-REVIEW-CHECKLIST.md
    解释一下提交代码前需要检查什么"
```

---

### 2️⃣ 典型工作流程

```
Week 开始
  ↓
@checklists/PLAN-CHECKLIST.md
  ↓
执行计划
  ├─ Bug 修复 → @checklists/FIX-CHECKLIST.md
  ├─ 写代码 → @checklists/CODE-REVIEW-CHECKLIST.md
  ├─ 重构 → @checklists/REFACTOR-CHECKLIST.md
  └─ 决策 → @checklists/DECISION-CHECKLIST.md
  ↓
Week 完成
  ↓
@checklists/WEEKLY_VERIFICATION_CHECKLIST.md
```

---

## 📖 详细文档

- **使用指南**：`@checklists/README.md`
  - 完整使用示例
  - 维护指南
  - 常见问题

---

## 🔧 维护

### 更新 Checklist（定期审查）

**触发条件**：
- 项目约束变化（如新增铁律）
- 技术栈升级（如 Swift 7.0）
- 命名规范调整
- 新增 ADR
- 方法论改进（如更好的 5 Why 方法）

**步骤**：
1. 修改 `checklists/` 下对应的 checklist 文件
2. 更新本文件（INDEX.md）中的相关引用
3. 记录到 `docs/07-changelog/YYYY-MM.md`

**频率**：每月审查一次

---

## ❓ 常见问题

### Q1: Checklist 文件较长，会影响 AI 性能吗？
**A**: 影响很小（+0.01-0.02% 上下文），精确性提升 > token 成本。建议按需引用特定 checklist。

### Q2: 如何为其他项目创建 Checklist？
**A**: 复制现有 checklist 文件，修改"项目特定约束"章节，替换 Epoch 特定的技术栈和命名规范。

### Q3: 如何快速找到需要的 Checklist？
**A**: 使用本文件（INDEX.md）的"快速选择"部分，或直接使用 `@checklists/文件名` 引用。

---

**版本**：v1.0  
**创建时间**：2025-11-08  
**维护者**：Epoch Team  
**下次审查**：2025-12-08

