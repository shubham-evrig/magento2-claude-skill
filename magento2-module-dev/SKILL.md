---
name: magento2-create-module
description: Create production-ready Magento 2 custom modules with proper directory structure, coding standards, and best practices. Automatically generates all essential files following official Magento conventions. Trigger phrases include "create module", "new module", "scaffold module", "generate module", "create custom module", "make a module", "build module".
metadata:
  short-description: Magento 2 custom module generator
  version: 1.0.1
  author: Magento Dev Team
  tags: [magento2, module, php, architecture]
  priority: 100
---

# Magento 2 Custom Module Creator

## Purpose
This skill creates complete, production-ready Magento 2 custom modules following official coding standards and architectural best practices. It reduces development time by automating the creation of proper directory structures, configuration files, and boilerplate code.

## When This Skill Activates

**Trigger phrases (this skill loads automatically when user says):**
- "create module" ← Generic
- "new module" ← Generic
- "scaffold module" ← Generic
- "generate module" ← Generic
- "create custom module" ← Generic
- "make a module" ← Generic
- "build module" ← Generic
- "create new magento 2 module"
- "generate magento module"
- "new custom module for magento"
- "build magento 2 extension"
- "create magento 2 custom module"
- "make a magento module"

**DO NOT activate for:**
- Editing existing modules (use modification skills instead)
- Core Magento file changes (prohibited)
- Theme-only modifications (use theme skills)

## Quick Start

When this skill activates, immediately gather these requirements:

### Required Information (Ask in this order)
1. **Vendor Name** (PascalCase, e.g., "Acme", "MyCompany")
2. **Module Name** (PascalCase, e.g., "ProductLabel", "CustomCheckout")
3. **PHP Version** (7.4, 8.1, 8.2, or 8.3) - This determines coding patterns
4. **Module Dependencies** (e.g., Magento_Catalog, Magento_Checkout)
5. **Module Purpose** (brief description for documentation)
6. **Hyvä Compatibility** (Yes/No) - Ask only when working with view/template/layout files

### Optional Features (ask user)
```
Which features does your module need?

□ Admin Configuration (system.xml)
□ Database Tables
□ Frontend Pages/Templates
□ REST/SOAP API
□ Event Observers
□ Plugins (Interceptors)
□ Cron Jobs
□ CLI Commands
□ Admin Grid/Form
```

### PHP Version-Based Patterns

The skill automatically adjusts code patterns based on PHP version:

**PHP 7.4:**
```php
// Constructor
private $logger;
private $productRepository;

public function __construct(
    LoggerInterface $logger,
    ProductRepositoryInterface $productRepository
) {
    $this->logger = $logger;
    $this->productRepository = $productRepository;
}
```

**PHP 8.0+:**
```php
// Constructor with property promotion
public function __construct(
    private readonly LoggerInterface $logger,
    private readonly ProductRepositoryInterface $productRepository
) {}
```

**PHP 8.1+:**
```php
// Constructor with promoted properties and readonly
public function __construct(
    private readonly LoggerInterface $logger,
    private readonly ProductRepositoryInterface $productRepository
) {}

// Enums for constants
enum Status: int
{
    case ENABLED = 1;
    case DISABLED = 0;
}
```

## Complete Module Creation Workflow

