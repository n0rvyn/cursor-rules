---
description: "300: Security audit checklist and secure coding practices"
scopes: [chat, edit]
tags: [security, audit]
priority: 301
globs:
  - "**/*.ts"
  - "**/*.js"
  - "**/*.py"
  - "**/*.go"
  - "**/*.java"
  - "**/*.swift"
alwaysApply: false
---

## 🔒 Security Audit Standards
- Never commit secrets, API keys, or passwords to version control
- Use environment variables for sensitive configuration
- Implement proper input validation and sanitization
- Use parameterized queries to prevent SQL injection
- Validate file uploads and restrict file types
- Use dedicated secret management tools (HashiCorp Vault, AWS Secrets Manager)
- Rotate secrets regularly
- Use different secrets for different environments
- Audit secret access and usage

## 🔐 Authentication & Authorization
- Implement strong password policies
- Use secure session management
- Implement proper role-based access control (RBAC)
- Log authentication attempts and failures
- Implement account lockout after failed attempts
- Implement multi-factor authentication where possible
- Use secure password hashing (bcrypt, scrypt, Argon2)

## 🛡️ Data Protection
- Encrypt sensitive data at rest and in transit
- Use HTTPS/TLS for all communications
- Implement proper data retention policies
- Follow privacy regulations (GDPR, CCPA)
- Sanitize data in logs and error messages
- Implement proper data classification
- Ensure secure data disposal

## 🔍 Code Security
- Keep dependencies up to date
- Run security scans on dependencies
- Implement Content Security Policy (CSP) for web apps
- Use secure coding practices to prevent XSS, CSRF
- Validate and escape all user inputs
- Regularly scan for known vulnerabilities
- Use dependency pinning in production
- Review third-party libraries before adoption
- Monitor for security advisories

## 📊 Monitoring & Logging
- Log security events and access attempts
- Monitor for suspicious activities
- Implement intrusion detection
- Set up alerts for security incidents
- Regular security assessments and penetration testing
- Implement centralized logging
- Avoid logging sensitive information

## 🚨 DEV ONLY - Development Environment
*Security considerations for development*
- Use development-specific API keys (not production)
- Enable detailed security logging for debugging
- Test with mock data, never production data
- Use localhost HTTPS for testing secure features
- Allow security tools and debuggers

## 🔒 PROD ONLY - Production Environment
*Critical security measures for production*
- Enable all security headers (HSTS, CSP, X-Frame-Options)
- Use production secrets management (Vault, AWS Secrets Manager)
- Enable WAF (Web Application Firewall)
- Implement security monitoring and alerting
- Regular security audits and penetration testing
- Zero-tolerance for hardcoded secrets

## ✅ Compliance Checklist
- [ ] No hardcoded secrets in code
- [ ] All inputs validated and sanitized
- [ ] HTTPS enforced for all endpoints
- [ ] Authentication properly implemented
- [ ] Authorization checks in place
- [ ] Security headers configured
- [ ] Dependencies scanned for vulnerabilities
- [ ] Logging and monitoring active