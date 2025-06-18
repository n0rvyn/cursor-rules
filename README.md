# Cursor Advanced Practice Guide - Configuration Package
# Cursor 高阶实践指南 - 配置文件包

> **English**: A complete Cursor AI programming assistant configuration package based on the "10+10+10" principle
> 
> **中文**: 完整的 Cursor AI 编程助手配置文件，基于「10+10+10」原则设计

---

## 📚 Contents | 目录

**English:**
- **10 Efficient Interaction Habits**
- **10 Core Configuration Items**  
- **10 Hallucination Prevention Rules**

**中文:**  
- **10 条高效交互习惯**
- **10 大核心配置项**  
- **10 条幻觉防护规则**

---

## 📁 Directory Structure | 目录结构

```
98-Cursor/
├── .cursor/
│   ├── rules/                    # Rule files | 规则文件
│   │   ├── 001-base.mdc         # Global coding conventions | 全局编码约定
│   │   ├── 010-checklist.mdc    # Task list management | 任务清单管理
│   │   ├── 020-safety.mdc       # Basic safety protection | 基础安全防护
│   │   ├── 030-test-driven.mdc  # Test-driven development | 测试驱动开发
│   │   └── 050-anti-hallucination.mdc # Hallucination prevention | 幻觉防护
│   └── config.json              # Core configuration | 核心配置
├── DEV_CHECKLIST.md             # Development task template | 开发任务模板
├── cursor-advanced-guide.md     # Complete usage guide | 完整使用指南
├── install-cursor-rules.sh      # Quick installation script | 快速安装脚本
└── README.md                    # This file | 本文件
```

---

## 🚀 Quick Start | 快速开始

### Method 1: Installation Script (Recommended) | 方法1：安装脚本（推荐）

```bash
# Run in target project root directory | 在目标项目根目录运行
./98-Cursor/install-cursor-rules.sh

# Or install to specified directory | 或安装到指定目录
./98-Cursor/install-cursor-rules.sh /path/to/your/project
```

### Method 2: Manual Copy | 方法2：手动复制

```bash
# Copy configuration files | 复制配置文件
cp -r 98-Cursor/.cursor your-project/
cp 98-Cursor/DEV_CHECKLIST.md your-project/

# Reload rules in VS Code | 在 VS Code 中重载规则
# Cmd/Ctrl + Shift + P → "Cursor: Reload Rules"
```

---

## ✅ Verify Installation | 验证安装

```bash
cd your-project
./.cursor/health-check.sh
```

---

## 📖 Core Features | 核心功能

| **Feature** | **File** | **Description** |
|-------------|----------|-----------------|
| **功能** | **文件** | **说明** |
| Coding Standards | `001-base.mdc` | PEP8, Airbnb style, context priority |
| 编码规范 | `001-base.mdc` | PEP8、Airbnb风格，上下文优先级 |
| Task Management | `010-checklist.mdc` | Auto-maintain DEV_CHECKLIST.md |
| 任务管理 | `010-checklist.mdc` | 自动维护 DEV_CHECKLIST.md |
| Safety Protection | `020-safety.mdc` | Basic rules to prevent AI hallucination |
| 安全防护 | `020-safety.mdc` | 防止AI幻觉的基础规则 |
| Test-Driven | `030-test-driven.mdc` | Red-green development cycle |
| 测试驱动 | `030-test-driven.mdc` | 红绿循环开发流程 |
| Advanced Protection | `050-anti-hallucination.mdc` | 10 hardcore protection strategies |
| 高级防护 | `050-anti-hallucination.mdc` | 10条硬核防护策略 |
| Core Config | `config.json` | Model, temperature, context settings |
| 核心配置 | `config.json` | 模型、温度、上下文等设置 |

---

## 🎯 Immediate Action Checklist | 立即行动清单

**English:**
- [ ] Copy configuration to your project
- [ ] Run health check script
- [ ] Reload rules in VS Code
- [ ] Adjust configuration parameters for your project
- [ ] Start using "Break-Ask-Select-Control" workflow

**中文:**
- [ ] 复制配置到你的项目
- [ ] 运行健康检查脚本
- [ ] 在 VS Code 中重载规则
- [ ] 根据项目调整配置参数
- [ ] 开始使用「拆-问-选-控制」工作流

---

## 🔗 Related Resources | 相关资源

**English:**
- [cursor-advanced-guide.md](./cursor-advanced-guide.md) - Complete usage guide
- [Cursor Official Documentation](https://cursor.sh/docs)
- [Workflow Examples](./cursor-advanced-guide.md#interaction-patterns)

**中文:**
- [cursor-advanced-guide.md](./cursor-advanced-guide.md) - 完整使用指南
- [Cursor 官方文档](https://cursor.sh/docs)
- [工作流程示例](./cursor-advanced-guide.md#interaction-patterns)

---

> **Tip | 提示**: It's recommended to read `cursor-advanced-guide.md` first to understand the complete concepts, then use these configuration files.
> 
> **提示**: 建议先阅读 `cursor-advanced-guide.md` 了解完整概念，再使用这些配置文件。 