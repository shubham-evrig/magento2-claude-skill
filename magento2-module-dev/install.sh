#!/bin/bash

# Magento 2 AI Skills Installer
# Copyright (c) 2026 Magento Dev Team

set -e

SKILLS_REPO="https://github.com/magento2-claude-skill/magento2-ai-skills"
SKILLS_BRANCH="main"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║   Magento 2 AI Skills Installer               ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Detect AI assistant
detect_assistant() {
    case "$1" in
        claude|claudecode|claude-code)
            ASSISTANT="claude"
            SKILLS_DIR="$HOME/.claude/skills"
            ASSISTANT_NAME="Claude Code"
            ASSISTANT_CHECK="claude"
            ;;
        cursor)
            ASSISTANT="cursor"
            SKILLS_DIR=".cursor/skills"
            ASSISTANT_NAME="Cursor"
            ASSISTANT_CHECK="cursor"
            ;;
        codex)
            ASSISTANT="codex"
            SKILLS_DIR=".codex/skills"
            ASSISTANT_NAME="Anthropic Codex"
            ASSISTANT_CHECK="codex"
            ;;
        copilot|github-copilot)
            ASSISTANT="copilot"
            SKILLS_DIR=".github/skills"
            ASSISTANT_NAME="GitHub Copilot"
            ASSISTANT_CHECK="gh"
            ;;
        gemini)
            ASSISTANT="gemini"
            SKILLS_DIR=".gemini/skills"
            ASSISTANT_NAME="Gemini"
            ASSISTANT_CHECK="gemini"
            ;;
        opencode)
            ASSISTANT="opencode"
            SKILLS_DIR=".opencode/skills"
            ASSISTANT_NAME="OpenCode"
            ASSISTANT_CHECK="opencode"
            ;;
        *)
            print_error "Unknown AI assistant: $1"
            echo ""
            echo "Supported assistants:"
            echo "  - claude (Claude Code)"
            echo "  - cursor (Cursor)"
            echo "  - codex (Anthropic Codex)"
            echo "  - copilot (GitHub Copilot)"
            echo "  - gemini (Gemini)"
            echo "  - opencode (OpenCode)"
            echo ""
            echo "Usage: $0 <assistant>"
            echo "Example: $0 claude"
            exit 1
            ;;
    esac
}

