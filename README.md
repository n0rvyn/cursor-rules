# Cursor Advanced Configuration Guide

> A comprehensive Cursor AI configuration package for professional development workflows

## 🆕 New Features

- ✅ **YAML Linting** - GitHub Actions automatically validate rule syntax
- ✅ **Scopes & Tags** - Modern Cursor features for selective rule enabling
- ✅ **Shell Support** - Dedicated Bash/Shell scripting rules (105-bash-conventions.mdc)
- ✅ **FAQ & Examples** - Comprehensive documentation and `.cursorignore` examples
- ✅ **Enhanced Priority System** - Clear rule precedence with priority fields

## 🚀 Quick Start

### One-Line Install
```bash
curl -s https://raw.githubusercontent.com/n0rvyn/cursor-rules/main/install-cursor-rules.sh | bash
```

### 1. Copy Configuration
```bash
# Copy to your project
cp -r .cursor your-project/
```

### 2. Reload Rules
- **Cursor**: Automatically reloads on file changes


### 3. Visual Demo - See Rules in Action
- **Before (without rules):**
  ```python
  def process_data(data):
      result = []
      for item in data:
        if item:
            result.append(item * 2)
      return result
  ```

- **After (with Python rules applied):**
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
  *✨ Auto-applied: type hints, docstring, list comprehension, better style*


## 📁 Project Structure

```
├── .cursor/                    # Core configuration
│   ├── FAQ.md                  # Frequently asked questions
│   ├── install-cursor-rules.sh # Installation script
│   ├── interaction-patterns/   # Interaction best practices
│   │   └── README.md
│   ├── migration-guides/       # Migration documentation
│   │   └── README.md
│   ├── rules/                  # Active rule files
│   │   ├── 001-base.mdc        # Core coding standards & AI guidelines
│   │   ├── 010-checklist.mdc   # Automated checklist workflow
│   │   ├── 020-safety.mdc      # Basic error prevention
│   │   ├── 030-test-driven.mdc # TDD patterns
│   │   ├── 050-anti-hallucination.mdc # AI protection strategies
│   │   ├── 060-token-efficiency.mdc # Performance optimization
│   │   ├── 090-env-schema.mdc      # Document environment variable names
│   │   ├── 100-python-specific.mdc # Python templates & patterns
│   │   ├── 105-bash-conventions.mdc # Shell/Bash best practices
│   │   ├── 110-typescript-specific.mdc # TypeScript/React patterns
│   │   ├── 200-bugbot-autofix.mdc  # BugBot PR workflow
│   │   ├── 210-api-design.mdc  # API development standards
│   │   ├── 300-commit-msg.mdc  # Conventional commit guidance
│   │   ├── 310-security-audit.mdc # Security & compliance
│   │   └── 400-reactive-storage.mdc # React state patterns
│   └── team-rules-examples/    # Team collaboration templates
│       ├── enterprise/
│       │   └── governance/
│       │       └── approval-process.mdc
│       ├── languages/
│       │   └── go/
│       │       └── go-specific.mdc
│       ├── projects/
│       │   └── web-api/
│       │       └── api-project.mdc
│       ├── README.md
│       └── shared/
│           └── 010-security-baseline.mdc
├── templates/                  # Reusable code templates
│   ├── express-service.ts      # Express API service template
│   ├── react-component.tsx     # React component template
│   └── python-service.py       # Python async service template
├── .cursorignore              # Project ignore patterns
└── README.md                  # This file
```

## ⚙️ Configuration Details

### Core Rules (Required)
- **001-base.mdc**: Global coding standards (PEP8, Airbnb style)
- **010-checklist.mdc**: Automatic task list maintenance
- **020-safety.mdc**: Basic error prevention
- **050-anti-hallucination.mdc**: Advanced AI protection strategies
- **060-token-efficiency.mdc**: Performance optimization
- **090-env-schema.mdc**: Document allowed environment variables

