# 💻 Práctica 01: Preferencias de Usuario

## 🎯 Objetivo

Crear una pantalla de configuración que persista las preferencias del usuario usando **SharedPreferences**.

---

## 📋 Requisitos

### Funcionales

1. **Tema de la App**
   - Switch para modo oscuro/claro
   - El tema debe persistir al cerrar la app

2. **Tamaño de Fuente**
   - Slider para ajustar (12-24px)
   - Visualización en tiempo real

3. **Idioma**
   - Selector: Español, English
   - Persistir selección

4. **Notificaciones**
   - Toggle para activar/desactivar
   - Sub-opciones: email, push, SMS

5. **Contador de Sesiones**
   - Mostrar cuántas veces se ha abierto la app
   - Incrementar automáticamente al iniciar

### Técnicos

- Usar patrón Provider para estado global
- Servicio de preferencias encapsulado
- Manejo de valores por defecto

---

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart
├── app.dart
├── services/
│   └── preferences_service.dart
├── providers/
│   └── settings_provider.dart
└── screens/
    └── settings_screen.dart
```

---

## 📝 Código Base

### 1. Servicio de Preferencias

```dart
// lib/services/preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';

/**
 * PreferencesService: Encapsula el acceso a SharedPreferences.
 * 
 * ¿Qué hace?
 * Proporciona métodos tipados para leer/escribir preferencias.
 * 
 * ¿Para qué?
 * Centralizar la lógica de persistencia y facilitar el mantenimiento.
 */
class PreferencesService {
  static PreferencesService? _instance;
  static late SharedPreferences _prefs;
  
  PreferencesService._();
  
  static Future<PreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = PreferencesService._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }
  
  // ===== CLAVES =====
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyFontSize = 'font_size';
  static const String _keyLanguage = 'language';
  static const String _keyNotificationsEnabled = 'notifications_enabled';
  static const String _keyEmailNotifications = 'email_notifications';
  static const String _keyPushNotifications = 'push_notifications';
  static const String _keySmsNotifications = 'sms_notifications';
  static const String _keySessionCount = 'session_count';
  
  // ===== TEMA =====
  bool get isDarkMode => _prefs.getBool(_keyDarkMode) ?? false;
  
  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_keyDarkMode, value);
  }
  
  // ===== FONT SIZE =====
  double get fontSize => _prefs.getDouble(_keyFontSize) ?? 16.0;
  
  Future<void> setFontSize(double value) async {
    await _prefs.setDouble(_keyFontSize, value);
  }
  
  // ===== LANGUAGE =====
  String get language => _prefs.getString(_keyLanguage) ?? 'es';
  
  Future<void> setLanguage(String value) async {
    await _prefs.setString(_keyLanguage, value);
  }
  
  // ===== NOTIFICATIONS =====
  // TODO: Implementar getters y setters para notificaciones
  
  // ===== SESSION COUNT =====
  int get sessionCount => _prefs.getInt(_keySessionCount) ?? 0;
  
  Future<void> incrementSessionCount() async {
    final current = sessionCount;
    await _prefs.setInt(_keySessionCount, current + 1);
  }
  
  Future<void> resetSessionCount() async {
    await _prefs.setInt(_keySessionCount, 0);
  }
}
```

### 2. Provider de Settings

```dart
// lib/providers/settings_provider.dart
import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

/**
 * SettingsProvider: Estado reactivo de configuraciones.
 * 
 * Combina la persistencia (PreferencesService) con
 * la reactividad (ChangeNotifier).
 */
class SettingsProvider extends ChangeNotifier {
  late PreferencesService _prefs;
  
  // Estado local
  bool _isDarkMode = false;
  double _fontSize = 16.0;
  String _language = 'es';
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsNotifications = false;
  int _sessionCount = 0;
  bool _isInitialized = false;
  
  // Getters
  bool get isDarkMode => _isDarkMode;
  double get fontSize => _fontSize;
  String get language => _language;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get emailNotifications => _emailNotifications;
  bool get pushNotifications => _pushNotifications;
  bool get smsNotifications => _smsNotifications;
  int get sessionCount => _sessionCount;
  bool get isInitialized => _isInitialized;
  
  // Texto del idioma para mostrar
  String get languageDisplay {
    switch (_language) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      default:
        return _language;
    }
  }
  
  /// Inicializar cargando preferencias
  Future<void> init() async {
    _prefs = await PreferencesService.getInstance();
    
    // Cargar valores guardados
    _isDarkMode = _prefs.isDarkMode;
    _fontSize = _prefs.fontSize;
    _language = _prefs.language;
    _sessionCount = _prefs.sessionCount;
    // TODO: Cargar preferencias de notificaciones
    
    // Incrementar contador de sesiones
    await _prefs.incrementSessionCount();
    _sessionCount = _prefs.sessionCount;
    
    _isInitialized = true;
    notifyListeners();
  }
  
  /// Cambiar tema
  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await _prefs.setDarkMode(value);
    notifyListeners();
  }
  
  /// Cambiar tamaño de fuente
  Future<void> setFontSize(double value) async {
    _fontSize = value;
    await _prefs.setFontSize(value);
    notifyListeners();
  }
  
  /// Cambiar idioma
  Future<void> setLanguage(String value) async {
    _language = value;
    await _prefs.setLanguage(value);
    notifyListeners();
  }
  
  // TODO: Implementar métodos para notificaciones
  
  /// Resetear a valores por defecto
  Future<void> resetToDefaults() async {
    await setDarkMode(false);
    await setFontSize(16.0);
    await setLanguage('es');
    // TODO: Resetear notificaciones
  }
}
```

### 3. Main con Provider

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar provider
  final settingsProvider = SettingsProvider();
  await settingsProvider.init();
  
  runApp(
    ChangeNotifierProvider.value(
      value: settingsProvider,
      child: const MyApp(),
    ),
  );
}
```