```
┌─────────────────────────────────────────────────────┐
│ STEP 1: GATHER REQUIREMENTS                         │
├─────────────────────────────────────────────────────┤
│ Ask user:                                           │
│ 1. Vendor Name (e.g., "Acme")                       │
│ 2. Module Name (e.g., "ProductLabel")              │
│ 3. PHP Version (7.4, 8.1, 8.2, 8.3)               │
│ 4. Dependencies (e.g., Magento_Catalog)            │
│ 5. Module Purpose                                   │
└─────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────┐
│ STEP 2: CREATE BASE STRUCTURE                       │
├─────────────────────────────────────────────────────┤
│ Generate:                                           │
│ ✅ Directory structure                              │
│ ✅ registration.php (with strict_types)            │
│ ✅ etc/module.xml (with dependencies)              │
│ ✅ composer.json (with PHP version)                │
│ ✅ etc/acl.xml                                      │
│ ✅ README.md (initial version)                      │
└─────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────┐
│ STEP 3: ASK ABOUT FEATURES                          │
├─────────────────────────────────────────────────────┤
│ "Which features does your module need?"            │
│ □ Admin Configuration                               │
│ □ Database Tables                                   │
│ □ Frontend Pages/Templates                          │
│ □ REST/SOAP API                                     │
│ □ Event Observers                                   │
│ □ Plugins                                           │
│ □ Cron Jobs                                         │
│ □ CLI Commands                                      │
└─────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────┐
│ STEP 4: IF VIEW/TEMPLATE FILES NEEDED                │
├─────────────────────────────────────────────────────┤
│ Ask: "Does this need Hyvä compatibility? (Y/N)"    │
│                                                     │
│ If YES:                                             │
│ ✅ Create view/frontend/layout/default.xml         │
│ ✅ Create view/frontend/layout/hyva/default.xml    │
│ ✅ Create view/frontend/templates/list.phtml       │
│ ✅ Create view/frontend/templates/hyva/list.phtml  │
└─────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────┐
│ STEP 5: GENERATE FEATURE FILES                      │
├─────────────────────────────────────────────────────┤
│ Based on user selections:                           │
│ • Use constants (not magic values)                  │
│ • Use ::class keyword (not FQCN strings)           │
│ • Add proper imports at top                         │
│ • Include comprehensive DocBlocks                   │
│ • Use declare(strict_types=1) in all PHP files     │
│ • Follow PHP version-specific patterns             │
└─────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────┐
│ STEP 6: UPDATE README.md                            │
├─────────────────────────────────────────────────────┤
│ Auto-update with:                                   │
│ • Feature list                                      │
│ • Installation instructions                         │
│ • Configuration details                             │
│ • API endpoints (if applicable)                     │
│ • Database schema                                   │
│ • Dependencies                                      │
│ • Hyvä compatibility status                         │
└─────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────┐
│ STEP 7: RUN QUALITY CHECKS                          │
├─────────────────────────────────────────────────────┤
│ Validate:                                           │
│ ✓ Magento Coding Standard (phpcs)                  │
│ ✓ PHP Stan Level 8                                 │
│ ✓ PHP version compatibility                        │
│ ✓ All files have declare(strict_types=1)          │
│ ✓ No FQCN strings (use ::class)                    │
│ ✓ Constants instead of magic values                │
└─────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────┐
│ STEP 8: PROVIDE INSTALLATION COMMANDS                │
├─────────────────────────────────────────────────────┤
│ bin/magento module:enable {Vendor}_{ModuleName}    │
│ bin/magento setup:upgrade                           │
│ bin/magento setup:di:compile                        │
│ bin/magento cache:clean                             │
└─────────────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────────────┐
│ STEP 9: SUGGEST NEXT STEPS                          │
├─────────────────────────────────────────────────────┤
│ "Module created! Need additional features?"         │
│ • magento2-admin-config (system configuration)      │
│ • magento2-database (tables & repositories)         │
│ • magento2-api (REST/SOAP endpoints)               │
│ • magento2-observers (event handling)              │
│ • magento2-plugins (method interception)           │
└─────────────────────────────────────────────────────┘
```



## Module Directory Structure

```
app/code/{Vendor}/{ModuleName}/
├── registration.php          # Module registration
├── composer.json            # Composer package definition
├── etc/
│   ├── module.xml          # Module declaration
│   ├── di.xml              # Dependency injection
│   ├── acl.xml             # Access control
│   └── config.xml          # Default configuration
├── Block/                  # Block classes
├── Controller/             # Controllers
├── Helper/                 # Helper classes
├── Model/                  # Business logic
│   └── ResourceModel/      # Database operations
├── Observer/               # Event observers
├── Plugin/                 # Plugins/Interceptors
├── Setup/                  # Installation scripts
│   └── Patch/             # Data/Schema patches
├── view/
│   ├── frontend/          # Frontend assets
│   └── adminhtml/         # Admin assets
└── README.md              # Documentation
```

## Essential Files Generation

### 1. registration.php
```php
<?php
/**
 * Copyright © {Vendor}. All rights reserved.
 * See COPYING.txt for license details.
 * 
 * Registration file for {Vendor}_{ModuleName} module
 * This file registers the module with Magento's component registrar
 */
declare(strict_types=1);

use Magento\Framework\Component\ComponentRegistrar;

ComponentRegistrar::register(
    ComponentRegistrar::MODULE,
    '{Vendor}_{ModuleName}',
    __DIR__
);
```

**CRITICAL:** Use underscore `{Vendor}_{ModuleName}` NOT backslash

### 2. etc/module.xml
```xml
<?xml version="1.0"?>
<!--
/**
 * Copyright © {Vendor}. All rights reserved.
 * See COPYING.txt for license details.
 * 
 * Module declaration file
 * Defines module name, version, and dependencies
 */
-->
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
    <module name="{Vendor}_{ModuleName}" setup_version="1.0.0">
        <sequence>
            <!-- Module dependencies - load order matters -->
            {DEPENDENCIES}
            <!-- Example:
            <module name="Magento_Catalog"/>
            <module name="Magento_Customer"/>
            -->
        </sequence>
    </module>
</config>
```

