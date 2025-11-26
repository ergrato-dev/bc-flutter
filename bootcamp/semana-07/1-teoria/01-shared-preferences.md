# 📦 Módulo 01: SharedPreferences

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- [ ] Entender cuándo usar SharedPreferences
- [ ] Guardar y recuperar datos primitivos
- [ ] Implementar preferencias de usuario persistentes
- [ ] Crear un servicio de configuración reutilizable

---

## 📚 Contenido

### 1. ¿Qué es SharedPreferences?

**SharedPreferences** es un mecanismo de almacenamiento **clave-valor** que persiste datos simples en el dispositivo.

#### Características

| Característica   | Descripción                                               |
| ---------------- | --------------------------------------------------------- |
| **Tipo**         | Almacenamiento clave-valor                                |
| **Datos**        | Solo primitivos (String, int, double, bool, List<String>) |
| **Persistencia** | Sobrevive al cierre de la app                             |
| **Seguridad**    | No encriptado (no usar para datos sensibles)              |
| **Plataforma**   | iOS (NSUserDefaults), Android (SharedPreferences)         |

#### Casos de Uso Ideales

```
✅ Preferencias de usuario (tema, idioma)
✅ Configuraciones de la app
✅ Flags de "primera vez"
✅ Tokens de sesión simples
✅ Última pantalla visitada

❌ Datos estructurados complejos
❌ Grandes cantidades de datos
❌ Contraseñas o datos sensibles
❌ Datos que requieren búsqueda
```

---

### 2. Instalación y Configuración

#### Agregar Dependencia

```yaml
# pubspec.yaml
dependencies:
  shared_preferences: ^2.2.2
```

```bash
# Instalar
flutter pub get
```

#### Import

```dart
import 'package:shared_preferences/shared_preferences.dart';
```

---

### 3. Operaciones Básicas

#### Obtener Instancia

```dart
/**
 * SharedPreferences es un singleton asíncrono.
 * Debemos esperar a que se inicialice antes de usarlo.
 */
Future<void> initPreferences() async {
  // Obtener instancia (carga desde disco)
  final SharedPreferences prefs = await SharedPreferences.getInstance();
}
```

#### Guardar Datos (Write)

```dart
/**
 * Guarda diferentes tipos de datos en SharedPreferences.
 *
 * ¿Qué hace?
 * Persiste valores primitivos usando claves únicas.
 *
 * ¿Para qué?
 * Mantener preferencias del usuario entre sesiones.
 *
 * ¿Cómo funciona?
 * 1. Obtiene instancia de SharedPreferences
 * 2. Llama al método set apropiado según el tipo
 * 3. Los datos se escriben en disco de forma asíncrona
 */
Future<void> saveUserPreferences() async {
  final prefs = await SharedPreferences.getInstance();

  // String - textos
  await prefs.setString('username', 'flutter_dev');
  await prefs.setString('language', 'es');

  // int - números enteros
  await prefs.setInt('loginCount', 42);
  await prefs.setInt('fontSize', 16);

  // double - números decimales
  await prefs.setDouble('volume', 0.75);
  await prefs.setDouble('rating', 4.5);

  // bool - valores booleanos
  await prefs.setBool('isDarkMode', true);
  await prefs.setBool('notificationsEnabled', false);
  await prefs.setBool('hasSeenOnboarding', true);

  // List<String> - lista de textos
  await prefs.setStringList('favoriteCategories', ['tech', 'sports', 'music']);
  await prefs.setStringList('recentSearches', ['flutter', 'dart', 'widgets']);
}
```

#### Leer Datos (Read)

```dart
/**
 * Lee datos almacenados proporcionando valores por defecto.
 *
 * Importante: Siempre proporcionar valores por defecto
 * ya que la clave podría no existir.
 */
Future<void> loadUserPreferences() async {
  final prefs = await SharedPreferences.getInstance();

  // Leer con valores por defecto usando ??
  final String username = prefs.getString('username') ?? 'guest';
  final String language = prefs.getString('language') ?? 'en';

  final int loginCount = prefs.getInt('loginCount') ?? 0;
  final int fontSize = prefs.getInt('fontSize') ?? 14;

  final double volume = prefs.getDouble('volume') ?? 1.0;
  final double rating = prefs.getDouble('rating') ?? 0.0;

  final bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  final bool notifications = prefs.getBool('notificationsEnabled') ?? true;

  final List<String> favorites = prefs.getStringList('favoriteCategories') ?? [];

  print('Usuario: $username, Tema oscuro: $isDarkMode');
}
```

#### Eliminar Datos (Delete)

```dart
/**
 * Elimina datos específicos o todos los datos.
 */
Future<void> clearPreferences() async {
  final prefs = await SharedPreferences.getInstance();

  // Eliminar una clave específica
  await prefs.remove('username');

  // Verificar si existe una clave
  final bool hasUsername = prefs.containsKey('username');
  print('¿Existe username?: $hasUsername'); // false

  // Eliminar TODOS los datos (usar con cuidado)
  await prefs.clear();

  // Obtener todas las claves almacenadas
  final Set<String> keys = prefs.getKeys();
  print('Claves restantes: $keys'); // {}
}
```

