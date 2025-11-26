# 📄 Cheatsheet: Hive

## 📋 Referencia Rápida

> Guía de consulta rápida para Hive en Flutter.

---

## 🚀 Setup Inicial

### Dependencias

```yaml
# pubspec.yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.6
```

### Instalación

```bash
flutter pub get
```

---

## 🔧 Inicialización

### En main.dart

```dart
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Hive
  await Hive.initFlutter();
  
  // Registrar adapters (antes de abrir boxes)
  Hive.registerAdapter(UserAdapter());
  
  // Abrir boxes necesarios
  await Hive.openBox('settings');
  await Hive.openBox<User>('users');
  
  runApp(MyApp());
}
```

---

## 📦 Boxes - Operaciones Básicas

### Abrir Box

```dart
// Box genérico (dynamic)
final box = await Hive.openBox('settings');

// Box tipado
final userBox = await Hive.openBox<User>('users');

// Obtener box ya abierto
final box = Hive.box('settings');
final userBox = Hive.box<User>('users');
```

### Cerrar Box

```dart
await box.close();

// Cerrar todos los boxes
await Hive.close();
```

---

## 💾 CRUD Operations

### CREATE (Put)

```dart
// Con clave auto-generada
final key = await box.add('valor');

// Con clave específica
await box.put('username', 'juan');
await box.put(0, 'primer item');

// Múltiples valores
await box.putAll({
  'name': 'Juan',
  'age': 25,
  'active': true,
});

// Objetos tipados
await userBox.add(User(name: 'Juan', email: 'juan@email.com'));
await userBox.put('admin', User(name: 'Admin', email: 'admin@email.com'));
```

### READ (Get)

```dart
// Obtener por clave
final username = box.get('username'); // dynamic
final user = userBox.get('admin'); // User?

// Con valor por defecto
final theme = box.get('theme', defaultValue: 'light');

// Obtener por índice
final first = box.getAt(0);

// Verificar existencia
final exists = box.containsKey('username');

// Obtener todas las claves
final keys = box.keys; // Iterable

// Obtener todos los valores
final values = box.values; // Iterable<dynamic>
final users = userBox.values; // Iterable<User>

// Convertir a lista
final userList = userBox.values.toList();
```

### UPDATE

```dart
// Mismo método que crear
await box.put('username', 'nuevo_nombre');

// Actualizar en índice
await box.putAt(0, 'nuevo valor');

// Actualizar objeto (necesita key)
final user = userBox.get('admin');
user?.name = 'Super Admin';
await user?.save(); // Si extiende HiveObject
// o
await userBox.put('admin', user!);
```

### DELETE

```dart
// Eliminar por clave
await box.delete('username');

// Eliminar por índice
await box.deleteAt(0);

// Eliminar múltiples
await box.deleteAll(['key1', 'key2', 'key3']);

// Limpiar todo el box
await box.clear();

// Eliminar box del disco
await Hive.deleteBoxFromDisk('settings');
```

---

## 🏷️ TypeAdapters

### Modelo con Anotaciones

```dart
import 'package:hive/hive.dart';

part 'user.g.dart'; // Archivo generado

@HiveType(typeId: 0) // ID único por tipo
class User extends HiveObject {
  @HiveField(0)
  String name;
  
  @HiveField(1)
  String email;
  
  @HiveField(2)
  DateTime? createdAt;
  
  @HiveField(3, defaultValue: false) // Valor por defecto
  bool isActive;
  
  User({
    required this.name,
    required this.email,
    this.createdAt,
    this.isActive = false,
  });
}
```

### Generar Adapter

```bash
flutter pub run build_runner build
# o watch mode
flutter pub run build_runner watch
```

### Registrar Adapter

```dart
// En main.dart, ANTES de abrir boxes
Hive.registerAdapter(UserAdapter());
```

---

## 🔄 HiveObject (Opcional pero Útil)

```dart
// Extender HiveObject permite:
class User extends HiveObject {
  // ...
}

// Beneficios:
final user = userBox.getAt(0);

// 1. Guardar directamente
user?.name = 'Nuevo Nombre';
await user?.save();

// 2. Eliminar directamente
await user?.delete();

// 3. Verificar si está en box
final isInBox = user?.isInBox ?? false;

// 4. Obtener la key
final key = user?.key;
```

---

## 📦 LazyBox (Para Boxes Grandes)

```dart
// Abrir como LazyBox
final lazyBox = await Hive.openLazyBox<User>('largeUsers');

// Leer es async
final user = await lazyBox.get('key');

// Escribir igual que Box normal
await lazyBox.put('key', user);

// Útil cuando:
// - Box tiene muchos registros
// - No necesitas todos los datos en memoria
// - Quieres optimizar memoria
```

---

## 🔐 Box Encriptado

```dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Generar/obtener clave de encriptación
Future<List<int>> getEncryptionKey() async {
  const storage = FlutterSecureStorage();
  final keyString = await storage.read(key: 'hive_key');
  
  if (keyString != null) {
    return base64Decode(keyString);
  }
  
  // Generar nueva clave
  final key = Hive.generateSecureKey();
  await storage.write(key: 'hive_key', value: base64Encode(key));
  return key;
}

// Abrir box encriptado
final key = await getEncryptionKey();
final encryptedBox = await Hive.openBox(
  'secure_data',
  encryptionCipher: HiveAesCipher(key),
);
```