**Note:** Only add dependencies that are truly required (used in di.xml, layouts, etc.)

### 3. composer.json
```json
{
    "name": "{vendor}/{module-name}",
    "description": "{Module description}",
    "type": "magento2-module",
    "version": "1.0.0",
    "license": [
        "OSL-3.0",
        "AFL-3.0"
    ],
    "require": {
        "php": "~7.4.0||~8.1.0||~8.2.0||~8.3.0",
        "magento/framework": "103.0.*"
    },
    "autoload": {
        "files": [
            "registration.php"
        ],
        "psr-4": {
            "{Vendor}\\{ModuleName}\\": ""
        }
    }
}
```

### 4. etc/acl.xml (if admin features)
```xml
<?xml version="1.0"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xsi:noNamespaceSchemaLocation="urn:magento:framework:Acl/etc/acl.xsd">
    <acl>
        <resources>
            <resource id="Magento_Backend::admin">
                <resource id="{Vendor}_{ModuleName}::config" 
                         title="{Module Name}" 
                         sortOrder="100" />
            </resource>
        </resources>
    </acl>
</config>
```

### 5. README.md
```markdown
# {Vendor}_{ModuleName}

## Description
{Module purpose and features}

## Installation

### Via Composer
```bash
composer require {vendor}/{module-name}
bin/magento module:enable {Vendor}_{ModuleName}
bin/magento setup:upgrade
bin/magento setup:di:compile
bin/magento cache:clean
```

### Manual Installation
1. Create directory `app/code/{Vendor}/{ModuleName}`
2. Copy all files to this directory
3. Run:
```bash
bin/magento module:enable {Vendor}_{ModuleName}
bin/magento setup:upgrade
```

## Configuration
{Configuration instructions if applicable}

## Usage
{Usage instructions}

## License
OSL-3.0 / AFL-3.0
```

## Feature-Specific Files

### For Database Tables

**etc/db_schema.xml** (Magento 2.3+):
```xml
<?xml version="1.0"?>
<schema xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:noNamespaceSchemaLocation="urn:magento:framework:Setup/Declaration/Schema/etc/schema.xsd">
    <table name="{vendor}_{module}_{entity}" resource="default" engine="innodb">
        <column xsi:type="int" name="entity_id" unsigned="true" nullable="false" 
                identity="true" comment="Entity ID"/>
        <column xsi:type="varchar" name="name" nullable="false" length="255" comment="Name"/>
        <column xsi:type="smallint" name="status" unsigned="true" nullable="false" 
                default="1" comment="Status"/>
        <column xsi:type="timestamp" name="created_at" nullable="false" 
                default="CURRENT_TIMESTAMP" comment="Created At"/>
        <column xsi:type="timestamp" name="updated_at" nullable="false" 
                default="CURRENT_TIMESTAMP" on_update="true" comment="Updated At"/>
        
        <constraint xsi:type="primary" referenceId="PRIMARY">
            <column name="entity_id"/>
        </constraint>
        
        <index referenceId="IDX_{VENDOR}_{MODULE}_{ENTITY}_NAME" indexType="btree">
            <column name="name"/>
        </index>
    </table>
</schema>
```

**Model/{Entity}.php**:
```php
<?php
/**
 * Copyright © {Vendor}. All rights reserved.
 * See COPYING.txt for license details.
 */
declare(strict_types=1);

namespace {Vendor}\{ModuleName}\Model;

use Magento\Framework\Model\AbstractModel;
use {Vendor}\{ModuleName}\Model\ResourceModel\{Entity} as {Entity}Resource;

/**
 * {Entity} Model
 * 
 * @method int getEntityId()
 * @method $this setEntityId(int $id)
 */
class {Entity} extends AbstractModel
{
    /**
     * Cache tag constant
     */
    public const CACHE_TAG = '{vendor}_{module}_{entity}';
    
    /**
     * Entity ID field name
     */
    public const ENTITY_ID = 'entity_id';
    
    /**
     * Status constants
     */
    public const STATUS_ENABLED = 1;
    public const STATUS_DISABLED = 0;
    
    /**
     * @var string
     */
    protected $_cacheTag = self::CACHE_TAG;
    
    /**
     * @var string
     */
    protected $_eventPrefix = '{vendor}_{module}_{entity}';
    
    /**
     * Initialize resource model
     *
     * @return void
     */
    protected function _construct(): void
    {
        $this->_init({Entity}Resource::class);
    }
    
    /**
     * Get identities
     *
     * @return array
     */
    public function getIdentities(): array
    {
        return [self::CACHE_TAG . '_' . $this->getId()];
    }
}
```

