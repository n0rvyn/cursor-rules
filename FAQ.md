# Cursor Rules FAQ

## 🤔 Common Questions

### How do rule priorities work?
Cursor loads rules in this order:
1. **Alphabetical filename order** (001-, 010-, 020-, etc.)
2. **Priority field** (higher numbers override lower ones)
3. **Last match wins** - if multiple rules conflict, the last loaded rule takes precedence

Example:
- `001-base.mdc` (priority: 1) loads first
- `050-anti-hallucination.mdc` (priority: 50) can override base rules
- `310-security-audit.mdc` (priority: 310) has highest precedence

### What are `scopes` and how do I use them?
Scopes control when rules are applied:
- `chat` - Applied during chat conversations
- `edit` - Applied during code editing
- `both` - Applied in both contexts

Enable specific scopes:
```bash
# Enable only chat rules with safety tags
cursor rules enable --scope chat --tags safety
```

### How do `tags` help organize rules?
Tags let you group and selectively enable rules:
- `core` - Essential base rules
- `python`, `typescript` - Language-specific rules  
- `safety`, `security` - Safety and security rules
- `testing` - Test-related rules

### What should I put in `.cursorignore`?
Common patterns to exclude:
```gitignore
# Dependencies
node_modules/
__pycache__/
.venv/
dist/
build/

# Large files
*.log
*.cache
*.tmp
data/
datasets/

# IDE files
.vscode/
.idea/
*.swp

# OS files
.DS_Store
Thumbs.db
```

### How do I override a rule temporarily?
1. **Comment out in rule file:**
   ```markdown
   <!-- Temporarily disabled
   - Always use type hints
   -->
   ```

2. **Use conditional loading:**
   ```yaml
   condition: "env.STRICT_MODE == 'true'"
   ```

3. **Lower priority:**
   ```yaml
   priority: 1  # Lower than other rules
   ```

### Why aren't my rules working?
Check these common issues:
1. **YAML syntax errors** - Run the lint workflow to check
2. **Missing front-matter delimiters** - Must have `---` lines
3. **File naming** - Should follow `NNN-name.mdc` pattern
4. **Conflicting rules** - Check rule priorities
5. **Wrong globs** - Verify file patterns match your code

### How do I add language-specific rules?
Create a new rule file:
```yaml
---
description: Go-specific patterns
scopes: [chat, edit]
tags: [go, language-specific]
priority: 120
globs:
  - "**/*.go"
---

## Go Rules
- Use `gofmt` for formatting
- Follow effective Go guidelines
- Use `context.Context` for cancellation
```

### Can I use rules for documentation?
Yes! Create documentation-specific rules:
```yaml
---
description: Documentation standards
scopes: [chat, edit]
tags: [documentation]
globs:
  - "**/*.md"
  - "**/*.rst"
---

## Documentation Rules
- Use clear, concise language
- Include code examples
- Add table of contents for long docs
```

### How do I share rules with my team?
1. **Fork this repository**
2. **Customize rules for your needs**
   - Copy templates from the `templates/` directory for common patterns
3. **Share the installation script:**
   ```bash
   curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/cursor-rules/main/install-cursor-rules.sh | bash
   ```

### What's the difference between `alwaysApply` and regular rules?
- `alwaysApply: true` - Rule is active in all contexts
- Regular rules - Only active when file patterns match `globs`
- Priority still controls which rule wins when multiple `alwaysApply` rules apply

### How do I debug rule conflicts?
1. **Check rule loading order:**
   ```bash
   find .cursor/rules -name "*.mdc" | sort
   ```

2. **Verify YAML front-matter:**
   ```bash
   head -20 .cursor/rules/*.mdc
   ```

3. **Use the linting workflow** to catch syntax errors

4. **Test with minimal rules** - disable all but essential rules

---

> 💡 **Tip**: Start with the base rules and gradually add language-specific ones. Don't enable everything at once!

### How do I automate rule checks?
1. Install `pre-commit` and add hooks for linting and tests.
2. Mirror the same commands in your CI pipeline so every push runs the checks.
