# 01 - Arquitectura de Producción

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- [ ] Configurar la aplicación para diferentes entornos (dev, staging, prod)
- [ ] Implementar variables de entorno seguras
- [ ] Estructurar el proyecto para producción
- [ ] Manejar configuraciones sensibles correctamente

---

## 📚 Contenido

### 1. Entornos de Desarrollo

En aplicaciones profesionales, es fundamental separar los entornos:

| Entorno      | Propósito                           | API URL                        |
| ------------ | ----------------------------------- | ------------------------------ |
| **Development** | Desarrollo local                 | `http://localhost:3000`        |
| **Staging**     | Pruebas pre-producción           | `https://staging.api.com`      |
| **Production**  | Usuarios finales                 | `https://api.production.com`   |

---

### 2. Variables de Entorno con Dart Define

#### Configuración Básica

```dart
/**
 * Archivo: lib/core/config/env.dart
 * 
 * ¿Qué hace?
 * Define constantes de entorno que se inyectan en tiempo de compilación
 * 
 * ¿Para qué?
 * Permite cambiar configuraciones sin modificar código
 * Mantiene datos sensibles fuera del repositorio
 * 
 * ¿Cómo funciona?
 * 1. Los valores se pasan con --dart-define al compilar
 * 2. String.fromEnvironment lee el valor en tiempo de compilación
 * 3. Si no existe, usa el defaultValue
 */

class Env {
  // Prevent instantiation
  // Prevenir instanciación
  Env._();

  /// URL base de la API
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  /// API Key para autenticación
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );

  /// Indica si estamos en producción
  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );

  /// Nombre del entorno actual
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// Habilitar analytics
  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
    defaultValue: false,
  );

  /// Habilitar crash reporting
  static const bool enableCrashReporting = bool.fromEnvironment(
    'ENABLE_CRASH_REPORTING',
    defaultValue: false,
  );
}
```

#### Ejecución con Variables

```bash
# Desarrollo
flutter run \
  --dart-define=API_URL=http://localhost:3000/api \
  --dart-define=ENVIRONMENT=development

# Staging
flutter run \
  --dart-define=API_URL=https://staging.api.com \
  --dart-define=API_KEY=staging_key_123 \
  --dart-define=ENVIRONMENT=staging

# Producción
flutter build apk \
  --dart-define=API_URL=https://api.production.com \
  --dart-define=API_KEY=prod_key_secret \
  --dart-define=ENVIRONMENT=production \
  --dart-define=PRODUCTION=true \
  --dart-define=ENABLE_ANALYTICS=true \
  --dart-define=ENABLE_CRASH_REPORTING=true
```

---

### 3. Flutter Flavors (Avanzado)

Los flavors permiten tener múltiples versiones de la app desde el mismo código:

#### Estructura de Proyecto con Flavors

```
lib/
├── main_dev.dart        # Entry point desarrollo
├── main_staging.dart    # Entry point staging
├── main_prod.dart       # Entry point producción
├── app.dart             # App widget compartido
└── core/
    └── config/
        ├── app_config.dart
        └── flavors.dart
```

#### Definición de Flavors

```dart
/**
 * Archivo: lib/core/config/flavors.dart
 * 
 * ¿Qué hace?
 * Define los diferentes "sabores" o variantes de la aplicación
 * 
 * ¿Para qué?
 * Permite tener apps con diferentes configuraciones, nombres e iconos
 * desde el mismo código base
 */

enum Flavor {
  development,
  staging,
  production,
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String apiBaseUrl;
  final bool enableAnalytics;
  final bool enableCrashReporting;

  static late FlavorConfig _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required String apiBaseUrl,
    bool enableAnalytics = false,
    bool enableCrashReporting = false,
  }) {
    _instance = FlavorConfig._internal(
      flavor: flavor,
      name: name,
      apiBaseUrl: apiBaseUrl,
      enableAnalytics: enableAnalytics,
      enableCrashReporting: enableCrashReporting,
    );
    return _instance;
  }

  FlavorConfig._internal({
    required this.flavor,
    required this.name,
    required this.apiBaseUrl,
    required this.enableAnalytics,
    required this.enableCrashReporting,
  });

  static FlavorConfig get instance => _instance;

  static bool get isDevelopment => _instance.flavor == Flavor.development;
  static bool get isStaging => _instance.flavor == Flavor.staging;
  static bool get isProduction => _instance.flavor == Flavor.production;
}
```

#### Entry Points por Flavor

```dart
/**
 * Archivo: lib/main_dev.dart
 * Entry point para desarrollo
 */

import 'package:flutter/material.dart';
import 'core/config/flavors.dart';
import 'app.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.development,
    name: 'MyApp DEV',
    apiBaseUrl: 'http://localhost:3000/api',
    enableAnalytics: false,
    enableCrashReporting: false,
  );

  runApp(const MyApp());
}
```

