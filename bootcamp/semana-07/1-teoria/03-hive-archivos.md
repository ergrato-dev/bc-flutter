# 📦 Módulo 03: Hive y Almacenamiento de Archivos

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- [ ] Usar Hive como base de datos NoSQL local
- [ ] Crear TypeAdapters para objetos personalizados
- [ ] Manejar archivos con path_provider
- [ ] Implementar caché de imágenes
- [ ] Elegir la mejor solución de almacenamiento según el caso

---

## 📚 Contenido

## Parte 1: Hive

### 1. ¿Qué es Hive?

**Hive** es una base de datos NoSQL **ligera y rápida** escrita en Dart puro, optimizada para Flutter.

#### Comparativa

| Característica  | Hive                  | SQLite          | SharedPrefs |
| --------------- | --------------------- | --------------- | ----------- |
| **Tipo**        | NoSQL (key-value/box) | Relacional      | Key-value   |
| **Velocidad**   | ⚡ Muy rápida         | Rápida          | Rápida      |
| **Complejidad** | Baja                  | Alta            | Muy baja    |
| **Relaciones**  | No nativas            | Sí (SQL)        | No          |
| **Queries**     | Básicas               | Avanzadas (SQL) | No          |
| **Dart puro**   | ✅ Sí                 | ❌ No (nativo)  | ❌ No       |
| **Web**         | ✅ Sí                 | ❌ No           | ✅ Sí       |

#### Cuándo Usar Hive

```
✅ Datos sin relaciones complejas
✅ Caché de datos de API
✅ Datos que cambian frecuentemente
✅ Apps multiplataforma (incluido Web)
✅ Rendimiento crítico
✅ Objetos Dart complejos

❌ Relaciones complejas (usar SQLite)
❌ Queries SQL avanzados (usar SQLite)
❌ Datos críticos de negocio (evaluar)
```

---

### 2. Instalación de Hive

```yaml
# pubspec.yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.7
```

```bash
flutter pub get
```

---

### 3. Configuración Inicial

```dart
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive
  await Hive.initFlutter();

  // Registrar adapters (antes de abrir boxes)
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskPriorityAdapter());

  // Abrir boxes que necesitamos
  await Hive.openBox<Task>('tasks');
  await Hive.openBox('settings');

  runApp(const MyApp());
}
```

---

### 4. Conceptos Básicos: Boxes

```dart
/**
 * Box: Contenedor de datos en Hive (como una tabla).
 *
 * Tipos:
 * - Box<dynamic>: Cualquier tipo de dato
 * - Box<T>: Tipado, solo objetos de tipo T
 * - LazyBox<T>: Carga datos bajo demanda
 */

// Abrir un box genérico
final settingsBox = await Hive.openBox('settings');

// Abrir un box tipado
final tasksBox = await Hive.openBox<Task>('tasks');

// Verificar si un box está abierto
if (Hive.isBoxOpen('settings')) {
  final box = Hive.box('settings');
}
```

#### Operaciones Básicas con Boxes

```dart
/**
 * CRUD básico con Hive boxes.
 */
class SettingsService {
  static const String _boxName = 'settings';

  // Obtener box (debe estar abierto)
  Box get _box => Hive.box(_boxName);

  // ===== CREATE / UPDATE =====

  // Guardar con clave string
  Future<void> setThemeMode(String mode) async {
    await _box.put('theme_mode', mode);
  }

  // Guardar con clave int (auto-increment)
  Future<int> addToHistory(String search) async {
    return await _box.add(search);
  }

  // Guardar múltiples valores
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    await _box.putAll(settings);
  }

  // ===== READ =====

  // Leer valor con default
  String getThemeMode() {
    return _box.get('theme_mode', defaultValue: 'system');
  }

  // Leer por índice
  String? getHistoryItem(int index) {
    return _box.getAt(index);
  }

  // Leer todos los valores
  List<dynamic> getAllHistory() {
    return _box.values.toList();
  }

  // Verificar si existe
  bool hasKey(String key) {
    return _box.containsKey(key);
  }

  // ===== DELETE =====

  // Eliminar por clave
  Future<void> removeThemeMode() async {
    await _box.delete('theme_mode');
  }

  // Eliminar por índice
  Future<void> removeHistoryAt(int index) async {
    await _box.deleteAt(index);
  }

  // Eliminar múltiples
  Future<void> clearHistory() async {
    final keys = _box.keys.where((k) => k is int);
    await _box.deleteAll(keys);
  }

  // Limpiar todo el box
  Future<void> clearAll() async {
    await _box.clear();
  }
}
```

