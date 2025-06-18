# Cursor Advanced Techniques Guide
# Cursor 高级技巧指南

> **Advanced configuration patterns and troubleshooting for professional Cursor usage**  
> **专业 Cursor 使用的高级配置模式和故障排除**

## 🎯 Advanced Configuration Patterns

### Environment-Specific Configuration
```jsonc
// .cursor/environments/development.json
{
  "model": "openai/gpt-4o",
  "temperature": 0.1,
  "contextLines": 300,
  "enableDebugMode": true,
  "excludePatterns": ["**/node_modules/**", "**/.git/**"]
}

// .cursor/environments/production.json
{
  "model": "anthropic/claude-3-opus",
  "temperature": 0.05,
  "contextLines": 150,
  "strictMode": true,
  "requireReview": true
}
```

### Performance Optimization
```jsonc
// .cursor/performance.json
{
  "contextPriority": {
    "openFiles": 10,        // Highest priority
    "selectedCode": 9,
    "recentFiles": 8,
    "projectFiles": 7,
    "gitChanges": 6
  },
  "caching": {
    "enabled": true,
    "ttl": 3600,
    "maxSize": "100MB"
  },
  "excludePatterns": [
    "**/node_modules/**",
    "**/dist/**",
    "**/.next/**",
    "**/coverage/**"
  ]
}
```

### Advanced Rule Patterns
```mdc
<!-- .cursor/rules/999-project-specific.mdc -->
---
description: Project-specific advanced patterns
globs: ["src/**/*.{ts,tsx}"]
priority: 999
---

# Advanced Patterns
- Use React Query for all API calls: `const { data } = useQuery(['key'], fetchFn)`
- Implement error boundaries for async components
- Use TypeScript discriminated unions for state management
- Follow our specific folder structure: `features/[feature]/[ui|api|hooks]`

## Context Injection
When modifying existing code:
1. Always examine the full file structure first
2. Consider impact on related components
3. Maintain existing patterns unless explicitly refactoring
```

## 🔍 Advanced Interaction Techniques

### Progressive Context Building
```bash
# Layer 1: Set domain context
"I'm working on a React e-commerce checkout flow..."

# Layer 2: Provide specific files
"@src/components/CheckoutForm.tsx @src/hooks/usePayment.ts"

# Layer 3: Define precise task
"Add Apple Pay integration. The button should appear when ApplePay.canMakePayments() returns true. Any questions?"
```

### Multi-Step Refactoring
```bash
# Step 1: Extract interface
"Extract a PaymentProvider interface from this payment processing code"

# Step 2: Implement variants
"Create implementations for Stripe, Apple Pay, and PayPal using the interface"

# Step 3: Integration
"Update the checkout component to use the new payment provider system"
```

### Validation Workflows
```bash
# Primary implementation
"Implement user authentication with JWT tokens"

# Security review
"Review this authentication implementation for security vulnerabilities"

# Performance check
"Analyze this authentication flow for performance bottlenecks"

# Integration test
"Create integration tests for the authentication flow"
```

## 🔧 Language-Specific Advanced Patterns

### Python Advanced Configuration
```mdc
---
description: Advanced Python patterns
globs: ["**/*.py"]
priority: 150
---

# Python Advanced Rules
- Use `typing.Protocol` for structural typing
- Implement async context managers with `__aenter__` and `__aexit__`
- Use `dataclasses` with `frozen=True` for immutable data
- Prefer `pathlib.Path` over `os.path` for file operations
- Use `pytest.mark.parametrize` for comprehensive test coverage

## FastAPI Specific
- Use dependency injection for database connections
- Implement proper exception handlers
- Use Pydantic models for request/response validation
- Add comprehensive OpenAPI documentation
```

### TypeScript Advanced Configuration
```mdc
---
description: Advanced TypeScript patterns
globs: ["**/*.{ts,tsx}"]
priority: 150
---

# TypeScript Advanced Rules
- Use `const assertions` for literal types: `as const`
- Implement branded types for domain modeling
- Use conditional types for advanced generics
- Prefer `unknown` over `any` for unsafe types
- Use template literal types for string manipulation

## React Specific
- Use `React.memo` with custom comparison for performance
- Implement proper error boundaries with componentDidCatch
- Use `useCallback` and `useMemo` strategically, not everywhere
- Prefer compound components over prop drilling
```

