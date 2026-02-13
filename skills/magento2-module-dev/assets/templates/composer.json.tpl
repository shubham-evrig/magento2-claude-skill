{
    "name": "{{vendor_kebabcase}}/module-{{module_kebabcase}}",
    "description": "{{DESCRIPTION}}",
    "type": "magento2-module",
    "version": "1.0.0",
    "license": [
        "MIT"
    ],
    "require": {
        "php": "^8.1",
        "magento/framework": "*"
        {{COMPOSER_REQUIRE}}
    },
    "autoload": {
        "files": [
            "registration.php"
        ],
        "psr-4": {
            "{{VENDOR}}\\{{MODULE}}\\": ""
        }
    }
}
