# 04 - CI/CD y Deployment

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- [ ] Configurar pipelines de CI/CD con GitHub Actions
- [ ] Automatizar tests y builds
- [ ] Distribuir apps con Firebase App Distribution
- [ ] Configurar deployment automatizado a stores
- [ ] Implementar versionado semántico

---

## 📚 Contenido

### 1. Introducción a CI/CD

#### ¿Qué es CI/CD?

| Término                      | Descripción                                    |
| ---------------------------- | ---------------------------------------------- |
| **CI (Continuous Integration)** | Integrar cambios frecuentemente con tests automáticos |
| **CD (Continuous Delivery)**    | Automatizar el proceso hasta staging           |
| **CD (Continuous Deployment)**  | Automatizar hasta producción                   |

#### Beneficios

- ✅ Detección temprana de errores
- ✅ Builds consistentes y reproducibles
- ✅ Menos errores humanos
- ✅ Feedback rápido
- ✅ Despliegues más frecuentes y seguros

---

### 2. GitHub Actions para Flutter

#### 2.1 Estructura Básica

```yaml
# .github/workflows/flutter-ci.yml

name: Flutter CI

# Cuándo ejecutar
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

# Jobs a ejecutar
jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Analyze code
        run: flutter analyze
      
      - name: Run tests
        run: flutter test
```

#### 2.2 CI Completo con Tests y Coverage

```yaml
# .github/workflows/flutter-ci.yml

name: Flutter CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  # Job 1: Análisis y tests
  test:
    name: Test & Analyze
    runs-on: ubuntu-latest
    
    steps:
      - name: 📥 Checkout repository
        uses: actions/checkout@v4

      - name: 🎯 Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
          cache: true

      - name: 📦 Get dependencies
        run: flutter pub get

      - name: 🔍 Verify formatting
        run: dart format --output=none --set-exit-if-changed .

      - name: 🔎 Analyze code
        run: flutter analyze --fatal-infos

      - name: 🧪 Run tests with coverage
        run: flutter test --coverage

      - name: 📊 Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          files: coverage/lcov.info
          fail_ci_if_error: true

  # Job 2: Build Android
  build-android:
    name: Build Android
    needs: test
    runs-on: ubuntu-latest
    
    steps:
      - name: 📥 Checkout repository
        uses: actions/checkout@v4

      - name: ☕ Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: 🎯 Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
          cache: true

      - name: 📦 Get dependencies
        run: flutter pub get

      - name: 🔨 Build APK
        run: flutter build apk --release

      - name: 📤 Upload APK artifact
        uses: actions/upload-artifact@v4
        with:
          name: android-release
          path: build/app/outputs/flutter-apk/app-release.apk

  # Job 3: Build iOS
  build-ios:
    name: Build iOS
    needs: test
    runs-on: macos-latest
    
    steps:
      - name: 📥 Checkout repository
        uses: actions/checkout@v4

      - name: 🎯 Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
          cache: true

      - name: 📦 Get dependencies
        run: flutter pub get

      - name: 🔨 Build iOS (no codesign)
        run: flutter build ios --release --no-codesign

      - name: 📤 Upload iOS artifact
        uses: actions/upload-artifact@v4
        with:
          name: ios-release
          path: build/ios/iphoneos/Runner.app
```

---

### 3. Build Firmado con Secretos

#### 3.1 Configurar Secretos en GitHub

1. Ir a **Settings → Secrets and variables → Actions**
2. Añadir secretos:
   - `KEYSTORE_BASE64`: Keystore en base64
   - `KEYSTORE_PASSWORD`: Contraseña del keystore
   - `KEY_ALIAS`: Alias de la clave
   - `KEY_PASSWORD`: Contraseña de la clave

```bash
# Convertir keystore a base64
base64 -i upload-keystore.jks > keystore-base64.txt
# Copiar contenido a GitHub Secrets
```

#### 3.2 Workflow con Firma Android

