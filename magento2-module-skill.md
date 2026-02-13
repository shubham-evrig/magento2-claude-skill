---
name: magento2-module-dev
description: Comprehensive guide for Magento 2 custom module development following official coding standards and best practices. Use this skill when creating, modifying, or reviewing Magento 2 modules, including controllers, models, plugins, observers, view models, blocks, templates, layouts, dependency injection, patches, and any other Magento 2 development tasks. Triggers include requests to create Magento modules, fix Magento code, follow Magento standards, implement Magento features, or work with Magento file structures (.xml, .phtml, .php module files).
license: MIT
---

# Magento 2 Module Development

This skill provides comprehensive guidance for creating high-quality Magento 2 custom modules following official coding standards and best practices.

## Core Development Principles

### 1. Module Structure and Dependencies

**Always declare dependencies in `etc/module.xml`:**
```xml
<?xml version="1.0"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
    <module name="Vendor_ModuleName" setup_version="1.0.0">
        <sequence>
            <module name="Magento_Catalog"/>
            <module name="Magento_Sales"/>
        </sequence>
    </module>
</config>
```

**Mirror dependencies in `composer.json`:**
```json
{
    "name": "vendor/module-name",
    "type": "magento2-module",
    "require": {
        "magento/module-catalog": "*",
        "magento/module-sales": "*"
    },
    "autoload": {
        "files": ["registration.php"],
        "psr-4": {
            "Vendor\\ModuleName\\": ""
        }
    }
}
```

### 2. Naming Conventions

- **Use short class names:** Import with `use` statements, never use fully qualified names in code
- **Follow PSR standards:** Proper namespacing, StudlyCaps for classes, camelCase for methods
- **Reference Magento core:** Always check how Magento core implements similar functionality

**Good:**
```php
<?php
namespace Vendor\ModuleName\Controller\Index;

use Magento\Framework\App\Action\HttpGetActionInterface;
use Magento\Framework\Controller\ResultFactory;
use Magento\Framework\View\Result\Page;

class Index implements HttpGetActionInterface
{
    private ResultFactory $resultFactory;

    public function __construct(ResultFactory $resultFactory)
    {
        $this->resultFactory = $resultFactory;
    }

    public function execute(): Page
    {
        return $this->resultFactory->create(ResultFactory::TYPE_PAGE);
    }
}
```

**Bad:**
```php
/* Avoid this */
public function execute()
{
    return $this->resultFactory->create(\Magento\Framework\Controller\ResultFactory::TYPE_PAGE);
}
```

### 3. Controllers

**Always implement HTTP interface methods:**
- `HttpGetActionInterface` for GET requests
- `HttpPostActionInterface` for POST requests
- `HttpPutActionInterface` for PUT requests
- `HttpDeleteActionInterface` for DELETE requests

**Example:**
```php
<?php
namespace Vendor\ModuleName\Controller\Index;

use Magento\Framework\App\Action\HttpPostActionInterface;
use Magento\Framework\Controller\Result\JsonFactory;
use Magento\Framework\App\RequestInterface;

class Save implements HttpPostActionInterface
{
    private JsonFactory $jsonFactory;
    private RequestInterface $request;

    public function __construct(
        JsonFactory $jsonFactory,
        RequestInterface $request
    ) {
        $this->jsonFactory = $jsonFactory;
        $this->request = $request;
    }

    public function execute()
    {
        $result = $this->jsonFactory->create();
        $data = $this->request->getPostValue();
        
        /* Process data */
        
        return $result->setData(['success' => true]);
    }
}
```

### 4. Dependency Injection (DI)

**Use constructor injection with typed properties (PHP 7.4+):**

```php
<?php
namespace Vendor\ModuleName\Model;

use Magento\Catalog\Api\ProductRepositoryInterface;
use Psr\Log\LoggerInterface;

class ProductProcessor
{
    private ProductRepositoryInterface $productRepository;
    private LoggerInterface $logger;

    public function __construct(
        ProductRepositoryInterface $productRepository,
        LoggerInterface $logger
    ) {
        $this->productRepository = $productRepository;
        $this->logger = $logger;
    }

    public function process(int $productId): void
    {
        try {
            $product = $this->productRepository->getById($productId);
            /* Process product */
        } catch (\Exception $e) {
            $this->logger->error($e->getMessage());
        }
    }
}
```

**NEVER use ObjectManager directly:** It violates DI principles and makes testing difficult.

### 5. Service Contracts

**Always use service contracts (API interfaces) for data operations:**

