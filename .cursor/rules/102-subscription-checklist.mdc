---
description: "订阅与 Premium 功能 - 检查清单"
scopes: [chat, edit]
tags: [subscription, premium, in-app-purchase, checklist]
priority: 102
globs: ["**/*Subscription*.swift", "**/*Premium*.swift"]
alwaysApply: false
---

# 订阅检查清单

> **触发条件**: 编辑订阅/Premium 相关文件时自动加载  
> **详细参考**: `docs/03-decisions/ADR-011-subscription-implementation.md`

---

## ⚠️ 操作前必须完成

### 1. 确认 Premium 功能定义

- [ ] 读取 `docs/01-product/subscription-tiers.md`（产品定义）
- [ ] 读取 `docs/03-decisions/ADR-011-subscription-implementation.md`（技术实现）

### 2. Premium 验证检查

- [ ] 所有 AI 功能调用前验证 Premium 状态
- [ ] 使用 Firebase Custom Claims：`user.customClaims['premium']`
- [ ] Premium 状态缓存：1 小时

---

## 🔴 核心约束

### Premium 功能限制表 ⭐⭐⭐⭐⭐

| 功能 | 免费用户 | Pro 用户 |
|---|---|---|
| AI 计划生成 | 1次/月 | 无限 |
| AI 即时反馈 | 3次/月 | 无限 |
| 对话式调整 | ❌ 不支持 | 无限 |
| 历史数据 | 90天 | 无限期 |

### Premium 验证流程

```swift
// ✅ 所有 AI 调用前必须验证
@MainActor
func generateTrainingPlan() async throws {
    // Step 1: 验证 Premium 状态
    guard let isPremium = user.customClaims['premium'] as? Bool,
          isPremium == true else {
        // Step 2: 检查免费额度
        let usageCount = try await checkUsageCount(for: .planGeneration)
        guard usageCount < 1 else {
            throw SubscriptionError.quotaExceeded
        }
    }
    
    // Step 3: 执行 AI 调用
    let plan = try await aiService.generatePlan(...)
    
    // Step 4: 更新使用次数（如果是免费用户）
    if !(isPremium ?? false) {
        try await incrementUsageCount(for: .planGeneration)
    }
}
```

### Custom Claims 管理

```swift
// Backend (Firebase Functions) 设置 Custom Claims
admin.auth().setCustomUserClaims(uid, { premium: true })

// iOS 读取 Custom Claims
let user = Auth.auth().currentUser
let isPremium = user?.customClaims?["premium"] as? Bool ?? false

// Premium 状态缓存（1 小时）
struct PremiumStatusCache {
    static var cachedStatus: Bool?
    static var cacheTime: Date?
    
    static func getPremiumStatus() async throws -> Bool {
        if let cached = cachedStatus,
           let time = cacheTime,
           Date().timeIntervalSince(time) < 3600 {  // 1 hour
            return cached
        }
        
        // 强制刷新 token
        try await Auth.auth().currentUser?.getIDTokenResult(forcingRefresh: true)
        let isPremium = Auth.auth().currentUser?.customClaims?["premium"] as? Bool ?? false
        
        cachedStatus = isPremium
        cacheTime = Date()
        return isPremium
    }
}
```

---

## 📋 操作步骤模板

### 保护 AI 功能

```swift
// Step 1: 检查 Premium 状态
let isPremium = try await PremiumStatusCache.getPremiumStatus()

// Step 2: 免费用户检查额度
if !isPremium {
    let usage = try await subscriptionService.getUsageCount(for: feature)
    let limit = subscriptionService.getFreeLimit(for: feature)
    
    guard usage < limit else {
        // 显示 Paywall
        throw SubscriptionError.quotaExceeded
    }
}

// Step 3: 执行功能
let result = try await executeFeature()

// Step 4: 记录使用（免费用户）
if !isPremium {
    try await subscriptionService.incrementUsage(for: feature)
}
```

### 收据验证（App Store Server API v2）

```swift
// MVP 阶段简化（客户端验证）
let result = try await StoreKit.verifyReceipt()

// V1.1 实现（服务端验证）
let result = try await backendService.verifyReceipt(receiptData)
```

---

## 🔗 详细参考

| 文档 | 内容 |
|------|------|
| `docs/03-decisions/ADR-011-subscription-implementation.md` | ⭐ 完整订阅策略（必读） |
| `docs/01-product/subscription-tiers.md` | 产品定义 |

---

**最后更新**: 2025-11-08  
**Token 估算**: ~1,000 tokens  
**加载方式**: Auto-attach（globs 匹配时）  
**优先级**: 102