```yaml
# .github/workflows/android-release.yml

name: Android Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build-signed-apk:
    name: Build Signed APK
    runs-on: ubuntu-latest
    
    steps:
      - name: 📥 Checkout
        uses: actions/checkout@v4

      - name: ☕ Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: 🎯 Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'

      - name: 📦 Get dependencies
        run: flutter pub get

      - name: 🔐 Decode keystore
        env:
          KEYSTORE_BASE64: ${{ secrets.KEYSTORE_BASE64 }}
        run: |
          echo $KEYSTORE_BASE64 | base64 --decode > android/app/upload-keystore.jks

      - name: 📝 Create key.properties
        env:
          KEYSTORE_PASSWORD: ${{ secrets.KEYSTORE_PASSWORD }}
          KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
          KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
        run: |
          echo "storePassword=$KEYSTORE_PASSWORD" > android/key.properties
          echo "keyPassword=$KEY_PASSWORD" >> android/key.properties
          echo "keyAlias=$KEY_ALIAS" >> android/key.properties
          echo "storeFile=upload-keystore.jks" >> android/key.properties

      - name: 🔨 Build signed APK
        run: flutter build apk --release

      - name: 🔨 Build signed App Bundle
        run: flutter build appbundle --release

      - name: 📤 Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: signed-apk
          path: build/app/outputs/flutter-apk/app-release.apk

      - name: 📤 Upload App Bundle
        uses: actions/upload-artifact@v4
        with:
          name: signed-aab
          path: build/app/outputs/bundle/release/app-release.aab

      - name: 🏷️ Create GitHub Release
        uses: softprops/action-gh-release@v1
        with:
          files: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

---

### 4. Firebase App Distribution

#### 4.1 Configuración Inicial

```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Obtener token para CI (guardar como secreto FIREBASE_TOKEN)
firebase login:ci
```

#### 4.2 Workflow con Firebase Distribution

```yaml
# .github/workflows/firebase-distribution.yml

name: Firebase App Distribution

on:
  push:
    branches: [develop]

jobs:
  distribute:
    name: Distribute to Firebase
    runs-on: ubuntu-latest
    
    steps:
      - name: 📥 Checkout
        uses: actions/checkout@v4

      - name: ☕ Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'

      - name: 🎯 Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'

      - name: 📦 Get dependencies
        run: flutter pub get

      - name: 🔐 Decode keystore
        env:
          KEYSTORE_BASE64: ${{ secrets.KEYSTORE_BASE64 }}
        run: |
          echo $KEYSTORE_BASE64 | base64 --decode > android/app/upload-keystore.jks

      - name: 📝 Create key.properties
        env:
          KEYSTORE_PASSWORD: ${{ secrets.KEYSTORE_PASSWORD }}
          KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
          KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
        run: |
          echo "storePassword=$KEYSTORE_PASSWORD" > android/key.properties
          echo "keyPassword=$KEY_PASSWORD" >> android/key.properties
          echo "keyAlias=$KEY_ALIAS" >> android/key.properties
          echo "storeFile=upload-keystore.jks" >> android/key.properties

      - name: 🔨 Build APK
        run: flutter build apk --release

      - name: 📱 Upload to Firebase App Distribution
        uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: ${{ secrets.FIREBASE_APP_ID }}
          serviceCredentialsFileContent: ${{ secrets.FIREBASE_SERVICE_ACCOUNT }}
          groups: testers
          file: build/app/outputs/flutter-apk/app-release.apk
          releaseNotes: |
            Commit: ${{ github.sha }}
            Branch: ${{ github.ref_name }}
            Changes: ${{ github.event.head_commit.message }}
```

---

### 5. Versionado Semántico

#### 5.1 Formato

```
MAJOR.MINOR.PATCH+BUILD
  │     │     │     │
  │     │     │     └── Build number (incrementa siempre)
  │     │     └──────── Patch: Bug fixes
  │     └────────────── Minor: Nuevas features (backward compatible)
  └──────────────────── Major: Breaking changes
```

**Ejemplos:**
- `1.0.0+1` → Primera versión
- `1.0.1+2` → Bug fix
- `1.1.0+3` → Nueva feature
- `2.0.0+4` → Breaking change

#### 5.2 Automatizar Versionado

```yaml
# pubspec.yaml
version: 1.2.3+45
```

```bash
# Script para incrementar versión
# scripts/bump_version.sh

#!/bin/bash

# Obtener versión actual
CURRENT_VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //')
echo "Versión actual: $CURRENT_VERSION"

# Extraer componentes
MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
PATCH=$(echo $CURRENT_VERSION | cut -d. -f3 | cut -d+ -f1)
BUILD=$(echo $CURRENT_VERSION | cut -d+ -f2)

# Incrementar según argumento
case $1 in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
esac

# Siempre incrementar build
BUILD=$((BUILD + 1))

NEW_VERSION="$MAJOR.$MINOR.$PATCH+$BUILD"
echo "Nueva versión: $NEW_VERSION"

# Actualizar pubspec.yaml
sed -i "s/version: .*/version: $NEW_VERSION/" pubspec.yaml

# Crear tag de git
git add pubspec.yaml
git commit -m "Bump version to $NEW_VERSION"
git tag "v$MAJOR.$MINOR.$PATCH"
```

---

### 6. Deploy Automatizado a Stores

#### 6.1 Google Play (con Fastlane)

```ruby
# android/fastlane/Fastfile

default_platform(:android)

