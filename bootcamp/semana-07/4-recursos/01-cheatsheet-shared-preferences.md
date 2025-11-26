# 📄 Cheatsheet: SharedPreferences

## 📋 Referencia Rápida

> Guía de consulta rápida para SharedPreferences en Flutter.

---

## 🚀 Setup Inicial

### Dependencia

```yaml
# pubspec.yaml
dependencies:
  shared_preferences: ^2.2.2
```

### Instalación

```bash
flutter pub get
```

---

## 📝 Operaciones Básicas

### Obtener Instancia

```dart
import 'package:shared_preferences/shared_preferences.dart';

// Obtener instancia (async)
final prefs = await SharedPreferences.getInstance();
```

---

## 💾 Guardar Datos

| Tipo | Método | Ejemplo |
|------|--------|---------|
| `String` | `setString()` | `prefs.setString('name', 'Juan')` |
| `int` | `setInt()` | `prefs.setInt('age', 25)` |
| `double` | `setDouble()` | `prefs.setDouble('price', 19.99)` |
| `bool` | `setBool()` | `prefs.setBool('darkMode', true)` |
| `List<String>` | `setStringList()` | `prefs.setStringList('tags', ['a', 'b'])` |

### Ejemplos de Guardado

```dart
// String
await prefs.setString('username', 'john_doe');

// Integer
await prefs.setInt('loginCount', 5);

// Double
await prefs.setDouble('rating', 4.5);

// Boolean
await prefs.setBool('isFirstLaunch', false);

// Lista de Strings
await prefs.setStringList('favorites', ['item1', 'item2', 'item3']);
```

---

## 📖 Leer Datos

| Tipo | Método | Valor por Defecto |
|------|--------|-------------------|
| `String?` | `getString()` | `null` |
| `int?` | `getInt()` | `null` |
| `double?` | `getDouble()` | `null` |
| `bool?` | `getBool()` | `null` |
| `List<String>?` | `getStringList()` | `null` |

### Ejemplos de Lectura

```dart
// Con valor por defecto usando ??
final username = prefs.getString('username') ?? 'guest';
final loginCount = prefs.getInt('loginCount') ?? 0;
final rating = prefs.getDouble('rating') ?? 0.0;
final darkMode = prefs.getBool('darkMode') ?? false;
final favorites = prefs.getStringList('favorites') ?? [];
```

---

## 🗑️ Eliminar Datos

```dart
// Eliminar una clave específica
await prefs.remove('username');

// Eliminar TODAS las preferencias
await prefs.clear();
```

---

## 🔍 Verificar Existencia

```dart
// Verificar si una clave existe
final hasUsername = prefs.containsKey('username');

// Obtener todas las claves
final allKeys = prefs.getKeys(); // Set<String>
```

---

## 🎯 Patrones Comunes

### Singleton Service

```dart
/// Servicio singleton para SharedPreferences
class PrefsService {
  static PrefsService? _instance;
  static late SharedPreferences _prefs;
  
  PrefsService._();
  
  /// Inicializar (llamar en main)
  static Future<PrefsService> getInstance() async {
    if (_instance == null) {
      _instance = PrefsService._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }
  
  // Getters y Setters tipados
  bool get darkMode => _prefs.getBool('darkMode') ?? false;
  set darkMode(bool value) => _prefs.setBool('darkMode', value);
  
  String get language => _prefs.getString('language') ?? 'es';
  set language(String value) => _prefs.setString('language', value);
}
```

### Guardar JSON (Objetos Complejos)

```dart
import 'dart:convert';

// Guardar objeto como JSON
Future<void> saveUser(Map<String, dynamic> user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', jsonEncode(user));
}

// Leer objeto desde JSON
Future<Map<String, dynamic>?> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('user');
  if (userJson == null) return null;
  return jsonDecode(userJson) as Map<String, dynamic>;
}
```

### Guardar DateTime

```dart
// Guardar fecha como ISO string
Future<void> saveLastLogin() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('lastLogin', DateTime.now().toIso8601String());
}

// Leer fecha
Future<DateTime?> getLastLogin() async {
  final prefs = await SharedPreferences.getInstance();
  final dateStr = prefs.getString('lastLogin');
  if (dateStr == null) return null;
  return DateTime.parse(dateStr);
}
```

### Guardar Enum

```dart
enum ThemeMode { light, dark, system }

// Guardar enum como string
Future<void> saveTheme(ThemeMode theme) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('theme', theme.name);
}

// Leer enum
Future<ThemeMode> getTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final themeName = prefs.getString('theme');
  return ThemeMode.values.firstWhere(
    (e) => e.name == themeName,
    orElse: () => ThemeMode.system,
  );
}
```

---

## ⚠️ Limitaciones

| Limitación | Descripción |
|------------|-------------|
| **Tipos soportados** | Solo String, int, double, bool, List\<String\> |
| **Sin encriptación** | Datos guardados en texto plano |
| **No para datos sensibles** | NO usar para contraseñas o tokens |
| **Tamaño** | No recomendado para grandes cantidades de datos |
| **Sincronía** | Escritura es asíncrona |

---

## 🔒 Datos Sensibles - Alternativas

```yaml
# Para datos sensibles, usar:
dependencies:
  flutter_secure_storage: ^9.0.0
```

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

// Guardar de forma segura
await storage.write(key: 'token', value: 'abc123');

// Leer
final token = await storage.read(key: 'token');
```

---

## 🧪 Testing

### Mock en Tests

```dart
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Configurar valores iniciales para tests
  SharedPreferences.setMockInitialValues({
    'username': 'test_user',
    'darkMode': true,
    'loginCount': 5,
  });
  
  test('should read mocked values', () async {
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('username'), 'test_user');
    expect(prefs.getBool('darkMode'), true);
  });
}
```

---

## 📊 Comparativa de Métodos

| Operación | Código | Retorna |
|-----------|--------|---------|
| Guardar | `await prefs.setX('key', value)` | `Future<bool>` |
| Leer | `prefs.getX('key')` | `T?` (nullable) |
| Eliminar | `await prefs.remove('key')` | `Future<bool>` |
| Limpiar | `await prefs.clear()` | `Future<bool>` |
| Existe | `prefs.containsKey('key')` | `bool` |
| Claves | `prefs.getKeys()` | `Set<String>` |

---

## 💡 Tips Rápidos

1. **Siempre usar await** al guardar datos
2. **Valores por defecto** con operador `??`
3. **Inicializar temprano** (en main o splash)
4. **No guardar listas grandes** de datos
5. **Usar constantes** para nombres de claves
6. **Considerar flutter_secure_storage** para datos sensibles

---

## 📝 Constantes de Claves (Best Practice)

```dart
/// Constantes para claves de SharedPreferences
abstract class PrefsKeys {
  static const String darkMode = 'pref_dark_mode';
  static const String language = 'pref_language';
  static const String fontSize = 'pref_font_size';
  static const String lastSync = 'pref_last_sync';
  static const String isFirstLaunch = 'pref_first_launch';
  static const String userId = 'pref_user_id';
}

// Uso
await prefs.setBool(PrefsKeys.darkMode, true);
final isDark = prefs.getBool(PrefsKeys.darkMode) ?? false;
```

---

> 📌 **Recuerda**: SharedPreferences es ideal para configuraciones simples y preferencias de usuario, no para datos estructurados complejos.
