# Cursor Advanced Configuration Guide
# Cursor 高级配置指南

> **English**: A comprehensive Cursor AI configuration package for professional development workflows
> 
> **中文**: 用于专业开发工作流的全面 Cursor AI 配置包

## 🚀 Quick Start

### 1. Copy Configuration
```bash
# Copy to your project
cp -r .cursor your-project/

# Choose language template (optional)
cp examples/sample-tsconfig.json your-project/tsconfig.json  # TypeScript
cp examples/sample-requirements.txt your-project/requirements.txt  # Python
```

### 2. Reload Rules
- **VS Code**: `Cmd/Ctrl + Shift + P` → "Cursor: Reload Rules"
- **Cursor**: Automatically reloads on file changes

### 3. Verify Setup
Test with a simple prompt: `@filename refactor this function`

**Quick Health Check:**
```bash
# Check if files were copied correctly
ls -la .cursor/rules/          # Should show *.mdc files
ls -la .cursor/environments/   # Should show development.json, production.json

# Test rule syntax (basic check)
head -5 .cursor/rules/*.mdc | grep "---"  # Should show YAML front matter

# Reload rules in Cursor
# Ctrl+Shift+P → "Cursor: Reload Rules"
```

## 📁 Project Structure

```
├── .cursor/                    # Core configuration
│   ├── rules/                  # MDC rule files
│   │   ├── 001-base.mdc       # Global coding standards
│   │   ├── 010-checklist.mdc  # Task management
│   │   ├── 020-safety.mdc     # Safety & validation
│   │   ├── 030-test-driven.mdc # TDD patterns
│   │   ├── 050-anti-hallucination.mdc # Advanced protection
│   │   ├── 100-python.mdc     # Python-specific rules
│   │   ├── 110-typescript.mdc # TypeScript-specific rules
│   │   ├── 200-api-design.mdc # API development
│   │   └── 300-security.mdc   # Security best practices
│   ├── environments/          # Environment configs
│   ├── performance.json       # Performance optimization
│   └── project.json          # Project overrides
├── examples/                  # Template configurations
├── team-rules-examples/       # Team collaboration templates
└── scripts/                   # Automation tools
```

## ⚙️ Configuration Details

### Core Rules (Required)
- **001-base.mdc**: Global coding standards (PEP8, Airbnb style)
- **010-checklist.mdc**: Automatic task list maintenance
- **020-safety.mdc**: Basic error prevention
- **050-anti-hallucination.mdc**: Advanced AI protection strategies

### Language-Specific Rules (Optional)
- **100-python.mdc**: Type hints, async/await, pytest patterns
- **110-typescript.mdc**: Strict typing, React patterns, Jest testing
- **200-api-design.mdc**: RESTful conventions, OpenAPI documentation
- **300-security.mdc**: Security best practices and compliance

### Environment Configurations

**🎯 Use different AI behavior for different contexts:**

```bash
# Development (more permissive, faster iteration)
export CURSOR_ENV=development

# Production (conservative, careful suggestions)
export CURSOR_ENV=production
```

**📝 Customize Models for Your Usage:**

Update `.cursor/environments/development.json`:
```json
{
  "model": "your-preferred-model",    // e.g., "gpt-4", "claude-3-sonnet"
  "temperature": 0.1,                 // 0.05-0.2 range
  "contextLines": 300,                // Adjust based on needs
  "enableDebugMode": true
}
```

Update `.cursor/environments/production.json`:
```json
{
  "model": "your-most-reliable-model", // e.g., "gpt-4", "claude-3-opus" 
  "temperature": 0.05,                 // Very conservative
  "contextLines": 150,                 // Less context for efficiency
  "strictMode": true,
  "requireReview": true                // Force human review
}
```

**🔍 Find Your Available Models:**
- Check the model dropdown in Cursor chat
- Common names: `"gpt-4"`, `"gpt-4-turbo"`, `"claude-3-sonnet"`, `"claude-3-opus"`

**💡 Environment Strategy:**
- **Development**: Daily coding, experimenting, debugging
- **Production**: Critical code changes, security-sensitive work

