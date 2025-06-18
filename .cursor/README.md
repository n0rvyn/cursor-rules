# Cursor Core Configuration | Cursor 核心配置

> **English**: This directory contains the core Cursor AI configuration files that control how the AI assistant behaves in your project.
> 
> **中文**: 此目录包含控制 AI 助手在项目中行为的核心 Cursor AI 配置文件。

---

## 📁 Directory Structure | 目录结构

```
.cursor/
├── config.json                 # Main configuration | 主配置文件
├── project.json                # Project overrides | 项目覆盖配置
├── performance.json            # Performance settings | 性能设置
├── environments/               # Environment configs | 环境配置
│   ├── development.json       # Development settings | 开发环境设置
│   └── production.json        # Production settings | 生产环境设置
└── rules/                     # Custom rules | 自定义规则
    ├── 100-python-specific.mdc
    ├── 110-typescript-specific.mdc
    ├── 200-api-design.mdc
    └── 300-security-audit.mdc
```

---

## 🎯 Purpose & Benefits | 目的与优势

### **English**

**Purpose:**
- **Centralized Configuration**: All Cursor AI settings in one place
- **Team Consistency**: Shared configuration ensures consistent AI behavior
- **Project Adaptation**: Tailored rules for your specific codebase
- **Performance Optimization**: Fine-tuned settings for optimal performance

**Benefits:**
- ✅ **Improved Code Quality**: AI suggestions follow your team's standards
- ✅ **Faster Development**: Context-aware AI assistance
- ✅ **Reduced Onboarding**: New team members get instant AI guidance
- ✅ **Consistent Style**: Automatic adherence to coding conventions

### **中文**

**目的:**
- **集中化配置**: 所有 Cursor AI 设置集中管理
- **团队一致性**: 共享配置确保 AI 行为一致
- **项目适应**: 为特定代码库定制规则
- **性能优化**: 针对最佳性能的精细调优

**优势:**
- ✅ **提升代码质量**: AI 建议遵循团队标准
- ✅ **加速开发**: 上下文感知的 AI 辅助
- ✅ **减少入职时间**: 新团队成员立即获得 AI 指导
- ✅ **保持一致风格**: 自动遵循编码约定

---

## 🔧 Configuration Files | 配置文件

### `config.json` - Main Configuration | 主配置

**English:**
- **Model Selection**: Choose AI model (GPT-4, Claude, etc.)
- **Temperature**: Control creativity vs consistency (0.0-1.0)
- **Context Settings**: How much code context to include
- **Basic Rules**: Core coding standards

**中文:**
- **模型选择**: 选择 AI 模型（GPT-4、Claude 等）
- **温度设置**: 控制创造性与一致性（0.0-1.0）
- **上下文设置**: 包含多少代码上下文
- **基础规则**: 核心编码标准

```jsonc
{
  "model": "openai/gpt-4o",        // AI model | AI 模型
  "temperature": 0.3,              // Creativity level | 创造性水平
  "contextLines": 200,             // Context size | 上下文大小
  "enableInlineCompletion": true   // Auto-suggestions | 自动建议
}
```

### `project.json` - Project Overrides | 项目覆盖配置

**English:**
- **Custom Commands**: Project-specific scripts (test, build, deploy)
- **Rule Overrides**: Modify global rules for this project
- **Tool Integration**: Connect with existing dev tools

**中文:**
- **自定义命令**: 项目特定脚本（测试、构建、部署）
- **规则覆盖**: 为此项目修改全局规则
- **工具集成**: 与现有开发工具连接

### `performance.json` - Performance Optimization | 性能优化

**English:**
- **Context Strategy**: Smart file prioritization
- **Caching**: Improve response times
- **Exclusion Patterns**: Skip irrelevant files
- **Memory Management**: Optimize resource usage

**中文:**
- **上下文策略**: 智能文件优先级
- **缓存机制**: 提升响应时间
- **排除模式**: 跳过无关文件
- **内存管理**: 优化资源使用

---

## 📝 Rules Directory | 规则目录

