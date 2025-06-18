# Cursor AI Interaction Patterns | Cursor AI 交互模式

> **English**: Master the art of effective AI collaboration with proven interaction patterns, habits, and memory aids.
> 
> **中文**: 通过经过验证的交互模式、习惯和记忆辅助工具，掌握有效 AI 协作的艺术。

---

## 📁 Directory Contents | 目录内容

```
interaction-patterns/
├── README.md                    # This guide | 本指南
├── 10-core-habits.md          # Core interaction habits | 核心交互习惯
├── memory-aids.md              # Slogans & mnemonics | 口号与记忆法
├── prompt-templates.md         # Ready-to-use prompts | 即用提示模板
├── workflow-examples.md        # Real workflow examples | 真实工作流示例
└── troubleshooting-patterns.md # Common issues & solutions | 常见问题与解决方案
```

---

## 🎯 Purpose & Benefits | 目的与优势

### **English**

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

### **中文**

**目的:**
- **最大化 AI 生产力**: 学习一致有效的验证模式
- **减少挫折感**: 避免常见陷阱和误解
- **建立肌肉记忆**: 通过练习培养本能的好习惯
- **团队一致性**: 在团队中标准化 AI 交互

**优势:**
- ✅ **更快结果**: 用更少的往返获得更好的输出
- ✅ **更少错误**: 减少幻觉和误解
- ✅ **更好代码质量**: 一致应用最佳实践
- ✅ **节省时间**: 减少纠正 AI 错误的时间

---

## 🎯 Core Memory Aid | 核心记忆法

### Master Slogan | 主口号
**"拆-问-选-控制，测试-清单-多验-低噪"**

### Mnemonic Poem | 记忆顺口溜
```
拆成小步写清单，
选段修改免胡乱；
先红后绿测再干，
复述确认少翻船；
多模投票防幻觉，
长聊五十记断联。
```

## 📚 The 10 Core Interaction Habits

| # | Habit | Practice | Why It Works |
|---|-------|----------|--------------|
| 1 | **Break Tasks Small** | 任务拆小，先列清单 | Reduces complexity, improves accuracy |
| 2 | **Test-First Approach** | 先写测试，再写实现 | Ensures quality, prevents regressions |
| 3 | **Use File References** | 用 `@path/to/file` 注入关键代码 | Provides precise context |
| 4 | **Select Relevant Code** | 修改前只选中最相关片段 | Focuses AI attention |
| 5 | **AI Confirmation** | AI 先复述理解，再动手 | Prevents misunderstandings |
| 6 | **Strategic Max Mode** | 大改动才开 Max mode | Balances power with efficiency |
| 7 | **Action-Verb Prompts** | 指令用动词开头 | Creates clear requests |
| 8 | **Question Endings** | 提示末加 "Any questions?" | Encourages clarification |
| 9 | **Multi-Model Validation** | 启用多模型比对 | Cross-validates responses |
| 10 | **Conversation Limits** | 长对话 > 50 条就新开窗口 | Prevents context pollution |

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

## 📚 Related Resources | 相关资源

- [Core Configuration](../.cursor/README.md) - Understanding rule files
- [Examples](../examples/README.md) - Ready-to-use templates  
- [Team Rules](../team-rules-examples/README.md) - Team collaboration
- [Migration Guide](../migration-guides/README.md) - Adding to existing projects

---

## 🤝 Contributing | 贡献

### Share Your Patterns | 分享你的模式

**English:**
- **Document successful patterns** you've discovered
- **Share failure stories** and what you learned
- **Contribute prompt templates** for common scenarios
- **Suggest improvements** to existing habits

**中文:**
- **记录成功模式** 你发现的
- **分享失败故事** 和你学到的
- **贡献提示模板** 用于常见场景
- **建议改进** 现有习惯

### Community Guidelines | 社区指南

1. **Test before sharing**: Verify patterns work consistently
2. **Provide examples**: Include real-world usage scenarios
3. **Explain the why**: Don't just show what, explain why it works
4. **Keep it practical**: Focus on actionable advice over theory

---

**Next Steps | 下一步:**
1. Start with the [10 Core Habits](10-core-habits.md) | 从[10个核心习惯](10-core-habits.md)开始
2. Practice with [Prompt Templates](prompt-templates.md) | 用[提示模板](prompt-templates.md)练习
3. Study [Workflow Examples](workflow-examples.md) | 学习[工作流示例](workflow-examples.md)
4. Troubleshoot with [Common Patterns](troubleshooting-patterns.md) | 用[常见模式](troubleshooting-patterns.md)故障排除 