# Cursor Advanced Configuration Guide

> A comprehensive Cursor AI configuration package for professional development workflows

## 🆕 New Features

- ✅ **YAML Linting** - GitHub Actions automatically validate rule syntax
- ✅ **Scopes & Tags** - Modern Cursor features for selective rule enabling
- ✅ **Shell Support** - Dedicated Bash/Shell scripting rules (105-bash-conventions.mdc)
- ✅ **Swift/iOS Support** - Dedicated Swift rules (120-swift-specific.mdc) and iPhone project template
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
│   │   ├── 120-swift-specific.mdc # Swift/iOS patterns
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
- **120-swift.mdc**: Swift language patterns, async concurrency, XCTest guidelines
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

**Examples**

```mdc
---
description: "Always enforce lint"  # Always
alwaysApply: true
---
```

```mdc
---
description: "Attach for UI components"  # Auto attached
globs: ["src/components/**/*.tsx"]
---
```

```mdc
---
description: "Refactor suggestions"  # Agent requested
---
```

```mdc
---
description: "Internal rule, call with @my-rule"  # Manual
---
```

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
- **Precedence Note**: `alwaysApply` rules are always injected, but priority still determines the order when multiple rules apply

When two rules apply to the same file, the one with the lower numeric priority is inserted first. `alwaysApply` simply ensures a rule is active; it does not override priority.

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

#### Extending and Customizing Rules
1. Copy an existing rule from `.cursor/rules` and adjust the front matter.
2. Reference reusable code under `templates/` with `@templates/<file>`.
3. Increase the `priority` number to override default behavior.
4. Commit the new rule so it is shared with your team.

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
- **Git Integration**: Pre-commit hooks run lint and tests before each commit
- **CI Pipelines**: Mirror the pre-commit checks in your build server
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

## 🚦 Adding Cursor to Existing Projects

> **Quick guide for integrating Cursor AI into existing codebases**

### 🚀 Quick Integration (5 minutes)

#### 1. Backup & Copy
```bash
# Backup your project
git add -A && git commit -m "Backup before Cursor integration"

# Copy Cursor configuration
cp -r path/to/98-Cursor/.cursor ./
```

#### 2. Configure Rules
```bash
# Rules are automatically loaded from .cursor/rules/
# Models are configured through Cursor Settings > Models
# No additional configuration files needed
```

#### 3. Test & Validate
```bash
# Reload rules in Cursor
# Ctrl+Shift+P → "Cursor: Reload Rules"

# Test with simple prompt
# "@filename refactor this function"
```

### 🔧 Handle Conflicts

#### Existing Linters/Formatters
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

#### Existing Code Standards
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

### 🎯 Language-Specific Migration

#### Python Projects
```bash
# If you have existing Python configs, they'll work together
cp .cursor/rules/100-python-specific.mdc .cursor/rules/
# Cursor respects your existing pylint/black/mypy configs
```

#### TypeScript Projects
```bash
# Works with existing tsconfig.json and eslint
cp .cursor/rules/110-typescript-specific.mdc .cursor/rules/
# No need to change existing configs
```

#### Large/Enterprise Projects
```bash
# Start minimal, expand gradually
cp .cursor/rules/001-base.mdc .cursor/rules/
cp .cursor/rules/020-safety.mdc .cursor/rules/
# Add more rules after team gets comfortable
```

### 🔍 Migration Troubleshooting

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

> **Key Point**: Don't overthink it. Copy the configs, update the model names, test it works. You can customize later based on actual usage.

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

---

# Cursor AI Interaction Patterns

> **Master the art of effective AI collaboration with proven interaction patterns, habits, and memory aids.**

---

## 📁 Directory Contents

```
interaction-patterns/
├── README.md                    # This guide
├── 10-core-habits.md          # Core interaction habits
├── memory-aids.md              # Slogans & mnemonics
├── prompt-templates.md         # Ready-to-use prompts
├── workflow-examples.md        # Real workflow examples
└── troubleshooting-patterns.md # Common issues & solutions
```

---

## 🎯 Purpose & Benefits

**Purpose:**
- **Maximize AI Productivity**: Learn proven patterns that work consistently
- **Reduce Frustration**: Avoid common pitfalls and miscommunications
- **Build Muscle Memory**: Develop instinctive good habits through practice
- **Team Consistency**: Standardize AI interaction across your team

**Benefits:**
- ✅ **Faster Results**: Get better outputs with less back-and-forth
- ✅ **Fewer Errors**: Reduce hallucinations and misunderstandings
- ✅ **Better Code Quality**: Consistent application of best practices
- ✅ **Time Savings**: Spend less time correcting AI mistakes

---

## 🎯 Core Memory Aid

### Master Slogan
**"Break-Ask-Select-Control, Test-List-Multi-Low"**

### Mnemonic Poem
```
Break tasks small, write the list,
Select code changes, don't get missed;
Red then green, test then do,
Confirm first, avoid the blues;
Multi-model prevents hallucination,
Long chats need conversation rotation.
```

## 📚 The 10 Core Interaction Habits

