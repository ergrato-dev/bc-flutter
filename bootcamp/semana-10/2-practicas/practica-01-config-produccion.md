# Práctica 01: Configuración de Producción

## 📋 Información General

| Campo           | Detalle                                      |
| --------------- | -------------------------------------------- |
| **Duración**    | 40 minutos                                   |
| **Dificultad**  | ⭐⭐ Intermedio                              |
| **Prerequisitos** | Proyecto Flutter funcional                 |
| **Objetivos**   | Configurar entornos dev/staging/prod         |

---

## 🎯 Objetivos de Aprendizaje

Al completar esta práctica, serás capaz de:

- [ ] Crear archivo de variables de entorno
- [ ] Implementar múltiples entry points
- [ ] Configurar FlavorConfig para diferentes ambientes
- [ ] Ejecutar la app en diferentes modos

---

## 📝 Descripción del Ejercicio

Configurarás tu aplicación Flutter para soportar tres entornos diferentes (development, staging, production) con sus propias configuraciones.

---

## 🚀 Instrucciones

### Paso 1: Crear Estructura de Configuración

Crea la siguiente estructura en tu proyecto:

```
lib/
├── main.dart              # Entry point por defecto
├── main_dev.dart          # Entry point desarrollo
├── main_staging.dart      # Entry point staging
├── main_prod.dart         # Entry point producción
├── app.dart               # Widget App compartido
└── core/
    └── config/
        ├── env.dart       # Variables de entorno
        ├── flavors.dart   # Configuración de flavors
        └── app_config.dart # Configuración centralizada
```

### Paso 2: Crear env.dart

```dart
/**
 * Archivo: lib/core/config/env.dart
 * 
 * ¿Qué hace?
 * Define variables de entorno inyectadas en compilación
 * 
 * ¿Para qué?
 * Permite cambiar configuraciones sin modificar código
 */

class Env {
  Env._();

  // URL de la API
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  // Clave de API
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );

  // ¿Es producción?
  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );

  // Nombre del entorno
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );
}
```

### Paso 3: Crear flavors.dart

```dart
/**
 * Archivo: lib/core/config/flavors.dart
 * 
 * ¿Qué hace?
 * Define los "sabores" de la aplicación
 * 
 * ¿Para qué?
 * Permite tener múltiples versiones con diferentes configuraciones
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
  final bool showDebugBanner;

  static late FlavorConfig _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required String apiBaseUrl,
    bool enableAnalytics = false,
    bool enableCrashReporting = false,
    bool showDebugBanner = true,
  }) {
    _instance = FlavorConfig._internal(
      flavor: flavor,
      name: name,
      apiBaseUrl: apiBaseUrl,
      enableAnalytics: enableAnalytics,
      enableCrashReporting: enableCrashReporting,
      showDebugBanner: showDebugBanner,
    );
    return _instance;
  }

  FlavorConfig._internal({
    required this.flavor,
    required this.name,
    required this.apiBaseUrl,
    required this.enableAnalytics,
    required this.enableCrashReporting,
    required this.showDebugBanner,
  });

  static FlavorConfig get instance => _instance;

  static bool get isDevelopment => _instance.flavor == Flavor.development;
  static bool get isStaging => _instance.flavor == Flavor.staging;
  static bool get isProduction => _instance.flavor == Flavor.production;
}
```

### Paso 4: Crear Entry Points

**main_dev.dart:**

```dart
/**
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
    showDebugBanner: true,
  );

  runApp(const MyApp());
}
```

**main_staging.dart:**

```dart
/**
 * Entry point para staging
 */

import 'package:flutter/material.dart';
import 'core/config/flavors.dart';
import 'app.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.staging,
    name: 'MyApp STAGING',
    apiBaseUrl: 'https://staging-api.myapp.com',
    enableAnalytics: true,
    enableCrashReporting: true,
    showDebugBanner: true,
  );

  runApp(const MyApp());
}
```

**main_prod.dart:**

```dart
/**
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
    showDebugBanner: false,
  );

  runApp(const MyApp());
}
```

### Paso 5: Crear app.dart

```dart
/**
 * Archivo: lib/app.dart
 * 
 * ¿Qué hace?
 * Define el widget principal de la aplicación
 * Usa la configuración del flavor actual
 */

import 'package:flutter/material.dart';
import 'core/config/flavors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlavorConfig.instance.name,
      debugShowCheckedModeBanner: FlavorConfig.instance.showDebugBanner,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _getThemeColor()),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }

  Color _getThemeColor() {
    switch (FlavorConfig.instance.flavor) {
      case Flavor.development:
        return Colors.green;
      case Flavor.staging:
        return Colors.orange;
      case Flavor.production:
        return Colors.blue;
    }
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(config.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Entorno: ${config.flavor.name}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text('API: ${config.apiBaseUrl}'),
            const SizedBox(height: 8),
            Text('Analytics: ${config.enableAnalytics ? "Sí" : "No"}'),
            Text('Crashlytics: ${config.enableCrashReporting ? "Sí" : "No"}'),
          ],
        ),
      ),
    );
  }
}
```

### Paso 6: Probar los Diferentes Entornos

```bash
# Ejecutar en modo desarrollo
flutter run -t lib/main_dev.dart

# Ejecutar en modo staging
flutter run -t lib/main_staging.dart

# Ejecutar en modo producción
flutter run -t lib/main_prod.dart --release
```

---

## ✅ Criterios de Aceptación

| Criterio                           | Cumplido |
| ---------------------------------- | -------- |
| env.dart creado con variables      | ☐        |
| flavors.dart con 3 flavors         | ☐        |
| 3 entry points funcionando         | ☐        |
| app.dart usa FlavorConfig          | ☐        |
| Colores diferentes por entorno     | ☐        |
| Debug banner solo en dev/staging   | ☐        |

---

## 🎯 Entregables

1. Archivos de configuración creados
2. Screenshot de la app en cada entorno
3. Comandos de ejecución probados

---

## 💡 Tips

- Usa `kDebugMode` para código solo en debug
- Nunca hardcodees URLs de producción
- Los secretos van por `--dart-define`, no en código

---

## 🔗 Navegación

| ⬅️ Anterior                       | 🏠 Índice                        | Siguiente ➡️                                        |
| --------------------------------- | -------------------------------- | --------------------------------------------------- |
| [Prácticas](./README.md)          | [Semana 10](../README.md)        | [Optimización Assets](./practica-02-optimizacion-assets.md) |
