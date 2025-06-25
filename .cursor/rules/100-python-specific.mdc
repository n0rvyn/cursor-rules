---
description: "100: Python-specific conventions and patterns"
alwaysApply: false
scopes: [chat, edit]
tags: [python, language-specific]
priority: 100
---

## 🎯 Template-First Development
- **Service Classes**: Use @templates/python-service.py as starting point for new services
- **Async Patterns**: Follow the BaseService pattern for consistent error handling
- **Type Safety**: Always use type hints as shown in templates

## 🐍 Core Python Standards
- Mandatory type annotations: `def func(param: str) -> int:`
- Use dataclasses instead of regular classes for data structures
- Prefer async/await for asynchronous functions
- Import order: standard library → third-party → local modules
- Docstrings must follow Google Style

## 📦 Type Hints & Annotations
- All function parameters and return types must have type hints
- Use `typing` module for complex types: `List[str]`, `Dict[str, int]`, `Optional[str]`
- For Python 3.9+, prefer built-in types: `list[str]`, `dict[str, int]`
- Use `from __future__ import annotations` for forward references

## 🔧 Code Organization
- Use `dataclasses` for data structures with `@dataclass` decorator
- Prefer `pathlib.Path` over `os.path` for file operations
- Use context managers (`with` statements) for resource management
- Exception handling: catch specific exceptions, not bare `except:`

## ⚡ Async Programming
- Use `async def` for asynchronous functions
- Prefer `asyncio.create_task()` over `asyncio.ensure_future()`
- Use `async with` for async context managers
- Always await coroutines, never leave them hanging

## 📖 Documentation Standards
- All public functions must have docstrings
- Use Google Style docstrings with Args, Returns, and Raises sections
- Include type information in docstring when types are complex
- Document class attributes and their purposes

## 🚨 DEV ONLY - Development Environment
*These rules apply only during development*
- Enable debug logging with `logging.DEBUG` level
- Use `pytest` with verbose output (`-v` flag)
- Include development dependencies in `requirements-dev.txt`
- Allow print statements for quick debugging (but remove before PR)

## 🔒 PROD ONLY - Production Environment
*These rules apply only in production*
- Use `logging.INFO` or higher levels only
- No print statements or debug code
- All secrets loaded from environment variables
- Use production-grade WSGI server (gunicorn, uvicorn)
- Enable error monitoring (Sentry, etc.)

## 🧪 Testing Requirements
- Use `pytest` for testing framework
- Test files: `test_*.py` or `*_test.py`
- Descriptive test names: `test_should_return_true_when_valid_input()`
- Use fixtures for common test setup
- Aim for >80% code coverage

## 🔍 Code Quality
- Use `black` for code formatting
- Use `isort` for import sorting
- Use `mypy` for static type checking
- Use `pylint` or `flake8` for linting
- Pre-commit hooks for automated quality checks