---

## 👀 ValueListenableBuilder

```dart
// Escuchar cambios en el box
ValueListenableBuilder<Box>(
  valueListenable: Hive.box('settings').listenable(),
  builder: (context, box, _) {
    final isDark = box.get('darkMode', defaultValue: false);
    return Text('Dark mode: $isDark');
  },
)

// Escuchar claves específicas
ValueListenableBuilder<Box>(
  valueListenable: Hive.box('settings').listenable(keys: ['darkMode', 'language']),
  builder: (context, box, _) {
    // Solo se reconstruye si cambian estas claves
    return SettingsWidget();
  },
)

// Con box tipado
ValueListenableBuilder<Box<User>>(
  valueListenable: Hive.box<User>('users').listenable(),
  builder: (context, box, _) {
    final users = box.values.toList();
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (_, i) => Text(users[i].name),
    );
  },
)
```

---

## 📊 Comparativa Box vs LazyBox

| Característica | Box | LazyBox |
|----------------|-----|---------|
| Carga inicial | Todo en memoria | Solo metadata |
| Lectura | Síncrona | Asíncrona |
| Uso de memoria | Mayor | Menor |
| Velocidad lectura | Más rápida | Más lenta |
| Ideal para | Datos pequeños/medianos | Datos grandes |

---

## 🎯 Patrones Comunes

### Singleton Service

```dart
class HiveService {
  static HiveService? _instance;
  late Box _settingsBox;
  late Box<User> _usersBox;
  
  HiveService._();
  
  static Future<HiveService> getInstance() async {
    if (_instance == null) {
      _instance = HiveService._();
      await _instance!._init();
    }
    return _instance!;
  }
  
  Future<void> _init() async {
    _settingsBox = await Hive.openBox('settings');
    _usersBox = await Hive.openBox<User>('users');
  }
  
  // Settings
  bool get darkMode => _settingsBox.get('darkMode', defaultValue: false);
  set darkMode(bool value) => _settingsBox.put('darkMode', value);
  
  // Users
  List<User> get users => _usersBox.values.toList();
  Future<void> addUser(User user) => _usersBox.add(user);
}
```

### Repository Pattern

```dart
abstract class UserRepository {
  Future<List<User>> getAll();
  Future<User?> getById(dynamic id);
  Future<void> save(User user);
  Future<void> delete(dynamic id);
}

class HiveUserRepository implements UserRepository {
  final Box<User> _box;
  
  HiveUserRepository(this._box);
  
  @override
  Future<List<User>> getAll() async {
    return _box.values.toList();
  }
  
  @override
  Future<User?> getById(dynamic id) async {
    return _box.get(id);
  }
  
  @override
  Future<void> save(User user) async {
    if (user.key != null) {
      await user.save();
    } else {
      await _box.add(user);
    }
  }
  
  @override
  Future<void> delete(dynamic id) async {
    await _box.delete(id);
  }
}
```

---

## ⚠️ Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| `HiveError: Box not found` | Box no abierto | `await Hive.openBox()` primero |
| `HiveError: TypeAdapter not registered` | Adapter no registrado | Registrar antes de abrir box |
| `HiveError: TypeId already in use` | Dos tipos con mismo typeId | Usar typeId únicos |
| `HiveError: Cannot write` | Box cerrado | Verificar que esté abierto |

---

## 💡 Tips Rápidos

1. **Registrar adapters** antes de abrir boxes tipados
2. **typeId únicos** para cada modelo (0, 1, 2...)
3. **HiveField index** únicos dentro de cada clase
4. **Nunca cambiar typeId** o field index en producción
5. **Usar defaultValue** en @HiveField para campos nuevos
6. **LazyBox** para datos grandes o que no se leen frecuentemente
7. **ValueListenableBuilder** para UI reactiva
8. **Cerrar boxes** al salir de la app si es necesario

---

## 📝 Template de Modelo

```dart
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  
  @HiveField(1)
  String? description;
  
  @HiveField(2)
  bool isCompleted;
  
  @HiveField(3)
  DateTime createdAt;
  
  @HiveField(4)
  DateTime? dueDate;
  
  @HiveField(5)
  int priority; // 0: low, 1: medium, 2: high
  
  Task({
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    this.dueDate,
    this.priority = 1,
  }) : createdAt = createdAt ?? DateTime.now();
  
  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    int? priority,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }
}
```

---

## 🔍 Filtrar y Buscar

```dart
// Filtrar valores
final completedTasks = taskBox.values
    .where((task) => task.isCompleted)
    .toList();

// Buscar por texto
final results = taskBox.values
    .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
    .toList();

// Ordenar
final sorted = taskBox.values.toList()
  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

// Combinar filtros
final highPriorityPending = taskBox.values
    .where((task) => !task.isCompleted && task.priority == 2)
    .toList();
```

---

> 📌 **Recuerda**: Hive es ideal para datos no relacionales, configuraciones y cachés. Para relaciones complejas, considera SQLite.