**Model/ResourceModel/{Entity}.php**:
```php
<?php
/**
 * Copyright © {Vendor}. All rights reserved.
 * See COPYING.txt for license details.
 */
declare(strict_types=1);

namespace {Vendor}\{ModuleName}\Model\ResourceModel;

use Magento\Framework\Model\ResourceModel\Db\AbstractDb;
use {Vendor}\{ModuleName}\Model\{Entity} as {Entity}Model;

/**
 * {Entity} Resource Model
 */
class {Entity} extends AbstractDb
{
    /**
     * Table name constant
     */
    public const TABLE_NAME = '{vendor}_{module}_{entity}';
    
    /**
     * Primary key field
     */
    public const ID_FIELD_NAME = {Entity}Model::ENTITY_ID;
    
    /**
     * Initialize resource model
     *
     * @return void
     */
    protected function _construct(): void
    {
        $this->_init(self::TABLE_NAME, self::ID_FIELD_NAME);
    }
}
```

**Model/ResourceModel/{Entity}/Collection.php**:
```php
<?php
/**
 * Copyright © {Vendor}. All rights reserved.
 * See COPYING.txt for license details.
 */
declare(strict_types=1);

namespace {Vendor}\{ModuleName}\Model\ResourceModel\{Entity};

use Magento\Framework\Model\ResourceModel\Db\Collection\AbstractCollection;
use {Vendor}\{ModuleName}\Model\{Entity} as {Entity}Model;
use {Vendor}\{ModuleName}\Model\ResourceModel\{Entity} as {Entity}Resource;

/**
 * {Entity} Collection
 */
class Collection extends AbstractCollection
{
    /**
     * @var string
     */
    protected $_idFieldName = {Entity}Model::ENTITY_ID;
    
    /**
     * Event prefix
     *
     * @var string
     */
    protected $_eventPrefix = '{vendor}_{module}_{entity}_collection';
    
    /**
     * Event object
     *
     * @var string
     */
    protected $_eventObject = '{entity}_collection';
    
    /**
     * Initialize collection
     *
     * @return void
     */
    protected function _construct(): void
    {
        $this->_init(
            {Entity}Model::class,
            {Entity}Resource::class
        );
    }
}
```

### For Admin Configuration

**etc/adminhtml/system.xml**:
```xml
<?xml version="1.0"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
    <system>
        <tab id="{vendor}_{module}" translate="label" sortOrder="200">
            <label>{Module Name}</label>
        </tab>
        <section id="{vendor}_{module}" translate="label" type="text" sortOrder="100" 
                 showInDefault="1" showInWebsite="1" showInStore="1">
            <label>{Module Name} Settings</label>
            <tab>{vendor}_{module}</tab>
            <resource>{Vendor}_{ModuleName}::config</resource>
            
            <group id="general" translate="label" type="text" sortOrder="10" 
                   showInDefault="1" showInWebsite="1" showInStore="1">
                <label>General Settings</label>
                
                <field id="enabled" translate="label" type="select" sortOrder="10" 
                       showInDefault="1" showInWebsite="1" showInStore="1">
                    <label>Enable</label>
                    <source_model>Magento\Config\Model\Config\Source\Yesno</source_model>
                </field>
            </group>
        </section>
    </system>
</config>
```

**etc/config.xml** (default values):
```xml
<?xml version="1.0"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Store:etc/config.xsd">
    <default>
        <{vendor}_{module}>
            <general>
                <enabled>1</enabled>
            </general>
        </{vendor}_{module}>
    </default>
</config>
```

### For Frontend Display

**etc/frontend/routes.xml**:
```xml
<?xml version="1.0"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xsi:noNamespaceSchemaLocation="urn:magento:framework:App/etc/routes.xsd">
    <router id="standard">
        <route id="{module_route}" frontName="{route_name}">
            <module name="{Vendor}_{ModuleName}" />
        </route>
    </router>
</config>
```

