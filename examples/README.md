# Configuration Examples

> **Ready-to-use configuration files for common project types**

## 📁 Available Files

- **`sample-tsconfig.json`** - TypeScript configuration with strict settings
- **`sample-package.json`** - Node.js project with dev tools (TypeScript, ESLint, Jest)  
- **`sample-requirements.txt`** - Python web development stack (FastAPI, SQLAlchemy, testing)

## 🚀 Quick Usage

### TypeScript Project
```bash
cp examples/sample-tsconfig.json ./tsconfig.json
cp examples/sample-package.json ./package.json
npm install
```

### Python Project
```bash
cp examples/sample-requirements.txt ./requirements.txt
pip install -r requirements.txt
```

## 🔧 What's Included

### TypeScript Configuration
- Strict type checking enabled
- Modern ES2020+ features
- Path aliases (`@/` for clean imports)
- Source maps for debugging

### Node.js Package
- **Build**: TypeScript compilation
- **Dev**: Hot reload with `tsx`
- **Test**: Jest testing framework
- **Lint**: ESLint + Prettier
- **Quality**: Husky git hooks

### Python Dependencies
- **Framework**: FastAPI + Uvicorn
- **Database**: SQLAlchemy + PostgreSQL
- **Testing**: pytest
- **Quality**: black, mypy, ruff

## 💡 Customization

These are **starting templates** - modify them for your specific needs:
- Add/remove dependencies as required
- Adjust TypeScript strictness settings  
- Configure linting rules for your team
- Add project-specific scripts

---

> **Tip**: The installer script (`./install-cursor-rules.sh`) automatically copies these files to your project if they don't already exist. 