---

### 4. Servicio de Preferencias

#### Implementación Básica

```dart
/**
 * PreferencesService: Servicio centralizado para preferencias.
 *
 * ¿Qué hace?
 * Encapsula toda la lógica de SharedPreferences en un solo lugar.
 *
 * ¿Para qué?
 * - Código más limpio y organizado
 * - Fácil de mantener y modificar
 * - Reutilizable en toda la app
 * - Testeable
 *
 * ¿Cómo funciona?
 * 1. Singleton que se inicializa una vez
 * 2. Proporciona getters/setters tipados
 * 3. Centraliza las claves de preferencias
 */
class PreferencesService {
  // Singleton pattern
  static PreferencesService? _instance;
  static late SharedPreferences _prefs;

  // Constructor privado
  PreferencesService._();

  // Factory para obtener instancia
  static Future<PreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = PreferencesService._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // ===== CLAVES (constantes para evitar typos) =====
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyLanguage = 'language';
  static const String _keyFontSize = 'font_size';
  static const String _keyOnboardingComplete = 'onboarding_complete';
  static const String _keyUserId = 'user_id';
  static const String _keyLastSync = 'last_sync';

  // ===== DARK MODE =====
  bool get isDarkMode => _prefs.getBool(_keyDarkMode) ?? false;

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_keyDarkMode, value);
  }

  // ===== LANGUAGE =====
  String get language => _prefs.getString(_keyLanguage) ?? 'es';

  Future<void> setLanguage(String value) async {
    await _prefs.setString(_keyLanguage, value);
  }

  // ===== FONT SIZE =====
  int get fontSize => _prefs.getInt(_keyFontSize) ?? 16;

  Future<void> setFontSize(int value) async {
    await _prefs.setInt(_keyFontSize, value);
  }

  // ===== ONBOARDING =====
  bool get isOnboardingComplete => _prefs.getBool(_keyOnboardingComplete) ?? false;

  Future<void> setOnboardingComplete(bool value) async {
    await _prefs.setBool(_keyOnboardingComplete, value);
  }

  // ===== USER ID =====
  String? get userId => _prefs.getString(_keyUserId);

  Future<void> setUserId(String? value) async {
    if (value == null) {
      await _prefs.remove(_keyUserId);
    } else {
      await _prefs.setString(_keyUserId, value);
    }
  }

  // ===== LAST SYNC =====
  DateTime? get lastSync {
    final timestamp = _prefs.getInt(_keyLastSync);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
  }

  Future<void> setLastSync(DateTime value) async {
    await _prefs.setInt(_keyLastSync, value.millisecondsSinceEpoch);
  }

  // ===== UTILITIES =====
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  Future<void> logout() async {
    // Solo eliminar datos de sesión, mantener preferencias
    await _prefs.remove(_keyUserId);
    await _prefs.remove(_keyLastSync);
  }
}
```

#### Uso del Servicio

```dart
// En main.dart - Inicialización temprana
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar servicio de preferencias
  await PreferencesService.getInstance();

  runApp(const MyApp());
}

// En cualquier parte de la app
class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late PreferencesService _prefs;
  bool _isDarkMode = false;
  String _language = 'es';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await PreferencesService.getInstance();
    setState(() {
      _isDarkMode = _prefs.isDarkMode;
      _language = _prefs.language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Modo Oscuro'),
            subtitle: const Text('Activar tema oscuro'),
            value: _isDarkMode,
            onChanged: (value) async {
              await _prefs.setDarkMode(value);
              setState(() => _isDarkMode = value);
            },
          ),
          ListTile(
            title: const Text('Idioma'),
            subtitle: Text(_language == 'es' ? 'Español' : 'English'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageDialog(),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Seleccionar idioma'),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              await _prefs.setLanguage('es');
              setState(() => _language = 'es');
              Navigator.pop(context);
            },
            child: const Text('Español'),
          ),
          SimpleDialogOption(
            onPressed: () async {
              await _prefs.setLanguage('en');
              setState(() => _language = 'en');
              Navigator.pop(context);
            },
            child: const Text('English'),
          ),
        ],
      ),
    );
  }
}
```

---

### 5. Patrón con Provider

