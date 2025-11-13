---
description: "测试策略与覆盖率 - 检查清单"
scopes: [chat, edit]
tags: [testing, unit-tests, mocking, checklist]
priority: 104
globs: ["**/*Test*.swift", "**/*Tests.swift"]
alwaysApply: false
---

# 测试检查清单

> **触发条件**: 编辑测试文件时自动加载  
> **详细参考**: `docs/09-roadmap/testing-strategy.md`

---

## 🔴 核心约束

### 测试覆盖率要求 ⭐⭐⭐⭐⭐

| 模块 | 最低覆盖率 | 说明 |
|---|-----|---|
| 数据层核心 (SwiftData CRUD, Mapper) | 100% | 🔴 必须 |
| 数据层整体 | ≥80% | 🟡 推荐 |
| 业务逻辑 (计算、验证) | ≥75% | 🔴 必须 |
| ViewModel | ≥70% | 🟡 推荐 |
| View (UI) | ≥30% | 🟢 可选 |

### Protocol-based Mock（强制）

```swift
// ✅ 正确：先定义 Protocol
protocol HealthKitServiceProtocol {
    func fetchWorkouts() async throws -> [TrainingLog]
}

// 生产实现
actor HealthKitService: HealthKitServiceProtocol { }

// 测试实现
class MockHealthKitService: HealthKitServiceProtocol {
    var mockWorkouts: [TrainingLog] = []
    
    func fetchWorkouts() async throws -> [TrainingLog] {
        return mockWorkouts
    }
}

// ❌ 错误：Mock 前缀用于测试，不能在生产代码中使用
```

---

## 📋 操作步骤模板

### 创建单元测试

```swift
import XCTest
@testable import Epoch

final class TrainingLogViewModelTests: XCTestCase {
    var viewModel: TrainingLogViewModel!
    var mockHealthKit: MockHealthKitService!
    var mockModelContext: ModelContext!
    
    override func setUp() async throws {
        mockHealthKit = MockHealthKitService()
        mockModelContext = try ModelContext(...)
        viewModel = TrainingLogViewModel(
            healthKit: mockHealthKit,
            modelContext: mockModelContext
        )
    }
    
    func testFetchRecentLogs() async throws {
        // Given
        mockHealthKit.mockWorkouts = [
            createMockWorkout(distance: 5000, duration: 1800)
        ]
        
        // When
        try await viewModel.fetchRecentLogs()
        
        // Then
        XCTAssertEqual(viewModel.trainingLogs.count, 1)
        XCTAssertEqual(viewModel.trainingLogs[0].distance, 5000)
    }
}
```

---

## 🔗 详细参考

| 文档 | 内容 |
|------|------|
| `docs/09-roadmap/testing-strategy.md` | ⭐ 完整测试策略（必读） |

---

**最后更新**: 2025-11-08  
**Token 估算**: ~600 tokens  
**加载方式**: Auto-attach（globs 匹配时）  
**优先级**: 104

