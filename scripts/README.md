# Validation Scripts

> **Simple validation tools for Cursor configurations**

## 🔧 Available Scripts

### `validate-cursor-config.sh` - Configuration Validator

**What it does:**
- ✅ Validates JSON syntax in config files
- ✅ Checks MDC rule files for proper YAML front matter
- ✅ Identifies potential rule conflicts
- ✅ Reports errors with color-coded output

**Usage:**
```bash
# Validate current directory
./scripts/validate-cursor-config.sh

# Validate specific directory
./scripts/validate-cursor-config.sh path/to/.cursor

# Use in CI/CD
./scripts/validate-cursor-config.sh || exit 1
```

**Sample Output:**
```bash
🔍 Cursor Configuration Validator
[PASS] config.json: Model configuration found
[WARN] config.json: contextLines 500 might impact performance
[PASS] 100-python-specific.mdc: Rule file structure is valid
[PASS] No conflicting glob patterns found

✅ Passed: 3  ⚠️ Warnings: 1  ❌ Errors: 0
⚠️ Validation PASSED with warnings
```

## 🚀 CI/CD Integration

### GitHub Actions
```yaml
# .github/workflows/cursor-validation.yml
name: Validate Cursor Config
on: [push, pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate Configuration
        run: ./scripts/validate-cursor-config.sh
```

### GitLab CI
```yaml
# .gitlab-ci.yml
validate_cursor:
  script:
    - ./scripts/validate-cursor-config.sh
  only:
    changes:
      - .cursor/**/*
```

## 🔍 Common Validation Errors

**JSON Syntax Error:**
```bash
[ERROR] config.json: Invalid JSON syntax at line 5
# Fix: Check for missing commas, quotes, brackets
```

**Missing YAML Front Matter:**
```bash
[ERROR] custom.mdc: Missing YAML front matter
# Fix: Add --- at start and end of metadata
```

**Rule Conflicts:**
```bash
[WARN] Conflicting glob patterns: **/*.py vs src/**/*.py
# Fix: Make glob patterns more specific
```

---

> **Keep it simple**: The validator catches most common config errors. Run it before committing changes to avoid broken configurations. 