# Check if AI assistant is installed
check_assistant_availability() {
    print_info "Checking if ${ASSISTANT_NAME} is available..."
    
    case "$ASSISTANT" in
        claude)
            # Check for Claude Code installation
            if [ -d "$HOME/.claude" ] || [ -d "$HOME/Library/Application Support/Claude" ] || command_exists claude; then
                print_success "${ASSISTANT_NAME} is installed"
                return 0
            else
                print_warning "${ASSISTANT_NAME} does not appear to be installed on your system"
                echo ""
                echo "  ${ASSISTANT_NAME} was not detected. This could mean:"
                echo "  1. Claude Code is not installed"
                echo "  2. You haven't run Claude Code yet (it creates ~/.claude on first run)"
                echo ""
                print_info "Installation options:"
                echo "  - Download Claude Code from: https://claude.ai/download"
                echo "  - Or continue anyway and skills will be ready when you install it"
                echo ""
                ask_continue
                return 1
            fi
            ;;
        cursor)
            # Check for Cursor installation in current project first
            if [ -d ".cursor" ]; then
                print_success "${ASSISTANT_NAME} project configuration found"
                print_info "Installing skills for this specific project"
                return 0
            elif [ -d "$HOME/.cursor" ] || [ -d "$HOME/Library/Application Support/Cursor" ] || command_exists cursor; then
                print_success "${ASSISTANT_NAME} is installed globally"
                # Ask if they want project-specific or global installation
                echo ""
                echo "  ${ASSISTANT_NAME} detected! Choose installation location:"
                echo "  1. Current project only (recommended): $(pwd)/.cursor/skills/"
                echo "  2. Global (all projects): $HOME/.cursor/skills/"
                echo ""
                echo -n "  Install for (1) project or (2) global? [1]: "
                read -r install_choice
                case "$install_choice" in
                    2)
                        SKILLS_DIR="$HOME/.cursor/skills"
                        print_info "Installing globally"
                        ;;
                    *)
                        SKILLS_DIR=".cursor/skills"
                        print_info "Installing for current project"
                        ;;
                esac
                echo ""
                return 0
            else
                print_warning "${ASSISTANT_NAME} does not appear to be installed on your system"
                echo ""
                echo "  ${ASSISTANT_NAME} was not detected in:"
                echo "  - Current project: $(pwd)/.cursor/"
                echo "  - Home directory: $HOME/.cursor/"
                echo "  - System commands: cursor"
                echo ""
                print_info "To use ${ASSISTANT_NAME}:"
                echo "  1. Download from: https://cursor.sh/"
                echo "  2. Open your project in Cursor"
                echo "  3. Run this installer again"
                echo ""
                print_warning "You can continue, but skills won't work until Cursor is installed"
                echo ""
                ask_continue
                return 1
            fi
            ;;
        codex)
            # Check for Codex installation in current project first
            if [ -d ".codex" ]; then
                print_success "${ASSISTANT_NAME} project configuration found"
                print_info "Installing skills for this specific project"
                return 0
            elif [ -d "$HOME/.codex" ] || command_exists codex; then
                print_success "${ASSISTANT_NAME} is installed"
                # Ask if they want project-specific or global installation
                echo ""
                echo "  ${ASSISTANT_NAME} detected! Choose installation location:"
                echo "  1. Current project only (recommended): $(pwd)/.codex/skills/"
                echo "  2. Global (all projects): $HOME/.codex/skills/"
                echo ""
                echo -n "  Install for (1) project or (2) global? [1]: "
                read -r install_choice
                case "$install_choice" in
                    2)
                        SKILLS_DIR="$HOME/.codex/skills"
                        print_info "Installing globally"
                        ;;
                    *)
                        SKILLS_DIR=".codex/skills"
                        print_info "Installing for current project"
                        ;;
                esac
                echo ""
                return 0
            else
                print_warning "${ASSISTANT_NAME} does not appear to be installed"
                echo ""
                echo "  ${ASSISTANT_NAME} was not detected in:"
                echo "  - Current project: $(pwd)/.codex/"
                echo "  - Home directory: $HOME/.codex/"
                echo ""
                print_info "To use ${ASSISTANT_NAME}:"
                echo "  1. Install Codex from Anthropic"
                echo "  2. Initialize your project"
                echo "  3. Run this installer again"
                echo ""
                ask_continue
                return 1
            fi
            ;;
        copilot)
            # Check for GitHub CLI and Copilot
            if command_exists gh; then
                if gh extension list 2>/dev/null | grep -q copilot; then
                    print_success "${ASSISTANT_NAME} is installed"
                    # Check if in a git repository
                    if git rev-parse --git-dir > /dev/null 2>&1; then
                        print_info "Git repository detected, installing in project"
                        return 0
                    else
                        print_warning "Not in a git repository"
                        echo ""
                        echo "  GitHub Copilot skills work best in git repositories."
                        echo "  Current directory: $(pwd)"
                        echo ""
                        ask_continue
                        return 1
                    fi
                else
                    print_warning "GitHub CLI found, but Copilot extension not detected"
                    echo ""
                    echo "  Install GitHub Copilot extension:"
                    echo "  gh extension install github/gh-copilot"
                    echo ""
                    ask_continue
                    return 1
                fi
            else
                print_warning "${ASSISTANT_NAME} requires GitHub CLI"
                echo ""
                echo "  GitHub CLI (gh) was not found. To use GitHub Copilot skills:"
                echo "  1. Install GitHub CLI: https://cli.github.com/"
                echo "  2. Install Copilot extension: gh extension install github/gh-copilot"
                echo ""
                ask_continue
                return 1
            fi
            ;;
        gemini|opencode)
            # For other assistants, check both project and global
            if [ -d "$SKILLS_DIR" ]; then
                print_success "${ASSISTANT_NAME} directory found in project"
                return 0
            elif [ -d "$(dirname "$SKILLS_DIR")" ]; then
                print_info "${ASSISTANT_NAME} parent directory detected"
                print_info "Skills will be created in: $SKILLS_DIR"
                return 0
            else
                print_warning "${ASSISTANT_NAME} directory not found"
                echo ""
                echo "  Expected directory: $SKILLS_DIR"
                echo "  Current directory: $(pwd)"
                echo ""
                print_info "This is normal for first-time setup"
                echo "  Skills will be installed and ready when you set up ${ASSISTANT_NAME}"
                echo ""
                return 1
            fi
            ;;
    esac
}

