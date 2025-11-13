---
description: "Firebase 数据结构与安全规则 - 检查清单"
scopes: [chat, edit]
tags: [firebase, firestore, security-rules, checklist]
priority: 100
globs: ["**/*Firebase*.swift", "**/*Firestore*.swift"]
alwaysApply: false
---

# Firebase 检查清单

> **触发条件**: 编辑 Firebase/Firestore 相关文件时自动加载  
> **详细参考**: `docs/04-implementation/firebase-schema.md`

---

## ⚠️ 操作前必须完成

### 1. 读取 Firebase Schema 文档

- [ ] **必读**: `docs/04-implementation/firebase-schema.md`
  - 确认数据表结构
  - 确认字段定义
  - 确认文档 ID 生成规则

### 2. 验证路径格式

- [ ] 路径段数为偶数（collection/document）
- [ ] 使用文档定义的路径（不随意发明）
- [ ] 避免奇数段路径（如 `users/{userId}/trainingPlans/framework`）

### 3. 检查 Security Rules

- [ ] 打开 `backend/firestore.rules`
- [ ] 确认对应 collection 有 match 规则
- [ ] 确认使用 `isOwner(userId)` 校验

### 4. 确认 DTO 字段完整

- [ ] 包含 `userId` 字段（用于 Security Rules）
- [ ] 包含 `id` 字段（文档主键）
- [ ] 所有必需字段都已定义

### 5. 使用标准 FirebaseService 方法

- [ ] 优先使用 `saveTrainingPlan()` 等专用方法
- [ ] 避免直接调用 `saveData(path:data:)`（容易出错）
- [ ] 使用 Mapper 转换（DTO ↔ Dictionary）

---

## 🔴 核心约束

### Firestore 路径规则（强制）⭐⭐⭐⭐⭐

#### 1. 路径格式：collection/document/collection/document

```markdown
✅ 正确：trainingPlans/{planId}（2段）
✅ 正确：users/{userId}/settings/profile（4段）
❌ 错误：users/{userId}/trainingPlans/framework（3段 - 奇数）
```

#### 2. 扁平结构优先（性能考虑）

| 表名 | 路径 | 查询方式 |
|---|---|---|
| trainingPlans | trainingPlans/{planId} | where('userId', '==', uid) |
| trainingGoals | trainingGoals/{goalId} | where('userId', '==', uid) |
| trainingLogs | trainingLogs/{logId} | where('userId', '==', uid) |

#### 3. 嵌套结构仅用于"1对1强依赖"

```markdown
✅ users/{userId}/settings/profile（设置属于用户）
❌ users/{userId}/trainingPlans/{planId}（计划可独立查询）
```

#### 4. 所有文档必须包含 userId 字段

**原因**：
- 用于 Security Rules 校验
- 用于 GDPR 删除查询
- 用于多设备同步过滤

#### 5. Security Rules 检查清单

- [ ] 每个 collection 都有对应的 match 规则
- [ ] 使用 `isOwner(userId)` 检查所有权
- [ ] create 时校验 `request.resource.data.userId`
- [ ] read/write 时校验 `resource.data.userId`

#### 6. firebase-schema.md 是权威定义

**优先级**：
```
firebase-schema.md > 代码实现
```

**规则**：
- 如果代码与文档冲突，以文档为准
- 修改数据结构必须先更新 firebase-schema.md

---

## ❌ 常见错误（Week 6 教训）

### 错误 1：随意发明路径（未查阅 firebase-schema.md）

**错误示例**：
```swift
let path = "users/\(userId)/trainingPlans/framework"
```

**问题**：
- 奇数段路径无效
- 未定义在 schema 中

**正确做法**：
```swift
// 查阅 firebase-schema.md，使用标准路径
firebaseService.saveTrainingPlan(dto) // → trainingPlans/{planId}
```

### 错误 2：忘记添加 Security Rules

**结果**：
```
Error: Permission denied
```

**正确做法**：
1. 在 `backend/firestore.rules` 中添加规则
2. 使用 `isOwner(userId)` 校验
3. 部署规则后测试

### 错误 3：使用嵌套结构（应该用扁平 + where 查询）

**问题**：
- 查询性能差
- GDPR 删除复杂

**正确做法**：
```swift
// ❌ 嵌套：users/{userId}/trainingPlans/{planId}
// ✅ 扁平：trainingPlans/{planId}
//    查询：where("userId", isEqualTo: userId)
```

### 错误 4：文档缺少 userId 字段

**结果**：
- Security Rules 失效
- 数据泄露风险

**正确做法**：
```swift
struct TrainingPlanDTO: Codable {
    let id: String
    let userId: String  // ⭐ 必须
    // ... 其他字段
}
```

---

## 📋 操作步骤模板

### 保存数据到 Firebase

```swift
// Step 1: 读取 firebase-schema.md，确认路径
// 例如：trainingPlans/{planId}

// Step 2: 创建 DTO
let dto = TrainingPlanDTO(
    id: UUID().uuidString,
    userId: userId,  // ⭐ 必须
    // ... 其他字段
)

// Step 3: 使用 FirebaseService 保存
try await firebaseService.saveTrainingPlan(dto)

// Step 4: 验证 Security Rules
// 打开 backend/firestore.rules，确认有对应规则
```

### 查询数据

```swift
// Step 1: 读取 firebase-schema.md，确认路径和查询方式

// Step 2: 使用 where 查询（扁平结构）
let plans = try await firebaseService.fetchTrainingPlans(userId: userId)

// 内部实现：
// db.collection("trainingPlans")
//   .whereField("userId", isEqualTo: userId)
//   .getDocuments()
```

### GDPR 删除

```swift
// Step 1: 删除所有包含 userId 的文档

// 扁平结构很简单：
let collections = ["trainingPlans", "trainingGoals", "trainingLogs"]
for collection in collections {
    let docs = db.collection(collection)
        .whereField("userId", isEqualTo: userId)
        .getDocuments()
    for doc in docs.documents {
        try await doc.reference.delete()
    }
}

// 如果使用嵌套结构，需要递归删除（很麻烦）
```

---

## 🔗 详细参考

| 文档 | 内容 |
|------|------|
| `docs/04-implementation/firebase-schema.md` | ⭐ 完整数据结构定义（权威） |
| `backend/firestore.rules` | Security Rules 文件 |
| `200-project-overview-detailed.mdc` | § 5.5 Firebase 数据结构索引 |

---

**最后更新**: 2025-11-08  
**Token 估算**: ~1,300 tokens  
**加载方式**: Auto-attach（globs 匹配时）  
**优先级**: 100