```php
<?php
namespace Vendor\ModuleName\Model;

use Magento\Catalog\Api\ProductRepositoryInterface;
use Magento\Catalog\Api\Data\ProductInterface;
use Magento\Framework\Exception\NoSuchEntityException;

class ProductService
{
    private ProductRepositoryInterface $productRepository;

    public function __construct(ProductRepositoryInterface $productRepository)
    {
        $this->productRepository = $productRepository;
    }

    public function updateProductPrice(int $productId, float $price): ProductInterface
    {
        $product = $this->productRepository->getById($productId);
        $product->setPrice($price);
        return $this->productRepository->save($product);
    }
}
```

**Avoid direct model/resource model/collection usage.** Use repositories and service contracts instead.

### 6. Customization Priority Order

Follow this hierarchy (highest to lowest priority):

1. **Plugins (Interceptors)** - Before, After, Around methods
2. **Events and Observers** - For cross-cutting concerns
3. **Preferences (Class rewrites)** - Last resort only

**Plugin Example (Preferred):**
```php
<?php
namespace Vendor\ModuleName\Plugin;

use Magento\Catalog\Api\Data\ProductInterface;
use Magento\Catalog\Api\ProductRepositoryInterface;

class ProductRepositoryPlugin
{
    /**
     * Before plugin example
     */
    public function beforeSave(
        ProductRepositoryInterface $subject,
        ProductInterface $product
    ): array {
        /* Modify product before save */
        return [$product];
    }

    /**
     * After plugin example
     */
    public function afterGetById(
        ProductRepositoryInterface $subject,
        ProductInterface $result,
        int $productId
    ): ProductInterface {
        /* Modify product after retrieval */
        return $result;
    }
}
```

**Configure in `etc/di.xml`:**
```xml
<?xml version="1.0"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
    <type name="Magento\Catalog\Api\ProductRepositoryInterface">
        <plugin name="vendor_modulename_product_repository" type="Vendor\ModuleName\Plugin\ProductRepositoryPlugin"/>
    </type>
</config>
```

**Preference Example (Last Resort):**
```xml
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:ObjectManager/etc/config.xsd">
    <preference for="Magento\Catalog\Model\Product" type="Vendor\ModuleName\Model\Product"/>
</config>
```

### 7. View Layer

**Use ViewModels instead of Blocks for business logic:**

```php
<?php
namespace Vendor\ModuleName\ViewModel;

use Magento\Framework\View\Element\Block\ArgumentInterface;
use Magento\Catalog\Api\ProductRepositoryInterface;

class ProductData implements ArgumentInterface
{
    private ProductRepositoryInterface $productRepository;

    public function __construct(ProductRepositoryInterface $productRepository)
    {
        $this->productRepository = $productRepository;
    }

    public function getProductName(int $productId): string
    {
        try {
            $product = $this->productRepository->getById($productId);
            return $product->getName();
        } catch (\Exception $e) {
            return '';
        }
    }
}
```

**Configure in layout XML:**
```xml
<block name="product.info" template="Vendor_ModuleName::product/view.phtml">
    <arguments>
        <argument name="view_model" xsi:type="object">Vendor\ModuleName\ViewModel\ProductData</argument>
    </arguments>
</block>
```

**Use in template:**
```php
<?php
/** @var \Vendor\ModuleName\ViewModel\ProductData $viewModel */
$viewModel = $block->getData('view_model');
?>
<div class="product-name">
    <?= $block->escapeHtml($viewModel->getProductName($productId)) ?>
</div>
```

### 8. Templates (.phtml)

**Never add inline styles:**
```php
/* Bad - Never do this */
<div style="color: red; font-size: 14px;">Content</div>

/* Good - Use CSS classes */
<div class="error-message">Content</div>
```

**Always escape output:**
```php
/* Text content */
<?= $block->escapeHtml($data) ?>

/* Attributes */
<div class="<?= $block->escapeHtmlAttr($className) ?>">

/* URLs */
<a href="<?= $block->escapeUrl($url) ?>">

/* JavaScript strings */
<script>
    var message = '<?= $block->escapeJs($message) ?>';
</script>
```

### 9. JavaScript and Comments

**Always use multi-line comments, never single-line:**

```javascript
/* Good - Multi-line comment for single line */
var isActive = true;

/* 
 * Good - Multi-line comment for multiple lines
 * This prevents issues with minification
 */
function processData() {
    return data;
}

// Bad - Avoid single-line comments as they break minification
```

**Same rule applies to .phtml files:**
```php
<?php
/* Good - Multi-line comment */
$productId = $block->getProductId();

// Bad - Avoid this
?>
```

### 10. Models vs Helpers

**Never create Helper classes. Use Models instead:**

```php
<?php
/* Good - Use Model */
namespace Vendor\ModuleName\Model;

class DataProcessor
{
    public function processData(array $data): array
    {
        /* Processing logic */
        return $data;
    }
}

/* Bad - Avoid Helper classes */
namespace Vendor\ModuleName\Helper;

use Magento\Framework\App\Helper\AbstractHelper;

class Data extends AbstractHelper
{
    /* Avoid this pattern */
}
```