platform :android do
  desc "Deploy to Google Play Internal Testing"
  lane :internal do
    upload_to_play_store(
      track: 'internal',
      aab: '../build/app/outputs/bundle/release/app-release.aab',
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true
    )
  end

  desc "Deploy to Google Play Production"
  lane :production do
    upload_to_play_store(
      track: 'production',
      aab: '../build/app/outputs/bundle/release/app-release.aab'
    )
  end
end
```

#### 6.2 GitHub Action para Play Store

```yaml
# .github/workflows/play-store.yml

name: Deploy to Play Store

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: 📥 Checkout
        uses: actions/checkout@v4

      # ... pasos de setup y build ...

      - name: 🔨 Build App Bundle
        run: flutter build appbundle --release

      - name: 📤 Upload to Play Store
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.PLAY_STORE_SERVICE_ACCOUNT }}
          packageName: com.tuempresa.tuapp
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: internal
          status: completed
```

---

### 7. Workflow Completo de Release

```yaml
# .github/workflows/release.yml

name: Release Workflow

on:
  push:
    tags:
      - 'v*'

env:
  FLUTTER_VERSION: '3.16.0'

jobs:
  # 1. Tests
  test:
    name: Run Tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
      - run: flutter pub get
      - run: flutter test

  # 2. Build Android
  build-android:
    name: Build Android Release
    needs: test
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Get version from tag
        id: version
        run: echo "version=${GITHUB_REF#refs/tags/v}" >> $GITHUB_OUTPUT
      
      - uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
      
      - run: flutter pub get
      
      - name: Setup signing
        env:
          KEYSTORE_BASE64: ${{ secrets.KEYSTORE_BASE64 }}
          KEYSTORE_PASSWORD: ${{ secrets.KEYSTORE_PASSWORD }}
          KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
          KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
        run: |
          echo $KEYSTORE_BASE64 | base64 --decode > android/app/upload-keystore.jks
          echo "storePassword=$KEYSTORE_PASSWORD" > android/key.properties
          echo "keyPassword=$KEY_PASSWORD" >> android/key.properties
          echo "keyAlias=$KEY_ALIAS" >> android/key.properties
          echo "storeFile=upload-keystore.jks" >> android/key.properties
      
      - name: Build APK & AAB
        run: |
          flutter build apk --release
          flutter build appbundle --release
      
      - uses: actions/upload-artifact@v4
        with:
          name: android-release
          path: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab

  # 3. Build iOS
  build-ios:
    name: Build iOS Release
    needs: test
    runs-on: macos-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
      
      - run: flutter pub get
      - run: flutter build ios --release --no-codesign
      
      - uses: actions/upload-artifact@v4
        with:
          name: ios-release
          path: build/ios/iphoneos/

  # 4. Create GitHub Release
  create-release:
    name: Create GitHub Release
    needs: [build-android, build-ios]
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/download-artifact@v4
        with:
          name: android-release
          path: artifacts/android
      
      - name: Create Release
        uses: softprops/action-gh-release@v1
        with:
          files: |
            artifacts/android/app-release.apk
            artifacts/android/app-release.aab
          generate_release_notes: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  # 5. Deploy to Firebase (opcional)
  deploy-firebase:
    name: Deploy to Firebase
    needs: build-android
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: android-release
          path: artifacts
      
      - uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: ${{ secrets.FIREBASE_APP_ID }}
          serviceCredentialsFileContent: ${{ secrets.FIREBASE_SERVICE_ACCOUNT }}
          groups: beta-testers
          file: artifacts/app-release.apk
```

---

### 8. Resumen de Workflows

| Workflow              | Trigger                    | Acciones                           |
| --------------------- | -------------------------- | ---------------------------------- |
| **flutter-ci.yml**    | Push/PR a main, develop    | Lint, test, analyze                |
| **android-release.yml** | Tag v*                   | Build firmado, GitHub Release      |
| **firebase-dist.yml** | Push a develop             | Build, Firebase App Distribution   |
| **play-store.yml**    | Tag v* (release)           | Build, Upload Play Store           |

---

## 🎯 Resumen

| Concepto               | Herramienta              | Uso                              |
| ---------------------- | ------------------------ | -------------------------------- |
| **CI/CD**              | GitHub Actions           | Automatización de builds y tests |
| **Distribución beta**  | Firebase App Distribution| Testers internos                 |
| **Play Store**         | Google Play API          | Producción Android               |
| **App Store**          | App Store Connect API    | Producción iOS                   |
| **Versionado**         | SemVer + Git tags        | Control de versiones             |

---

## 🔗 Navegación

| ⬅️ Anterior                                     | 🏠 Índice                 |
| ----------------------------------------------- | ------------------------- |
| [Preparación Stores](./03-preparacion-stores.md) | [Semana 10](../README.md) |
