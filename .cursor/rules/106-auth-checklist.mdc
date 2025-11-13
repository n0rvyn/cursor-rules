---
description: "认证与安全 - 检查清单"
scopes: [chat, edit]
tags: [authentication, firebase-auth, security, checklist]
priority: 106
globs: ["**/*Auth*.swift", "**/*Login*.swift"]
alwaysApply: false
---

# 认证检查清单

> **触发条件**: 编辑认证相关文件时自动加载  
> **详细参考**: `docs/03-decisions/ADR-009-backend-auth-strategy.md`

---

## 🔴 核心约束

### Token 验证流程 ⭐⭐⭐⭐⭐

#### 1. 所有 Backend 请求必须带 Firebase ID Token

```swift
// ✅ 正确
func callBackendAPI() async throws {
    guard let token = try await Auth.auth().currentUser?.getIDToken() else {
        throw AuthError.notAuthenticated
    }
    
    var request = URLRequest(url: backendURL)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let (data, _) = try await URLSession.shared.data(for: request)
    // ...
}

// ❌ 错误：不带 Token
var request = URLRequest(url: backendURL)
let (data, _) = try await URLSession.shared.data(for: request)
```

#### 2. Custom Claims 检查

```swift
// ✅ 检查 Premium 状态
guard let user = Auth.auth().currentUser,
      let isPremium = user.customClaims?["premium"] as? Bool,
      isPremium else {
    throw AuthError.notPremium
}
```

#### 3. MVP 阶段简化（Week 1-3）

```swift
// ⚠️ MVP 阶段：Backend 跳过 Token 验证
// Week 4+ 启用完整验证
```

---

## 📋 操作步骤模板

### 用户登录

```swift
// Step 1: Firebase 登录
let authResult = try await Auth.auth().signIn(withEmail: email, password: password)

// Step 2: 获取 ID Token
let token = try await authResult.user.getIDToken()

// Step 3: 获取 Custom Claims（如果需要）
let idTokenResult = try await authResult.user.getIDTokenResult()
let isPremium = idTokenResult.claims["premium"] as? Bool ?? false
```

### Token 刷新

```swift
// 自动刷新（Firebase SDK）
let token = try await Auth.auth().currentUser?.getIDToken(forcingRefresh: true)

// 失败时重新登录
catch {
    // 提示用户重新登录
}
```

---

## 🔗 详细参考

| 文档 | 内容 |
|------|------|
| `docs/03-decisions/ADR-009-backend-auth-strategy.md` | ⭐ 完整认证策略（必读） |

---

**最后更新**: 2025-11-08  
**Token 估算**: ~600 tokens  
**加载方式**: Auto-attach（globs 匹配时）  
**优先级**: 106