---

### 5. TypeAdapters para Objetos Personalizados

#### Método 1: Generación Automática (Recomendado)

```dart
import 'package:hive/hive.dart';

// Parte del archivo generado
part 'task.g.dart';

/**
 * Task: Modelo con TypeAdapter generado automáticamente.
 *
 * @HiveType(typeId: X) - ID único para este tipo (0-223)
 * @HiveField(X) - ID único para cada campo (0-255)
 *
 * ⚠️ Una vez asignados, NO cambiar los typeId ni HiveField
 *    para mantener compatibilidad con datos existentes.
 */
@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime? dueDate;

  @HiveField(6)
  TaskPriority priority;

  @HiveField(7)
  List<String> tags;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
    this.priority = TaskPriority.normal,
    this.tags = const [],
  });

  // Método para actualizar y guardar
  Future<void> toggleComplete() async {
    isCompleted = !isCompleted;
    await save(); // HiveObject proporciona save()
  }
}

// Enum también necesita adapter
@HiveType(typeId: 1)
enum TaskPriority {
  @HiveField(0)
  low,

  @HiveField(1)
  normal,

  @HiveField(2)
  high,

  @HiveField(3)
  urgent,
}
```

Generar adapters:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Archivo generado `task.g.dart`:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      isCompleted: fields[3] as bool,
      createdAt: fields[4] as DateTime,
      dueDate: fields[5] as DateTime?,
      priority: fields[6] as TaskPriority,
      tags: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      // ... resto de campos
  }
}

class TaskPriorityAdapter extends TypeAdapter<TaskPriority> {
  @override
  final int typeId = 1;

  @override
  TaskPriority read(BinaryReader reader) {
    return TaskPriority.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, TaskPriority obj) {
    writer.writeByte(obj.index);
  }
}
```

#### Método 2: TypeAdapter Manual

```dart
/**
 * TypeAdapter manual para casos especiales.
 */
class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    return User(
      id: reader.read(),
      name: reader.read(),
      email: reader.read(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.read()),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.email);
    writer.write(obj.createdAt.millisecondsSinceEpoch);
  }
}
```

---

### 6. Repository con Hive

```dart
/**
 * TaskRepository: Abstracción sobre Hive para tareas.
 */
class TaskRepository {
  static const String _boxName = 'tasks';

  Box<Task> get _box => Hive.box<Task>(_boxName);

  // Obtener todas las tareas
  List<Task> getAll() {
    return _box.values.toList();
  }

  // Obtener tareas ordenadas
  List<Task> getAllSorted() {
    final tasks = _box.values.toList();
    tasks.sort((a, b) {
      // Primero por completado, luego por prioridad, luego por fecha
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      if (a.priority != b.priority) {
        return b.priority.index - a.priority.index;
      }
      return b.createdAt.compareTo(a.createdAt);
    });
    return tasks;
  }

  // Obtener por ID
  Task? getById(String id) {
    return _box.values.firstWhere(
      (t) => t.id == id,
      orElse: () => throw Exception('Task not found'),
    );
  }

  // Obtener pendientes
  List<Task> getPending() {
    return _box.values.where((t) => !t.isCompleted).toList();
  }

  // Obtener por prioridad
  List<Task> getByPriority(TaskPriority priority) {
    return _box.values.where((t) => t.priority == priority).toList();
  }