| # | Habit | Practice | Why It Works |
|---|-------|----------|--------------|
| 1 | **Break Tasks Small** | Split complex tasks into clear steps | Reduces complexity, improves accuracy |
| 2 | **Test-First Approach** | Write tests before implementation | Ensures quality, prevents regressions |
| 3 | **Use File References** | Use `@path/to/file` to inject key code | Provides precise context |
| 4 | **Select Relevant Code** | Highlight only the most relevant sections | Focuses AI attention |
| 5 | **AI Confirmation** | Have AI repeat understanding first | Prevents misunderstandings |
| 6 | **Strategic Max Mode** | Use Max mode only for major changes | Balances power with efficiency |
| 7 | **Action-Verb Prompts** | Start commands with action verbs | Creates clear requests |
| 8 | **Question Endings** | End prompts with "Any questions?" | Encourages clarification |
| 9 | **Multi-Model Validation** | Enable multi-model comparison | Cross-validates responses |
| 10 | **Conversation Limits** | Start new chat after 50+ exchanges | Prevents context pollution |

## 🚀 Ready-to-Use Prompt Templates

### Code Review Pattern
```
@filename review this code for:
- Logic errors
- Performance issues
- Security vulnerabilities
- Code style violations

Any questions about the requirements?
```

### Refactoring Pattern
```
Selected code needs refactoring to:
1. Extract reusable functions
2. Improve readability
3. Add proper error handling

Please confirm understanding before proceeding.
```

### Test-Driven Development Pattern
```
Write failing tests for this feature:
[describe feature requirements]

Then implement the minimal code to make tests pass.
Use @test_file for existing test patterns.
```

### Bug Fix Pattern
```
Issue: [clear problem description]
Expected: [what should happen]
Actual: [what happens instead]

@relevant_file shows the current implementation.
Please identify root cause before suggesting fixes.
```

## 🔍 Pattern Categories

### 🎯 Precision Patterns
**Goal**: Get exactly what you want
- **File References**: `@path/to/file` for context
- **Code Selection**: Highlight relevant sections only
- **Confirmation Loop**: "Please confirm you understand X"

### 🛡️ Safety Patterns
**Goal**: Prevent errors and hallucinations
- **Task Decomposition**: Break complex requests into steps
- **Resource Management**: Use Max mode sparingly
- **Validation**: Multi-model comparison for critical decisions
- **Context Hygiene**: Fresh conversations prevent pollution

### ⚡ Efficiency Patterns
**Goal**: Maximize productivity
- **Test-Driven**: Write tests first to clarify requirements
- **Action Verbs**: "Refactor", "Add", "Fix" vs vague descriptions
- **Open Questions**: Invite clarification to prevent assumptions

## 🎯 Quick Practice Guide

### Week 1: Foundation
- [ ] Practice file references: `@filename` in every prompt
- [ ] Break one complex task into 3 smaller tasks
- [ ] End 5 prompts with "Any questions?"
- [ ] Try test-first approach on one feature

### Week 2: Habits
- [ ] Use code selection before asking for changes
- [ ] Practice confirmation pattern: AI repeats requirements
- [ ] Monitor conversation length, start fresh when needed
- [ ] Experiment with action-verb prompts

### Week 3: Mastery
- [ ] Memorize the mnemonic poem
- [ ] Teach patterns to a colleague
- [ ] Create custom prompt templates
- [ ] Track improvement in AI interaction quality

## 🔧 Common Mistakes to Avoid

❌ **Vague requests**: "Make this better"
✅ **Specific actions**: "Refactor this function to reduce cyclomatic complexity"

❌ **No context**: Asking about code without file references
✅ **Rich context**: `@filename` + selected code + clear requirements

❌ **Long conversations**: 100+ exchanges in one chat
✅ **Fresh starts**: New conversation when context gets polluted

❌ **Assuming understanding**: "You know what I mean"
✅ **Explicit confirmation**: "Please confirm you understand the requirements"

## 📊 Success Metrics

**Quantitative:**
- Fewer iterations per task
- Less time correcting AI mistakes
- Faster task completion
- Lower token usage

**Qualitative:**
- Less frustration with AI responses
- More confidence in AI-generated code
- Better team collaboration
- Cleaner, more maintainable code

---

> **Remember**: These patterns work best when they become automatic. Practice consistently until they feel natural.

---

## 📚 Related Resources

- [Core Configuration](./.cursor/README.md) - Understanding rule files
- [Examples](./examples/README.md) - Ready-to-use templates
- [Team Rules](./team-rules-examples/README.md) - Team collaboration
- [Migration Guide](./migration-guides/README.md) - Adding to existing projects

---

## 🤝 Contributing

### Share Your Patterns

- **Document successful patterns** you've discovered
- **Share failure stories** and what you learned
- **Contribute prompt templates** for common scenarios
- **Suggest improvements** to existing habits

### Community Guidelines

1. **Test before sharing**: Verify patterns work consistently
2. **Provide examples**: Include real-world usage scenarios
3. **Explain the why**: Don't just show what, explain why it works
4. **Keep it practical**: Focus on actionable advice over theory

---

**Next Steps:**
1. Start with the [10 Core Habits](interaction-patterns/10-core-habits.md)
2. Practice with [Prompt Templates](interaction-patterns/prompt-templates.md)
3. Study [Workflow Examples](interaction-patterns/workflow-examples.md)
4. Troubleshoot with [Common Patterns](interaction-patterns/troubleshooting-patterns.md)