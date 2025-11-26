# Práctica 05: Analytics y Monitoring

## 📋 Información General

| Campo           | Detalle                                      |
| --------------- | -------------------------------------------- |
| **Duración**    | 40 minutos                                   |
| **Dificultad**  | ⭐⭐⭐ Avanzado                              |
| **Prerequisitos** | Proyecto Firebase configurado              |
| **Objetivos**   | Implementar analytics y crash reporting      |

---

## 🎯 Objetivos de Aprendizaje

Al completar esta práctica, serás capaz de:

- [ ] Configurar Firebase Analytics
- [ ] Implementar Firebase Crashlytics
- [ ] Crear un servicio de analytics reutilizable
- [ ] Rastrear eventos y pantallas

---

## 📝 Descripción del Ejercicio

Implementarás un sistema completo de analytics y monitoreo de crashes para tu aplicación usando Firebase.

---

## 🚀 Instrucciones

### Paso 1: Configurar Firebase

Si no tienes Firebase configurado:

```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# Configurar proyecto (ejecutar en raíz del proyecto)
flutterfire configure
```

### Paso 2: Añadir Dependencias

```yaml
# pubspec.yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_analytics: ^10.7.0
  firebase_crashlytics: ^3.4.7
```

```bash
flutter pub get
```

### Paso 3: Crear Servicio de Analytics

```dart
/**
 * Archivo: lib/core/services/analytics_service.dart
 * 
 * ¿Qué hace?
 * Centraliza toda la lógica de analytics
 * 
 * ¿Para qué?
 * Facilita el seguimiento de eventos y pantallas
 * Permite cambiar de proveedor fácilmente
 */

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  /// Observer para NavigatorObserver
  FirebaseAnalyticsObserver get observer => 
      FirebaseAnalyticsObserver(analytics: _analytics);

  /// Registrar vista de pantalla
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (kDebugMode) {
      debugPrint('📊 Analytics: Screen View - $screenName');
    }
    
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass ?? screenName,
    );
  }

  /// Registrar evento personalizado
  Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    if (kDebugMode) {
      debugPrint('📊 Analytics: Event - $name | $parameters');
    }
    
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  /// Registrar login
  Future<void> logLogin({String? method}) async {
    await _analytics.logLogin(loginMethod: method ?? 'unknown');
  }

  /// Registrar signup
  Future<void> logSignUp({String? method}) async {
    await _analytics.logSignUp(signUpMethod: method ?? 'unknown');
  }

  /// Registrar búsqueda
  Future<void> logSearch(String searchTerm) async {
    await _analytics.logSearch(searchTerm: searchTerm);
  }

  /// Registrar compra
  Future<void> logPurchase({
    required double value,
    required String currency,
    String? transactionId,
  }) async {
    await _analytics.logPurchase(
      value: value,
      currency: currency,
      transactionId: transactionId,
    );
  }

  /// Establecer ID de usuario
  Future<void> setUserId(String? userId) async {
    await _analytics.setUserId(id: userId);
  }

  /// Establecer propiedad de usuario
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  /// Resetear datos de analytics
  Future<void> resetAnalyticsData() async {
    await _analytics.resetAnalyticsData();
  }
}

// Instancia global
final analyticsService = AnalyticsService();
```

### Paso 4: Crear Servicio de Crashlytics

```dart
/**
 * Archivo: lib/core/services/crash_service.dart
 * 
 * ¿Qué hace?
 * Centraliza el manejo de crashes y errores
 * 
 * ¿Para qué?
 * Permite rastrear y analizar crashes en producción
 */

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashService {
  static final CrashService _instance = CrashService._internal();
  factory CrashService() => _instance;
  CrashService._internal();

  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  /// Inicializar Crashlytics
  Future<void> initialize() async {
    // Deshabilitar en debug mode
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
    
    if (kDebugMode) {
      debugPrint('🔥 Crashlytics: Disabled in debug mode');
    }
  }

  /// Registrar error no fatal
  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    if (kDebugMode) {
      debugPrint('❌ Crash Service: $exception');
      debugPrint('Stack: $stackTrace');
      return;
    }

    await _crashlytics.recordError(
      exception,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Registrar error de Flutter
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
      return;
    }

    await _crashlytics.recordFlutterFatalError(details);
  }

  /// Establecer ID de usuario para crashlytics
  Future<void> setUserId(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  /// Añadir clave personalizada
  Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  /// Log de mensaje
  Future<void> log(String message) async {
    if (kDebugMode) {
      debugPrint('📝 Crash Log: $message');
      return;
    }
    
    await _crashlytics.log(message);
  }

  /// Forzar crash (solo para testing)
  void forceCrash() {
    _crashlytics.crash();
  }
}

// Instancia global
final crashService = CrashService();
```

