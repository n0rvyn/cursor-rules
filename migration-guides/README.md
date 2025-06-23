# Adding Cursor to Existing Projects

> **Quick guide for integrating Cursor AI into existing codebases**

## 🚀 Quick Integration (5 minutes)

### 1. Backup & Copy
```bash
# Backup your project
git add -A && git commit -m "Backup before Cursor integration"

# Copy Cursor configuration
cp -r path/to/98-Cursor/.cursor ./
```

### 2. Configure Rules
```bash
# Rules are automatically loaded from .cursor/rules/
# Models are configured through Cursor Settings > Models
# No additional configuration files needed
```

### 3. Test & Validate
```bash
# Reload rules in Cursor
# Ctrl+Shift+P → "Cursor: Reload Rules"

# Test with simple prompt
# "@filename refactor this function"
```

## 🔧 Handle Conflicts

### Existing Linters/Formatters
**Keep your existing tools**, Cursor rules work alongside them:
```mdc
---
description: Project-specific overrides for existing standards
priority: 900
---

# Existing Standards Integration
- Respect existing linting configurations
- Follow current code formatting rules
- Use conservative AI suggestions when existing tools are present
```

### Existing Code Standards
**Adapt rules to your standards**:
```bash
# Create custom rule
cat > .cursor/rules/900-existing-standards.mdc << 'EOF'
---
description: Existing project standards
priority: 900
---

# Our Existing Standards
- Follow our current naming conventions
- Use our existing error handling patterns
- Maintain our current file structure
EOF
```

## 🎯 Language-Specific Setup

### Python Projects
```bash
# If you have existing Python configs, they'll work together
cp .cursor/rules/100-python-specific.mdc .cursor/rules/
# Cursor respects your existing pylint/black/mypy configs
```

### TypeScript Projects
```bash
# Works with existing tsconfig.json and eslint
cp .cursor/rules/110-typescript-specific.mdc .cursor/rules/
# No need to change existing configs
```

### Large/Enterprise Projects
```bash
# Start minimal, expand gradually
cp .cursor/rules/001-base.mdc .cursor/rules/
cp .cursor/rules/020-safety.mdc .cursor/rules/
# Add more rules after team gets comfortable
```

## 🔍 Troubleshooting

**Rules not working?**
1. Check rule file syntax: `find .cursor/rules -name "*.mdc"`
2. Restart Cursor: Cmd+Shift+P → "Cursor: Reload Rules"
3. Verify in Cursor Settings > Rules > Project Rules

**AI suggestions conflict with existing code?**
1. Add project-specific rules with higher priority numbers
2. Use more specific glob patterns in rule files
3. Create custom rules that reference your existing standards

**Team resistance?**
1. Start with just basic rules
2. Show value with simple examples
3. Let team opt-in gradually

---

> **Key Point**: Don't overthink it. Copy the configs, update the model names, test it works. You can customize later based on actual usage.
