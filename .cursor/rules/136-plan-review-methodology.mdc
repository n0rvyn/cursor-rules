
# 136: Multi-Perspective Plan Review Methodology

## Purpose
Prevent over-engineering by systematically reviewing plans from multiple critical perspectives before implementation. Catch theoretical compliance fixes that don't solve real user problems.

## The Five-Lens Review Framework

### 🚨 Lens 1: User Impact Reality Check
**Core Question**: What **user-facing problems** are we actually solving?

**Required Evidence**:
- [ ] Document specific user complaints or bug reports
- [ ] Show performance metrics indicating real problems
- [ ] Demonstrate crashes, errors, or UX issues
- [ ] Prove business impact (user retention, app store ratings)

**Red Flags**:
- ❌ "This violates best practices" (without user impact)
- ❌ "This might cause issues" (no evidence of actual issues)
- ❌ "Apple recommends..." (but users aren't affected)
- ❌ "Theoretical compliance" without measurable benefit

**Green Flags**:
- ✅ Console errors affecting users
- ✅ Performance metrics below targets
- ✅ User-reported bugs or crashes
- ✅ Measurable business impact

### ⚖️ Lens 2: Risk vs Benefit Analysis
**Core Question**: Is the implementation risk justified by the benefit?

**Risk Assessment Matrix**:
```
| Current Issues | Proposed Changes | Risk Level | Justification |
|----------------|------------------|------------|---------------|
| Real problems  | Targeted fixes   | LOW        | ✅ Justified |
| No problems    | Major changes    | HIGH       | ❌ Unjustified |
```

**Required Analysis**:
- [ ] Document what could break during implementation
- [ ] Estimate effort vs impact ratio
- [ ] Consider opportunity cost (what else could we build?)
- [ ] Assess rollback complexity if changes fail

### 🛠️ Lens 3: Anti-Overengineering Violation Check
**Core Question**: Are we fixing things that aren't broken?

**Violation Checklist**:
- [ ] **Evidence-First**: Did we find existing patterns solving similar problems?
- [ ] **Complexity ≤3/10**: Is the solution appropriately simple?
- [ ] **Pattern Compliance**: Are we following established working patterns?
- [ ] **Real Problems**: Are we solving actual issues or perceived ones?

**Common Violations**:
- ❌ "Multiple X instances violate best practices" (no evidence of problems)
- ❌ "File is too large" (no evidence of compilation or maintenance issues)
- ❌ "Should use modern pattern Y" (current pattern works fine)
- ❌ "Architecture could be cleaner" (no measurable benefit)

### 🏗️ Lens 4: "Architecture is Already Excellent" View
**Core Question**: Are we recognizing and preserving what's working well?

**Success Pattern Recognition**:
- [ ] Recent successful optimizations (performance, memory, cache)
- [ ] Stable, working features with no user complaints  
- [ ] Patterns that have proven reliable over time
- [ ] Code that has weathered production usage successfully

**Protection Principle**: **Don't fix what isn't broken**
- If recent work solved real problems → Architecture is improving
- If users aren't complaining → Current patterns work
- If metrics are good → Don't chase theoretical improvements

### 🚀 Lens 5: "Ship Features, Not Compliance" View
**Core Question**: What's the opportunity cost of this work?

**Alternative Uses of Engineering Time**:
- [ ] New features users are requesting
- [ ] Performance improvements in user-visible areas
- [ ] Bug fixes for real issues users experience
- [ ] Developer experience improvements that speed up development

**Value Prioritization**:
1. **P0**: User-facing bugs and performance issues
2. **P1**: Requested features that add user value
3. **P2**: Developer experience improvements
4. **P3**: Architecture cleanup (only if no negative impact)
5. **P4**: Theoretical compliance (only if significant benefit proven)

## Implementation Protocol

### Phase 1: Multi-Lens Analysis (Required Before Any Plan)
```markdown
## PLAN REVIEW CHECKLIST

### 🚨 Lens 1: User Impact Reality Check
- **Problem Evidence**: [Link to user reports/metrics/console errors]
- **User Benefit**: [Specific, measurable improvement]
- **Business Impact**: [How this helps users/business]

### ⚖️ Lens 2: Risk vs Benefit Analysis  
- **Implementation Risk**: [High/Medium/Low + justification]
- **Benefit Level**: [High/Medium/Low + measurable outcomes]
- **Risk/Benefit Ratio**: [Justified/Questionable/Unjustified]

### 🛠️ Lens 3: Anti-Overengineering Check
- **Complexity Rating**: [X/10 + justification if >3/10]
- **Existing Patterns**: [Show similar working solutions]
- **Evidence-First**: [Cite file paths + line numbers]

### 🏗️ Lens 4: Current Architecture Assessment
- **What's Working Well**: [Recent successes, stable features]
- **Preservation Plan**: [How to avoid breaking good patterns]
- **Change Justification**: [Why current approach insufficient]

### 🚀 Lens 5: Opportunity Cost Analysis
- **Engineering Effort**: [Hours/complexity]
- **Alternative Uses**: [What else could we build?]
- **Prioritization**: [P0-P4 rating with justification]

## VERDICT: [PROCEED/MODIFY/CANCEL + reasoning]
```

### Phase 2: Red Flag Detection
**Automatic cancellation criteria** (any one triggers review halt):
- ❌ No evidence of user-facing problems
- ❌ Risk level HIGH + benefit level LOW/MEDIUM  
- ❌ Complexity >3/10 without explicit approval
- ❌ Modifying working patterns without strong justification
- ❌ Priority P3/P4 work when P0/P1 items exist

### Phase 3: Alternative Recommendation
**If plan fails review, always provide alternatives**:
1. **Evidence-First Approach**: How to validate problems actually exist
2. **Minimal Fix**: Smallest change that addresses real issues
3. **User Value Alternative**: Better use of engineering time
4. **Future Consideration**: When this might become appropriate

## Examples of Good vs Bad Plans

### ❌ Bad Plan Example
```
"Multiple HealthKit instances violate Apple best practices"
- No evidence of user problems
- No performance impact shown
- Changes 15+ working services
- High risk, theoretical benefit
```

### ✅ Good Plan Example  
```
"Console shows 7.386s load times, users report slow startup"
- Clear user problem with metrics
- Performance target missed (>16ms budget)
- Targeted fix for specific bottleneck
- Low risk, high measured benefit
```

## Rule Integration

**Before implementing any architectural plan**:
1. Run through all 5 lenses systematically
2. Document findings using the checklist template
3. Apply red flag detection criteria
4. Get explicit approval for any plan that fails initial review
5. Always provide alternative recommendations

**Success Criteria**:
- Plans solve real user problems with evidence
- Changes are proportional to benefit
- Working patterns are preserved and respected
- Engineering time is used for maximum user value

---

*This rule prevents the "5% compliance" trap by ensuring all architectural changes serve real user needs rather than theoretical best practices.*