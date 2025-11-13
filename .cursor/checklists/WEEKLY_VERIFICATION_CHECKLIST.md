# Weekly Verification Checklist

> **Purpose**: Ensure every week's implementation is complete and verified BEFORE moving to next week

---

## 📚 相关 Checklist 快速参考

**如果验证失败，根据问题类型使用**：
- 🐛 **FIX-CHECKLIST.md** - Build 失败、测试失败、功能 bug
- 📝 **CODE-REVIEW-CHECKLIST.md** - 代码质量问题、规范违反
- 🔄 **REFACTOR-CHECKLIST.md** - 需要重构（代码混乱、性能差）

---

## 🔴 MUST DO After Every Week

### 1. Build Verification (5 min)
```bash
cd /Users/norvyn/Code/Projects/Epoch
xcodebuild -scheme Epoch -destination 'generic/platform=iOS' build
```

**Requirement**: **BUILD SUCCEEDED** with **0 errors**

**❌ If Build Fails**: 使用 **@FIX-CHECKLIST.md** 进行根因分析和修复

---

### 2. Linter Check (1 min)
In Cursor AI, check all modified files for linter errors.

**Requirement**: **0 linter errors**

---

### 3. Code Review Checklist (5 min)

**快速自检**（详细版见 **CODE-REVIEW-CHECKLIST.md**）：

**架构层面**：
- [ ] All new files added to Xcode project
- [ ] MVVM pattern followed (ViewModel 有 `@MainActor`, Service 是 `actor`)
- [ ] Dependency injection used (Protocol + Mock)

**代码质量**：
- [ ] No hardcoded values (use constants)
- [ ] No commented-out code
- [ ] No `print()` debug code (use Logger)
- [ ] All TODOs addressed or documented
- [ ] Naming conventions followed (SwiftData `Cached` prefix, DTO `DTO` suffix)
- [ ] Error handling complete (no `try!`)

**测试覆盖**：
- [ ] Core logic has unit tests (data layer 100%, business logic ≥75%)
- [ ] Mocks created for all new Services

**💡 提示**：如果任何检查点失败，参考 **CODE-REVIEW-CHECKLIST.md** 的详细说明

---

### 4. Documentation Updates (3 min)

- [ ] `file-structure.md` updated with new files
- [ ] `YYYY-MM.md` changelog updated
- [ ] Week completion summary created (`.cursor/docs/`)

---

### 5. Real Device Test (10-15 min)

**Basic Smoke Test**:
1. Install app on iPhone (测试设备：iPhone 15 Pro, iOS 18.x)
2. Login with test account
3. Navigate through main features
4. Check new week's feature works
5. No crashes or freezes

**Regression Test**（快速检查核心流程）：
- [ ] Onboarding flow works (if applicable)
- [ ] Training plan generation works
- [ ] Data sync works (Firebase ↔ SwiftData)
- [ ] HealthKit integration works (if applicable)

**Performance Check**（快速评估）：
- [ ] App launch time <2s (从点击图标到首屏显示)
- [ ] No obvious UI lag (滚动流畅)
- [ ] No memory warnings

**Requirement**: 
- ✅ App runs without crashes
- ✅ Core features work
- ✅ Performance acceptable

**❌ If Test Fails**: 使用 **@FIX-CHECKLIST.md** 排查问题

---

### 6. Update MVP Plan (2 min)

Mark week as complete in `docs/09-roadmap/mvp-plan.md`:

```markdown
### Week X: [Feature Name] ✅

**状态**: ✅ 已完成（YYYY-MM-DD）
**评分**: 9/10
**完成度**: 95% (18/19 任务)

**详细报告**: `.cursor/docs/YYYY-MM-DD_WeekX验收报告.md`
**Commit**: `abc1234`
```

---

## 📊 Week Completion Template

After completing all checks, create:

**File**: `.cursor/docs/YYYY-MM-DD_WeekX_Completion.md`

```markdown
# Week X Completion Report

## Build Status
- ✅ Build: SUCCEEDED
- ✅ Linter: 0 errors
- ✅ New Files: X files

## Testing
- ✅ Real device test passed
- ✅ No crashes
- ✅ Feature works as expected

## Documentation
- ✅ file-structure.md updated
- ✅ Changelog updated
- ✅ MVP plan updated

## Issues Found
- None / [List any issues]

## Next Week
- Ready for Week X+1
```

---

## 🚨 If Any Check Fails

**DO NOT PROCEED to next week!**

1. **识别问题类型**：
   - Build 失败 / 功能 bug → 使用 **FIX-CHECKLIST.md**
   - 代码质量问题 → 使用 **CODE-REVIEW-CHECKLIST.md**
   - 需要重构 → 使用 **REFACTOR-CHECKLIST.md**

2. **修复问题**：
   - 按照对应 Checklist 的流程
   - 记录修复过程到 changelog

3. **重新验证**：
   - Re-run ALL checks
   - 确保所有检查通过

4. **更新文档**：
   - 如果是重要教训，记录到 `docs/09-lessons-learned/`

---

## 📊 验收评分标准

**通过标准**（所有项必须达到）：
- ✅ Build: SUCCEEDED (0 errors)
- ✅ Linter: 0 errors
- ✅ Code Review: 所有检查点通过
- ✅ Documentation: 已更新
- ✅ Real Device: 核心功能正常，无崩溃
- ✅ Performance: 启动 <2s, 无明显卡顿

**可选加分项**：
- 🌟 测试覆盖率 >80%
- 🌟 性能优化（启动时间减少、内存占用降低）
- 🌟 代码复杂度降低（重构成功）

---

**Remember**: **Quality > Speed**. A broken week will cause problems later!