### Language-Specific Rules (Optional)
- **100-python.mdc**: Type hints, async/await, pytest patterns
- **105-bash-conventions.mdc**: Shell/Bash scripting best practices, error handling
- **110-typescript.mdc**: Strict typing, React patterns, Jest testing
- **210-api-design.mdc**: RESTful conventions, OpenAPI documentation
- **300-commit-msg.mdc**: Conventional commit guidance

### Modern Rule Features
All rules now include:
- **Scopes**: `[chat, edit]` - Control when rules apply
- **Tags**: Categorization for selective enabling
- **Priority**: Clear precedence ordering (1-300)
- **Globs**: File pattern matching

### Rule Configuration System

**🎯 Cursor uses a modern, file-based rule system for AI behavior customization:**

#### Global vs Project Rules
- **Global Rules**: Set in `Cursor Settings > Rules` - apply to all projects
- **Project Rules**: Stored in `.cursor/rules/*.mdc` - version-controlled and team-shared
- **Legacy Support**: `.cursorrules` files still work but are deprecated

#### Rule Types and Activation
```mdc
---
description: "Brief description of when this rule applies"
globs: ["src/**/*.ts", "**/*.tsx"]  # File patterns (optional)
alwaysApply: true                   # Always vs conditional activation
---

# Rule content in Markdown
- Your coding standards
- Project-specific guidance
- Reference templates with @filename.ts
```

**📝 Available Rule Types:**

| Rule Type | Configuration | When Activated |
|-----------|---------------|----------------|
| **Always** | `alwaysApply: true` | Every AI interaction |
| **Auto Attached** | `globs: ["*.tsx"]` | When matching files referenced |
| **Agent Requested** | `description` required | AI decides based on description |
| **Manual** | Default | Only when explicitly called with `@ruleName` |

**💡 Best Practices:**
- Keep rules under 500 lines for optimal performance
- Use specific, actionable language
- Reference template files with `@filename.ts`
- Organize rules by priority (001-099 core, 100-199 language-specific, 200+ domain-specific)

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

## 🔧 Rule-Based Configuration System

**Our rule files make Cursor "remember" your preferences and coding standards**

### Core Rules (1-99)
- **001-base.mdc**: Global coding conventions, AI interaction guidelines, context precedence, prohibited actions
- **010-checklist.mdc**: Automated DEV_CHECKLIST.md maintenance with task tracking workflow
- **020-safety.mdc**: Basic error prevention, file-by-file editing, verification requirements
- **030-test-driven.mdc**: Test-first development patterns and TDD workflow
- **050-anti-hallucination.mdc**: Advanced AI protection with quality gates, context verification, change size limits
- **060-token-efficiency.mdc**: Performance optimization, conversation management, template usage patterns

### Language-Specific Rules (100-199)
- **100-python-specific.mdc**: Template-first development, type hints, async patterns, testing conventions
- **105-bash-conventions.mdc**: Bash best practices, error handling, security considerations, shellcheck compliance
- **110-typescript-specific.mdc**: Template-driven React/Express patterns, strict TypeScript, modern frameworks

### Domain-Specific Rules (200-399)
- **200-bugbot-autofix.mdc**: Handle BugBot PR comments
- **210-api-design.mdc**: Template-first API development, RESTful conventions, OpenAPI documentation
- **300-commit-msg.mdc**: Conventional commit guidance
- **310-security-audit.mdc**: Comprehensive security standards, best practices, compliance checklists
- **400-reactive-storage.mdc**: React context and state patterns

### Template Library (`/templates/`)
- **express-service.ts**: Complete Express service with validation, error handling, TypeScript types
- **react-component.tsx**: Modern React component with hooks, accessibility, proper TypeScript patterns
- **python-service.py**: Async Python service with error handling, logging, type safety patterns

### Rule Architecture Principles
- **Priority System**: Lower numbers = higher priority (001 overrides 100)
- **Template Integration**: `@templates/` references for consistent code patterns
- **File Targeting**: `globs` patterns match specific file types
- **Scope Control**: `alwaysApply: true` for critical rules
- **Contextual Application**: Rules activate based on file type and project context
- **Two-Stage Activation**: Rules are first injected into context, then AI decides relevance based on description

### Advanced Rule Techniques

