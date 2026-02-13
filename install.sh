#!/bin/sh

set -e

SKILL_NAME="magento2-module"
CLAUDE_DIR="$HOME/.claude/skills"

echo "Installing Magento 2 Claude Skill..."

mkdir -p "$CLAUDE_DIR"

curl -fsSL https://raw.githubusercontent.com/shubham-evrig/magento2-claude-skill/main/magento2-module-skill.md \
  -o "$CLAUDE_DIR/$SKILL_NAME.md"

echo "Skill installed successfully!"
