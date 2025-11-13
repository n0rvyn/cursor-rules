---
description: "离线同步与冲突解决 - 检查清单"
scopes: [chat, edit]
tags: [offline-sync, conflict-resolution, checklist]
priority: 103
globs: ["**/*Sync*.swift"]
alwaysApply: false
---

# 离线同步检查清单

> **触发条件**: 编辑同步相关文件时自动加载  
> **详细参考**: `docs/03-decisions/ADR-010-offline-sync-strategy.md`

---

## 🔴 核心约束

### 冲突解决规则 ⭐⭐⭐⭐⭐

#### MVP 阶段（Week 1-12）

**统一策略**：所有数据类型使用 **Last Write Wins**

```swift
// 基于毫秒级时间戳判断
func resolveConflict<T>(local: T, remote: T) -> T where T: Syncable {
    return local.lastModifiedMs > remote.lastModifiedMs ? local : remote
}
```

#### V1.1 实现（未来）

| 数据类型 | 冲突策略 | 原因 |
|---|---|---|
| 训练记录 (Log) | Last Write Wins | 用户数据，以最新为准 |
| 训练计划 (Plan) | Server Wins | AI 生成，服务端权威 |
| 用户配置 (Profile) | Merge | 字段级合并 |

### 离线优先原则（所有阶段）

```swift
// 1. 读取优先本地（<100ms）
let logs = try modelContext.fetch(descriptor)

// 2. 写入先存本地（不阻塞用户）
modelContext.insert(newLog)
try modelContext.save()

// 3. 后台自动同步（检测网络后上传）
Task.detached {
    try await syncService.uploadPendingChanges()
}

// 4. 使用 PendingSyncOperation 队列管理未同步数据
let operation = PendingSyncOperation(
    entityType: .trainingLog,
    operation: .create,
    payload: logData
)
modelContext.insert(operation)
```

---

## 📋 操作步骤模板

### 保存数据（离线优先）

```swift
// Step 1: 先存本地
let log = CachedTrainingLog(...)
log.lastModifiedMs = Date().timeIntervalSince1970 * 1000
modelContext.insert(log)
try modelContext.save()

// Step 2: 创建 PendingSyncOperation
let operation = PendingSyncOperation(
    entityType: "TrainingLog",
    operation: "create",
    entityId: log.id,
    payload: try JSONEncoder().encode(log.toDTO()),
    timestamp: Date()
)
modelContext.insert(operation)
try modelContext.save()

// Step 3: 后台同步
Task.detached {
    try await syncService.processPendingOperations()
}
```

### 冲突解决（Last Write Wins）

```swift
func syncTrainingLog(localLog: CachedTrainingLog, remoteDTO: TrainingLogDTO) throws {
    // MVP: 简单比较时间戳
    if remoteDTO.lastModifiedMs > localLog.lastModifiedMs {
        // 服务端更新
        localLog.updateFrom(dto: remoteDTO)
    } else {
        // 本地更新
        try await firebaseService.saveTrainingLog(localLog.toDTO())
    }
    
    localLog.lastSyncedMs = Date().timeIntervalSince1970 * 1000
    try modelContext.save()
}
```

---

## 🔗 详细参考

| 文档 | 内容 |
|------|------|
| `docs/03-decisions/ADR-010-offline-sync-strategy.md` | ⭐ 完整同步策略（必读） |

---

**最后更新**: 2025-11-08  
**Token 估算**: ~800 tokens  
**加载方式**: Auto-attach（globs 匹配时）  
**优先级**: 103