#### Symlink Hack for Shared Rules
Create reusable rule libraries across projects:
```bash
# Create central rule library
mkdir ~/cursor-rules-library
# Add your common rules there

# Link to any project
cd your-project/.cursor/rules
ln -s ~/cursor-rules-library/global-rules ./

# Restart Cursor to recognize symlinked rules
```

#### MDC Editor Workaround
Enable normal editing of `.mdc` files by adding to VS Code settings:
```json
{
  "workbench.editorAssociations": {
    "*.mdc": "default"
  }
}
```
**Benefits:**
- Normal save operations (Cmd/Ctrl+S)
- AI can edit its own rule files
- No more editor bugs with rule modifications

#### Nested Rules Organization
Organize rules by directory structure:
```
project/
  .cursor/rules/          # Project-wide rules
  backend/
    .cursor/rules/        # Backend-specific rules
  frontend/
    .cursor/rules/        # Frontend-specific rules
```

#### Combined Rule Types
Rules can be both auto-attached AND agent-requested:
```mdc
---
description: "React component patterns and conventions"
globs: ["src/components/**/*.tsx"]
alwaysApply: false
---
```
This rule activates for component files AND can be manually invoked by AI when relevant.

## 🛡️ Advanced Quality Control

**Multi-layered protection against AI errors and code quality issues**

### Anti-Hallucination Strategies
Our rule system implements research-backed techniques to reduce AI errors:

- **Context Verification**: Always cross-check against provided context (25-30% error reduction)
- **File-by-File Processing**: Complete one file before moving to next (prevents cascade errors)
- **No Inventions Policy**: Implement only explicitly requested features (40% reduction in unwanted features)
- **Change Size Limits**: Single modifications ≤ 120 lines (large tasks = higher hallucination risk)
- **Chain-of-Thought Reasoning**: Step-by-step problem solving for complex issues

### Quality Gates
- **Type Check First**: Ensure `mypy`/`tsc --noEmit` passes before suggestions
- **Test-Driven Approach**: Write failing tests first, then implement
- **Existing Pattern Search**: Check codebase before creating new APIs
- **Self-Assessment**: End responses with `SELF-CHECK:` noting potential risks

### Automated Safeguards
- **DEV_CHECKLIST.md**: Automatic task tracking and completion verification
- **Git Integration**: Pre-commit hooks prevent incomplete work from being committed
- **Progress Checkpoints**: Structured workflow prevents scope creep

## 🚀 Advanced Techniques

### Expert-Level Context Management

#### Master @ Commands for Surgical Context
```bash
@Files src/api/auth.ts src/types/user.ts    # Multiple specific files
@Folders src/components/                    # Entire directories
@Code handleLogin                          # Specific functions
@Docs React                               # Official documentation
@Web "Next.js 14 app router best practices" # Live web search
@Link https://example.com/spec.pdf         # External documents
@Git:diff                                 # Recent changes
@Cursor Rules my-api-rules.mdc            # Specific rules
```

#### Checklist Auto-Maintenance Pattern
Create a rule that automatically maintains `DEV_CHECKLIST.md`:
```mdc
---
description: "Automatic task tracking and checklist maintenance"
alwaysApply: true
---

## Checklist Workflow
1. After analyzing the prompt, create/update `DEV_CHECKLIST.md`
2. For each task, append: `- [ ] <verb + task>`
3. When modifying code, tick items `- [x]` and append "✅ YYYY-MM-DD"
4. Add new unchecked items for fresh TODOs

### Sections Order
- Features
- Refactors
- Tests
- Documentation
- Chores

Never delete completed items - history stays for diff review.
```

#### Safety Rails Implementation
Add explicit no-invention rules to prevent hallucinations:
```mdc
---
description: "Anti-hallucination safety measures"
alwaysApply: true
---

## Safety Guardrails
- **No Invention**: Only implement explicitly requested features
- **Verify Context**: Compare referenced files before coding
- **One-File Focus**: Edit only current file, review before switching
- **Ask if Unsure**: When uncertain → ask first
- **Change Size Limits**: Single modifications ≤ 120 lines
```

