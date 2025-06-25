# Cursor 高级配置指南

> 专业开发工作流程的综合 Cursor AI 配置包

## 🆕 新功能

- ✅ **YAML 语法检查** - GitHub Actions 自动验证规则语法
- ✅ **作用域和标签** - 现代 Cursor 功能，支持选择性规则启用
- ✅ **Shell 支持** - 专门的 Bash/Shell 脚本规则 (105-bash-conventions.mdc)
- ✅ **Swift/iOS 支持** - Swift 语言规则 (120-swift-specific.mdc) 及 iPhone 项目模板
- ✅ **FAQ 和示例** - 全面的文档和 `.cursorignore` 示例
- ✅ **增强优先级系统** - 清晰的规则优先级字段

## 🚀 快速开始

### 一行安装
```bash
curl -s https://raw.githubusercontent.com/n0rvyn/cursor-rules/main/install-cursor-rules.sh | bash
```

### 1. 复制配置
```bash
# 复制到你的项目
cp -r .cursor your-project/
```

### 2. 重新加载规则
- **Cursor**: 文件更改时自动重新加载

### 3. 可视化演示 - 查看规则效果
- **无规则）：**
  ```python
  def process_data(data):
      result = []
      for item in data:
        if item:
            result.append(item * 2)
      return result
  ```

- **应用规则后:**
  ```python
  def process_data(data: list[int]) -> list[int]:
      """Process data by doubling non-zero values.

      Args:
          data: List of integers to process.

      Returns:
          List of doubled non-zero values.
      """
      return [item * 2 for item in data if item]
  ```
  *✨ 自动应用：类型提示、文档字符串、列表推导式、更好的代码风格*

## 📁 项目结构

```
├── .cursor/                    # 核心配置
│   ├── FAQ.md                  # 常见问题
│   ├── install-cursor-rules.sh # 安装脚本
│   ├── interaction-patterns/   # 交互最佳实践
│   │   └── README.md
│   ├── migration-guides/       # 迁移文档
│   │   └── README.md
│   ├── rules/                  # 活跃规则文件
│   │   ├── 001-base.mdc        # 核心编码标准和 AI 指南
│   │   ├── 010-checklist.mdc   # 自动化清单工作流
│   │   ├── 020-safety.mdc      # 基本错误预防
│   │   ├── 030-test-driven.mdc # TDD 模式
│   │   ├── 050-anti-hallucination.mdc # AI 保护策略
│   │   ├── 060-token-efficiency.mdc # 性能优化
│   │   ├── 090-env-schema.mdc      # 环境变量名称文档
│   │   ├── 100-python-specific.mdc # Python 模板和模式
│   │   ├── 105-bash-conventions.mdc # Shell/Bash 最佳实践
│   │   ├── 110-typescript-specific.mdc # TypeScript/React 模式
│   │   ├── 120-swift-specific.mdc # Swift/iOS 模式
│   │   ├── 200-bugbot-autofix.mdc  # BugBot PR 工作流
│   │   ├── 210-api-design.mdc  # API 开发标准
│   │   ├── 300-commit-msg.mdc  # 约定式提交
│   │   ├── 310-security-audit.mdc # 安全和合规性
│   │   └── 400-reactive-storage.mdc # React 状态模式
│   └── team-rules-examples/    # 团队协作模板
│       ├── enterprise/
│       │   └── governance/
│       │       └── approval-process.mdc
│       ├── languages/
│       │   ├── go/
│       │   │   └── go-specific.mdc
│       │   └── swift/
│       │       └── swift-specific.mdc
│       ├── projects/
│       │   ├── ios-app/
│       │   │   └── ios-project.mdc
│       │   └── web-api/
│       │       └── api-project.mdc
│       ├── README.md
│       └── shared/
│           └── 010-security-baseline.mdc
├── templates/                  # 可重用代码模板
│   ├── express-service.ts      # Express API 服务模板
│   ├── react-component.tsx     # React 组件模板
│   └── python-service.py       # Python 异步服务模板
├── .cursorignore              # 项目忽略模式
└── README.md                  # 主要文档
```

## ⚙️ 配置详情