### 4. App con Tema Dinámico

```dart
// lib/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'screens/settings_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          title: 'Preferencias App',
          debugShowCheckedModeBanner: false,
          
          // Tema dinámico
          theme: ThemeData(
            brightness: settings.isDarkMode 
                ? Brightness.dark 
                : Brightness.light,
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              bodyMedium: TextStyle(fontSize: settings.fontSize),
              bodyLarge: TextStyle(fontSize: settings.fontSize + 2),
              titleMedium: TextStyle(fontSize: settings.fontSize + 4),
            ),
          ),
          
          home: const SettingsScreen(),
        );
      },
    );
  }
}
```

### 5. Pantalla de Configuración (A completar)

```dart
// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Restaurar valores',
            onPressed: () => _showResetDialog(context),
          ),
        ],
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          if (!settings.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return ListView(
            children: [
              // Contador de sesiones
              _buildSessionCounter(settings),
              const Divider(),
              
              // TODO: Implementar sección de Apariencia
              // - Switch tema oscuro
              // - Slider tamaño de fuente
              
              // TODO: Implementar sección de Idioma
              // - ListTile con selector
              
              // TODO: Implementar sección de Notificaciones
              // - Toggle principal
              // - Sub-opciones (email, push, sms)
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildSessionCounter(SettingsProvider settings) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.login, size: 40),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sesiones iniciadas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${settings.sessionCount} veces',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restaurar configuración'),
        content: const Text(
          '¿Estás seguro de restaurar todos los valores por defecto?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SettingsProvider>().resetToDefaults();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configuración restaurada')),
              );
            },
            child: const Text('Restaurar'),
          ),
        ],
      ),
    );
  }
}
```

---

## ✅ Tareas a Completar

### Nivel 1: Básico
- [ ] Completar getters/setters de notificaciones en `PreferencesService`
- [ ] Implementar sección de Apariencia con Switch y Slider
- [ ] Implementar selector de idioma

### Nivel 2: Intermedio
- [ ] Implementar sección de Notificaciones con sub-opciones
- [ ] Las sub-opciones deben deshabilitarse si el toggle principal está off
- [ ] Añadir preview del tamaño de fuente en tiempo real

### Nivel 3: Avanzado
- [ ] Agregar opción "Recordar última pantalla visitada"
- [ ] Implementar exportar/importar configuración (JSON)
- [ ] Añadir animaciones suaves en los cambios

---

## 🎨 Ejemplo de UI Esperada

```
┌─────────────────────────────────────┐
│ ← Configuración               🔄   │
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │ 🔑  Sesiones iniciadas          │ │
│ │     42 veces                    │ │
│ └─────────────────────────────────┘ │
│                                     │
│ APARIENCIA                          │
│ ┌─────────────────────────────────┐ │
│ │ 🌙 Modo oscuro           [═══]  │ │
│ │ 🔤 Tamaño de fuente       16    │ │
│ │    ○───────●───────○            │ │
│ │    12               24          │ │
│ └─────────────────────────────────┘ │
│                                     │
│ IDIOMA                              │
│ ┌─────────────────────────────────┐ │
│ │ 🌐 Idioma             Español › │ │
│ └─────────────────────────────────┘ │
│                                     │
│ NOTIFICACIONES                      │
│ ┌─────────────────────────────────┐ │
│ │ 🔔 Notificaciones        [═══]  │ │
│ │   ├ 📧 Email             [═══]  │ │
│ │   ├ 📱 Push              [═══]  │ │
│ │   └ 💬 SMS               [   ]  │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

---

## 📊 Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| Persistencia funciona correctamente | 30 |
| UI completa y usable | 25 |
| Código limpio y documentado | 20 |
| Provider implementado correctamente | 15 |
| Manejo de estados de carga | 10 |
| **Total** | **100** |

---

## 🔗 Recursos

- [SharedPreferences docs](https://pub.dev/packages/shared_preferences)
- [Provider docs](https://pub.dev/packages/provider)
- [Material Design - Settings](https://material.io/design/platform-guidance/android-settings.html)

---

## ➡️ Siguiente Práctica

[Práctica 02: Base de Datos de Contactos](./practica-02-sqlite-contactos.md)