```dart
/**
 * Archivo: lib/main_staging.dart
 * Entry point para staging
 */

import 'package:flutter/material.dart';
import 'core/config/flavors.dart';
import 'app.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.staging,
    name: 'MyApp STAGING',
    apiBaseUrl: 'https://staging.api.myapp.com',
    enableAnalytics: true,
    enableCrashReporting: true,
  );

  runApp(const MyApp());
}
```

```dart
/**
 * Archivo: lib/main_prod.dart
 * Entry point para producción
 */

import 'package:flutter/material.dart';
import 'core/config/flavors.dart';
import 'app.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.production,
    name: 'MyApp',
    apiBaseUrl: 'https://api.myapp.com',
    enableAnalytics: true,
    enableCrashReporting: true,
  );

  runApp(const MyApp());
}
```

#### Ejecutar Flavors

```bash
# Desarrollo
flutter run -t lib/main_dev.dart

# Staging
flutter run -t lib/main_staging.dart

# Producción
flutter run -t lib/main_prod.dart --release
```

---

### 4. Configuración Android para Flavors

#### build.gradle

```groovy
// android/app/build.gradle

android {
    // ...existing config...

    flavorDimensions "environment"

    productFlavors {
        development {
            dimension "environment"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
            resValue "string", "app_name", "MyApp DEV"
        }
        staging {
            dimension "environment"
            applicationIdSuffix ".staging"
            versionNameSuffix "-staging"
            resValue "string", "app_name", "MyApp STAGING"
        }
        production {
            dimension "environment"
            resValue "string", "app_name", "MyApp"
        }
    }
}
```

#### Ejecutar con Flavor Android

```bash
# Build específico por flavor
flutter build apk --flavor development -t lib/main_dev.dart
flutter build apk --flavor staging -t lib/main_staging.dart
flutter build apk --flavor production -t lib/main_prod.dart
```

---

### 5. Configuración iOS para Flavors

#### Schemes en Xcode

1. Abrir `ios/Runner.xcworkspace` en Xcode
2. Product → Scheme → Manage Schemes
3. Duplicar el scheme "Runner" para cada flavor
4. Renombrar: Runner-dev, Runner-staging, Runner-prod
5. Configurar cada scheme con su Build Configuration

#### xcconfig Files

```
// ios/Flutter/Development.xcconfig
#include "Generated.xcconfig"
FLUTTER_TARGET=lib/main_dev.dart
PRODUCT_BUNDLE_IDENTIFIER=com.mycompany.myapp.dev
PRODUCT_NAME=MyApp DEV
```

```
// ios/Flutter/Staging.xcconfig
#include "Generated.xcconfig"
FLUTTER_TARGET=lib/main_staging.dart
PRODUCT_BUNDLE_IDENTIFIER=com.mycompany.myapp.staging
PRODUCT_NAME=MyApp STAGING
```

```
// ios/Flutter/Production.xcconfig
#include "Generated.xcconfig"
FLUTTER_TARGET=lib/main_prod.dart
PRODUCT_BUNDLE_IDENTIFIER=com.mycompany.myapp
PRODUCT_NAME=MyApp
```

---

### 6. App Configuration Service

```dart
/**
 * Archivo: lib/core/config/app_config.dart
 * 
 * ¿Qué hace?
 * Centraliza toda la configuración de la aplicación
 * 
 * ¿Para qué?
 * Provee un punto único de acceso a configuraciones
 * Facilita testing y mocking de configuraciones
 */

import 'package:flutter/foundation.dart';
import 'flavors.dart';

class AppConfig {
  // Singleton
  // Instancia única
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  /// Nombre de la aplicación
  String get appName => FlavorConfig.instance.name;

  /// URL base de la API
  String get apiBaseUrl => FlavorConfig.instance.apiBaseUrl;

  /// ¿Es modo debug?
  bool get isDebug => kDebugMode;

  /// ¿Es modo release?
  bool get isRelease => kReleaseMode;

  /// ¿Es modo profile?
  bool get isProfile => kProfileMode;

  /// ¿Habilitar analytics?
  bool get enableAnalytics => FlavorConfig.instance.enableAnalytics;

  /// ¿Habilitar crash reporting?
  bool get enableCrashReporting => FlavorConfig.instance.enableCrashReporting;

  /// Timeout para requests HTTP (segundos)
  int get httpTimeout => FlavorConfig.isProduction ? 30 : 60;

  /// Número máximo de reintentos
  int get maxRetries => FlavorConfig.isProduction ? 3 : 1;

  /// ¿Mostrar logs detallados?
  bool get verboseLogs => !FlavorConfig.isProduction;

  /// Información de configuración (para debug)
  Map<String, dynamic> toMap() {
    return {
      'appName': appName,
      'apiBaseUrl': apiBaseUrl,
      'flavor': FlavorConfig.instance.flavor.name,
      'isDebug': isDebug,
      'isRelease': isRelease,
      'enableAnalytics': enableAnalytics,
      'enableCrashReporting': enableCrashReporting,
    };
  }

  @override
  String toString() => 'AppConfig(${toMap()})';
}
```

