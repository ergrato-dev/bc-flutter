# Práctica 04: CI/CD con GitHub Actions

## 📋 Información General

| Campo           | Detalle                                      |
| --------------- | -------------------------------------------- |
| **Duración**    | 50 minutos                                   |
| **Dificultad**  | ⭐⭐⭐ Avanzado                              |
| **Prerequisitos** | Proyecto en GitHub, keystore configurado   |
| **Objetivos**   | Configurar pipeline CI/CD automatizado       |

---

## 🎯 Objetivos de Aprendizaje

Al completar esta práctica, serás capaz de:

- [ ] Crear workflows de GitHub Actions
- [ ] Configurar secrets para builds firmados
- [ ] Automatizar tests y análisis de código
- [ ] Generar releases automáticos

---

## 📝 Descripción del Ejercicio

Configurarás un pipeline completo de CI/CD que ejecute tests, genere builds y cree releases automáticamente cuando hagas push o crees tags.

---

## 🚀 Instrucciones

### Paso 1: Crear Estructura de Workflows

```bash
# En la raíz del proyecto
mkdir -p .github/workflows
```

### Paso 2: Workflow de CI (Tests y Análisis)

Crea `.github/workflows/ci.yml`:

```yaml
# .github/workflows/ci.yml
name: CI - Tests & Analysis

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  analyze-and-test:
    name: Analyze & Test
    runs-on: ubuntu-latest
    
    steps:
      # 1. Checkout del código
      - name: 📥 Checkout repository
        uses: actions/checkout@v4

      # 2. Setup Flutter
      - name: 🎯 Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'
          cache: true

      # 3. Verificar versión de Flutter
      - name: 📋 Check Flutter version
        run: flutter --version

      # 4. Obtener dependencias
      - name: 📦 Get dependencies
        run: flutter pub get

      # 5. Verificar formato del código
      - name: 🎨 Check formatting
        run: dart format --output=none --set-exit-if-changed .

      # 6. Analizar código
      - name: 🔍 Analyze code
        run: flutter analyze --fatal-infos

      # 7. Ejecutar tests
      - name: 🧪 Run tests
        run: flutter test --coverage

      # 8. Subir coverage (opcional)
      - name: 📊 Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          files: coverage/lcov.info
          fail_ci_if_error: false
```

### Paso 3: Configurar Secrets en GitHub

1. Ve a tu repositorio en GitHub
2. **Settings → Secrets and variables → Actions**
3. Añade los siguientes secrets:

```bash
# Convertir keystore a base64
base64 -i ~/keystores/my-app-upload.jks | pbcopy  # macOS
base64 -w 0 ~/keystores/my-app-upload.jks          # Linux
```

| Secret Name          | Valor                          |
| -------------------- | ------------------------------ |
| `KEYSTORE_BASE64`    | Keystore en base64             |
| `KEYSTORE_PASSWORD`  | Contraseña del keystore        |
| `KEY_ALIAS`          | Alias de la clave (ej: upload) |
| `KEY_PASSWORD`       | Contraseña de la clave         |

### Paso 4: Workflow de Build Android

Crea `.github/workflows/build-android.yml`:

```yaml
# .github/workflows/build-android.yml
name: Build Android

on:
  push:
    branches: [main]
  workflow_dispatch:  # Permite ejecutar manualmente

jobs:
  build:
    name: Build APK & AAB
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

      - name: 🔨 Build App Bundle
        run: flutter build appbundle --release

      - name: 📤 Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: app-release-apk
          path: build/app/outputs/flutter-apk/app-release.apk

      - name: 📤 Upload AAB
        uses: actions/upload-artifact@v4
        with:
          name: app-release-aab
          path: build/app/outputs/bundle/release/app-release.aab
```

### Paso 5: Workflow de Release

Crea `.github/workflows/release.yml`:

```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    tags:
      - 'v*'  # Se ejecuta cuando creas un tag como v1.0.0

jobs:
  # Job 1: Tests
  test:
    name: Run Tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          cache: true
      - run: flutter pub get
      - run: flutter test

  # Job 2: Build Android
  build-android:
    name: Build Android
    needs: test
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          cache: true

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

      - name: Build Release
        run: |
          flutter build apk --release
          flutter build appbundle --release

      - uses: actions/upload-artifact@v4
        with:
          name: android-release
          path: |
            build/app/outputs/flutter-apk/app-release.apk
            build/app/outputs/bundle/release/app-release.aab

  # Job 3: Create GitHub Release
  create-release:
    name: Create Release
    needs: build-android
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4

      - uses: actions/download-artifact@v4
        with:
          name: android-release
          path: artifacts

      - name: Get version from tag
        id: version
        run: echo "version=${GITHUB_REF#refs/tags/}" >> $GITHUB_OUTPUT

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v1
        with:
          name: Release ${{ steps.version.outputs.version }}
          body: |
            ## Changes in this release
            
            - See commit history for details
            
            ## Downloads
            
            - **APK**: Direct install for Android devices
            - **AAB**: For Google Play Store upload
          files: |
            artifacts/flutter-apk/app-release.apk
            artifacts/bundle/release/app-release.aab
          draft: false
          prerelease: false
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Paso 6: Crear un Release

```bash
# Actualizar versión en pubspec.yaml
# version: 1.0.0+1

# Commit los cambios
git add .
git commit -m "Prepare release 1.0.0"

# Crear tag
git tag v1.0.0

# Push del tag (activa el workflow)
git push origin v1.0.0
```

### Paso 7: Verificar Workflows

1. Ve a tu repositorio en GitHub
2. Click en **Actions**
3. Verifica que los workflows se ejecuten correctamente
4. Revisa los artifacts generados

---

## ✅ Criterios de Aceptación

| Criterio                              | Cumplido |
| ------------------------------------- | -------- |
| Workflow CI creado y funcionando      | ☐        |
| Secrets configurados en GitHub        | ☐        |
| Workflow Build Android funcionando    | ☐        |
| Workflow Release funcionando          | ☐        |
| Tag creado activa release             | ☐        |
| Artifacts descargables en Actions     | ☐        |
| GitHub Release creado automáticamente | ☐        |

---

## 🎯 Entregables

1. Link a tu repositorio con los workflows
2. Screenshot de Actions ejecutándose
3. Screenshot de un Release creado

---

## 💡 Tips

- Usa `workflow_dispatch` para poder ejecutar manualmente
- Los secrets nunca se muestran en logs
- Usa `cache: true` en flutter-action para acelerar builds
- Crea branches protegidos que requieran CI verde

---

## ⚠️ Errores Comunes

| Error                                | Solución                                    |
| ------------------------------------ | ------------------------------------------- |
| `Secret not found`                   | Verificar nombre exacto del secret          |
| `Permission denied`                  | Verificar permisos del GITHUB_TOKEN         |
| `Keystore invalid`                   | Verificar encoding base64                   |
| `Java version mismatch`              | Usar Java 17 para Flutter 3.x               |

---

## 🔗 Navegación

| ⬅️ Anterior                                | 🏠 Índice                 | Siguiente ➡️                                          |
| ------------------------------------------ | ------------------------- | ----------------------------------------------------- |
| [Build y Firma](./practica-03-build-firma.md) | [Semana 10](../README.md) | [Analytics Monitoring](./practica-05-analytics-monitoring.md) |