### Language-Specific Rules | 语言特定规则

**English:**
- **`100-python-specific.mdc`**: Python coding standards, type hints, testing
- **`110-typescript-specific.mdc`**: TypeScript patterns, React best practices
- **Go, Java, Rust**: Additional language support available

**中文:**
- **`100-python-specific.mdc`**: Python 编码标准、类型注解、测试
- **`110-typescript-specific.mdc`**: TypeScript 模式、React 最佳实践
- **Go、Java、Rust**: 提供额外语言支持

### Project-Specific Rules | 项目特定规则

**English:**
- **`200-api-design.mdc`**: RESTful API conventions, OpenAPI documentation
- **`300-security-audit.mdc`**: Security best practices, vulnerability prevention

**中文:**
- **`200-api-design.mdc`**: RESTful API 约定、OpenAPI 文档
- **`300-security-audit.mdc`**: 安全最佳实践、漏洞预防

---

## 🚀 Quick Start | 快速开始

### **English**

1. **Copy Configuration**:
   ```bash
   cp -r /path/to/cursor-templates/.cursor ./
   ```

2. **Customize for Your Project**:
   - Edit `config.json` for basic settings
   - Modify rules in `rules/` directory
   - Set environment-specific configs

3. **Test Configuration**:
   ```bash
   # Validate configuration
   ./scripts/validate-cursor-config.sh
   ```

### **中文**

1. **复制配置**:
   ```bash
   cp -r /path/to/cursor-templates/.cursor ./
   ```

2. **为项目定制**:
   - 编辑 `config.json` 基本设置
   - 修改 `rules/` 目录中的规则
   - 设置环境特定配置

3. **测试配置**:
   ```bash
   # 验证配置
   ./scripts/validate-cursor-config.sh
   ```

---

## ⚙️ Environment Configuration | 环境配置

### Development vs Production | 开发环境 vs 生产环境

| Setting | Development | Production |
|---------|-------------|------------|
| Temperature | 0.1-0.3 (more creative) | 0.05-0.15 (conservative) |
| Debug Mode | Enabled | Disabled |
| Context Lines | 300+ | 150-200 |
| Validation | Relaxed | Strict |

| 设置 | 开发环境 | 生产环境 |
|------|----------|----------|
| 温度设置 | 0.1-0.3（更有创造性） | 0.05-0.15（保守） |
| 调试模式 | 启用 | 禁用 |
| 上下文行数 | 300+ | 150-200 |
| 验证模式 | 宽松 | 严格 |

---

## 🔍 Troubleshooting | 故障排除

### Common Issues | 常见问题

**English:**
- **Rules not working**: Check YAML front matter in `.mdc` files
- **Slow performance**: Reduce `contextLines` or add exclusion patterns
- **Inconsistent suggestions**: Restart Cursor after config changes

**中文:**
- **规则不生效**: 检查 `.mdc` 文件中的 YAML 前言
- **性能缓慢**: 减少 `contextLines` 或添加排除模式
- **建议不一致**: 配置更改后重启 Cursor

### Validation Commands | 验证命令

```bash
# Check configuration syntax | 检查配置语法
./scripts/validate-cursor-config.sh

# Test rule application | 测试规则应用
cursor test-rules --dry-run

# Performance analysis | 性能分析
cursor analyze-performance
```

---

## 📚 Related Documentation | 相关文档

- [Advanced Guide](../cursor-advanced-guide.md) - Complete configuration reference
- [Team Rules](../team-rules-examples/README.md) - Team collaboration setup
- [Migration Guide](../migration-guides/EXISTING_PROJECT_MIGRATION.md) - Adding to existing projects
- [Usage Guide](../USAGE_GUIDE.md) - Detailed usage instructions

---

**Next Steps | 下一步:**
1. Customize configuration for your project | 为项目定制配置
2. Add team-specific rules | 添加团队特定规则  
3. Set up CI/CD validation | 设置 CI/CD 验证
4. Train team on usage patterns | 培训团队使用模式 