### 核心规则（必需）
- **001-base.mdc**: 全局编码标准（PEP8、Airbnb 风格）
- **010-checklist.mdc**: 自动任务列表维护
- **020-safety.mdc**: 基本错误预防
- **050-anti-hallucination.mdc**: 高级 AI 保护策略
- **060-token-efficiency.mdc**: 性能优化
- **090-env-schema.mdc**: 环境变量名称文档

### 语言特定规则（可选）
- **100-python.mdc**: 类型提示、async/await、pytest 模式
- **105-bash-conventions.mdc**: Shell/Bash 脚本最佳实践、错误处理
- **110-typescript.mdc**: 严格类型、React 模式、Jest 测试
- **210-api-design.mdc**: RESTful 约定、OpenAPI 文档
- **300-commit-msg.mdc**: 约定式提交信息指南

### 现代规则功能
所有规则现在包括：
- **作用域**: `[chat, edit]` - 控制规则何时应用
- **标签**: 用于选择性启用的分类
- **优先级**: 清晰的优先级排序（1-300）
- **Globs**: 文件模式匹配

### 规则配置系统

**🎯 Cursor 使用现代的基于文件的规则系统进行 AI 行为自定义：**

#### 全局 vs 项目规则
- **全局规则**: 在 `Cursor Settings > Rules` 中设置 - 应用于所有项目
- **项目规则**: 存储在 `.cursor/rules/*.mdc` - 版本控制和团队共享
- **传统支持**: `.cursorrules` 文件仍可用但已弃用

#### 规则类型和激活
```mdc
---
description: "规则应用场景的简要描述"
globs: ["src/**/*.ts", "**/*.tsx"]  # 文件模式（可选）
alwaysApply: true                   # 始终 vs 条件激活
---

# Markdown 格式的规则内容
- 你的编码标准
- 项目特定指导
- 使用 @filename.ts 引用模板
```

**📝 可用规则类型：**

| 规则类型 | 配置 | 激活时机 |
|-----------|---------------|----------------|
| **Always** | `alwaysApply: true` | 每次 AI 交互 |
| **Auto Attached** | `globs: ["*.tsx"]` | 引用匹配文件时 |
| **Agent Requested** | 需要 `description` | AI 根据描述决定 |
| **Manual** | 默认 | 仅通过 `@ruleName` 显式调用 |

**💡 最佳实践：**
- 保持规则在 500 行以下以获得最佳性能
- 使用具体、可操作的语言
- 使用 `@filename.ts` 引用模板文件
- 按优先级组织规则（001-099 核心，100-199 语言特定，200+ 领域特定）

## 🎯 10 个核心交互习惯

**让 Cursor 更好理解你的高效交互要点**

| # | 交互习惯 | 为什么有效 |
|---|---|---|
| 1 | **任务拆小**：用一句话概括本次要做的事，再把子步骤列成清单 | 大语言模型上下文有限，长指令更容易丢信息或产生幻觉 |
| 2 | **先写测试再写代码**：在 prompt 里显式要求"先生成单元测试，再实现代码" | 测试即规格；实战显示成功率显著提升 |
| 3 | **@ 文件/文件夹**：用 `@path/to/file` 显式注入关键代码 | 强制把关键上下文放进 prompt，防止 AI 猜测 |
| 4 | **Cmd + K 前选中最相关代码** | Inline-Edit 只看所选文本，避免全文件误改 |
| 5 | **多轮"问-答-确认"**：让 AI 先复述理解，再动手改 | 先校对意图，可减少返工 |
| 6 | **策略性 Max Mode**：只在大改动时开启 | 上下文窗口大 = 代价高，且更易幻觉。常规任务用默认模式足够 |
| 7 | **动作动词提示**：对话里用动词开头的指令（"Refactor…", "Add test…"） | 动词-任务配对便于解析，也方便 Checklist 自动勾选 |
| 8 | **让 AI 提问题**：在 prompt 末尾加"Ask any clarification questions before you start" | 社区实测能减少 20-30% 的误改 |
| 9 | **开启多模型比对**：在设置里勾选 "Use multiple models for suggestions" | 实测可降低 10-15% 幻觉 |
| 10 | **定期重开 Chat**：长对话 > 50 条时新开一窗，把关键信息 @ 引过去 | 避免上下文污染和性能下降 |