**Controller/Index/Index.php**:
```php
<?php
/**
 * Copyright © {Vendor}. All rights reserved.
 * See COPYING.txt for license details.
 */
declare(strict_types=1);

namespace {Vendor}\{ModuleName}\Controller\Index;

use Magento\Framework\App\Action\HttpGetActionInterface;
use Magento\Framework\App\ResponseInterface;
use Magento\Framework\Controller\ResultInterface;
use Magento\Framework\View\Result\Page;
use Magento\Framework\View\Result\PageFactory;

/**
 * Index Controller
 * 
 * Displays the main index page for the module
 */
class Index implements HttpGetActionInterface
{
    /**
     * Constructor
     *
     * @param PageFactory $resultPageFactory
     */
    public function __construct(
        private readonly PageFactory $resultPageFactory
    ) {}
    
    /**
     * Execute action
     *
     * @return ResponseInterface|ResultInterface|Page
     */
    public function execute(): ResponseInterface|ResultInterface|Page
    {
        $resultPage = $this->resultPageFactory->create();
        $resultPage->getConfig()->getTitle()->set(__('Module Title'));
        
        return $resultPage;
    }
}
```

**view/frontend/layout/{module_route}_index_index.xml**:
```xml
<?xml version="1.0"?>
<page xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
      xsi:noNamespaceSchemaLocation="urn:magento:framework:View/Layout/etc/page_configuration.xsd">
    <body>
        <referenceContainer name="content">
            <block class="{Vendor}\{ModuleName}\Block\Index" 
                   name="{vendor}.{module}.index" 
                   template="{Vendor}_{ModuleName}::index.phtml"/>
        </referenceContainer>
    </body>
</page>
```

**view/frontend/templates/index.phtml**:
```php
<?php
/**
 * @var \{Vendor}\{ModuleName}\Block\Index $block
 * @var \Magento\Framework\Escaper $escaper
 */
?>
<div class="{vendor}-{module}-container">
    <h1><?= $escaper->escapeHtml(__('Welcome to {Module Name}')) ?></h1>
</div>
```

## Magento 2 Coding Standards (Official)

This skill strictly follows the official Magento 2 Coding Standard:
**Reference:** https://github.com/magento/magento-coding-standard

### Core Principles

1. **PSR-12 Compliance** - All code must follow PSR-12 standards
2. **Magento-Specific Rules** - Additional rules from Magento Coding Standard
3. **Security First** - No unescaped output, SQL injection prevention
4. **Type Safety** - Always use `declare(strict_types=1);`
5. **Class Resolution** - Use `::class` keyword, NEVER string literals

### Critical Rules

#### 1. Always Use `declare(strict_types=1);`
```php
<?php
/**
 * Copyright © {Vendor}. All rights reserved.
 */
declare(strict_types=1);

namespace {Vendor}\{ModuleName}\Model;

class Example
{
    // Your code
}
```

#### 2. Use ::class Keyword for Class References

**✅ CORRECT:**
```php
use Vendor\ModuleName\Model\Item;
use Vendor\ModuleName\Model\ResourceModel\Item as ItemResource;

class Example
{
    public function __construct(
        private readonly Item $item,
        private readonly ItemResource $itemResource
    ) {}
    
    public function execute(): void
    {
        $this->_init(ItemResource::class);
        
        // When using in strings/arrays
        $implements = [
            Item::class,
            'Vendor\ModuleName\Api\DataInterface'
        ];
    }
}
```

**❌ WRONG:**
```php
// Never use fully qualified class names in code
$this->_init(\Vendor\ModuleName\Model\ResourceModel\Item::class);
$this->_init('Vendor\ModuleName\Model\ResourceModel\Item');
```

#### 3. Use Constants Instead of Magic Values

**✅ CORRECT:**
```php
<?php
declare(strict_types=1);

namespace Vendor\ModuleName\Model;

class Item
{
    /**
     * Status constants
     */
    public const STATUS_ENABLED = 1;
    public const STATUS_DISABLED = 0;
    
    /**
     * Cache tag
     */
    public const CACHE_TAG = 'vendor_module_item';
    
    /**
     * Table name
     */
    public const TABLE_NAME = 'vendor_module_item';
    
    /**
     * Get status label
     *
     * @param int $status
     * @return string
     */
    public function getStatusLabel(int $status): string
    {
        return match($status) {
            self::STATUS_ENABLED => __('Enabled'),
            self::STATUS_DISABLED => __('Disabled'),
            default => __('Unknown'),
        };
    }
}
```

**❌ WRONG:**
```php
// No magic numbers or strings
if ($item->getStatus() == 1) {
    return 'Enabled';
}
```

#### 4. Proper Documentation

**Every class, method, and property MUST have DocBlocks:**

