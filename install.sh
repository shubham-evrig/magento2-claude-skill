#!/bin/sh
set -e

echo "Installing Magento 2 Claude Skill..."

# Detect target (like hyva does)
TARGET=${1:-claude}

# Detect project .claude folder first
if [ -d ".claude" ]; then
    SKILL_DIR=".claude/skills"
else
    SKILL_DIR="$HOME/.claude/skills"
fi

mkdir -p "$SKILL_DIR"

echo "Installing to: $SKILL_DIR"

curl -fsSL https://raw.githubusercontent.com/shubham-evrig/magento2-claude-skill/main/magento2-module-skill.md \
-o "$SKILL_DIR/magento2-module-dev.md"

echo "Magento 2 Claude Skill installed successfully!"