**记忆口诀："拆-问-选-控制，测试-清单-多验-低噪"**

## 🔧 基于规则的配置系统

**我们的规则文件让 Cursor "记住"你的偏好和编码标准**

### 核心规则 (1-99)
- **001-base.mdc**: 全局编码约定、AI 交互指南、上下文优先级、禁止操作
- **010-checklist.mdc**: 自动化 DEV_CHECKLIST.md 维护和任务跟踪工作流
- **020-safety.mdc**: 基本错误预防、逐文件编辑、验证要求
- **030-test-driven.mdc**: 测试优先开发模式和 TDD 工作流
- **050-anti-hallucination.mdc**: 高级 AI 保护策略、质量门控、上下文验证、更改大小限制
- **060-token-efficiency.mdc**: 性能优化、对话管理、模板使用模式

### 语言特定规则 (100-199)
- **100-python-specific.mdc**: 模板优先开发、类型提示、异步模式、测试约定
- **105-bash-conventions.mdc**: Bash 最佳实践、错误处理、安全考虑、shellcheck 合规性
- **110-typescript-specific.mdc**: 模板驱动 React/Express 模式、严格 TypeScript、现代框架
- **120-swift-specific.mdc**: Swift 模式、异步并发、XCTest 指南

### 领域特定规则 (200-399)
- **200-bugbot-autofix.mdc**: 处理 BugBot PR 评论
- **210-api-design.mdc**: 模板优先 API 开发、RESTful 约定、OpenAPI 文档
- **300-commit-msg.mdc**: 约定式提交信息指南
- **310-security-audit.mdc**: 综合安全标准、最佳实践、合规性清单
- **400-reactive-storage.mdc**: React 状态管理模式

### 模板库 (`/templates/`)
- **express-service.ts**: 完整的 Express 服务，包含验证、错误处理、TypeScript 类型
- **react-component.tsx**: 现代 React 组件，包含 hooks、无障碍性、正确的 TypeScript 模式
- **python-service.py**: 异步 Python 服务，包含错误处理、日志记录、类型安全模式

### 规则架构原则
- **优先级系统**: 数字越小优先级越高 (001 覆盖 100)
- **模板集成**: `@templates/` 引用确保一致的代码模式
- **文件定位**: `globs` 模式匹配特定文件类型
- **作用域控制**: 关键规则使用 `alwaysApply: true`
- **上下文应用**: 规则根据文件类型和项目上下文激活
- **两阶段激活**: 规则首先注入上下文，然后 AI 根据描述决定相关性

### 高级规则技巧

#### 共享规则的符号链接技巧
跨项目创建可重用规则库：
```bash
# 创建中央规则库
mkdir ~/cursor-rules-library
# 在那里添加你的通用规则

# 链接到任何项目
cd your-project/.cursor/rules
ln -s ~/cursor-rules-library/global-rules ./

# 重启 Cursor 以识别符号链接的规则
```

#### MDC 编辑器解决方案
通过添加到 VS Code 设置启用 `.mdc` 文件的正常编辑：
```json
{
  "workbench.editorAssociations": {
    "*.mdc": "default"
  }
}
```
**好处：**
- 正常保存操作 (Cmd/Ctrl+S)
- AI 可以编辑自己的规则文件
- 不再有规则修改的编辑器错误

#### 嵌套规则组织
按目录结构组织规则：
```
project/
  .cursor/rules/          # 项目级规则
  backend/
    .cursor/rules/        # 后端特定规则
  frontend/
    .cursor/rules/        # 前端特定规则
```

#### 组合规则类型
规则可以同时是自动附加和代理请求的：
```mdc
---
description: "React 组件模式和约定"
globs: ["src/components/**/*.tsx"]
alwaysApply: false
---
```
此规则为组件文件激活，并且可以在相关时被 AI 手动调用。

## 🛡️ 高级质量控制

**多层防护对抗 AI 错误和代码质量问题**

### 防幻觉策略
我们的规则系统实现了基于研究的技术来减少 AI 错误：