### Advanced AI Interaction Patterns

#### Multi-Model Validation Workflow
1. Use primary model for initial implementation
2. Switch models for critical code review
3. Compare outputs for consistency
4. Results in 10-15% hallucination reduction

#### Strategic Max Mode Usage
**Use Max Mode for:**
- Major refactoring across multiple files
- Architecture changes requiring full codebase context
- Complex dependency analysis

**Avoid Max Mode for:**
- Simple bug fixes
- Single-file edits
- Formatting changes
- Performance cost: 3-5x higher token usage

#### Token-Efficient Development
- Use `@templates/` references instead of repeating boilerplate
- Keep rules under 500 lines each
- Split large concepts into focused, composable rules
- Start fresh conversations after 50+ exchanges

### Model Context Protocol (MCP) Integration
Connect external knowledge sources:
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

### Background Agents & BugBot
- **Background Agents**: Delegate tasks to remote environments
- **BugBot**: Automated PR reviews with "Fix in Cursor" buttons
- **Security Note**: Higher attack surface - use on trusted repos only

## 🔧 Basic Customization

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

### Access Rules in Settings
View and manage rules through Cursor's interface:
```bash
# Command palette
Cmd+Shift+P > "New Cursor Rule"

# Settings UI
Cursor Settings > Rules > Project Rules
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

# Symlink team rules into project
ln -s .cursor/team/shared/* .cursor/rules/
```

## ❓ Troubleshooting

Having issues? Check our comprehensive [FAQ.md](./FAQ.md) for:
- Rule precedence and conflicts
- YAML syntax errors
- File pattern matching
- Performance optimization
- Common setup problems

**Quick fixes:**
```bash
# Validate rule syntax
.github/workflows/lint.yml  # Run this locally

# Check rule loading order
find .cursor/rules -name "*.mdc" | sort

# Reset configuration
cp -r .cursor.backup .cursor  # If you made a backup
```

## 🛠️ Language-Specific Setup

### Python Projects
```bash
# Copy Python-specific rules
cp .cursor/rules/100-python-specific.mdc your-project/.cursor/rules/
cp templates/python-service.py your-project/templates/
```

### TypeScript Projects
```bash
# Copy TypeScript-specific rules
cp .cursor/rules/110-typescript-specific.mdc your-project/.cursor/rules/
cp templates/react-component.tsx your-project/templates/
cp templates/express-service.ts your-project/templates/
```

## 🔍 Troubleshooting

**Rules not working?**
- Check YAML front matter syntax in `.mdc` files
- Verify `globs` patterns match your files
- Restart Cursor after major config changes

**Performance issues?**
- Keep rules under 500 lines each
- Use specific glob patterns to limit rule activation
- Split large rules into focused, composable files

**Team sync issues?**
- Use git submodules for team rules
- Version your team rules repository
- Document team-specific configurations

### Common Issues

**"Model not found" error:**
```bash
# Check available models in Cursor chat dropdown
# Models are managed through Cursor Settings > Models
# Common models: GPT-4, Claude-3.5-Sonnet, etc.
```

**Rules not applying to files:**
```bash
# Check glob patterns in rule files
grep -r "globs:" .cursor/rules/
# Make sure patterns match your file structure
```

**Conflicting with existing linters:**
```bash
# Add linting rules to your .mdc files
# Or use .cursorignore to exclude problematic files
echo "*.min.js" >> .cursorignore
echo "dist/" >> .cursorignore
```

**Rules not activating:**
```bash
# Check rule syntax with command palette
Cmd+Shift+P > "Cursor: Validate Rules"

# Verify glob patterns match your files
# Restart Cursor after major rule changes
```

## 📚 Resources

- [Cursor Official Docs](https://docs.cursor.com)
- [Cursor Rules Documentation](https://docs.cursor.com/context/rules)
- [Cursor Directory](https://cursor.directory) - Community rule collection
- [Cursor Forum](https://forum.cursor.com) - Community discussions and support

---

> **Pro Tip**: Start with the core rules, then gradually add language-specific and project-specific rules as needed. Less is often more with AI configuration.