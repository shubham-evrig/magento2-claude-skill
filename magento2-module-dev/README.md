# Magento 2 AI Skills

AI-powered skills for Magento 2 development. These skills extend AI coding assistants with specialized knowledge for creating production-ready Magento 2 modules, following official coding standards and best practices.

## Available Skills

| Skill                                                          | Description                                                                                                                     |
|----------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| [magento2-create-module](magento2-create-module/)             | Create production-ready Magento 2 modules with proper structure, coding standards, and PHP version-specific patterns           |

More skills coming soon for admin configuration, database operations, API endpoints, and frontend components.

## Quick Install

```bash
# For Claude Code
curl -fsSL https://raw.githubusercontent.com/your-repo/magento2-ai-skills/main/install.sh | sh -s claude

# For Cursor
curl -fsSL https://raw.githubusercontent.com/your-repo/magento2-ai-skills/main/install.sh | sh -s cursor

# For Codex
curl -fsSL https://raw.githubusercontent.com/your-repo/magento2-ai-skills/main/install.sh | sh -s codex

# For GitHub Copilot
curl -fsSL https://raw.githubusercontent.com/your-repo/magento2-ai-skills/main/install.sh | sh -s copilot
```

## Manual Installation

1. Clone or download this repository
2. Copy the skill directories to your project:
    - **Claude Code**: `~/.claude/skills/`
    - **Cursor**: `.cursor/skills/`
    - **Codex**: `.codex/skills/`
    - **GitHub Copilot**: `.github/skills/`

## Usage

Once installed, the AI assistant will automatically use these skills when relevant. You can also invoke them directly:

```bash
# Create a new module
create new custom module

# With specific features
create a product enhancement module with database and admin config

# Hyva-compatible module
create a frontend module with Hyva support
```

## Features

- ✅ **PHP Version Aware** - Adjusts code patterns for PHP 7.4, 8.1, 8.2, 8.3
- ✅ **Coding Standards** - Follows Magento 2 Coding Standard and PSR-12
- ✅ **Strict Types** - Automatically adds `declare(strict_types=1);`
- ✅ **Constant-Based** - Uses constants instead of magic values
- ✅ **Hyvä Compatible** - Optional Hyvä theme support with Alpine.js
- ✅ **Auto-Documentation** - Generates and maintains README.md
- ✅ **Quality Assured** - Built-in PHPCS and PHPStan validation

## Requirements

- Magento 2.4.4+
- PHP 7.4+ (8.1+ recommended)
- Claude Code, Cursor, Codex, or compatible AI coding assistant

## Documentation

- [Module Creator Skill Guide](magento2-create-module/SKILL.md) - Complete documentation
- [Skill Conflict Resolution](SKILL_CONFLICT_SOLUTION.md) - Fix trigger conflicts
- [Examples & Best Practices](#) - Coming soon

## Support

- **Issues**: [GitHub Issues](https://github.com/your-repo/magento2-ai-skills/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-repo/magento2-ai-skills/discussions)

## Roadmap

### Current Version (1.0.1)
- ✅ Base module structure generation
- ✅ PHP version-specific patterns
- ✅ Hyvä theme compatibility
- ✅ Auto-documentation

### Upcoming Skills
- 🔜 `magento2-admin-config` - System configuration and admin panels
- 🔜 `magento2-database` - Database tables, models, repositories
- 🔜 `magento2-frontend` - Controllers, layouts, templates
- 🔜 `magento2-api` - REST/SOAP API endpoints
- 🔜 `magento2-observers` - Event observers and custom events
- 🔜 `magento2-plugins` - Plugins (interceptors)
- 🔜 `magento2-cron` - Cron jobs and scheduled tasks
- 🔜 `magento2-cli` - CLI commands
- 🔜 `magento2-ui-component` - Admin grids and forms
- 🔜 `magento2-payment` - Payment method integration
- 🔜 `magento2-shipping` - Shipping method integration

## License

Licensed under the MIT License.

---

Copyright (c) 2026 Magento Dev Team. All rights reserved.
