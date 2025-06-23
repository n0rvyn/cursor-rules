# Team Cursor Rules Setup Guide

> **Focus**: Practical guidance for setting up shared Cursor AI rules across development teams

## 🎯 Quick Team Setup

### 1. Create Team Rules Repository
```bash
# Initialize team rules repo
git init cursor-team-rules
cd cursor-team-rules

# Copy and customize base rules
cp -r ../98-Cursor/.cursor/rules/* ./rules/
cp -r ../98-Cursor/team-rules-examples/languages ./
cp -r ../98-Cursor/team-rules-examples/projects ./

# Customize for your team
git add . && git commit -m "Initial team Cursor rules"
git push origin main
```

### 2. Add to Team Projects
```bash
# Method 1: Git submodule (recommended)
git submodule add https://github.com/yourorg/cursor-team-rules .cursor/team

# Method 2: Copy and sync manually
cp -r cursor-team-rules/rules/* .cursor/rules/
```

### 3. Project Configuration
```bash
# Team rules are automatically loaded from .cursor/rules/
# Simply ensure team rules are present in the rules directory
ln -s .cursor/team/shared/* .cursor/rules/
ln -s .cursor/team/languages/typescript/* .cursor/rules/
```

## 📁 Team Rules Structure

```
cursor-team-rules/
├── shared/
│   └── 010-security-baseline.mdc    # Security requirements for all projects
├── languages/
│   ├── go/
│   │   └── go-specific.mdc          # Go language conventions
│   └── swift/
│       └── swift-specific.mdc       # Swift language conventions
├── projects/
│   ├── ios-app/
│   │   └── ios-project.mdc          # iPhone app project rules
│   └── web-api/
│       └── api-project.mdc          # Web API specific rules
└── enterprise/
    └── governance/
        └── approval-process.mdc     # Enterprise approval workflows
```

## 🛠️ Available Templates

### Language-Specific Rules
- **Go**: `languages/go/go-specific.mdc` - Idiomatic Go patterns, error handling, concurrency
- **Python**: Already in core rules as `100-python-specific.mdc`
- **TypeScript**: Already in core rules as `110-typescript-specific.mdc`
- **Swift**: `languages/swift/swift-specific.mdc` - SwiftLint, SPM, XCTest patterns

### Project-Type Rules
- **Web API**: `projects/web-api/api-project.mdc` - RESTful patterns, OpenAPI docs
- **iOS App**: `projects/ios-app/ios-project.mdc` - Xcode workspace, SwiftUI guidelines
- **Security**: `shared/010-security-baseline.mdc` - Basic security requirements

### Enterprise Features
- **Approval Process**: `enterprise/governance/approval-process.mdc` - Code review workflows

## 🔄 Synchronization Strategies

### Option 1: Git Submodules (Recommended)
```bash
# Team members update rules
git submodule update --remote .cursor/team

# Commit the update
git add .cursor/team
git commit -m "Update team Cursor rules"
```

### Option 2: CI/CD Sync
```yaml
# .github/workflows/sync-cursor-rules.yml
name: Sync Cursor Rules
on:
  schedule:
    - cron: '0 9 * * 1'  # Weekly on Monday
jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Download latest team rules
        run: |
          curl -L https://github.com/yourorg/cursor-team-rules/archive/main.zip -o rules.zip
          unzip rules.zip
          cp -r cursor-team-rules-main/rules/* .cursor/rules/
      - name: Create PR
        uses: peter-evans/create-pull-request@v3
        with:
          title: 'Update team Cursor rules'
```

### Option 3: Package Manager
```json
// package.json (for Node.js projects)
{
  "scripts": {
    "setup-cursor": "npx @yourorg/cursor-rules-cli install"
  },
  "devDependencies": {
    "@yourorg/cursor-rules": "^1.0.0"
  }
}
```

## 🔧 Customization Guidelines

### Adding Company-Specific Rules
```bash
# Create company-specific rule
cat > .cursor/rules/900-company.mdc << 'EOF'
---
description: Our company specific conventions
priority: 900
---

# Company Standards
- Use our internal logging library: `import { logger } from '@company/logger'`
- API responses must follow our error schema
- All database queries must use our ORM wrapper
EOF
```

### Context-Specific Rules
```mdc
---
description: Staging environment specific rules
priority: 950
globs: ["staging/**/*", "**/*.staging.*"]
---

# Staging Environment Rules
- Allow experimental features for testing
- Use verbose logging for debugging
- Less strict validation for rapid iteration
```

## 📊 Team Adoption Metrics

Track team adoption success:
- **Setup Time**: How long to configure new projects
- **Rule Compliance**: Percentage of code following team standards
- **Developer Satisfaction**: Survey team on AI assistance quality
- **Code Review Time**: Reduction in review cycles due to consistency

## 🚀 Best Practices

### Start Small
- Begin with 2-3 core rules
- Add language-specific rules gradually
- Get team buy-in before adding complex rules

### Iterate Based on Usage
- Monitor which rules are most helpful
- Remove rules that cause confusion
- Adjust based on team feedback

### Document Decisions
- Explain why each rule exists
- Provide examples of good/bad code
- Link to relevant style guides or standards

### Version Control
- Tag rule releases for stability
- Use semantic versioning
- Document breaking changes

---

> **Key Principle**: Team rules should enhance productivity, not create bureaucracy. Focus on rules that directly improve AI assistance quality.
