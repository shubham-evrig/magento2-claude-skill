#!/bin/sh
#
# Magento 2 AI Skills Installer
# Inspired by Hyva AI Tools Installer
#

set -e

# Configuration
REPO_URL="${M2_SKILLS_REPO_URL:-https://github.com/shubham-evrig/magento2-claude-skill}"
BRANCH="${M2_SKILLS_BRANCH:-main}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

INSTALLED_SKILLS=""

print_header() {
    echo ""
    echo "${BLUE}============================================${NC}"
    echo "${BLUE}  Magento 2 AI Skills Installer${NC}"
    echo "${BLUE}============================================${NC}"
    echo ""
}

print_success() { echo "${GREEN}[OK]${NC} $1"; }
print_warning() { echo "${YELLOW}[WARN]${NC} $1"; }
print_error() { echo "${RED}[ERROR]${NC} $1"; }
print_info() { echo "${BLUE}[INFO]${NC} $1"; }

usage() {
    echo "Usage: $0 <platform>"
    echo ""
    echo "Platforms:"
    echo "  claude    Install skills for Claude Code (.claude/skills/)"
    echo "  cursor    Install skills for Cursor (.cursor/skills/)"
    echo ""
    exit 1
}

get_skills_dir() {
    case "$1" in
        claude) echo ".claude/skills" ;;
        cursor) echo ".cursor/skills" ;;
        *) print_error "Unknown platform: $1"; usage ;;
    esac
}

detect_project_root() {
    current_dir="$(pwd)"
    while [ "$current_dir" != "/" ]; do
        if [ -f "$current_dir/app/etc/env.php" ]; then
            echo "$current_dir"
            return
        fi
        current_dir="$(dirname "$current_dir")"
    done
    echo "$(pwd)"
}

install_skill() {
    src_path="$1"
    dest_dir="$2"
    skill="$(basename "$src_path")"
    dest_path="$dest_dir/$skill"

    if [ -d "$dest_path" ]; then
        rm -rf "$dest_path"
        cp -r "$src_path" "$dest_path"
        print_success "Updated $skill"
    else
        cp -r "$src_path" "$dest_path"
        print_success "Installed $skill"
    fi

    INSTALLED_SKILLS="$INSTALLED_SKILLS $skill"
}

install_skills_from_repo() {
    repo_dir="$1"
    dest_dir="$2"

    skills_src="$repo_dir/skills"

    if [ ! -d "$skills_src" ]; then
        print_error "No skills directory found in repository"
        exit 1
    fi

    for skill_path in "$skills_src"/*; do
        if [ -d "$skill_path" ]; then
            install_skill "$skill_path" "$dest_dir"
        fi
    done
}

install_via_git() {
    skills_dir="$1"
    tmp_dir=$(mktemp -d)

    print_info "Cloning repository..."
    git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$tmp_dir" >/dev/null 2>&1 || {
        print_error "Failed to clone repository"
        rm -rf "$tmp_dir"
        return 1
    }

    install_skills_from_repo "$tmp_dir" "$skills_dir"
    rm -rf "$tmp_dir"
}

install_via_tarball() {
    skills_dir="$1"
    tmp_dir=$(mktemp -d)

    tarball_url="$REPO_URL/archive/refs/heads/$BRANCH.tar.gz"

    print_info "Downloading from $tarball_url..."
    curl -fsSL "$tarball_url" -o "$tmp_dir/repo.tar.gz" || {
        print_error "Failed to download archive"
        rm -rf "$tmp_dir"
        exit 1
    }

    tar -xzf "$tmp_dir/repo.tar.gz" -C "$tmp_dir"

    extracted_dir=$(find "$tmp_dir" -maxdepth 1 -type d -name "*-*" | head -1)

    install_skills_from_repo "$extracted_dir" "$skills_dir"

    rm -rf "$tmp_dir"
}

main() {
    print_header

    if [ -z "$1" ]; then
        usage
    fi

    platform="$1"
    skills_dir_name=$(get_skills_dir "$platform")

    project_root=$(detect_project_root)
    skills_dir="$project_root/$skills_dir_name"

    mkdir -p "$skills_dir"

    print_info "Installing skills for: $platform"
    print_info "Project root: $project_root"
    print_info "Target directory: $skills_dir"
    echo ""

    if command -v git >/dev/null 2>&1; then
        install_via_git "$skills_dir" || install_via_tarball "$skills_dir"
    else
        install_via_tarball "$skills_dir"
    fi

    echo ""
    echo "${GREEN}============================================${NC}"
    echo "${GREEN} Installation complete!${NC}"
    echo "${GREEN}============================================${NC}"
    echo ""
    echo "Installed skills:$INSTALLED_SKILLS"
    echo ""
}

main "$@"