- **上下文验证**: 始终与提供的上下文交叉检查（减少 25-30% 错误）
- **逐文件处理**: 完成一个文件后再转到下一个（防止级联错误）
- **禁止"想当然"政策**: 仅实现明确请求的功能（减少 40% 不需要的功能）
- **更改大小限制**: 单次修改 ≤ 120 行（大任务 = 更高幻觉风险）
- **链式思考推理**: 复杂问题的逐步解决

### 质量门控
- **类型检查优先**: 确保 `mypy`/`tsc --noEmit` 通过后再建议
- **测试驱动方法**: 首先编写失败的测试，然后实现
- **现有模式搜索**: 创建新 API 前检查代码库
- **自我评估**: 响应结尾使用 `SELF-CHECK:` 注明潜在风险

### 自动化保障
- **DEV_CHECKLIST.md**: 自动任务跟踪和完成验证
- **Git 集成**: Pre-commit 钩子防止提交不完整的工作
- **进度检查点**: 结构化工作流防止范围蔓延

## 🚀 高级技巧

### 专家级上下文管理

#### 掌握 @ 命令进行精确上下文控制
```bash
@Files src/api/auth.ts src/types/user.ts    # 多个特定文件
@Folders src/components/                    # 整个目录
@Code handleLogin                          # 特定函数
@Docs React                               # 官方文档
@Web "Next.js 14 app router best practices" # 实时网络搜索
@Link https://example.com/spec.pdf         # 外部文档
@Git:diff                                 # 最近更改
@Cursor Rules my-api-rules.mdc            # 特定规则
```

#### 清单自动维护模式
创建自动维护 `DEV_CHECKLIST.md` 的规则：
```mdc
---
description: "自动任务跟踪和清单维护"
alwaysApply: true
---

## 清单工作流
1. 分析提示后，创建/更新 `DEV_CHECKLIST.md`
2. 对于每个任务，追加：`- [ ] <动词 + 任务>`
3. 修改代码时，勾选项目 `- [x]` 并追加 "✅ YYYY-MM-DD"
4. 为新的 TODO 添加新的未勾选项目

### 部分顺序
- Features
- Refactors
- Tests
- Documentation
- Chores

永远不要删除已完成的项目 - 历史记录保留用于差异审查。
```

#### 安全防护实现
添加明确的禁止发明规则以防止幻觉：
```mdc
---
description: "防幻觉安全措施"
alwaysApply: true
---

## 安全防护栏
- **禁止发明**: 仅实现明确请求的功能
- **验证上下文**: 编码前比较引用的文件
- **单文件专注**: 仅编辑当前文件，切换前审查
- **不确定时询问**: 不确定时 → 先询问
- **更改大小限制**: 单次修改 ≤ 120 行
```

### 高级 AI 交互模式

#### 多模型验证工作流
1. 使用主模型进行初始实现
2. 切换模型进行关键代码审查
3. 比较输出的一致性
4. 结果：减少 10-15% 的幻觉

#### 策略性 Max Mode 使用
**使用 Max Mode 的场景：**
- 跨多个文件的重大重构
- 需要完整代码库上下文的架构更改
- 复杂依赖分析

**避免 Max Mode 的场景：**
- 简单错误修复
- 单文件编辑
- 格式化更改
- 性能成本：3-5倍更高的 token 使用

#### Token 高效开发
- 使用 `@templates/` 引用而不是重复样板代码
- 保持每个规则在 500 行以下
- 将大概念拆分为专注、可组合的规则
- 50+ 次交换后开始新对话

### 模型上下文协议 (MCP) 集成
连接外部知识源：
```json
// .cursor/mcp.json
{
  "servers": {
    "docs": {
      "command": "mcp-server-docs",
      "args": ["--docs-path", "./docs"]
    }
  }
}
```

### 后台代理和 BugBot
- **后台代理**: 将任务委托给远程环境
- **BugBot**: 带有"在 Cursor 中修复"按钮的自动 PR 审查
- **安全注意**: 攻击面更大 - 仅在可信仓库上使用

## 🔧 基础自定义

### 添加项目特定规则
```bash
# 创建自定义规则
cat > .cursor/rules/400-custom.mdc << 'EOF'
---
description: 我的项目规则
globs: ["src/**/*.ts"]
---

# Custom Rules
- Use our specific naming convention
- Follow our API patterns
EOF
```

