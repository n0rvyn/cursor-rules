---
description: "016: Deep log analysis approach for root cause debugging"
scopes: [chat, edit]
tags: [debugging, logging, root-cause-analysis]
priority: 16
globs:
alwaysApply: false
---

# Deep Log Analysis for Root Cause Debugging

## 🎯 Core Principle

> **"Perform deep log analysis to find root causes rather than repeatedly restarting services when debugging container health issues."**

## 🚨 The Service Restart Problem

### **Common Anti-Pattern**:
- **Symptom**: Container or service appears unhealthy
- **Quick Fix**: Restart the service/container
- **Result**: Problem temporarily resolved, but returns later
- **Root Cause**: Never identified, leading to repeated restarts

### **Why This Happens**:
- **Time pressure** - restart seems faster than investigation
- **Lack of log analysis skills** - not sure how to read logs effectively
- **Missing monitoring** - no visibility into what's actually failing
- **No documentation** - previous similar issues not recorded

## 🔍 Deep Analysis Approach

### **Step 1: Log Collection (Before Any Restart)**
```bash
# Collect all relevant logs from the time period
docker logs <container_name> --since 1h > container.log
kubectl logs <pod_name> --since=1h > pod.log
journalctl -u <service_name> --since "1 hour ago" > service.log

# Include system logs if container issues
journalctl --since "1 hour ago" > system.log
```

### **Step 2: Pattern Analysis**
```bash
# Look for error patterns
grep -i "error\|exception\|fail" *.log | sort | uniq -c

# Check for resource issues
grep -i "memory\|cpu\|disk\|timeout" *.log

# Analyze timing patterns
grep -E "\[.*\]" *.log | head -20
```

### **Step 3: Root Cause Identification**
- **Resource exhaustion**: Memory, CPU, disk space, file descriptors
- **Configuration issues**: Wrong settings, missing environment variables
- **Dependency failures**: Database connections, external services
- **Code bugs**: Unhandled exceptions, infinite loops, race conditions
- **Infrastructure issues**: Network problems, storage failures

## 🚫 When NOT to Restart

### **Never Restart As First Step When**:
- **Error logs show specific patterns** - investigate the pattern first
- **Resource usage is high** - check what's consuming resources
- **Dependencies are failing** - fix the dependency, not the service
- **Configuration changes were recent** - check if config is correct
- **Multiple services are affected** - likely infrastructure issue

### **Restart Only After**:
- **Root cause identified** and fix implemented
- **Logs analyzed** and no clear pattern found
- **Quick fix needed** for production emergency (but still log for later analysis)
- **Known issue** with documented restart procedure

## ✅ Proper Debugging Workflow

### **Emergency (Production Down)**:
1. **Quick restart** to restore service (if absolutely necessary)
2. **Immediately collect logs** from before restart
3. **Analyze logs** to find root cause
4. **Implement proper fix** to prevent recurrence
5. **Document the issue** and solution

### **Non-Emergency (Service Degraded)**:
1. **Collect comprehensive logs** first
2. **Analyze patterns** and identify root cause
3. **Implement targeted fix** for root cause
4. **Test fix** before restarting
5. **Monitor** to ensure fix is effective

## 📊 Log Analysis Tools

### **Essential Commands**:
```bash
# Time-based filtering
grep "2024-01-15 14:" *.log

# Pattern counting
grep -c "ERROR" *.log

# Multi-file correlation
grep "request_id_123" *.log

# Resource monitoring
docker stats <container_name>
kubectl top pod <pod_name>
```

### **Advanced Analysis**:
```bash
# Error frequency over time
grep "ERROR" app.log | cut -d' ' -f1-2 | uniq -c

# Stack trace analysis
grep -A 10 "Exception" *.log

# Performance correlation
grep -E "(slow|timeout|latency)" *.log
```

## 🎯 Success Criteria

### **Root Cause Found When**:
- [ ] **Specific error identified** with clear cause
- [ ] **Resource constraint** identified and quantified
- [ ] **Configuration issue** found and documented
- [ ] **Dependency failure** traced to source
- [ ] **Code bug** located with stack trace

### **Proper Fix Implemented When**:
- [ ] **Root cause addressed** not just symptoms
- [ ] **Monitoring improved** to catch similar issues
- [ ] **Documentation updated** with solution
- [ ] **Prevention measures** put in place
- [ ] **No unnecessary restarts** performed

## 🔄 Integration with Existing Rules

### **Works With**:
- **Build/Test Commands (011)**: Use proper testing before deploying fixes
- **Evidence-First (008)**: Base fixes on log evidence, not assumptions
- **Issue Fixing (007)**: Follow systematic approach to problem solving
- **Rule Logging (015)**: Document debugging patterns for future reference

### **Complements**:
- **Anti-Overengineering (006)**: Focus on simple, targeted fixes
- **Plan/Act Workflow (003)**: Plan debugging approach before execution
- **Memory Bank (004)**: Update with debugging insights and solutions