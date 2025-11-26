# Práctica 03: Build y Firma

## 📋 Información General

| Campo           | Detalle                                      |
| --------------- | -------------------------------------------- |
| **Duración**    | 45 minutos                                   |
| **Dificultad**  | ⭐⭐⭐ Avanzado                              |
| **Prerequisitos** | Proyecto Flutter listo para release        |
| **Objetivos**   | Generar builds firmados para distribución    |

---

## 🎯 Objetivos de Aprendizaje

Al completar esta práctica, serás capaz de:

- [ ] Generar un keystore para Android
- [ ] Configurar firma de release
- [ ] Crear APK y App Bundle firmados
- [ ] Entender el proceso de firma de iOS

---

## 📝 Descripción del Ejercicio

Generarás builds de release firmados para Android, listos para subir a Google Play Store o distribuir directamente.

---

## 🚀 Instrucciones

### Parte A: Android

#### Paso 1: Generar Keystore

```bash
# Crear directorio para el keystore (fuera del proyecto)
mkdir -p ~/keystores

# Generar keystore
keytool -genkey -v \
  -keystore ~/keystores/my-app-upload.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias upload
```

Te pedirá:
- **Contraseña del keystore**: Usa una contraseña segura
- **Nombre y apellido**: Tu nombre o nombre de la empresa
- **Unidad organizacional**: Departamento (ej: "Development")
- **Organización**: Nombre de la empresa
- **Ciudad**: Tu ciudad
- **Estado/Provincia**: Tu estado
- **Código de país**: ES, MX, AR, etc.

> ⚠️ **IMPORTANTE**: Guarda el keystore y las contraseñas de forma segura. Si los pierdes, no podrás actualizar tu app.

#### Paso 2: Crear key.properties

Crea el archivo `android/key.properties`:

```properties
# android/key.properties
# ⚠️ NO SUBIR A GIT

storePassword=tu_contraseña_keystore
keyPassword=tu_contraseña_key
keyAlias=upload
storeFile=/Users/tu_usuario/keystores/my-app-upload.jks
```

Añade a `.gitignore`:

```gitignore
# Signing
*.jks
*.keystore
key.properties
```

#### Paso 3: Configurar build.gradle

Edita `android/app/build.gradle`:

```groovy
// Cargar propiedades de firma
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    namespace "com.tuempresa.tuapp"
    compileSdkVersion 34

    defaultConfig {
        applicationId "com.tuempresa.tuapp"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            
            // Habilitar optimizaciones
            minifyEnabled true
            shrinkResources true
            
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

#### Paso 4: Configurar ProGuard

Crea/edita `android/app/proguard-rules.pro`:

```proguard
# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Mantener nombres de clases para reflection
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

# Si usas Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Si usas JSON serialization
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
```

#### Paso 5: Build Release

```bash
# Limpiar builds anteriores
flutter clean

# Obtener dependencias
flutter pub get

# Build APK de release
flutter build apk --release

# Build App Bundle (recomendado para Play Store)
flutter build appbundle --release

# Build con obfuscación (producción)
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/debug-info

# Build APKs separados por arquitectura
flutter build apk --release --split-per-abi
```

#### Paso 6: Verificar Firma

```bash
# Verificar que el APK está firmado
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk

# Ver información del certificado
keytool -list -v -keystore ~/keystores/my-app-upload.jks
```

---

### Parte B: iOS (Referencia)

> ⚠️ Requiere macOS y cuenta de Apple Developer

#### Paso 1: Configurar en Xcode

1. Abrir `ios/Runner.xcworkspace`
2. Seleccionar **Runner** en el navegador
3. En **General**:
   - Display Name: Nombre de tu app
   - Bundle Identifier: `com.tuempresa.tuapp`
   - Version: `1.0.0`
   - Build: `1`
4. En **Signing & Capabilities**:
   - Team: Seleccionar tu cuenta de desarrollador
   - Signing Certificate: Distribution
   - Provisioning Profile: App Store

#### Paso 2: Build iOS

```bash
# Build para release
flutter build ios --release

# Build IPA (Archive)
flutter build ipa --release

# Con obfuscación
flutter build ipa --release \
  --obfuscate \
  --split-debug-info=build/debug-info
```

---

## 📁 Ubicación de Builds

| Tipo                | Ubicación                                              |
| ------------------- | ------------------------------------------------------ |
| APK Release         | `build/app/outputs/flutter-apk/app-release.apk`        |
| APK Split (arm64)   | `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` |
| App Bundle          | `build/app/outputs/bundle/release/app-release.aab`     |
| iOS IPA             | `build/ios/ipa/`                                       |

---

## ✅ Criterios de Aceptación

| Criterio                              | Cumplido |
| ------------------------------------- | -------- |
| Keystore generado y guardado          | ☐        |
| key.properties creado                 | ☐        |
| key.properties en .gitignore          | ☐        |
| build.gradle configurado              | ☐        |
| ProGuard configurado                  | ☐        |
| APK release generado sin errores      | ☐        |
| App Bundle generado sin errores       | ☐        |
| Firma verificada con jarsigner        | ☐        |

---

## 🎯 Entregables

1. Keystore guardado de forma segura
2. APK y/o AAB generados
3. Output del comando de verificación de firma
4. Screenshot del tamaño del build (`--analyze-size`)

---

## 💡 Tips

- **Guarda el keystore** en un lugar seguro (ej: 1Password, Google Drive encriptado)
- Usa **App Bundle** (.aab) para Play Store - reduce tamaño hasta 50%
- **Split per ABI** es útil para distribución directa (no Play Store)
- La **obfuscación** dificulta la ingeniería inversa

---

## ⚠️ Errores Comunes

| Error                                | Solución                                    |
| ------------------------------------ | ------------------------------------------- |
| `Keystore was tampered with`         | Contraseña incorrecta                       |
| `No key with alias 'upload'`         | Verificar keyAlias en key.properties        |
| `storeFile not found`                | Verificar ruta absoluta del keystore        |
| `minifyEnabled breaks app`           | Agregar reglas a ProGuard                   |
| `Version code already used`          | Incrementar versionCode                     |

---

## 🔗 Navegación

| ⬅️ Anterior                                           | 🏠 Índice                 | Siguiente ➡️                                  |
| ----------------------------------------------------- | ------------------------- | --------------------------------------------- |
| [Optimización Assets](./practica-02-optimizacion-assets.md) | [Semana 10](../README.md) | [CI/CD GitHub](./practica-04-cicd-github.md)  |