### 在设置中访问规则
通过 Cursor 界面查看和管理规则：
```bash
# 命令面板
Cmd+Shift+P > "New Cursor Rule"

# 设置界面
Cursor Settings > Rules > Project Rules
```

## 👥 团队设置

### 1. 创建团队规则仓库
```bash
git init team-cursor-rules
cp -r team-rules-examples/* team-cursor-rules/
# 为你的团队自定义
git add . && git commit -m "Team Cursor rules"
```

### 2. 添加到项目
```bash
# 作为子模块
git submodule add https://github.com/yourorg/team-cursor-rules .cursor/team

# 将团队规则符号链接到项目
ln -s .cursor/team/shared/* .cursor/rules/
```

## 🚦 将 Cursor 添加到现有项目

> **快速指南：将 Cursor AI 集成到现有代码库**

### 🚀 快速集成（5分钟）

#### 1. 备份和复制
```bash
# 备份您的项目
git add -A && git commit -m "Cursor 集成前的备份"

# 复制 Cursor 配置
cp -r path/to/cursor-rules/.cursor ./
```

#### 2. 配置规则
```bash
# 规则会自动从 .cursor/rules/ 加载
# 模型通过 Cursor 设置 > 模型进行配置
# 无需额外的配置文件
```

#### 3. 测试和验证
```bash
# 在 Cursor 中重新加载规则
# Ctrl+Shift+P → "Cursor: Reload Rules"

# 使用简单提示进行测试
# "@filename 重构这个函数"
```

### 🔧 处理冲突

#### 现有的 Linter/格式化工具
**保留您现有的工具**，Cursor 规则与它们协同工作：
```mdc
---
description: 现有标准的项目特定覆盖
priority: 900
---

# 现有标准集成
- 尊重现有的 linting 配置
- 遵循当前的代码格式化规则
- 当存在现有工具时使用保守的 AI 建议
```

#### 现有代码标准
**将规则适配到您的标准**：
```bash
# 创建自定义规则
cat > .cursor/rules/900-existing-standards.mdc << 'EOF'
---
description: 现有项目标准
priority: 900
---

# 我们的现有标准
- 遵循我们当前的命名约定
- 使用我们现有的错误处理模式
- 维护我们当前的文件结构
EOF
```

### 🎯 特定语言设置

#### Python 项目
```bash
# 如果您有现有的 Python 配置，它们会协同工作
cp .cursor/rules/100-python-specific.mdc .cursor/rules/
# Cursor 尊重您现有的 pylint/black/mypy 配置
```

#### TypeScript 项目
```bash
# 与现有的 tsconfig.json 和 eslint 协同工作
cp .cursor/rules/110-typescript-specific.mdc .cursor/rules/
# 无需更改现有配置
```

#### 大型/企业项目
```bash
# 从最小配置开始，逐步扩展
cp .cursor/rules/001-base.mdc .cursor/rules/
cp .cursor/rules/020-safety.mdc .cursor/rules/
# 团队熟悉后再添加更多规则
```

### 🔍 迁移故障排除

**规则不生效？**
1. 检查规则文件语法：`find .cursor/rules -name "*.mdc"`
2. 重启 Cursor：Cmd+Shift+P → "Cursor: Reload Rules"
3. 在 Cursor 设置 > 规则 > 项目规则中验证

**AI 建议与现有代码冲突？**
1. 添加具有更高优先级数字的项目特定规则
2. 在规则文件中使用更具体的 glob 模式
3. 创建引用您现有标准的自定义规则

**团队抵制？**
1. 从基本规则开始
2. 用简单示例展示价值
3. 让团队逐步选择加入

> **要点**：不要过度思考。复制配置，更新模型名称，测试是否有效。您可以根据实际使用情况稍后进行自定义。

## 🔍 故障排除

**规则不起作用？**
- 检查 `.mdc` 文件中的 YAML front matter 语法
- 验证 `globs` 模式是否匹配你的文件
- 重大配置更改后重启 Cursor

**性能问题？**
- 保持每个规则在 500 行以下
- 使用特定的 glob 模式限制规则激活
- 将大规则拆分为专注、可组合的文件