```php
<?php
/**
 * Copyright © {Vendor}. All rights reserved.
 * See COPYING.txt for license details.
 */
declare(strict_types=1);

namespace Vendor\ModuleName\Model;

use Magento\Framework\Model\AbstractModel;
use Vendor\ModuleName\Api\Data\ItemInterface;

/**
 * Item Model
 * 
 * Represents a single item entity with CRUD operations
 * 
 * @method int getId()
 * @method $this setId(int $id)
 * @method string getName()
 * @method $this setName(string $name)
 */
class Item extends AbstractModel implements ItemInterface
{
    /**
     * Cache tag constant
     */
    public const CACHE_TAG = 'vendor_module_item';
    
    /**
     * @var string
     */
    protected $_cacheTag = self::CACHE_TAG;
    
    /**
     * @var string
     */
    protected $_eventPrefix = 'vendor_module_item';
    
    /**
     * Initialize resource model
     *
     * @return void
     */
    protected function _construct(): void
    {
        $this->_init(ResourceModel\Item::class);
    }
    
    /**
     * Get identities for cache
     *
     * @return string[]
     */
    public function getIdentities(): array
    {
        return [self::CACHE_TAG . '_' . $this->getId()];
    }
    
    /**
     * Get item name
     *
     * @return string|null
     */
    public function getName(): ?string
    {
        return $this->getData(self::NAME);
    }
    
    /**
     * Set item name
     *
     * @param string $name
     * @return $this
     */
    public function setName(string $name): ItemInterface
    {
        return $this->setData(self::NAME, $name);
    }
}
```

#### 5. Hyvä Theme Compatibility

**When creating view/template or view/layout files, ALWAYS ask:**

```
"Does this module need to be compatible with Hyvä theme? (Yes/No)"
```

**If YES, generate both Luma and Hyvä templates:**

```
view/
├── frontend/
│   ├── layout/
│   │   ├── default.xml              # Standard Luma layout
│   │   └── hyva/                    # Hyvä-specific layouts
│   │       └── default.xml
│   ├── templates/
│   │   ├── list.phtml               # Standard Luma template
│   │   └── hyva/                    # Hyvä-specific templates
│   │       └── list.phtml
│   └── web/
│       ├── css/
│       └── js/
│           ├── component.js         # RequireJS (Luma)
│           └── hyva/                # Alpine.js (Hyvä)
│               └── component.js
```

**Hyvä Template Example (uses Alpine.js & Tailwind):**
```phtml
<?php
/**
 * @var \Vendor\ModuleName\Block\Item $block
 * @var \Magento\Framework\Escaper $escaper
 */
?>
<div x-data="itemComponent()" 
     class="container mx-auto px-4 py-8">
    
    <h2 class="text-2xl font-bold mb-4">
        <?= $escaper->escapeHtml(__('Items List')) ?>
    </h2>
    
    <template x-for="item in items" :key="item.id">
        <div class="bg-white rounded-lg shadow-md p-6 mb-4">
            <h3 class="text-xl font-semibold" x-text="item.name"></h3>
            <p class="text-gray-600 mt-2" x-text="item.description"></p>
        </div>
    </template>
</div>

<script>
    function itemComponent() {
        return {
            items: <?= $block->getItemsJson() ?>,
            
            init() {
                console.log('Hyvä component initialized');
            }
        }
    }
</script>
```

#### 6. README.md Auto-Update

**The skill MUST update README.md whenever module changes:**

```markdown
# {Vendor}_{ModuleName}

## Version
Current Version: 1.0.0

## Description
{Module purpose and detailed description}

## Features
- ✅ {Feature 1}
- ✅ {Feature 2}
- ✅ {Feature 3}

## Requirements
- Magento 2.4.4+
- PHP {php_version}+

## Dependencies
{list all module dependencies}

## Installation

### Via Composer
```bash
composer require {vendor}/{module-name}
bin/magento module:enable {Vendor}_{ModuleName}
bin/magento setup:upgrade
bin/magento setup:di:compile
bin/magento cache:clean
```

### Manual
1. Create directory `app/code/{Vendor}/{ModuleName}`
2. Copy all files
3. Run:
```bash
bin/magento module:enable {Vendor}_{ModuleName}
bin/magento setup:upgrade
```

## Configuration

{If system configuration exists, document paths and options}

Navigate to: **Stores → Configuration → {Section} → {Module Name}**

### Available Settings:
- **Enable Module**: Enable/Disable the module functionality
- **{Setting Name}**: {Setting description}

## Usage

### For Store Owners
{Instructions for admin users}

### For Developers

#### Repository Pattern
```php
use Vendor\ModuleName\Api\ItemRepositoryInterface;

class Example
{
    public function __construct(
        private readonly ItemRepositoryInterface $itemRepository
    ) {}
    