## 🔒 Security-Focused Patterns

### Input Validation Rules
```mdc
---
description: Security-focused validation
globs: ["**/*.{ts,js,py}"]
priority: 300
---

# Security Requirements
- All user inputs must be validated using schema validation
- Use parameterized queries, never string concatenation
- Implement rate limiting on all public endpoints
- Log security events but never log sensitive data
- Use HTTPS for all external communications

## Authentication Patterns
- Always hash passwords with bcrypt (min 12 rounds)
- Implement proper JWT token expiration
- Use CSRF tokens for state-changing operations
- Implement proper session management
```

## 🐛 Advanced Troubleshooting

### Rule Conflicts
```bash
# Diagnose rule conflicts
grep -r "description:" .cursor/rules/ | sort

# Check rule priority
find .cursor/rules -name "*.mdc" -exec grep -l "priority:" {} \;

# Validate YAML front matter
find .cursor/rules -name "*.mdc" -exec head -10 {} \; | grep -E "^---$"
```

### Performance Issues
```bash
# Check context size
# Look for files being included unnecessarily
du -sh .cursor/

# Identify large files in context
find . -name "*.log" -o -name "*.cache" | head -20

# Clean up ignored patterns
echo "Add these to .cursor/performance.json excludePatterns:"
find . -type d -name node_modules -o -name dist -o -name .git
```

### Model Switching Strategy
```jsonc
// .cursor/project.json - Dynamic model selection
{
  "modelSelection": {
    "rules": [
      {
        "condition": "fileType === 'python'",
        "model": "openai/gpt-4-turbo",
        "reason": "Better Python code generation"
      },
      {
        "condition": "taskType === 'refactoring'",
        "model": "anthropic/claude-3-opus",
        "reason": "Superior code analysis"
      },
      {
        "condition": "codebase.size > '10MB'",
        "model": "openai/gpt-4-turbo",
        "reason": "Better context handling"
      }
    ]
  }
}
```

## 🎛️ Advanced Prompt Engineering

### Constraint-Based Prompting
```
CONSTRAINTS:
- Use only stdlib Python modules
- Maximum function length: 15 lines  
- Add type hints for all parameters
- Include docstring with examples

TASK: Implement a rate limiter using the token bucket algorithm

CONTEXT: @src/utils/rate_limiter.py (existing interface)

VALIDATION: Please confirm constraints before implementing.
```

### Template-Based Requests
```
TEMPLATE: API Endpoint
- HTTP method and route
- Request/response schemas
- Authentication requirements
- Error handling
- Tests (happy path + 2 edge cases)

IMPLEMENT: User profile update endpoint
EXISTING: @src/api/users.py @src/models/user.py
```

## 📊 Success Metrics and Monitoring

### Code Quality Metrics
```python
# Track improvement over time
metrics = {
    "ai_suggestions_accepted": 0.75,    # Target: >70%
    "code_review_cycles": 1.2,          # Target: <2
    "bug_report_rate": 0.05,            # Target: <0.1 per feature
    "time_to_implementation": "45min",   # Track over time
}
```

### Rule Effectiveness Tracking
```bash
# Analyze rule usage patterns
find .cursor/rules -name "*.mdc" -exec basename {} \; | \
  xargs -I {} echo "Rule: {} - Last modified: $(stat -c %y .cursor/rules/{})"

# Monitor frequently triggered rules
tail -f cursor.log | grep "Rule applied" | sort | uniq -c
```

## 🔄 Continuous Improvement Process

### Weekly Review Checklist
- [ ] Review AI suggestion acceptance rates
- [ ] Identify patterns in rejected suggestions
- [ ] Update rules based on recurring issues
- [ ] Optimize exclude patterns for performance
- [ ] Gather team feedback on rule effectiveness

### Monthly Optimization
- [ ] Analyze codebase evolution and update rules
- [ ] Review and update environment configurations
- [ ] Evaluate new Cursor features and integration
- [ ] Update team rules repository
- [ ] Conduct rule effectiveness survey

---

> **Remember**: Advanced techniques should solve real problems. Don't add complexity unless it provides measurable value to your development workflow. 