```bash
# Development (verbose, debug-enabled)
export CURSOR_ENV=development

# Production (conservative, review-required)
export CURSOR_ENV=production
```

## 🎯 10 Core Interaction Habits

**Memory aid: "拆-问-选-控制，测试-清单-多验-低噪"**

1. **Break Tasks Small** - Decompose complex requests
2. **Test-First Approach** - Write tests before implementation
3. **Use File References** - `@path/to/file` for precise context
4. **Select Relevant Code** - Highlight only relevant sections
5. **AI Confirmation** - Let AI confirm understanding first
6. **Strategic Max Mode** - Use sparingly for major changes
7. **Action-Verb Prompts** - Start with "Refactor", "Add", "Fix"
8. **Question Endings** - End prompts with "Any questions?"
9. **Multi-Model Validation** - Cross-validate critical changes
10. **Conversation Limits** - Start fresh after 50+ exchanges

## 🔧 Customization

### Add Project-Specific Rules
```bash
# Create custom rule
cat > .cursor/rules/400-custom.mdc << 'EOF'
---
description: My project rules
globs: ["src/**/*.ts"]
---

# Custom Rules
- Use our specific naming convention
- Follow our API patterns
EOF
```

### Override Settings
```json
// .cursor/project.json
{
  "extends": "./config.json",
  "overrides": {
    "model": "openai/gpt-4-turbo",
    "temperature": 0.1,
    "customRules": ["rules/400-custom.mdc"]
  }
}
```

## 👥 Team Setup

### 1. Create Team Rules Repository
```bash
git init team-cursor-rules
cp -r team-rules-examples/* team-cursor-rules/
# Customize for your team
git add . && git commit -m "Team Cursor rules"
```

### 2. Add to Projects
```bash
# As submodule
git submodule add https://github.com/yourorg/team-cursor-rules .cursor/team

# Reference in project config
echo '{"extends": ["./config.json", "team/shared/standards.mdc"]}' > .cursor/project.json
```

## 🛠️ Language-Specific Setup

### Python Projects
```bash
cp .cursor/rules/100-python.mdc your-project/.cursor/rules/
cp examples/sample-requirements.txt your-project/
pip install -r requirements.txt
```

### TypeScript Projects
```bash
cp .cursor/rules/110-typescript.mdc your-project/.cursor/rules/
cp examples/sample-tsconfig.json your-project/
cp examples/sample-package.json your-project/
npm install
```

## 🔍 Troubleshooting

**Rules not working?**
- Check YAML front matter syntax in `.mdc` files
- Verify `globs` patterns match your files
- Restart Cursor after major config changes

**Performance issues?**
- Reduce `contextLines` in `performance.json`
- Add more patterns to `excludePatterns`
- Enable caching in performance settings

**Team sync issues?**
- Use git submodules for team rules
- Version your team rules repository
- Document team-specific configurations

### Common Issues

**"Model not found" error:**
```bash
# Check available models in Cursor chat dropdown
# Update .cursor/environments/*.json with correct model names
vim .cursor/environments/development.json
```

**Rules not applying to files:**
```bash
# Check glob patterns in rule files
grep -r "globs:" .cursor/rules/
# Make sure patterns match your file structure
```

**Conflicting with existing linters:**
```json
// .cursor/project.json - Add overrides
{
  "overrides": {
    "respectExistingLinting": true,
    "temperature": 0.05
  }
}
```

**Environment variables not working:**
```bash
# Make sure to export the environment
export CURSOR_ENV=development
# Or set in your shell profile (.bashrc, .zshrc)
echo 'export CURSOR_ENV=development' >> ~/.bashrc
```

## 📚 Resources

- [Cursor Official Docs](https://cursor.sh/docs)
- [Community Rules](https://github.com/cursor-community/rules)
- [Best Practices Guide](./cursor-advanced-guide.md)

---

> **Pro Tip**: Start with the core rules, then gradually add language-specific and project-specific rules as needed. Less is often more with AI configuration. 