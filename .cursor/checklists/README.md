# Checklist 系统使用指南

> **创建时间**: 2025-11-08  
> **版本**: v1.0

---

## 📚 文件组织

```
.cursor/
└── checklists/                           ← 📋 所有Checklist集中
    ├── epoch/                            ← 🟩 Epoch定制版（6个）
    │   ├── FIX-CHECKLIST.md
    │   ├── CODE-REVIEW-CHECKLIST.md
    │   ├── REFACTOR-CHECKLIST.md
    │   ├── DECISION-CHECKLIST.md
    │   ├── PLAN-CHECKLIST.md
    │   └── WEEKLY_VERIFICATION_CHECKLIST.md
    │
    ├── general/                          ← 🟦 通用版（6个）
    │   ├── FIX-CHECKLIST.md
    │   ├── CODE-REVIEW-CHECKLIST.md
    │   ├── REFACTOR-CHECKLIST.md
    │   ├── DECISION-CHECKLIST.md
    │   ├── PLAN-CHECKLIST.md
    │   └── WEEKLY_VERIFICATION_CHECKLIST.md
    │
    └── docs/                             ← 📄 文档（4个）
        ├── README.md                     ← 📖 本文件
        ├── SYSTEM-SUMMARY.md             ← 📊 系统总结
        ├── COMPARISON.md                 ← 🔍 详细对比
        └── FINAL-SUMMARY.md              ← ✅ 完成总结
```

---

## 🎯 快速选择：使用哪个版本？

### 使用 Epoch 定制版 ✅ **推荐（日常开发）**

**适用场景**：
- ✅ Epoch 项目的日常开发工作
- ✅ 代码审查（有明确的Epoch标准）
- ✅ 新人 onboarding（快速了解项目约束）
- ✅ Bug 修复（包含三大铁律检查）
- ✅ 自动化验证（可执行的检查脚本）

**优势**：
- ⭐ 精确匹配Epoch项目（减少误判）
- ⭐ 包含三大铁律（HealthKit/UESCA/性能）
- ⭐ 具体命令（可直接执行）
- ⭐ 可验证脚本（自动化检查）

**引用方式**：
```markdown
在 Cursor Chat 中：
@checklists/epoch/FIX-CHECKLIST.md        # 修复bug
@checklists/epoch/CODE-REVIEW-CHECKLIST.md # 代码审查
@checklists/epoch/REFACTOR-CHECKLIST.md    # 重构代码
```

---

### 使用通用版 🟦 **备选（学习/分享）**

**适用场景**：
- 🔵 学习checklist背后的方法论
- 🔵 作为模板创建其他项目的checklist
- 🔵 分享给他人（不暴露Epoch项目细节）
- 🔵 新项目初期（技术栈未定）

**优势**：
- ⭐ 开箱即用（任何Swift/iOS项目）
- ⭐ 迁移0成本（直接复制）
- ⭐ 方法论清晰（易于理解）

**引用方式**：
```markdown
在 Cursor Chat 中：
@checklists/general/FIX-CHECKLIST.md
@checklists/general/CODE-REVIEW-CHECKLIST.md
```

---

## 📖 使用示例

### 示例 1：修复 Bug

```markdown
User在Chat中：
"Tab 2 点击崩溃，请使用 @checklists/epoch/FIX-CHECKLIST.md 修复"

AI会：
1. ✅ 读取 Epoch 定制版 FIX-CHECKLIST.md
2. ✅ Phase 1: 问题识别（复现步骤 + 错误日志）
3. ✅ Phase 2: 根因分析（5 Why + 检查三大铁律）
4. ✅ Phase 3: 修复方案（至少2个对比）
5. ✅ Phase 4: 三级验证
   - 编译：cd /Users/norvyn/Code/Projects/Epoch && xcodebuild
   - 检查铁律：grep -r "HKHealthStore.*delete" Epoch/
   - 真机测试
6. ✅ Phase 5: 防复发（文档 + 测试）
```

---

### 示例 2：提交代码前