# Ask user if they want to continue
ask_continue() {
    echo -n "  Do you want to continue anyway? (y/N): "
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            print_info "Continuing with installation..."
            echo ""
            return 0
            ;;
        *)
            print_info "Installation cancelled"
            echo ""
            echo "  Install ${ASSISTANT_NAME} first, then run this script again:"
            echo "  curl -fsSL https://raw.githubusercontent.com/.../install.sh | sh -s ${ASSISTANT}"
            echo ""
            exit 0
            ;;
    esac
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Download and install skills
install_skills() {
    print_info "Installing Magento 2 AI skills for ${ASSISTANT}..."
    echo ""

    # Create skills directory
    if [ ! -d "$SKILLS_DIR" ]; then
        print_info "Creating skills directory: $SKILLS_DIR"
        mkdir -p "$SKILLS_DIR"
        print_success "Skills directory created"
    else
        print_info "Skills directory exists: $SKILLS_DIR"
    fi

    # Check if git is available
    if command_exists git; then
        print_info "Cloning skills from repository..."
        
        # Temporary directory
        TEMP_DIR=$(mktemp -d)
        
        # Clone repository
        git clone --depth 1 --branch "$SKILLS_BRANCH" "$SKILLS_REPO" "$TEMP_DIR" 2>/dev/null || {
            print_error "Failed to clone repository"
            print_warning "Trying alternative download method..."
            download_with_curl
            return
        }
        
        # Copy skills
        print_info "Copying skills to $SKILLS_DIR..."
        cp -r "$TEMP_DIR"/magento2-* "$SKILLS_DIR/" 2>/dev/null || {
            print_error "No skills found in repository"
            rm -rf "$TEMP_DIR"
            exit 1
        }
        
        # Cleanup
        rm -rf "$TEMP_DIR"
        print_success "Skills installed successfully"
        
    else
        print_warning "Git not found, using curl to download..."
        download_with_curl
    fi
}

# Download using curl as fallback
download_with_curl() {
    if ! command_exists curl; then
        print_error "Neither git nor curl is available"
        print_error "Please install git or curl and try again"
        exit 1
    fi
    
    print_info "Downloading skills archive..."
    
    TEMP_DIR=$(mktemp -d)
    ARCHIVE="$TEMP_DIR/skills.tar.gz"
    
    curl -fsSL "${SKILLS_REPO}/archive/refs/heads/${SKILLS_BRANCH}.tar.gz" -o "$ARCHIVE" || {
        print_error "Failed to download skills"
        rm -rf "$TEMP_DIR"
        exit 1
    }
    
    print_info "Extracting skills..."
    tar -xzf "$ARCHIVE" -C "$TEMP_DIR" || {
        print_error "Failed to extract skills"
        rm -rf "$TEMP_DIR"
        exit 1
    }
    
    # Find extracted directory
    EXTRACTED_DIR=$(find "$TEMP_DIR" -maxdepth 1 -type d -name "magento2-ai-skills-*" | head -n 1)
    
    if [ -z "$EXTRACTED_DIR" ]; then
        print_error "Could not find extracted skills"
        rm -rf "$TEMP_DIR"
        exit 1
    fi
    
    # Copy skills
    print_info "Copying skills to $SKILLS_DIR..."
    cp -r "$EXTRACTED_DIR"/magento2-* "$SKILLS_DIR/" 2>/dev/null || {
        print_error "No skills found in archive"
        rm -rf "$TEMP_DIR"
        exit 1
    }
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    print_success "Skills installed successfully"
}

