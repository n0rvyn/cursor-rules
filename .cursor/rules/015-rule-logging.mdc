---
description: "015: Log encountered rules and patterns for future reference"
scopes: [chat, edit]
tags: [logging, documentation, patterns]
priority: 15
globs:
alwaysApply: false
---

# Rule and Pattern Logging Protocol

## 🎯 Core Principle

> **"Log important rules and patterns discovered during development to avoid repeating the same analysis."**

## 📝 When to Log

### **Always Log** (High Priority):
- **User-specific preferences** that contradict general rules
- **Project-specific patterns** that differ from standard approaches
- **Architectural decisions** that affect multiple components
- **Workarounds** for framework or tool limitations
- **Performance optimizations** with measurable impact

### **Consider Logging** (Medium Priority):
- **New coding patterns** that could be reused
- **Configuration changes** that solved specific problems
- **Integration patterns** with external services
- **Testing strategies** that proved effective

### **Don't Log** (Low Priority):
- **Obvious or standard patterns** already documented
- **One-off solutions** unlikely to be reused
- **Temporary workarounds** that will be replaced
- **Personal preferences** without technical justification

## 📋 Logging Format

Use this simple format for rule entries:

```
## [Date] - [Brief Description]
**Context**: [What project/feature this applies to]
**Rule**: [The specific rule or pattern]
**Why**: [Why this rule exists - the problem it solves]
**When**: [When to apply this rule]
**Example**: [Brief code example or usage]
```

## 🗂️ Storage Strategy

### **Project-Specific Rules**:
- Add to existing `memory-bank/` files when relevant
- Create new files only for major new categories
- Use descriptive filenames: `memory-bank/project-patterns.md`

### **General Patterns**:
- Add to appropriate existing rule files
- Update rule descriptions if pattern becomes standard
- Cross-reference with related rules

### **User Preferences**:
- Document in `memory-bank/user-preferences.md`
- Include context about why preference exists
- Note any conflicts with standard practices

## 🔍 Quality Checklist

Before logging a rule, verify:
- [ ] **Clear problem**: The rule solves a specific, recurring problem
- [ ] **Actionable**: Others can follow the rule without confusion
- [ ] **Contextual**: Includes when and why to apply the rule
- [ ] **Non-obvious**: Not something that's already well-documented
- [ ] **Reusable**: Likely to be useful in future similar situations

## 🚫 Anti-Patterns

### **Don't Log**:
- **Every minor decision** - focus on significant patterns
- **Obvious solutions** - only log non-obvious approaches
- **Temporary fixes** - only log permanent solutions
- **Personal opinions** - only log technical justifications
- **Duplicate content** - check existing rules first

### **Avoid**:
- **Over-documentation** - too much logging slows development
- **Under-documentation** - important patterns get lost
- **Vague rules** - unclear when or how to apply
- **Outdated rules** - remove or update obsolete patterns

## ✅ Success Criteria

A good rule log entry:
- **Saves time** - prevents re-analyzing the same problem
- **Prevents mistakes** - helps avoid known pitfalls
- **Shares knowledge** - transfers insights to team members
- **Maintains consistency** - ensures similar problems get similar solutions
- **Stays current** - gets updated when patterns change

## 🔄 Maintenance

### **Regular Review**:
- **Monthly**: Review logged rules for relevance
- **After major changes**: Update rules that may be affected
- **When conflicts arise**: Resolve contradictions between rules
- **Archive old rules**: Move obsolete patterns to archive

### **Integration**:
- **Cross-reference** with existing rule files
- **Update descriptions** when patterns become standard
- **Merge similar rules** to avoid duplication
- **Link related rules** for better discoverability