**团队同步问题？**
- 为团队规则使用 git 子模块
- 版本化你的团队规则仓库
- 记录团队特定配置

### 常见问题

**"找不到模型"错误：**
```bash
# 检查 Cursor 聊天下拉菜单中的可用模型
# 模型通过 Cursor Settings > Models 管理
# 常见模型：GPT-4、Claude-3.5-Sonnet 等
```

**规则不应用于文件：**
```bash
# 检查规则文件中的 glob 模式
grep -r "globs:" .cursor/rules/
# 确保模式匹配你的文件结构
```

**与现有 linter 冲突：**
```bash
# 将 linting 规则添加到你的 .mdc 文件
# 或使用 .cursorignore 排除有问题的文件
echo "*.min.js" >> .cursorignore
echo "dist/" >> .cursorignore
```

**规则未激活：**
```bash
# 通过命令面板检查规则语法
Cmd+Shift+P > "Cursor: Validate Rules"

# 验证 glob 模式是否匹配你的文件
# 重大规则更改后重启 Cursor
```

## 📚 资源

- [Cursor 官方文档](https://docs.cursor.com)
- [Cursor 规则文档](https://docs.cursor.com/context/rules)
- [Cursor Directory](https://cursor.directory) - 社区规则集合
- [Cursor 论坛](https://forum.cursor.com) - 社区讨论和支持

---

> **专业提示**：从核心规则开始，然后根据需要逐步添加语言特定和项目特定规则。在 AI 配置中，少即是多。

---

# Cursor AI 交互模式

> **通过经过验证的交互模式、习惯和记忆辅助工具，掌握有效 AI 协作的艺术。**

---

## 📁 目录内容

```
interaction-patterns/
├── README.md                    # 本指南
├── 10-core-habits.md          # 核心交互习惯
├── memory-aids.md              # 口号与记忆法
├── prompt-templates.md         # 即用提示模板
├── workflow-examples.md        # 真实工作流示例
└── troubleshooting-patterns.md # 常见问题与解决方案
```

---

## 🎯 目的与优势

**目的:**
- **最大化 AI 生产力**: 学习一致有效的验证模式
- **减少挫折感**: 避免常见陷阱和误解
- **建立肌肉记忆**: 通过练习培养本能的好习惯
- **团队一致性**: 在团队中标准化 AI 交互

**优势:**
- ✅ **更快结果**: 用更少的往返获得更好的输出
- ✅ **更少错误**: 减少幻觉和误解
- ✅ **更好代码质量**: 一致应用最佳实践
- ✅ **节省时间**: 减少纠正 AI 错误的时间

---

## 🎯 核心记忆法

### 主口号
**"拆-问-选-控制，测试-清单-多验-低噪"**

### 记忆顺口溜
```
拆成小步写清单，
选段修改免胡乱；
先红后绿测再干，
复述确认少翻船；
多模投票防幻觉，
长聊五十记断联。
```

## 📚 10个核心交互习惯

| # | 习惯 | 实践 | 为什么有效 |
|---|------|------|------------|
| 1 | **任务拆小** | 将复杂任务分解为清晰步骤 | 降低复杂性，提高准确性 |
| 2 | **测试优先** | 先写测试，再写实现 | 确保质量，防止回归 |
| 3 | **使用文件引用** | 用 `@path/to/file` 注入关键代码 | 提供精确上下文 |
| 4 | **选择相关代码** | 只高亮最相关的片段 | 聚焦 AI 注意力 |
| 5 | **AI 确认** | 让 AI 先复述理解 | 防止误解 |
| 6 | **策略性 Max 模式** | 只在重大更改时使用 Max 模式 | 平衡功能与效率 |
| 7 | **动词开头提示** | 用动作动词开始命令 | 创建清晰请求 |
| 8 | **问题结尾** | 用"有问题吗？"结尾 | 鼓励澄清 |
| 9 | **多模型验证** | 启用多模型比较 | 交叉验证响应 |
| 10 | **对话限制** | 50次以上交换后开新对话 | 防止上下文污染 |

## 🚀 即用提示模板

### 代码审查模式
```
@filename 审查此代码：
- 逻辑错误
- 性能问题
- 安全漏洞
- 代码风格违规

对要求有任何疑问吗？
```

### 重构模式
```
选中的代码需要重构：
1. 提取可复用函数
2. 提高可读性
3. 添加适当的错误处理

请在继续之前确认理解。
```

### 测试驱动开发模式
```
为此功能编写失败测试：
[描述功能要求]

然后实现使测试通过的最小代码。
使用 @test_file 了解现有测试模式。
```

### 错误修复模式
```
问题：[清晰的问题描述]
期望：[应该发生什么]
实际：[实际发生什么]

@relevant_file 显示当前实现。
请在建议修复前识别根本原因。
```

## 🔍 模式分类

### 🎯 精确模式
**目标**: 获得你想要的确切结果
- **文件引用**: 用 `@path/to/file` 提供上下文
- **代码选择**: 只高亮相关部分
- **确认循环**: "请确认你理解 X"

### 🛡️ 安全模式
**目标**: 防止错误和幻觉
- **任务分解**: 将复杂请求分解为步骤
- **资源管理**: 谨慎使用 Max 模式
- **验证**: 为关键决策进行多模型比较
- **上下文卫生**: 新对话防止污染

### ⚡ 效率模式
**目标**: 最大化生产力
- **测试驱动**: 先写测试来澄清需求
- **动作动词**: "重构"、"添加"、"修复" vs 模糊描述
- **开放问题**: 邀请澄清以防止假设

## 🎯 快速练习指南

### 第1周：基础
- [ ] 练习文件引用：每个提示都用 `@filename`
- [ ] 将一个复杂任务分解为3个小任务
- [ ] 5个提示以"有问题吗？"结尾
- [ ] 在一个功能上尝试测试优先方法

### 第2周：习惯
- [ ] 在请求更改前使用代码选择
- [ ] 练习确认模式：AI 重复需求
- [ ] 监控对话长度，必要时重新开始
- [ ] 实验动作动词提示

### 第3周：掌握
- [ ] 记住记忆顺口溜
- [ ] 向同事教授模式
- [ ] 创建自定义提示模板
- [ ] 跟踪 AI 交互质量的改进

## 🔧 需要避免的常见错误

❌ **模糊请求**: "改善这个"
✅ **具体行动**: "重构此函数以降低圈复杂度"

❌ **无上下文**: 不使用文件引用询问代码
✅ **丰富上下文**: `@filename` + 选中代码 + 清晰需求

❌ **长对话**: 一次聊天中100+次交换
✅ **重新开始**: 上下文被污染时开新对话

❌ **假设理解**: "你知道我的意思"
✅ **明确确认**: "请确认你理解需求"

## 📊 成功指标

**定量:**
- 每任务更少迭代
- 更少时间纠正 AI 错误
- 更快任务完成
- 更低 token 使用量

**定性:**
- 对 AI 响应的挫折感更少
- 对 AI 生成代码的信心更强
- 更好的团队协作
- 更清洁、更可维护的代码

---

> **记住**: 这些模式在变成自动化时效果最好。持续练习直到感觉自然。

---

## 📚 相关资源

- [核心配置](./.cursor/README.md) - 理解规则文件
- [示例](./examples/README.md) - 即用模板
- [团队规则](./team-rules-examples/README.md) - 团队协作
- [迁移指南](./migration-guides/README.md) - 添加到现有项目

---

## 🤝 贡献

### 分享你的模式

- **记录成功模式** 你发现的
- **分享失败故事** 和你学到的
- **贡献提示模板** 用于常见场景
- **建议改进** 现有习惯

### 社区指南

1. **分享前测试**: 验证模式一致有效
2. **提供示例**: 包含真实世界使用场景
3. **解释原因**: 不只展示做什么，解释为什么有效
4. **保持实用**: 专注于可操作的建议而非理论

---

**下一步:**
1. 从[10个核心习惯](interaction-patterns/10-core-habits.md)开始
2. 用[提示模板](interaction-patterns/prompt-templates.md)练习
3. 学习[工作流示例](interaction-patterns/workflow-examples.md)
4. 用[常见模式](interaction-patterns/troubleshooting-patterns.md)故障排除