# List installed skills
list_skills() {
    echo ""
    print_info "Installed skills:"
    echo ""
    
    if [ -d "$SKILLS_DIR" ]; then
        for skill_dir in "$SKILLS_DIR"/magento2-*; do
            if [ -d "$skill_dir" ]; then
                skill_name=$(basename "$skill_dir")
                if [ -f "$skill_dir/SKILL.md" ]; then
                    # Extract description from SKILL.md
                    description=$(grep -m 1 "^description:" "$skill_dir/SKILL.md" | sed 's/description: //' | sed 's/^[[:space:]]*//')
                    echo -e "  ${GREEN}●${NC} ${skill_name}"
                    echo -e "    ${description:0:80}..."
                else
                    echo -e "  ${YELLOW}●${NC} ${skill_name} (no SKILL.md found)"
                fi
            fi
        done
    else
        print_warning "Skills directory not found: $SKILLS_DIR"
    fi
    
    echo ""
}

# Show usage instructions
show_usage() {
    echo ""
    print_success "Installation complete!"
    echo ""
    print_info "Usage instructions for ${ASSISTANT}:"
    echo ""
    
    case "$ASSISTANT" in
        claude)
            echo "  1. Restart Claude Code"
            echo "  2. Open your Magento 2 project"
            echo "  3. Type: 'create new custom module'"
            echo ""
            echo "  The skill will automatically load:"
            echo "  ${GREEN}● Skill(magento2-create-module)${NC}"
            echo "  ${GREEN}  ⎿ Successfully loaded skill${NC}"
            ;;
        cursor)
            echo "  1. Restart Cursor"
            echo "  2. Open your Magento 2 project"
            echo "  3. Type: 'create new custom module'"
            echo ""
            echo "  Skills are located in: $(pwd)/.cursor/skills/"
            ;;
        codex)
            echo "  1. Restart Codex"
            echo "  2. Open your Magento 2 project"
            echo "  3. Type: 'create new custom module'"
            echo ""
            echo "  Skills are located in: $(pwd)/.codex/skills/"
            ;;
        copilot)
            echo "  1. Restart your editor"
            echo "  2. Open your Magento 2 project"
            echo "  3. GitHub Copilot will use these skills automatically"
            echo ""
            echo "  Skills are located in: $(pwd)/.github/skills/"
            ;;
        *)
            echo "  1. Restart your AI assistant"
            echo "  2. Open your Magento 2 project"
            echo "  3. Start using the skills"
            ;;
    esac
    
    echo ""
    print_info "Available trigger phrases:"
    echo "  - 'create new custom module'"
    echo "  - 'generate magento module'"
    echo "  - 'make a module'"
    echo "  - 'scaffold module'"
    echo ""
    print_info "Documentation: $SKILLS_DIR/magento2-create-module/SKILL.md"
    echo ""
}

# Main installation flow
main() {
    print_header
    
    # Check arguments
    if [ $# -eq 0 ]; then
        print_error "No AI assistant specified"
        echo ""
        echo "Usage: $0 <assistant>"
        echo ""
        echo "Supported assistants:"
        echo "  - claude (Claude Code)"
        echo "  - cursor (Cursor)"
        echo "  - codex (Anthropic Codex)"
        echo "  - copilot (GitHub Copilot)"
        echo "  - gemini (Gemini)"
        echo "  - opencode (OpenCode)"
        echo ""
        echo "Example:"
        echo "  curl -fsSL https://raw.githubusercontent.com/.../install.sh | sh -s claude"
        echo ""
        exit 1
    fi
    
    # Detect assistant
    detect_assistant "$1"
    
    print_info "Installing for: ${ASSISTANT_NAME}"
    print_info "Skills directory: ${SKILLS_DIR}"
    echo ""
    
    # Check if AI assistant is available
    check_assistant_availability
    echo ""
    
    # Install skills
    install_skills
    
    # List installed skills
    list_skills
    
    # Show usage
    show_usage
    
    print_success "Setup complete! Happy coding! 🚀"
    echo ""
}

# Run main function
main "$@"
