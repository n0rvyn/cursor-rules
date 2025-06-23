# 将 Cursor 添加到现有项目

> **快速指南：将 Cursor AI 集成到现有代码库**

## 🚀 快速集成（5分钟）

### 1. 备份和复制
```bash
# 备份您的项目
git add -A && git commit -m "Cursor 集成前的备份"

# 复制 Cursor 配置
cp -r path/to/cursor-rules/.cursor ./
```

### 2. 配置规则
```bash
# 规则会自动从 .cursor/rules/ 加载
# 模型通过 Cursor 设置 > 模型进行配置
# 无需额外的配置文件
```

### 3. 测试和验证
```bash
# 在 Cursor 中重新加载规则
# Ctrl+Shift+P → "Cursor: Reload Rules"

# 使用简单提示进行测试
# "@filename 重构这个函数"
```

## 🔧 处理冲突

### 现有的 Linter/格式化工具
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

### 现有代码标准
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

## 🎯 特定语言设置

### Python 项目
```bash
# 如果您有现有的 Python 配置，它们会协同工作
cp .cursor/rules/100-python-specific.mdc .cursor/rules/
# Cursor 尊重您现有的 pylint/black/mypy 配置
```

### TypeScript 项目
```bash
# 与现有的 tsconfig.json 和 eslint 协同工作
cp .cursor/rules/110-typescript-specific.mdc .cursor/rules/
# 无需更改现有配置
```

### 大型/企业项目
```bash
# 从最小配置开始，逐步扩展
cp .cursor/rules/001-base.mdc .cursor/rules/
cp .cursor/rules/020-safety.mdc .cursor/rules/
# 团队熟悉后再添加更多规则
```

## 🔍 故障排除

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

---

> **要点**：不要过度思考。复制配置，更新模型名称，测试是否有效。您可以根据实际使用情况稍后进行自定义。