```markdown
User在Chat中：
"请使用 @checklists/epoch/CODE-REVIEW-CHECKLIST.md 审查我的代码"

AI会：
1. ✅ Phase 1: 架构检查
   - MVVM：View → ViewModel → Service
   - actor：Service必须是actor
   - @MainActor：ViewModel必须@MainActor

2. ✅ Phase 2: 代码质量
   - 命名规范：Cached/DTO/Mapper前缀
   - 无硬编码：使用LocalizedString
   
3. ✅ Phase 3: Swift规范
   - 并发：async/await，不用闭包
   
4. ✅ Phase 4: 测试覆盖
   - 数据层核心：100%
   - 整体：≥70%

5. ✅ Phase 5-8: 文档/数据流/性能/编译

6. ✅ Epoch特定检查
   - grep "HKHealthStore.*delete" → 0结果
   - find Epoch/Models -name "*.swift" | grep -v "Cached"
```

---

### 示例 3：重构代码

```markdown
User在Chat中：
"我想重构 HealthKitService（10个文件，500行），
请使用 @checklists/epoch/REFACTOR-CHECKLIST.md 评估"

AI会：
1. ✅ Phase 1: 重构前评估
   - 目的：拆分为3个Service
   - 时机：测试覆盖75%，可以重构
   - 影响：10个文件，500行
   - ⚠️ Epoch约束：>5文件，必须征得用户批准

2. ⏸️  停止并询问：
   "这次重构影响10个文件（>5个Epoch阈值），
    是否批准？请确认后我再继续。"

3. ✅ 用户批准后，继续：
   - Phase 2: 重构策略（分3个阶段）
   - Phase 3: 小步快跑
   - Phase 4: 验证（测试+回归+性能）
   - Phase 5: 清理总结
```

---

## 🔍 详细对比

**想了解通用版和Epoch版的具体差异？**

查看：`@checklists/docs/COMPARISON.md`

**核心差异总结**：
| 维度 | 通用版 | Epoch版 |
|------|--------|---------|
| 技术栈 | 不指定 | Swift 6.2 + SwiftUI + SwiftData + Firebase |
| 命名规范 | 建议 | **强制** Cached/DTO/Mapper |
| 三大铁律 | 无 | **有**（每个checklist都检查） |
| 验证命令 | 通用 | **具体**（Epoch项目路径 + 脚本） |
| 可验证性 | 低 | **高**（可自动化） |

---

## 🛠 高级用法

### 1. 只引用特定章节

如果不想加载整个checklist，可以引用特定章节：

```markdown
# 只看Epoch特定约束
@checklists/epoch/FIX-CHECKLIST.md#epoch-项目特定约束

# 只看Phase 4验证
@checklists/epoch/FIX-CHECKLIST.md#phase-4
```

---

### 2. 组合使用多个checklist

复杂任务可以组合使用：

```markdown
"我要修复一个bug，然后重构相关代码。
请使用 @checklists/epoch/FIX-CHECKLIST.md 修复bug，
然后使用 @checklists/epoch/REFACTOR-CHECKLIST.md 评估重构。"
```

---

### 3. 创建项目特定的检查点

在Epoch版的基础上，添加Week特定的检查：

```markdown
"请使用 @checklists/epoch/CODE-REVIEW-CHECKLIST.md 审查代码，
并额外检查：
- [ ] 是否遵循 ADR-014 的计划生成策略？
- [ ] 是否处理了 Week 7 的detailedWeeks字段？"
```

---

## 📋 完整工作流程

### Week 开始
```
1. @checklists/epoch/PLAN-CHECKLIST.md
   - 创建 Week Plan
   - 研读 MVP Plan + ADR
   - 交叉验证
```

### 执行 Week Plan
```
2a. 修复Bug → @checklists/epoch/FIX-CHECKLIST.md
    - 根因分析
    - 三级验证
    - 防复发

2b. 写新代码 → @checklists/epoch/CODE-REVIEW-CHECKLIST.md
    - 提交前自检
    - 架构 + 质量 + 测试

2c. 重构代码 → @checklists/epoch/REFACTOR-CHECKLIST.md
    - 重构前评估
    - 小步快跑
    - 行为不变

2d. 做决策 → @checklists/epoch/DECISION-CHECKLIST.md
    - 方案对比
    - 证据支持
    - 是否需要ADR
```

### Week 完成
```
3. @checklists/epoch/WEEKLY_VERIFICATION_CHECKLIST.md
   - Build验证
   - 代码审查
   - 真机测试
   - 文档更新
```

