# Rules 目录重组计划

> **问题**: 当前有 69 个规则文件，但 README.md 只列出了 19 个文件（三层架构）
> **目标**: 重组文件以符合三层架构，消除编号冲突，明确文件归属

---

## 🔍 当前问题分析

### 1. 编号冲突

#### Layer 1 冲突（000-003）
- ✅ `000-critical-rules.mdc` - **保留**（Layer 1）
- ❌ `001-base.mdc` - **冲突**（通用规则，与 001-project-context.mdc 冲突）
- ✅ `001-project-context.mdc` - **保留**（Layer 1）
- ❌ `002-chunked-read.mdc` - **冲突**（通用规则，与 002-ai-checklist.mdc 冲突）
- ✅ `002-ai-checklist.mdc` - **保留**（Layer 1）
- ❌ `003-plan-act-workflow.mdc` - **冲突**（通用规则，与 003-structured-decision-workflow.mdc 冲突）
- ✅ `003-structured-decision-workflow.mdc` - **保留**（Layer 1）

#### Layer 2 冲突（100-106）
- ✅ `100-firebase-checklist.mdc` - **保留**（Layer 2，Epoch 特定）
- ❌ `100-python-specific.mdc` - **冲突**（语言特定，非 Epoch）
- ❌ `101-go-specific.mdc` - **冲突**（语言特定，非 Epoch）
- ✅ `101-healthkit-checklist.mdc` - **保留**（Layer 2，Epoch 特定）
- ✅ `102-subscription-checklist.mdc` - **保留**（Layer 2）
- ✅ `103-sync-checklist.mdc` - **保留**（Layer 2）
- ✅ `104-testing-checklist.mdc` - **保留**（Layer 2）
- ❌ `105-bash-conventions.mdc` - **冲突**（语言特定，非 Epoch）
- ✅ `105-data-model-checklist.mdc` - **保留**（Layer 2）
- ✅ `106-auth-checklist.mdc` - **保留**（Layer 2）

#### Layer 3 冲突（200-208）
- ❌ `200-api-design.mdc` - **冲突**（通用规则，与 200-project-overview-detailed.mdc 冲突）
- ✅ `200-project-overview-detailed.mdc` - **保留**（Layer 3）
- ❌ `201-bugbot-autofix.mdc` - **冲突**（工具特定，与 201-workflow-detailed.mdc 冲突）
- ✅ `201-workflow-detailed.mdc` - **保留**（Layer 3）
- ✅ `202-swift-standards-detailed.mdc` - **保留**（Layer 3）
- ✅ `203-healthkit-integration-detailed.mdc` - **保留**（Layer 3）
- ✅ `204-anti-overengineering-detailed.mdc` - **保留**（Layer 3）
- ✅ `205-quality-assurance-detailed.mdc` - **保留**（Layer 3）
- ✅ `206-product-principles-detailed.mdc` - **保留**（Layer 3）
- ✅ `207-task-execution-detailed.mdc` - **保留**（Layer 3）
- ✅ `208-decision-support-detailed.mdc` - **保留**（Layer 3）

### 2. 其他文件分类

#### 通用规则（非 Epoch 特定）
- `004-memory-bank-updater.mdc` - 通用工作流
- `005-whitespace.mdc` - 代码格式
- `006-anti-overengineering.mdc` - 通用原则（与 204 重复？）
- `007-issue-fixing.mdc` - 通用工作流
- `008-evidence-first.mdc` - 通用原则（与 012 重复？）
- `009-ios-project-specific.mdc` - iOS 通用（与 202 重复？）
- `010-checklist.mdc` - 通用
- `010-healthkit-workoutkit.mdc` - HealthKit 通用（与 101/203 重复？）
- `011-build-test-commands.mdc` - 通用命令
- `012-evidence-requirements.mdc` - 通用原则
- `015-rule-logging.mdc` - 工具特定
- `016-deep-debugging.mdc` - 通用调试
- `020-safety.mdc` - 通用安全
- `025-preserve-behaviour.mdc` - 通用原则
- `026-english-comments.mdc` - 代码格式
- `027-double-confirm.mdc` - 通用工作流
- `031-continuous-test-loop.mdc` - 通用测试
- `050-anti-hallucination.mdc` - 通用原则
- `060-token-efficiency.mdc` - 通用优化
- `090-env-schema.mdc` - 通用配置
- `110-typescript-specific.mdc` - 语言特定
- `121-swift-core.mdc` - Swift 通用（与 202 重复？）
- `122-swift-development.mdc` - Swift 通用（与 202 重复？）
- `126-swift-advanced.mdc` - Swift 通用（与 202 重复？）
- `133-code-quality-review.mdc` - 通用审查
- `134-architecture-design-system.mdc` - 通用架构
- `135-feature-implementation.mdc` - 通用实现
- `136-plan-review-methodology.mdc` - 通用方法
- `220-obsidian-standards.mdc` - 工具特定
- `300-commit-msg.mdc` - 通用提交
- `301-security-audit.mdc` - 通用安全
- `400-design-system.mdc` - 通用设计系统
- `450-layout-rtl.mdc` - 通用布局
- `460-layout-sizeclasses.mdc` - 通用布局
- `470-viewstate.mdc` - 通用状态
- `480-performance-lazy.mdc` - 通用性能
- `490-accessibility-ids.mdc` - 通用可访问性
- `500-localization.mdc` - 通用本地化
- `510-elevation.mdc` - 通用设计
- `520-privacy-redact.mdc` - 通用隐私
- `530-haptics.mdc` - 通用交互

