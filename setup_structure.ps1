$ErrorActionPreference = 'Stop'
$root = "."

# Monorepo root files
New-Item -Path "$root/README.md" -ItemType File -Force | Out-Null
New-Item -Path "$root/docker-compose.yml" -ItemType File -Force | Out-Null

# Docs & Github
New-Item -Path "$root/docs" -ItemType Directory -Force | Out-Null
New-Item -Path "$root/.github" -ItemType Directory -Force | Out-Null

# kalai_mobile
$mobile = "$root/kalai_mobile"
New-Item -Path $mobile -ItemType Directory -Force | Out-Null
New-Item -Path "$mobile/pubspec.yaml" -ItemType File -Force | Out-Null
New-Item -Path "$mobile/.env" -ItemType File -Force | Out-Null

# mobile/lib
$lib = "$mobile/lib"
New-Item -Path $lib -ItemType Directory -Force | Out-Null
New-Item -Path "$lib/main.dart" -ItemType File -Force | Out-Null
New-Item -Path "$lib/app.dart" -ItemType File -Force | Out-Null

$screens = "$lib/screens"
New-Item -Path $screens -ItemType Directory -Force | Out-Null
"splash_screen.dart", "welcome_screen.dart", "login_screen.dart", "signup_screen.dart", "artisan_dashboard.dart", "add_product_screen.dart", "my_products_screen.dart", "product_success_screen.dart", "scanner_screen.dart", "verify_screen.dart", "admin_dashboard.dart" | ForEach-Object { New-Item -Path "$screens/$_" -ItemType File -Force | Out-Null }

$components = "$lib/components"
New-Item -Path $components -ItemType Directory -Force | Out-Null
"kalai_button.dart", "product_card.dart", "qr_widget.dart", "timeline_widget.dart", "map_preview.dart", "blockchain_badge.dart" | ForEach-Object { New-Item -Path "$components/$_" -ItemType File -Force | Out-Null }

$services = "$lib/services"
New-Item -Path $services -ItemType Directory -Force | Out-Null
"auth_service.dart", "product_service.dart", "blockchain_service.dart", "qr_service.dart", "location_service.dart", "image_service.dart", "storage_service.dart", "admin_service.dart" | ForEach-Object { New-Item -Path "$services/$_" -ItemType File -Force | Out-Null }

$models = "$lib/models"
New-Item -Path $models -ItemType Directory -Force | Out-Null
"user_model.dart", "product_model.dart", "auth_response.dart" | ForEach-Object { New-Item -Path "$models/$_" -ItemType File -Force | Out-Null }

$utils = "$lib/utils"
New-Item -Path $utils -ItemType Directory -Force | Out-Null
"constants.dart", "theme.dart", "validators.dart", "formatters.dart", "secure_storage.dart" | ForEach-Object { New-Item -Path "$utils/$_" -ItemType File -Force | Out-Null }

$providers = "$lib/providers"
New-Item -Path $providers -ItemType Directory -Force | Out-Null
"auth_provider.dart", "product_provider.dart" | ForEach-Object { New-Item -Path "$providers/$_" -ItemType File -Force | Out-Null }

# mobile/assets
$assets = "$mobile/assets"
New-Item -Path "$assets/images" -ItemType Directory -Force | Out-Null
"kalai_logo.png", "splash_bg.png", "pattern_motif.svg" | ForEach-Object { New-Item -Path "$assets/images/$_" -ItemType File -Force | Out-Null }

New-Item -Path "$assets/fonts" -ItemType Directory -Force | Out-Null
"PlayfairDisplay.ttf", "DMSans.ttf" | ForEach-Object { New-Item -Path "$assets/fonts/$_" -ItemType File -Force | Out-Null }

# mobile/abi
New-Item -Path "$mobile/abi" -ItemType Directory -Force | Out-Null
New-Item -Path "$mobile/abi/KalaiRegistry.json" -ItemType File -Force | Out-Null