---

## 🔧 维护指南

### Epoch版维护

**更新场景**：
- ✅ 项目约束变化（如新增第4条铁律）
- ✅ 技术栈升级（如Swift 7.0）
- ✅ 命名规范调整
- ✅ ADR增加

**更新步骤**：
1. 修改对应的 Epoch 版 checklist（在 `checklists/epoch/`）
2. 更新 `checklists/docs/COMPARISON.md`（记录差异）
3. 记录到 `docs/07-changelog/2025-11.md`
4. 通知团队（如果有）

**更新频率**：每月审查一次

---

### 通用版维护

**更新场景**：
- ✅ 方法论改进（如发现更好的分析方法）
- ✅ 通用最佳实践更新

**更新步骤**：
1. 修改 `checklists/general/` 下的文件
2. **不要**同步到Epoch版（除非有充分理由）
3. 记录到 `checklists/docs/COMPARISON.md`

**更新频率**：每季度/半年审查一次

---

## ❓ 常见问题

### Q1: 我应该用哪个版本？

**A**: 
- **日常开发** → Epoch版 ✅
- **学习/分享** → 通用版

---

### Q2: 两个版本的内容会不会冲突？

**A**: 不会。两者独立维护：
- 通用版：方法论（稳定，少变）
- Epoch版：方法论 + 项目约束（更新频繁）

---

### Q3: 如果我要创建第2个iOS项目，怎么办？

**A**: 两种方案：

**方案1**：基于通用版创建新项目的定制版
```bash
# 复制通用版
cp checklists/general/*.md project2-checklists/

# 修改为Project2约束
# 只需修改"项目特定约束"章节
```

**方案2**：基于Epoch版修改
```bash
# 复制Epoch版
cp checklists/epoch/*.md project2-checklists/

# 替换所有Epoch特定内容
# 预计时间：3-4小时
```

**推荐**：方案1（基于通用版）

---

### Q4: Epoch版的文件更长，会不会影响AI性能？

**A**: 影响很小：
- 单个checklist增加：+100-200 tokens
- 占1M上下文：+0.01-0.02%
- 实际可忽略

**并且**：精确性提升带来的效率增益 > token成本

---

### Q5: 我修改了Epoch版，需要同步到通用版吗？

**A**: 看情况：
- **项目特定约束**（三大铁律、命名规范） → **不需要**同步
- **方法论改进**（如更好的5 Why方法） → **可以**同步到通用版

**原则**：
- 项目特有的 → 只改Epoch版
- 通用适用的 → 两者都改（可选）

---

## 🚀 快速上手

### 新人5分钟快速入门

1. **阅读本文件**（5分钟）
2. **选择版本**：Epoch版（日常） / 通用版（学习）
3. **试用一次**：
   ```markdown
   在Chat中："请使用 @checklists/epoch/CODE-REVIEW-CHECKLIST.md 
   解释一下提交代码前需要检查什么"
   ```
4. **遇到问题**：查看 `@checklists/docs/COMPARISON.md`

---

## 📚 相关文档

- `checklists/docs/SYSTEM-SUMMARY.md` - 系统总结（新增4个+改进2个）
- `checklists/docs/COMPARISON.md` - 通用版vs Epoch版详细对比
- `docs/00-AI-CONTEXT.md` - Epoch项目概述
- `.cursor/rules/000-critical-rules.mdc` - 三大铁律详细说明

---

## 📊 效果跟踪

**想要跟踪checklist的使用效果？**

建议记录：
```markdown
文件：.cursor/docs/YYYY-MM-DD_Checklist_Usage_Log.md

## 使用记录

| 日期 | Checklist | 场景 | 发现问题数 | 解决时间 |
|------|-----------|------|-----------|---------|
| 2025-11-08 | FIX | Tab 2崩溃 | 3（根因+命名+测试） | 30分钟 |
| 2025-11-09 | CODE-REVIEW | 提交前 | 2（@MainActor+硬编码） | 10分钟 |

## 改进建议

- [ ] Checklist X 的 Phase Y 不够清晰
- [ ] 建议增加 Z 的检查点
```

---

**版本**: v1.0  
**创建时间**: 2025-11-08  
**维护者**: Epoch Team

**下次审查时间**：2025-12-08（1个月后）