---

## 💡 重组方案

### 方案 A：严格三层架构（推荐）⭐

**原则**：
- 只保留 Epoch 项目特定的规则
- 通用规则移到 `deprecated/` 或 `archive/`
- 消除所有编号冲突

**操作**：

1. **保留 Layer 1-3 的 19 个文件**（按 README.md 列出）

2. **重命名冲突文件**（移到新编号或 archive）：
   ```
   001-base.mdc → archive/001-base.mdc
   002-chunked-read.mdc → archive/002-chunked-read.mdc
   003-plan-act-workflow.mdc → archive/003-plan-act-workflow.mdc
   100-python-specific.mdc → archive/100-python-specific.mdc
   101-go-specific.mdc → archive/101-go-specific.mdc
   105-bash-conventions.mdc → archive/105-bash-conventions.mdc
   200-api-design.mdc → archive/200-api-design.mdc
   201-bugbot-autofix.mdc → archive/201-bugbot-autofix.mdc
   ```

3. **其他通用规则**：
   - 如果与 Epoch 特定规则重复 → 删除或 archive
   - 如果不重复且有用 → 移到 `archive/` 或 `deprecated/`
   - 如果 Epoch 特定但不在三层架构 → 评估是否整合到 Layer 2/3

4. **更新 README.md**：
   - 明确说明只使用三层架构的 19 个文件
   - 其他文件在 `archive/` 中，供参考但不自动加载

**优点**：
- ✅ 清晰的三层架构
- ✅ 无编号冲突
- ✅ README 与实际一致
- ✅ Token 节省最大化

**缺点**：
- ❌ 需要评估每个文件是否有用
- ❌ 可能需要整合一些通用规则到 Epoch 特定规则中

---

### 方案 B：扩展三层架构

**原则**：
- 保留有用的通用规则
- 整合到三层架构中（使用新编号）
- 明确标记哪些是 Epoch 特定，哪些是通用

**操作**：

1. **Layer 1 扩展**（000-099）：
   - 000-003: Epoch 核心（保留）
   - 004-099: 通用核心规则（如 004-memory-bank-updater, 005-whitespace 等）

2. **Layer 2 扩展**（100-199）：
   - 100-106: Epoch 场景检查清单（保留）
   - 110-199: 语言特定规则（Python, Go, TypeScript, Swift 通用等）

3. **Layer 3 扩展**（200-299）：
   - 200-208: Epoch 详细参考（保留）
   - 210-299: 通用详细参考（API 设计、安全审计等）

4. **其他编号**（300+）：
   - 300-399: 工具特定（Commit, Security, BugBot）
   - 400-599: 设计系统、布局、可访问性等

**优点**：
- ✅ 保留所有有用规则
- ✅ 清晰的分类体系
- ✅ 可以逐步迁移

**缺点**：
- ❌ 三层架构变得复杂
- ❌ Token 消耗可能增加
- ❌ 需要更新 README 说明扩展架构

---

## 🎯 推荐方案：方案 A（严格三层架构）

**理由**：
1. **符合设计目标**：三层架构就是为了节省 Token（84% 节省）
2. **Epoch 项目特定**：README 明确说明这是 "Cursor Project Rules for Epoch"
3. **清晰简单**：19 个文件，易于维护和理解
4. **通用规则可复用**：移到 archive 后，其他项目可以复制使用

**实施步骤**：

1. **创建 archive 目录**：
   ```bash
   mkdir -p .cursor/rules/archive
   ```

2. **移动冲突文件**：
   ```bash
   mv .cursor/rules/001-base.mdc .cursor/rules/archive/
   mv .cursor/rules/002-chunked-read.mdc .cursor/rules/archive/
   mv .cursor/rules/003-plan-act-workflow.mdc .cursor/rules/archive/
   mv .cursor/rules/100-python-specific.mdc .cursor/rules/archive/
   mv .cursor/rules/101-go-specific.mdc .cursor/rules/archive/
   mv .cursor/rules/105-bash-conventions.mdc .cursor/rules/archive/
   mv .cursor/rules/200-api-design.mdc .cursor/rules/archive/
   mv .cursor/rules/201-bugbot-autofix.mdc .cursor/rules/archive/
   ```

3. **评估其他文件**：
   - 检查是否有 Epoch 特定的内容需要整合
   - 通用规则移到 archive
   - 重复内容删除

4. **更新 README.md**：
   - 明确说明三层架构的 19 个文件
   - 说明 archive/ 目录的作用
   - 更新文件列表

---

## ✅ 验收标准

- [ ] 无编号冲突（000-003, 100-106, 200-208 各只有一个文件）
- [ ] README.md 列出的文件与实际文件一致
- [ ] 所有冲突文件已移到 archive/
- [ ] README.md 已更新说明 archive/ 目录
- [ ] 三层架构清晰，Token 节省目标达成

---

**创建时间**: 2025-11-08  
**状态**: 待实施