# mobile/android
New-Item -Path "$mobile/android/app" -ItemType Directory -Force | Out-Null
New-Item -Path "$mobile/android/app/build.gradle" -ItemType File -Force | Out-Null
New-Item -Path "$mobile/android/app/src/main" -ItemType Directory -Force | Out-Null
New-Item -Path "$mobile/android/app/src/main/AndroidManifest.xml" -ItemType File -Force | Out-Null

# kalai_backend
$backend = "$root/kalai_backend"
New-Item -Path $backend -ItemType Directory -Force | Out-Null
"server.js", "package.json", ".env", "Dockerfile", "README.md" | ForEach-Object { New-Item -Path "$backend/$_" -ItemType File -Force | Out-Null }

$src = "$backend/src"
New-Item -Path $src -ItemType Directory -Force | Out-Null

$routes = "$src/routes"
New-Item -Path $routes -ItemType Directory -Force | Out-Null
"auth.routes.js", "product.routes.js", "admin.routes.js" | ForEach-Object { New-Item -Path "$routes/$_" -ItemType File -Force | Out-Null }

$controllers = "$src/controllers"
New-Item -Path $controllers -ItemType Directory -Force | Out-Null
"auth.controller.js", "product.controller.js", "admin.controller.js", "blockchain.controller.js" | ForEach-Object { New-Item -Path "$controllers/$_" -ItemType File -Force | Out-Null }

$bmodels = "$src/models"
New-Item -Path $bmodels -ItemType Directory -Force | Out-Null
"User.model.js", "Product.model.js", "AuditLog.model.js" | ForEach-Object { New-Item -Path "$bmodels/$_" -ItemType File -Force | Out-Null }

$middleware = "$src/middleware"
New-Item -Path $middleware -ItemType Directory -Force | Out-Null
"auth.middleware.js", "role.middleware.js", "upload.middleware.js", "error.middleware.js" | ForEach-Object { New-Item -Path "$middleware/$_" -ItemType File -Force | Out-Null }

$bservices = "$src/services"
New-Item -Path $bservices -ItemType Directory -Force | Out-Null
"blockchain.service.js", "qr.service.js", "ipfs.service.js", "hash.service.js" | ForEach-Object { New-Item -Path "$bservices/$_" -ItemType File -Force | Out-Null }

$butils = "$src/utils"
New-Item -Path $butils -ItemType Directory -Force | Out-Null
"idGenerator.js", "logger.js", "response.js" | ForEach-Object { New-Item -Path "$butils/$_" -ItemType File -Force | Out-Null }

$config = "$src/config"
New-Item -Path $config -ItemType Directory -Force | Out-Null
"db.js", "web3.js", "multer.js" | ForEach-Object { New-Item -Path "$config/$_" -ItemType File -Force | Out-Null }

# kalai_blockchain
$blockchain = "$root/kalai_blockchain"
New-Item -Path $blockchain -ItemType Directory -Force | Out-Null
"hardhat.config.js", ".env", "package.json" | ForEach-Object { New-Item -Path "$blockchain/$_" -ItemType File -Force | Out-Null }

$contracts = "$blockchain/contracts"
New-Item -Path $contracts -ItemType Directory -Force | Out-Null
New-Item -Path "$contracts/KalaiRegistry.sol" -ItemType File -Force | Out-Null
New-Item -Path "$contracts/interfaces" -ItemType Directory -Force | Out-Null
New-Item -Path "$contracts/interfaces/IKalaiRegistry.sol" -ItemType File -Force | Out-Null

$scripts = "$blockchain/scripts"
New-Item -Path $scripts -ItemType Directory -Force | Out-Null
"deploy.js", "verify.js", "seed.js" | ForEach-Object { New-Item -Path "$scripts/$_" -ItemType File -Force | Out-Null }

$test = "$blockchain/test"
New-Item -Path $test -ItemType Directory -Force | Out-Null
"KalaiRegistry.test.js", "utils.test.js" | ForEach-Object { New-Item -Path "$test/$_" -ItemType File -Force | Out-Null }

$artifacts = "$blockchain/artifacts"
New-Item -Path $artifacts -ItemType Directory -Force | Out-Null
New-Item -Path "$artifacts/KalaiRegistry.json" -ItemType File -Force | Out-Null

Write-Host "Folder structure created successfully."