    public function execute(): void
    {
        $item = $this->itemRepository->getById(1);
    }
}
```

#### Events
**Dispatched Events:**
- `vendor_module_item_save_before` - Before item save
- `vendor_module_item_save_after` - After item save
- `vendor_module_item_delete_before` - Before item delete
- `vendor_module_item_delete_after` - After item delete

## API Endpoints

{If REST/SOAP API exists}

### REST API
- `GET /V1/vendor-module/items` - Get all items
- `GET /V1/vendor-module/items/:id` - Get item by ID
- `POST /V1/vendor-module/items` - Create item
- `PUT /V1/vendor-module/items/:id` - Update item
- `DELETE /V1/vendor-module/items/:id` - Delete item

## Database Schema

### Tables Created
- `{vendor}_{module}_{entity}` - Main entity table

## Hyvä Compatibility
{If applicable}
✅ This module is fully compatible with Hyvä theme.

Hyvä-specific files are located in:
- `view/frontend/layout/hyva/`
- `view/frontend/templates/hyva/`

## Testing

### Run Unit Tests
```bash
vendor/bin/phpunit -c dev/tests/unit/phpunit.xml.dist app/code/{Vendor}/{ModuleName}/Test/Unit
```

### Run Integration Tests
```bash
vendor/bin/phpunit -c dev/tests/integration/phpunit.xml.dist app/code/{Vendor}/{ModuleName}/Test/Integration
```

## Troubleshooting

### Common Issues

**Issue:** Module not showing in module list
**Solution:** 
```bash
rm -rf generated/* var/cache/*
bin/magento module:enable {Vendor}_{ModuleName}
bin/magento setup:upgrade
```

## Changelog

### Version 1.0.0 (YYYY-MM-DD)
- Initial release
- {Feature list}

## Support
- **Email**: support@{vendor}.com
- **Documentation**: https://{vendor}.com/docs/{module}
- **Issues**: https://github.com/{vendor}/{module}/issues

## License
OSL-3.0 / AFL-3.0

## Credits
Developed by {Vendor} Development Team

---
**Note**: This README is automatically updated when the module structure changes.
```

## Coding Standards

### PHP Standards (PSR-12 + Magento)

**Always include:**
- Strict types declaration: `declare(strict_types=1);`
- Proper DocBlocks with copyright
- Type hints for parameters and return types
- Constructor property promotion (PHP 8.0+)

**Example:**
```php
<?php
/**
 * Copyright © {Vendor}. All rights reserved.
 * See COPYING.txt for license details.
 */
declare(strict_types=1);

namespace {Vendor}\{ModuleName}\Model;

use Psr\Log\LoggerInterface;

class Example
{
    /**
     * @param LoggerInterface $logger
     */
    public function __construct(
        private readonly LoggerInterface $logger
    ) {}
    
    /**
     * Get example data
     *
     * @param int $id
     * @return array
     */
    public function getData(int $id): array
    {
        $this->logger->info('Getting data for ID: ' . $id);
        return [];
    }
}
```

### Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Class Files | PascalCase | `ProductRepository.php` |
| Methods | camelCase | `getProductById()` |
| Layout Files | lowercase-hyphen | `catalog_product_view.xml` |
| Templates | lowercase_underscore | `product_list.phtml` |
| Database Tables | lowercase_underscore | `vendor_module_entity` |
| Variables | camelCase | `$productData` |

### Best Practices

**DO:**
- ✅ Use dependency injection
- ✅ Follow repository pattern for data access
- ✅ Use service contracts (interfaces)
- ✅ Implement proper exception handling
- ✅ Add proper ACL for admin resources
- ✅ Escape output in templates
- ✅ Use factories for object creation
- ✅ Follow SOLID principles

**DON'T:**
- ❌ Use ObjectManager directly
- ❌ Put business logic in controllers
- ❌ Write direct SQL queries
- ❌ Modify core files
- ❌ Use `die()` or `exit()`
- ❌ Access `$_GET`, `$_POST` directly
- ❌ Create God classes

## Installation Commands

After generating the module, provide these commands:

```bash
# Enable the module
bin/magento module:enable {Vendor}_{ModuleName}

# Run setup upgrade
bin/magento setup:upgrade

# Generate db_schema_whitelist.json (if database used)
bin/magento setup:db-declaration:generate-whitelist --module-name={Vendor}_{ModuleName}

# Compile DI
bin/magento setup:di:compile

# Deploy static content (dev mode)
bin/magento setup:static-content:deploy -f

