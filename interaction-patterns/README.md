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

- [Core Configuration](../.cursor/README.md) - Understanding rule files
- [Examples](../examples/README.md) - Ready-to-use templates
- [Team Rules](../team-rules-examples/README.md) - Team collaboration
- [Migration Guide](../migration-guides/README.md) - Adding to existing projects

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
1. Start with the [10 Core Habits](10-core-habits.md)
2. Practice with [Prompt Templates](prompt-templates.md)
3. Study [Workflow Examples](workflow-examples.md)
4. Troubleshoot with [Common Patterns](troubleshooting-patterns.md)