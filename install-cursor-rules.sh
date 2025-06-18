#!/bin/bash

# Cursor Configuration Quick Installer
# Usage: ./install-cursor-rules.sh [target-directory]

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}🚀 Installing Cursor Configuration to: $TARGET_DIR${NC}"
echo "=============================================="

# Create directory structure
mkdir -p "$TARGET_DIR/.cursor/rules"
mkdir -p "$TARGET_DIR/.cursor/environments"

# Copy core configuration files
echo -e "${BLUE}📝 Copying configuration files...${NC}"
cp -r "$SCRIPT_DIR/.cursor/rules/"*.mdc "$TARGET_DIR/.cursor/rules/"
cp "$SCRIPT_DIR/.cursor/"*.json "$TARGET_DIR/.cursor/" 2>/dev/null || true

# Copy environment configs
echo -e "${BLUE}⚙️ Setting up environments...${NC}"
cp -r "$SCRIPT_DIR/.cursor/environments/"*.json "$TARGET_DIR/.cursor/environments/"

# Copy examples if they don't exist
if [[ -d "$SCRIPT_DIR/examples" ]]; then
    echo -e "${BLUE}📋 Adding example configs...${NC}"
    [[ ! -f "$TARGET_DIR/tsconfig.json" ]] && cp "$SCRIPT_DIR/examples/sample-tsconfig.json" "$TARGET_DIR/tsconfig.json" 2>/dev/null || true
    [[ ! -f "$TARGET_DIR/package.json" ]] && cp "$SCRIPT_DIR/examples/sample-package.json" "$TARGET_DIR/package.json" 2>/dev/null || true
    [[ ! -f "$TARGET_DIR/requirements.txt" ]] && cp "$SCRIPT_DIR/examples/sample-requirements.txt" "$TARGET_DIR/requirements.txt" 2>/dev/null || true
fi

# Add to .gitignore if it exists
if [[ -f "$TARGET_DIR/.gitignore" ]]; then
    if ! grep -q ".cursor/debug/" "$TARGET_DIR/.gitignore" 2>/dev/null; then
        echo -e "${BLUE}📝 Adding to .gitignore...${NC}"
        echo -e "\n# Cursor debug files\n.cursor/debug/" >> "$TARGET_DIR/.gitignore"
    fi
fi

echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo -e "${YELLOW}🎯 Next steps:${NC}"
echo "1. cd $TARGET_DIR"
echo "2. Update model names in .cursor/environments/*.json"
echo "3. Reload Cursor rules: Ctrl+Shift+P → 'Cursor: Reload Rules'"
echo "4. Test with: @filename refactor this function"
echo ""
echo -e "${BLUE}📖 See README.md for detailed usage guide${NC}" 