# Clear cache
bin/magento cache:clean
bin/magento cache:flush
```

## Calling Other Skills

After creating the base module structure, suggest these follow-up skills if user needs:

**Available Follow-up Skills:**
- `magento2-admin-config` - System configuration (if admin features needed)
- `magento2-database` - Database operations (if tables needed)
- `magento2-frontend` - Frontend pages and templates (if UI needed)
- `magento2-api` - REST/SOAP APIs (if API needed)
- `magento2-observers` - Event observers
- `magento2-plugins` - Plugins/Interceptors
- `magento2-cron` - Cron jobs
- `magento2-cli` - CLI commands
- `magento2-ui-grid` - Admin grids

**Suggestion format:**
```
✅ Base module created successfully!

Next steps - Do you need any of these features?
1. Admin configuration panel
2. Database tables
3. Frontend display
4. API endpoints
5. Event observers
6. Scheduled tasks (cron)
7. CLI commands

Reply with the numbers you need, or type 'done' if the base module is sufficient.
```

## Troubleshooting

### Common Issues

**Module not detected:**
```bash
# Check if registered
bin/magento module:status

# Clear generated files
rm -rf generated/code/* generated/metadata/*
bin/magento setup:upgrade
```

**Compilation errors:**
```bash
# Check syntax
php -l {path/to/file.php}

# Clear generated
rm -rf generated/*
bin/magento setup:di:compile
```

**Database issues:**
```bash
# Check schema status
bin/magento setup:db:status

# Regenerate whitelist
bin/magento setup:db-declaration:generate-whitelist --module-name={Vendor}_{ModuleName}
```

## Output Format

When creating a module, output:

1. ✅ Created directory structure
2. ✅ Generated registration.php
3. ✅ Generated etc/module.xml
4. ✅ Generated composer.json
5. ✅ Generated README.md
6. ✅ [Feature-specific files based on requirements]

**File tree visualization:**
```
app/code/{Vendor}/{ModuleName}/
├── ✅ registration.php
├── ✅ composer.json
├── ✅ README.md
└── etc/
    ├── ✅ module.xml
    ├── ✅ acl.xml
    └── ✅ config.xml
```

## Quality Checks

Before finalizing, verify:

- [ ] All file names follow conventions
- [ ] Namespace matches directory structure
- [ ] Copyright headers present in all files
- [ ] `declare(strict_types=1);` in all PHP files
- [ ] Type declarations used everywhere
- [ ] No ObjectManager usage
- [ ] ACL configured for admin resources
- [ ] README.md complete and up-to-date
- [ ] composer.json has correct autoload
- [ ] Constants used instead of magic values
- [ ] ::class keyword used (not FQCN strings)
- [ ] Proper use statements (imports at top)
- [ ] All methods have DocBlocks
- [ ] Dependencies properly declared in module.xml
- [ ] Hyvä compatibility considered (if applicable)

### Run Automated Quality Checks

```bash
# Install Magento Coding Standard
composer require --dev magento/magento-coding-standard

# Check coding standards
vendor/bin/phpcs --standard=Magento2 app/code/{Vendor}/{ModuleName}

# Auto-fix some issues
vendor/bin/phpcbf --standard=Magento2 app/code/{Vendor}/{ModuleName}

# PHP Stan analysis
vendor/bin/phpstan analyse -l 8 app/code/{Vendor}/{ModuleName}

# Check for specific PHP version compatibility
vendor/bin/phpcs --standard=PHPCompatibility --runtime-set testVersion {php_version} app/code/{Vendor}/{ModuleName}
```

## Version Compatibility

**Target Magento versions:**
- Magento 2.4.4 - 2.4.7 (latest stable)
- PHP 8.1, 8.2, 8.3
- Use declarative schema (db_schema.xml)

## Examples

### Example 1: Simple Module
```
User: "Create a module to add a custom attribute to products"

Action:
1. Ask: Vendor name, Module name
2. Generate base structure
3. Ask: "Do you need admin configuration for this attribute?"
4. Generate files
5. Provide installation commands
```

### Example 2: Complete Module
```
User: "Create a wishlist enhancement module with database and admin config"

Action:
1. Gather: Vendor="Acme", Module="WishlistEnhancement"
2. Create base structure
3. Ask feature checklist
4. User selects: Database ✓, Admin Config ✓
5. Generate all necessary files
6. Suggest: "Would you like to add API endpoints for this module?"
```

## Summary

This skill creates a complete, standards-compliant Magento 2 module foundation. It:
- Follows official Magento coding standards
- Uses proper architectural patterns
- Generates all boilerplate code
- Provides clear next steps
- Suggests additional skills when needed

**Result:** A production-ready module that can be immediately enabled and extended.