```dart
/**
 * SettingsProvider: Gestión de preferencias con Provider.
 *
 * Beneficios:
 * - Reactivo: La UI se actualiza automáticamente
 * - Accesible: Desde cualquier widget con context
 * - Separado: Lógica fuera de los widgets
 */
class SettingsProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  // Estado
  bool _isDarkMode = false;
  String _language = 'es';
  int _fontSize = 16;
  bool _isInitialized = false;

  // Getters
  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  int get fontSize => _fontSize;
  bool get isInitialized => _isInitialized;

  // Inicialización
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    _isDarkMode = _prefs.getBool('dark_mode') ?? false;
    _language = _prefs.getString('language') ?? 'es';
    _fontSize = _prefs.getInt('font_size') ?? 16;

    _isInitialized = true;
    notifyListeners();
  }

  // Setters con persistencia
  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await _prefs.setBool('dark_mode', value);
    notifyListeners();
  }

  Future<void> setLanguage(String value) async {
    _language = value;
    await _prefs.setString('language', value);
    notifyListeners();
  }

  Future<void> setFontSize(int value) async {
    _fontSize = value;
    await _prefs.setInt('font_size', value);
    notifyListeners();
  }

  Future<void> resetToDefaults() async {
    await setDarkMode(false);
    await setLanguage('es');
    await setFontSize(16);
  }
}

// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  await settingsProvider.init();

  runApp(
    ChangeNotifierProvider.value(
      value: settingsProvider,
      child: const MyApp(),
    ),
  );
}

// MyApp con tema dinámico
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          title: 'Mi App',
          theme: settings.isDarkMode
              ? ThemeData.dark()
              : ThemeData.light(),
          home: const HomeScreen(),
        );
      },
    );
  }
}
```

---

### 6. Almacenar Objetos Complejos (JSON)

```dart
/**
 * Aunque SharedPreferences solo soporta primitivos,
 * podemos serializar objetos a JSON String.
 */
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  // Serialización a Map
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'createdAt': createdAt.toIso8601String(),
  };

  // Deserialización desde Map
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}

// Guardar objeto como JSON String
Future<void> saveUser(User user) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(user.toJson());
  await prefs.setString('current_user', jsonString);
}

// Recuperar objeto desde JSON String
Future<User?> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('current_user');

  if (jsonString == null) return null;

  final Map<String, dynamic> json = jsonDecode(jsonString);
  return User.fromJson(json);
}

// Guardar lista de objetos
Future<void> saveUsers(List<User> users) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = users.map((u) => u.toJson()).toList();
  await prefs.setString('users', jsonEncode(jsonList));
}

// Recuperar lista de objetos
Future<List<User>> getUsers() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('users');

  if (jsonString == null) return [];

  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((json) => User.fromJson(json)).toList();
}
```

---

### 7. Buenas Prácticas

#### ✅ Hacer

```dart
// 1. Usar constantes para las claves
class PrefsKeys {
  static const String darkMode = 'dark_mode';
  static const String language = 'language';
  static const String userId = 'user_id';
}

// 2. Proporcionar siempre valores por defecto
final theme = prefs.getString(PrefsKeys.language) ?? 'es';

// 3. Inicializar en main() antes de runApp()
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPreferences();
  runApp(MyApp());
}

// 4. Encapsular en un servicio
class PrefsService {
  // Toda la lógica centralizada
}

// 5. Usar async/await correctamente
Future<void> save() async {
  await prefs.setString('key', 'value');
}
```

#### ❌ Evitar

```dart
// 1. NO usar strings mágicos
prefs.getString('usr_nm'); // ¿Qué es esto?

// 2. NO guardar datos sensibles sin encriptar
prefs.setString('password', '123456'); // ¡NUNCA!

// 3. NO olvidar el await
prefs.setString('key', 'value'); // Sin await puede no guardarse

// 4. NO almacenar grandes cantidades de datos
prefs.setString('all_data', hugeJsonString); // Usar SQLite/Hive

// 5. NO acceder a SharedPreferences en el constructor de widgets
class MyWidget extends StatelessWidget {
  final prefs = SharedPreferences.getInstance(); // ERROR
}
```

---

## 🧪 Ejercicio Rápido

Implementa un contador de visitas que:

1. Incremente cada vez que se abre la app
2. Muestre el número de visitas
3. Tenga un botón para resetear el contador

```dart
class VisitCounter extends StatefulWidget {
  @override
  State<VisitCounter> createState() => _VisitCounterState();
}

class _VisitCounterState extends State<VisitCounter> {
  int _visits = 0;

  @override
  void initState() {
    super.initState();
    _loadAndIncrementVisits();
  }

  Future<void> _loadAndIncrementVisits() async {
    // TODO: Implementar
    // 1. Obtener SharedPreferences
    // 2. Leer visitas actuales (default: 0)
    // 3. Incrementar
    // 4. Guardar nuevo valor
    // 5. Actualizar estado con setState
  }

  Future<void> _resetVisits() async {
    // TODO: Implementar reset
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Visitas: $_visits', style: TextStyle(fontSize: 32)),
            ElevatedButton(
              onPressed: _resetVisits,
              child: Text('Resetear'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 📖 Recursos

- [Documentación oficial SharedPreferences](https://pub.dev/packages/shared_preferences)
- [Flutter Cookbook - Persistencia](https://docs.flutter.dev/cookbook/persistence/key-value)

---

## ➡️ Siguiente Módulo

[02 - SQLite con sqflite](./02-sqlite-sqflite.md) - Bases de datos relacionales para datos estructurados.
