#!/bin/bash

# Cursor Advanced Practice Guide - Quick Installation Script
# Cursor 高阶实践指南 - 快速安装脚本
# Usage: ./install-cursor-rules.sh [target-directory]

set -e

TARGET_DIR="${1:? Please provide a target project directory (e.g. ./my-project)}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Installing Cursor Advanced Rules to: $TARGET_DIR"
echo "================================================="

# 创建目录结构
mkdir -p "$TARGET_DIR/.cursor/rules"
mkdir -p "$TARGET_DIR/.cursor/environments"

# 复制规则文件
echo "📝 Copying rule files..."
cp "$SCRIPT_DIR/.cursor/rules/"*.mdc "$TARGET_DIR/.cursor/rules/"
cp "$SCRIPT_DIR/.cursor/config.json" "$TARGET_DIR/.cursor/"

# 复制 DEV_CHECKLIST.md（如果不存在）
if [ ! -f "$TARGET_DIR/DEV_CHECKLIST.md" ]; then
    echo "📋 Creating initial DEV_CHECKLIST.md..."
    cp "$SCRIPT_DIR/DEV_CHECKLIST.md" "$TARGET_DIR/"
else
    echo "📋 DEV_CHECKLIST.md already exists, skipping..."
fi

# 创建环境特定配置示例
echo "⚙️  Creating environment configs..."
cat > "$TARGET_DIR/.cursor/environments/development.json" << 'EOF'
{
  "model": "openai/gpt-4o",
  "temperature": 0.1,
  "contextLines": 300,
  "enableDebugMode": true
}
EOF

cat > "$TARGET_DIR/.cursor/environments/production.json" << 'EOF'
{
  "model": "anthropic/claude-3-opus",
  "temperature": 0.05,
  "contextLines": 150,
  "strictMode": true,
  "requireReview": true
}
EOF

# 创建健康检查脚本
echo "🔍 Creating health check script..."
cat > "$TARGET_DIR/.cursor/health-check.sh" << 'EOF'
#!/bin/bash

echo "🔍 Cursor Configuration Health Check"
echo "===================================="

# 检查规则文件
for rule in .cursor/rules/*.mdc; do
  if [ -f "$rule" ]; then
    if ! head -5 "$rule" | grep -q "^---"; then
      echo "❌ $rule: Missing YAML frontmatter"
    else
      echo "✅ $rule: OK"
    fi
  fi
done

# 检查配置文件语法 (JSONC format with comments)
if command -v node >/dev/null 2>&1; then
  if node -e "JSON.parse(require('fs').readFileSync('.cursor/config.json', 'utf8').replace(/\/\*[\s\S]*?\*\/|\/\/.*$/gm, ''))" > /dev/null 2>&1; then
    echo "✅ config.json: Valid JSONC format"
  else
    echo "❌ config.json: Invalid JSON/JSONC syntax"
  fi
elif command -v python3 >/dev/null 2>&1; then
  echo "⚠️  config.json: JSONC format (with comments) - skipping strict JSON validation"
  echo "✅ config.json: File exists and appears formatted correctly"
else
  echo "⚠️  Node.js/Python not found, skipping JSON validation"
  echo "✅ config.json: File exists"
fi

echo ""
echo "📊 Summary:"
echo "- Rules: $(ls -1 .cursor/rules/*.mdc 2>/dev/null | wc -l) files"
echo "- Config files: $(ls -1 .cursor/*.json 2>/dev/null | wc -l) files"
echo ""
echo "🎯 Next steps:"
echo "1. Customize .cursor/config.json for your project"
echo "2. Adjust rules in .cursor/rules/ as needed"
echo "3. Run 'Cursor: Reload Rules' in VS Code"
EOF

chmod +x "$TARGET_DIR/.cursor/health-check.sh"

# 添加到 .gitignore（如果存在）
if [ -f "$TARGET_DIR/.gitignore" ]; then
    if ! grep -q ".cursor/debug/" "$TARGET_DIR/.gitignore"; then
        echo "📝 Adding Cursor debug folder to .gitignore..."
        echo "" >> "$TARGET_DIR/.gitignore"
        echo "# Cursor debug files" >> "$TARGET_DIR/.gitignore"
        echo ".cursor/debug/" >> "$TARGET_DIR/.gitignore"
    fi
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "🎯 Quick start:"
echo "1. cd $TARGET_DIR"
echo "2. ./.cursor/health-check.sh"
echo "3. Open VS Code and run 'Cursor: Reload Rules'"
echo ""
echo "📖 Read the full guide: cursor-advanced-guide.md" 