### 11. Data Patches

**Use patches for data installation and updates:**

```php
<?php
namespace Vendor\ModuleName\Setup\Patch\Data;

use Magento\Framework\Setup\Patch\DataPatchInterface;
use Magento\Framework\Setup\ModuleDataSetupInterface;

class AddCustomAttribute implements DataPatchInterface
{
    private ModuleDataSetupInterface $moduleDataSetup;

    public function __construct(ModuleDataSetupInterface $moduleDataSetup)
    {
        $this->moduleDataSetup = $moduleDataSetup;
    }

    public function apply(): self
    {
        $this->moduleDataSetup->startSetup();
        /* Add your data changes here */
        $this->moduleDataSetup->endSetup();
        return $this;
    }

    public static function getDependencies(): array
    {
        return [];
    }

    public function getAliases(): array
    {
        return [];
    }
}
```

**Declare patches in composer.json:**
```json
{
    "extra": {
        "patches": {
            "magento/module-catalog": {
                "Fix product display": "patches/catalog-fix.patch"
            }
        }
    }
}
```

### 12. Code Quality Standards

**Remove all commented code before committing:**
```php
/* Bad */
public function execute()
{
    $data = $this->getData();
    // $oldData = $this->getOldData();
    // return $this->process($oldData);
    return $this->process($data);
}

/* Good */
public function execute()
{
    $data = $this->getData();
    return $this->process($data);
}
```

**Avoid deprecated functions:**
- Check Magento DevDocs for deprecation notices
- Use static analysis tools to detect deprecated code
- Always reference current Magento core implementations

**Follow Magento Coding Standards:**
- Install: `composer require --dev magento/magento-coding-standard`
- Check code: `vendor/bin/phpcs --standard=Magento2 app/code/Vendor/ModuleName`
- Auto-fix: `vendor/bin/phpcbf --standard=Magento2 app/code/Vendor/ModuleName`

### 13. Module Documentation

**Always maintain README.md:**

```markdown
# Vendor_ModuleName

## Description
Brief description of module functionality.

## Installation
```bash
composer require vendor/module-name
bin/magento setup:upgrade
bin/magento setup:di:compile
bin/magento cache:flush
```

## Configuration
Navigate to: Stores > Configuration > Section Name

## Features
- Feature 1
- Feature 2

## Technical Details
- Plugins: List of plugins implemented
- Observers: List of observers
- Commands: List of CLI commands

## Changelog
### Version 1.0.0
- Initial release
```

**Update README.md whenever you add or modify functionality.**

### 14. Third-Party Module Modifications

**Never edit third-party module code directly:**

1. Create plugin to modify behavior
2. Use events if plugin not suitable
3. Use preference only as last resort
4. Document dependencies in module.xml and composer.json

```xml
<!-- Declare dependency on third-party module -->
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
    <module name="Vendor_ModuleName">
        <sequence>
            <module name="ThirdParty_ModuleName"/>
        </sequence>
    </module>
</config>
```

### 15. Copyright Notice

**Do not add Magento copyright to custom modules:**

```php
<?php
/**
 * Copyright © Vendor Name. All rights reserved.
 */
declare(strict_types=1);

namespace Vendor\ModuleName\Model;
```

## Development Workflow

### Module Creation Checklist

1. Create module directory structure: `app/code/Vendor/ModuleName/`
2. Create `registration.php`
3. Create `etc/module.xml` with dependencies
4. Create `composer.json` with dependencies
5. Implement functionality using appropriate patterns
6. Create README.md
7. Test functionality
8. Run coding standards check
9. Enable module: `bin/magento module:enable Vendor_ModuleName`
10. Run setup: `bin/magento setup:upgrade`

### Code Review Focus Areas

- Dependencies declared in both module.xml and composer.json
- Service contracts used instead of direct model access
- Plugins used instead of preferences where possible
- ViewModels used for template logic
- No ObjectManager usage
- No Helper classes
- Multi-line comments in JS/PHTML
- No inline styles
- No commented code
- Output properly escaped
- README.md updated
- Follows Magento coding standards

## Reference Magento Core

Before implementing any feature, always check how Magento core handles similar functionality:

```bash
/* Search for similar implementations */
grep -r "similar_function" vendor/magento/module-*/
```

Study core module structure, naming conventions, and patterns to ensure consistency with Magento best practices.

## Additional Resources

- Magento DevDocs: https://developer.adobe.com/commerce/php/development/
- Coding Standards: https://github.com/magento/magento-coding-standard
- Best Practices: https://developer.adobe.com/commerce/php/best-practices/