---

### 7. Manejo de Secretos

> ⚠️ **IMPORTANTE**: Nunca guardes secretos en el código fuente

#### ❌ Incorrecto

```dart
// NUNCA hagas esto
// NEVER do this
class ApiKeys {
  static const String googleMapsKey = 'AIzaSyB...actual_key';
  static const String stripeKey = 'sk_live_...actual_key';
}
```

#### ✅ Correcto - Usar Variables de Entorno

```dart
/**
 * Los secretos se pasan en tiempo de compilación
 * y NUNCA se guardan en el repositorio
 */
class ApiKeys {
  static const String googleMapsKey = String.fromEnvironment(
    'GOOGLE_MAPS_KEY',
    defaultValue: '',
  );
  
  static const String stripeKey = String.fromEnvironment(
    'STRIPE_KEY',
    defaultValue: '',
  );
}
```

#### .gitignore para Secretos

```gitignore
# Archivos de secretos
*.env
.env.*
secrets.dart
key.properties
*.keystore
*.jks

# Archivos de configuración local
local_config.dart
```

#### Archivo .env (NO comitear)

```bash
# .env.development (local, no en git)
API_URL=http://localhost:3000/api
API_KEY=dev_key_12345
GOOGLE_MAPS_KEY=AIzaSyB...dev_key

# .env.production (solo en CI/CD)
API_URL=https://api.myapp.com
API_KEY=prod_key_secret
GOOGLE_MAPS_KEY=AIzaSyB...prod_key
```

---

### 8. Logger Configurable por Entorno

```dart
/**
 * Archivo: lib/core/utils/app_logger.dart
 * 
 * ¿Qué hace?
 * Proporciona logging configurable según el entorno
 * 
 * ¿Para qué?
 * En desarrollo: logs detallados para debugging
 * En producción: solo errores críticos (sin exponer info sensible)
 */

import 'package:flutter/foundation.dart';
import '../config/app_config.dart';

enum LogLevel { debug, info, warning, error }

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  final AppConfig _config = AppConfig();

  void debug(String message, [dynamic data]) {
    if (_config.verboseLogs) {
      _log(LogLevel.debug, message, data);
    }
  }

  void info(String message, [dynamic data]) {
    if (_config.verboseLogs) {
      _log(LogLevel.info, message, data);
    }
  }

  void warning(String message, [dynamic data]) {
    _log(LogLevel.warning, message, data);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error);
    
    // En producción, enviar a crash reporting
    if (_config.enableCrashReporting && error != null) {
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }

  void _log(LogLevel level, String message, [dynamic data]) {
    if (kReleaseMode && level == LogLevel.debug) return;

    final timestamp = DateTime.now().toIso8601String();
    final prefix = _getPrefix(level);
    
    debugPrint('$prefix [$timestamp] $message');
    if (data != null) {
      debugPrint('$prefix Data: $data');
    }
  }

  String _getPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛 DEBUG';
      case LogLevel.info:
        return 'ℹ️ INFO';
      case LogLevel.warning:
        return '⚠️ WARNING';
      case LogLevel.error:
        return '❌ ERROR';
    }
  }
}

// Uso global
// Global usage
final logger = AppLogger();
```

---

## 🎯 Resumen

| Concepto                | Descripción                                           |
| ----------------------- | ----------------------------------------------------- |
| **dart-define**         | Variables de entorno en tiempo de compilación         |
| **Flavors**             | Múltiples variantes de la app desde el mismo código   |
| **Entry Points**        | Diferentes `main.dart` por entorno                    |
| **AppConfig**           | Servicio centralizado de configuración                |
| **Secretos**            | Variables sensibles via CI/CD, nunca en código        |

---

## 📝 Ejercicio Práctico

Configura tu proyecto con:

1. Archivo `env.dart` con variables de entorno
2. Tres entry points: `main_dev.dart`, `main_staging.dart`, `main_prod.dart`
3. `FlavorConfig` con las tres variantes
4. `AppConfig` como servicio singleton
5. Script de ejecución por entorno

---

## 🔗 Recursos Adicionales

- [Flutter Flavors](https://docs.flutter.dev/deployment/flavors)
- [Environment Variables](https://dart.dev/guides/environment-declarations)
- [Multi-environment Setup](https://medium.com/@salvatorevetro/flutter-multi-environment-setup-36f33c0e7f9a)

---

## 🔗 Navegación

| ⬅️ Anterior                      | 🏠 Índice                         | Siguiente ➡️                                              |
| -------------------------------- | --------------------------------- | --------------------------------------------------------- |
| [Teoría](./README.md)            | [Semana 10](../README.md)         | [Optimización y Performance](./02-optimizacion-performance.md) |
