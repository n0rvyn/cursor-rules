---
description: "SwiftData 数据模型 - 检查清单"
scopes: [chat, edit]
tags: [swiftdata, data-model, dto, mapper, checklist]
priority: 105
globs: ["**/*Model*.swift", "**/Cached*.swift"]
alwaysApply: false
---

# SwiftData 数据模型检查清单

> **触发条件**: 编辑数据模型文件时自动加载  
> **详细参考**: `docs/04-implementation/swiftdata-schema.md`

---

## 🔴 核心约束

### 双 Model 架构（强制）⭐⭐⭐⭐⭐

```
Firebase DTO (struct, Codable) ↔ Mapper ↔ SwiftData Model (class, @Model)
```

#### 命名规范

```swift
// ✅ SwiftData Model: Cached{Entity}
@Model
class CachedTrainingLog {
    var id: String
    var userId: String
    var date: Date
    // ...
}

// ✅ Firebase DTO: {Entity}DTO
struct TrainingLogDTO: Codable {
    let id: String
    let userId: String
    let date: Date
    // ...
}

// ✅ Mapper: {Entity}Mapper
struct TrainingLogMapper {
    static func toSwiftData(_ dto: TrainingLogDTO) -> CachedTrainingLog {
        // ...
    }
    
    static func toDTO(_ model: CachedTrainingLog) -> TrainingLogDTO {
        // ...
    }
}
```

### 关键规则

#### 1. 关系设计必须指定 deleteRule

```swift
@Model
class CachedTrainingPlan {
    @Relationship(deleteRule: .cascade)
    var weeks: [CachedWeekPlan]
}
```

#### 2. 所有 Model 必须支持软删除

```swift
@Model
class CachedTrainingLog {
    var deletedAt: Date?  // ⭐ 软删除
}

// 查询时过滤已删除
let descriptor = FetchDescriptor<CachedTrainingLog>(
    predicate: #Predicate { $0.deletedAt == nil }
)
```

#### 3. 时间戳字段（用于同步）

```swift
@Model
class CachedTrainingLog {
    var lastModifiedMs: Double  // ⭐ 毫秒级时间戳
    var lastSyncedMs: Double?   // 上次同步时间
    var createdAt: Date
    var updatedAt: Date
}
```

---

## 📋 操作步骤模板

### 创建新的数据模型

```swift
// Step 1: 定义 Firebase DTO
struct TrainingLogDTO: Codable {
    let id: String
    let userId: String
    let healthKitWorkoutId: String
    let date: Date
    let userNotes: String?
    let rpe: Int?
    let lastModifiedMs: Double
}

// Step 2: 定义 SwiftData Model
@Model
class CachedTrainingLog {
    @Attribute(.unique) var id: String
    var userId: String
    var healthKitWorkoutId: String
    var date: Date
    var userNotes: String?
    var rpe: Int?
    var lastModifiedMs: Double
    var lastSyncedMs: Double?
    var deletedAt: Date?
    
    init(id: String, userId: String, ...) {
        self.id = id
        self.userId = userId
        // ...
        self.lastModifiedMs = Date().timeIntervalSince1970 * 1000
    }
}

// Step 3: 定义 Mapper
struct TrainingLogMapper {
    static func toSwiftData(_ dto: TrainingLogDTO) -> CachedTrainingLog {
        CachedTrainingLog(
            id: dto.id,
            userId: dto.userId,
            // ... 映射所有字段
        )
    }
    
    static func toDTO(_ model: CachedTrainingLog) -> TrainingLogDTO {
        TrainingLogDTO(
            id: model.id,
            userId: model.userId,
            // ... 映射所有字段
        )
    }
}
```

---

## 🔗 详细参考

| 文档 | 内容 |
|------|------|
| `docs/04-implementation/swiftdata-schema.md` | ⭐ 完整数据模型架构（必读） |

---

**最后更新**: 2025-11-08  
**Token 估算**: ~800 tokens  
**加载方式**: Auto-attach（globs 匹配时）  
**优先级**: 105