  // Buscar por título
  List<Task> search(String query) {
    final lowerQuery = query.toLowerCase();
    return _box.values.where((t) {
      return t.title.toLowerCase().contains(lowerQuery) ||
             (t.description?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  // Crear tarea
  Future<void> add(Task task) async {
    await _box.put(task.id, task);
  }

  // Crear múltiples
  Future<void> addAll(List<Task> tasks) async {
    final map = {for (var t in tasks) t.id: t};
    await _box.putAll(map);
  }

  // Actualizar
  Future<void> update(Task task) async {
    await _box.put(task.id, task);
  }

  // Eliminar
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  // Eliminar completadas
  Future<void> deleteCompleted() async {
    final completedKeys = _box.values
        .where((t) => t.isCompleted)
        .map((t) => t.id)
        .toList();
    await _box.deleteAll(completedKeys);
  }

  // Limpiar todo
  Future<void> clear() async {
    await _box.clear();
  }

  // Escuchar cambios (reactivo)
  ValueListenable<Box<Task>> listenable() {
    return _box.listenable();
  }
}
```

---

### 7. UI Reactiva con ValueListenableBuilder

```dart
/**
 * Pantalla de tareas con actualización reactiva.
 */
class TaskListScreen extends StatelessWidget {
  final TaskRepository _repository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Tareas')),
      body: ValueListenableBuilder<Box<Task>>(
        // Escuchar cambios en el box
        valueListenable: _repository.listenable(),
        builder: (context, box, _) {
          final tasks = _repository.getAllSorted();

          if (tasks.isEmpty) {
            return const Center(
              child: Text('No hay tareas'),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskTile(
                task: task,
                onToggle: () => task.toggleComplete(),
                onDelete: () => _repository.delete(task.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    // Implementar diálogo de agregar
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) => onToggle(),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : null,
        ),
      ),
      subtitle: task.description != null
          ? Text(task.description!)
          : null,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
```

---

## Parte 2: Almacenamiento de Archivos

### 8. path_provider

```dart
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/**
 * path_provider: Acceso a directorios del sistema.
 *
 * Directorios disponibles:
 * - Documents: Datos del usuario (se respalda)
 * - Temporary: Caché temporal (puede limpiarse)
 * - Application Support: Datos de la app (no visible al usuario)
 * - External Storage: Almacenamiento externo (solo Android)
 */
class DirectoryService {
  /// Directorio de documentos (persistente, se respalda)
  Future<Directory> getDocumentsDir() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Directorio temporal (puede limpiarse por el sistema)
  Future<Directory> getTempDir() async {
    return await getTemporaryDirectory();
  }

  /// Directorio de soporte de la app
  Future<Directory> getSupportDir() async {
    return await getApplicationSupportDirectory();
  }

  /// Directorio de caché de la app
  Future<Directory> getCacheDir() async {
    return await getApplicationCacheDirectory();
  }

  /// Almacenamiento externo (Android)
  Future<Directory?> getExternalDir() async {
    return await getExternalStorageDirectory();
  }

  /// Obtener rutas
  Future<void> printPaths() async {
    final docs = await getDocumentsDir();
    final temp = await getTempDir();
    final support = await getSupportDir();

    print('Documents: ${docs.path}');
    print('Temp: ${temp.path}');
    print('Support: ${support.path}');
  }
}
```

---

### 9. Operaciones con Archivos

```dart
import 'dart:io';
import 'dart:convert';

/**
 * FileService: Servicio para operaciones de archivos.
 */
class FileService {
  final DirectoryService _dirs = DirectoryService();

  // ===== ARCHIVOS DE TEXTO =====

  /// Guardar texto en archivo
  Future<File> saveTextFile(String filename, String content) async {
    final dir = await _dirs.getDocumentsDir();
    final file = File('${dir.path}/$filename');
    return await file.writeAsString(content);
  }

  /// Leer archivo de texto
  Future<String?> readTextFile(String filename) async {
    try {
      final dir = await _dirs.getDocumentsDir();
      final file = File('${dir.path}/$filename');

      if (await file.exists()) {
        return await file.readAsString();
      }
      return null;
    } catch (e) {
      print('Error leyendo archivo: $e');
      return null;
    }
  }

  // ===== ARCHIVOS JSON =====

  /// Guardar objeto como JSON
  Future<File> saveJsonFile(String filename, Map<String, dynamic> data) async {
    final jsonString = jsonEncode(data);
    return await saveTextFile(filename, jsonString);
  }

  /// Leer archivo JSON
  Future<Map<String, dynamic>?> readJsonFile(String filename) async {
    final content = await readTextFile(filename);
    if (content == null) return null;
    return jsonDecode(content);
  }

  /// Guardar lista de objetos como JSON
  Future<File> saveJsonList(String filename, List<Map<String, dynamic>> data) async {
    final jsonString = jsonEncode(data);
    return await saveTextFile(filename, jsonString);
  }

  /// Leer lista JSON
  Future<List<dynamic>?> readJsonList(String filename) async {
    final content = await readTextFile(filename);
    if (content == null) return null;
    return jsonDecode(content);
  }

  // ===== ARCHIVOS BINARIOS =====

  /// Guardar bytes
  Future<File> saveBinaryFile(String filename, List<int> bytes) async {
    final dir = await _dirs.getDocumentsDir();
    final file = File('${dir.path}/$filename');
    return await file.writeAsBytes(bytes);
  }

  /// Leer bytes
  Future<List<int>?> readBinaryFile(String filename) async {
    try {
      final dir = await _dirs.getDocumentsDir();
      final file = File('${dir.path}/$filename');

      if (await file.exists()) {
        return await file.readAsBytes();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ===== GESTIÓN DE ARCHIVOS =====

  /// Verificar si existe
  Future<bool> fileExists(String filename) async {
    final dir = await _dirs.getDocumentsDir();
    final file = File('${dir.path}/$filename');
    return await file.exists();
  }

  /// Eliminar archivo
  Future<bool> deleteFile(String filename) async {
    try {
      final dir = await _dirs.getDocumentsDir();
      final file = File('${dir.path}/$filename');

      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Obtener tamaño del archivo
  Future<int> getFileSize(String filename) async {
    final dir = await _dirs.getDocumentsDir();
    final file = File('${dir.path}/$filename');

    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }

  /// Listar archivos en directorio
  Future<List<String>> listFiles() async {
    final dir = await _dirs.getDocumentsDir();
    final files = dir.listSync();

    return files
        .whereType<File>()
        .map((f) => f.path.split('/').last)
        .toList();
  }

  /// Limpiar directorio temporal
  Future<void> clearCache() async {
    final dir = await _dirs.getTempDir();

    if (await dir.exists()) {
      await for (final entity in dir.list()) {
        await entity.delete(recursive: true);
      }
    }
  }

  /// Calcular tamaño del caché
  Future<int> getCacheSize() async {
    final dir = await _dirs.getTempDir();
    int size = 0;

    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) {
        size += await entity.length();
      }
    }

    return size;
  }
}
```

---

### 10. Caché de Imágenes

```dart
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

/**
 * ImageCacheService: Caché de imágenes descargadas.
 */
class ImageCacheService {
  final FileService _fileService = FileService();

  /// Generar nombre de archivo desde URL (hash)
  String _getCacheKey(String url) {
    final bytes = utf8.encode(url);
    final digest = md5.convert(bytes);
    return 'img_${digest.toString()}.cache';
  }

  /// Obtener imagen (de caché o descargar)
  Future<Uint8List?> getImage(String url) async {
    final cacheKey = _getCacheKey(url);

    // Intentar desde caché
    final cached = await _fileService.readBinaryFile(cacheKey);
    if (cached != null) {
      print('Imagen desde caché: $url');
      return Uint8List.fromList(cached);
    }

    // Descargar y cachear
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Guardar en caché
        await _fileService.saveBinaryFile(cacheKey, response.bodyBytes);
        print('Imagen descargada y cacheada: $url');
        return response.bodyBytes;
      }
    } catch (e) {
      print('Error descargando imagen: $e');
    }

    return null;
  }

  /// Precargar múltiples imágenes
  Future<void> preloadImages(List<String> urls) async {
    await Future.wait(urls.map((url) => getImage(url)));
  }

  /// Limpiar caché de imágenes
  Future<void> clearImageCache() async {
    final files = await _fileService.listFiles();

    for (final file in files) {
      if (file.startsWith('img_') && file.endsWith('.cache')) {
        await _fileService.deleteFile(file);
      }
    }
  }
}

/// Widget de imagen con caché
class CachedNetworkImage extends StatefulWidget {
  final String url;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CachedNetworkImage({
    required this.url,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<CachedNetworkImage> createState() => _CachedNetworkImageState();
}

class _CachedNetworkImageState extends State<CachedNetworkImage> {
  final _cacheService = ImageCacheService();
  Uint8List? _imageData;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final data = await _cacheService.getImage(widget.url);

    if (mounted) {
      setState(() {
        _imageData = data;
        _loading = false;
        _error = data == null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return widget.placeholder ?? const CircularProgressIndicator();
    }

    if (_error || _imageData == null) {
      return widget.errorWidget ?? const Icon(Icons.error);
    }

    return Image.memory(_imageData!);
  }
}
```

---

### 11. Comparativa de Soluciones

```
┌─────────────────┬────────────────┬────────────────┬─────────────────┐
│ Necesidad       │ Solución       │ Paquete        │ Ejemplo         │
├─────────────────┼────────────────┼────────────────┼─────────────────┤
│ Preferencias    │ SharedPrefs    │ shared_prefs   │ Tema, idioma    │
│ Datos simples   │ Hive           │ hive_flutter   │ Tareas, notas   │
│ Datos complejos │ SQLite         │ sqflite        │ CRM, inventario │
│ Archivos        │ File I/O       │ path_provider  │ PDFs, exports   │
│ Imágenes        │ Caché custom   │ path_provider  │ Avatares        │
│ Seguro          │ Secure Storage │ flutter_secure │ Tokens, API keys│
└─────────────────┴────────────────┴────────────────┴─────────────────┘
```

---

### 12. Buenas Prácticas

#### ✅ Hive

```dart
// 1. Inicializar antes de runApp
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(MyApp());
}

// 2. Cerrar boxes al salir
@override
void dispose() {
  Hive.close();
  super.dispose();
}

// 3. No cambiar typeId ni HiveField una vez en producción

// 4. Usar compact() para optimizar tamaño
await box.compact();
```

#### ✅ Archivos

```dart
// 1. Siempre verificar existencia
if (await file.exists()) {
  // operar
}

// 2. Manejar errores
try {
  await file.writeAsString(content);
} on FileSystemException catch (e) {
  // Sin espacio, permisos, etc.
}

// 3. Usar directorio apropiado
// - Docs: Datos del usuario
// - Temp: Caché que puede borrarse
// - Cache: Datos que pueden regenerarse

// 4. Limpiar caché periódicamente
if (cacheSize > maxCacheSize) {
  await clearOldCache();
}
```

---

## 📖 Recursos

- [Documentación Hive](https://docs.hivedb.dev/)
- [hive_flutter en pub.dev](https://pub.dev/packages/hive_flutter)
- [path_provider](https://pub.dev/packages/path_provider)
- [Flutter Cookbook - Files](https://docs.flutter.dev/cookbook/persistence/reading-writing-files)

---

## ✅ Checklist del Módulo

- [ ] Entiendo cuándo usar cada tipo de almacenamiento
- [ ] Puedo crear y usar boxes de Hive
- [ ] Sé crear TypeAdapters para mis modelos
- [ ] Puedo leer y escribir archivos con path_provider
- [ ] Implementé un caché de imágenes básico