### Paso 5: Configurar main.dart

```dart
/**
 * Archivo: lib/main.dart
 * 
 * Configuración de Firebase con manejo de errores
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'core/services/analytics_service.dart';
import 'core/services/crash_service.dart';
import 'app.dart';

void main() async {
  // Asegurar inicialización de widgets
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Inicializar Crashlytics
  await crashService.initialize();
  
  // Capturar errores de Flutter
  FlutterError.onError = (details) {
    crashService.recordFlutterError(details);
  };
  
  // Capturar errores asíncronos
  runZonedGuarded(
    () {
      runApp(const MyApp());
    },
    (error, stackTrace) {
      crashService.recordError(error, stackTrace);
    },
  );
}
```

### Paso 6: Usar Analytics en la App

```dart
/**
 * Archivo: lib/app.dart
 */

import 'package:flutter/material.dart';
import 'core/services/analytics_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      // Agregar observer de analytics para navegación
      navigatorObservers: [
        analyticsService.observer,
      ],
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Registrar vista de pantalla
    analyticsService.logScreenView(screenName: 'HomeScreen');
  }

  void _onButtonPressed() {
    // Registrar evento
    analyticsService.logEvent(
      name: 'button_pressed',
      parameters: {
        'button_name': 'action_button',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void _onSearch(String query) {
    // Registrar búsqueda
    analyticsService.logSearch(query);
  }

  void _onLogin() {
    // Registrar login
    analyticsService.logLogin(method: 'email');
    // Establecer user ID
    analyticsService.setUserId('user_123');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _onButtonPressed,
              child: const Text('Track Event'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onLogin,
              child: const Text('Simulate Login'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Paso 7: Screen Tracking Automático

```dart
/**
 * Archivo: lib/core/widgets/tracked_screen.dart
 * 
 * Widget base para tracking automático de pantallas
 */

import 'package:flutter/material.dart';
import '../services/analytics_service.dart';

abstract class TrackedScreen extends StatefulWidget {
  const TrackedScreen({super.key});
  
  String get screenName;
}

abstract class TrackedScreenState<T extends TrackedScreen> extends State<T> {
  @override
  void initState() {
    super.initState();
    _trackScreen();
  }

  void _trackScreen() {
    analyticsService.logScreenView(
      screenName: widget.screenName,
      screenClass: widget.runtimeType.toString(),
    );
  }
}

// Ejemplo de uso:
class ProfileScreen extends TrackedScreen {
  const ProfileScreen({super.key});
  
  @override
  String get screenName => 'ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends TrackedScreenState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}
```

---

## ✅ Criterios de Aceptación

| Criterio                              | Cumplido |
| ------------------------------------- | -------- |
| Firebase Analytics configurado        | ☐        |
| Firebase Crashlytics configurado      | ☐        |
| AnalyticsService creado               | ☐        |
| CrashService creado                   | ☐        |
| main.dart con manejo de errores       | ☐        |
| Eventos registrándose correctamente   | ☐        |
| Screen views registrándose            | ☐        |
| Crashes capturados (en release)       | ☐        |

---

## 🎯 Entregables

1. Código de los servicios de analytics y crash
2. Screenshot de Firebase Console mostrando eventos
3. Screenshot de Crashlytics dashboard

---

## 🔍 Verificar en Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com)
2. Selecciona tu proyecto
3. **Analytics → Events**: Ver eventos registrados
4. **Analytics → Realtime**: Ver usuarios en tiempo real
5. **Crashlytics**: Ver crashes y errores

---

## 💡 Tips

- Los eventos tardan ~24h en aparecer en Analytics (usa Realtime para debug)
- En debug mode, los crashes se imprimen en consola
- Usa `setUserId` después del login para tracking por usuario
- Limita los parámetros de eventos a 25 por evento

---

## ⚠️ Consideraciones de Privacidad

```dart
// Permitir opt-out de analytics
Future<void> setAnalyticsEnabled(bool enabled) async {
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(enabled);
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);
}
```

---

## 🔗 Navegación

| ⬅️ Anterior                                  | 🏠 Índice                 | Siguiente ➡️                      |
| -------------------------------------------- | ------------------------- | --------------------------------- |
| [CI/CD GitHub](./practica-04-cicd-github.md) | [Semana 10](../README.md) | [Proyecto](../3-proyecto/README.md) |
