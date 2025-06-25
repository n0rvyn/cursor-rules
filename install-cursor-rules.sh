#!/bin/bash

# Cursor Rules Quick Installer
# Usage: ./install-cursor-rules.sh [target-directory]

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TARGET_DIR="${1:?A target directory is required}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}🚀 Installing Cursor Rules to: $TARGET_DIR${NC}"
echo "=============================================="

# Create directory structure
mkdir -p "$TARGET_DIR/.cursor/rules"

# Copy rule files
echo -e "${BLUE}📝 Copying rule files...${NC}"
cp -r "$SCRIPT_DIR/.cursor/rules/"*.mdc "$TARGET_DIR/.cursor/rules/"

# Copy templates
if [[ -d "$SCRIPT_DIR/templates" ]]; then
    echo -e "${BLUE}📋 Copying templates...${NC}"
    mkdir -p "$TARGET_DIR/templates"
    cp -r "$SCRIPT_DIR/templates/"* "$TARGET_DIR/templates/"
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
echo "2. Reload Cursor rules: Cmd+Shift+P → 'Cursor: Reload Rules'"
echo "3. Test with: @filename refactor this function"
echo "4. Check available rules: Cursor Settings > Rules > Project Rules"
echo ""
echo -e "${BLUE}📖 See README.md for detailed usage guide${NC}"