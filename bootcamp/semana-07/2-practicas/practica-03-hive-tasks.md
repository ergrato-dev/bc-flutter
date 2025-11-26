# 💻 Práctica 03: Lista de Tareas con Hive

## 🎯 Objetivo

Crear una aplicación de gestión de tareas usando **Hive** como base de datos NoSQL, con TypeAdapters y UI reactiva.

---

## 📋 Requisitos

### Funcionales

1. **Lista de Tareas**

   - Mostrar todas las tareas agrupadas por estado
   - Pendientes arriba, completadas abajo
   - Orden por prioridad y fecha

2. **Agregar Tarea**

   - Título (requerido)
   - Descripción (opcional)
   - Prioridad (baja, normal, alta, urgente)
   - Fecha límite (opcional)
   - Etiquetas/tags

3. **Marcar como Completada**

   - Checkbox en cada tarea
   - Animación al completar
   - Mover a sección completadas

4. **Editar/Eliminar**

   - Editar cualquier campo
   - Eliminar con confirmación
   - Eliminar todas las completadas

5. **Filtros**
   - Por prioridad
   - Por estado
   - Por etiqueta

### Modelo de Datos

```dart
@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  TaskPriority priority;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime? dueDate;

  @HiveField(7)
  List<String> tags;
}

@HiveType(typeId: 1)
enum TaskPriority { low, normal, high, urgent }
```

---

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart
├── models/
│   ├── task.dart
│   └── task.g.dart         (generado)
├── repositories/
│   └── task_repository.dart
├── providers/
│   └── tasks_provider.dart
├── screens/
│   ├── task_list_screen.dart
│   └── task_form_screen.dart
└── widgets/
    ├── task_tile.dart
    ├── priority_badge.dart
    └── filter_chip_row.dart
```

---

## 📝 Código Base

### 1. Modelo con Hive Annotations

```dart
// lib/models/task.dart
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

/**
 * TaskPriority: Enum para prioridad de tarea.
 */
@HiveType(typeId: 1)
enum TaskPriority {
  @HiveField(0)
  low,

  @HiveField(1)
  normal,

  @HiveField(2)
  high,

  @HiveField(3)
  urgent;

  String get label {
    switch (this) {
      case TaskPriority.low:
        return 'Baja';
      case TaskPriority.normal:
        return 'Normal';
      case TaskPriority.high:
        return 'Alta';
      case TaskPriority.urgent:
        return 'Urgente';
    }
  }

  int get colorValue {
    switch (this) {
      case TaskPriority.low:
        return 0xFF4CAF50; // Green
      case TaskPriority.normal:
        return 0xFF2196F3; // Blue
      case TaskPriority.high:
        return 0xFFFF9800; // Orange
      case TaskPriority.urgent:
        return 0xFFF44336; // Red
    }
  }
}

/**
 * Task: Modelo de tarea con Hive.
 *
 * Extiende HiveObject para tener acceso a:
 * - save(): Guardar cambios
 * - delete(): Eliminar del box
 * - key: Obtener la clave en el box
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
  TaskPriority priority;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  DateTime? dueDate;

  @HiveField(7)
  List<String> tags;

  @HiveField(8)
  DateTime? completedAt;

  Task({
    String? id,
    required this.title,
    this.description,
    this.priority = TaskPriority.normal,
    this.isCompleted = false,
    DateTime? createdAt,
    this.dueDate,
    List<String>? tags,
    this.completedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        tags = tags ?? [];

  /// Verificar si está vencida
  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  /// Días restantes hasta vencimiento
  int? get daysUntilDue {
    if (dueDate == null) return null;
    return dueDate!.difference(DateTime.now()).inDays;
  }

  /// Toggle completado y guardar
  Future<void> toggleComplete() async {
    isCompleted = !isCompleted;
    completedAt = isCompleted ? DateTime.now() : null;
    await save();
  }

  /// Crear copia con modificaciones
  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    List<String>? tags,
    DateTime? completedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      tags: tags ?? List.from(this.tags),
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
```

### 2. Generar Adapters

```bash
# Ejecutar en terminal
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Repository

```dart
// lib/repositories/task_repository.dart
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

/**
 * TaskRepository: Acceso a datos de tareas con Hive.
 */
class TaskRepository {
  static const String _boxName = 'tasks';

  Box<Task> get _box => Hive.box<Task>(_boxName);

  /// Inicializar box
  static Future<void> init() async {
    await Hive.openBox<Task>(_boxName);
  }

  /// Obtener todas las tareas
  List<Task> getAll() {
    return _box.values.toList();
  }

  /// Obtener tareas ordenadas
  List<Task> getAllSorted() {
    final tasks = _box.values.toList();

    tasks.sort((a, b) {
      // Primero no completadas
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }

      // Luego por prioridad (mayor primero)
      if (a.priority != b.priority) {
        return b.priority.index - a.priority.index;
      }

      // Luego por fecha de vencimiento
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      }
      if (a.dueDate != null) return -1;
      if (b.dueDate != null) return 1;

      // Finalmente por fecha de creación
      return b.createdAt.compareTo(a.createdAt);
    });

    return tasks;
  }

  /// Obtener pendientes
  List<Task> getPending() {
    return _box.values.where((t) => !t.isCompleted).toList();
  }

  /// Obtener completadas
  List<Task> getCompleted() {
    return _box.values.where((t) => t.isCompleted).toList();
  }

  /// Obtener por prioridad
  List<Task> getByPriority(TaskPriority priority) {
    return _box.values.where((t) => t.priority == priority).toList();
  }

  /// Obtener por etiqueta
  List<Task> getByTag(String tag) {
    return _box.values.where((t) => t.tags.contains(tag)).toList();
  }

  /// Obtener vencidas
  List<Task> getOverdue() {
    return _box.values.where((t) => t.isOverdue).toList();
  }

  /// Buscar por texto
  List<Task> search(String query) {
    final lowerQuery = query.toLowerCase();
    return _box.values.where((t) {
      return t.title.toLowerCase().contains(lowerQuery) ||
             (t.description?.toLowerCase().contains(lowerQuery) ?? false) ||
             t.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  /// Obtener por ID
  Task? getById(String id) {
    try {
      return _box.values.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Agregar tarea
  Future<void> add(Task task) async {
    await _box.put(task.id, task);
  }

  /// Actualizar tarea
  Future<void> update(Task task) async {
    await _box.put(task.id, task);
  }

  /// Eliminar tarea
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  /// Eliminar completadas
  Future<void> deleteCompleted() async {
    final completedIds = _box.values
        .where((t) => t.isCompleted)
        .map((t) => t.id)
        .toList();
    await _box.deleteAll(completedIds);
  }

  /// Limpiar todo
  Future<void> clear() async {
    await _box.clear();
  }

  /// Obtener todas las etiquetas únicas
  List<String> getAllTags() {
    final tags = <String>{};
    for (final task in _box.values) {
      tags.addAll(task.tags);
    }
    return tags.toList()..sort();
  }

  /// Escuchar cambios (para UI reactiva)
  ValueListenable<Box<Task>> listenable() {
    return _box.listenable();
  }

  /// Estadísticas
  Map<String, int> getStats() {
    final tasks = _box.values.toList();
    return {
      'total': tasks.length,
      'pending': tasks.where((t) => !t.isCompleted).length,
      'completed': tasks.where((t) => t.isCompleted).length,
      'overdue': tasks.where((t) => t.isOverdue).length,
      'urgent': tasks.where((t) => t.priority == TaskPriority.urgent && !t.isCompleted).length,
    };
  }
}
```

### 4. Main con Inicialización

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'repositories/task_repository.dart';
import 'providers/tasks_provider.dart';
import 'screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive
  await Hive.initFlutter();

  // Registrar adapters
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskPriorityAdapter());

  // Abrir boxes
  await TaskRepository.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => TasksProvider()..loadTasks(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Tasks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}
```

### 5. Provider (A completar)

```dart
// lib/providers/tasks_provider.dart
import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

enum TaskFilter { all, pending, completed, overdue }

/**
 * TasksProvider: Estado reactivo para tareas.
 *
 * TODO: Completar implementación
 */
class TasksProvider extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();

  List<Task> _tasks = [];
  TaskFilter _filter = TaskFilter.all;
  TaskPriority? _priorityFilter;
  String? _tagFilter;
  String _searchQuery = '';
  bool _isLoading = false;

  // Getters
  bool get isLoading => _isLoading;
  TaskFilter get filter => _filter;
  TaskPriority? get priorityFilter => _priorityFilter;
  String? get tagFilter => _tagFilter;
  List<String> get allTags => _repository.getAllTags();
  Map<String, int> get stats => _repository.getStats();

  /// Obtener tareas filtradas
  List<Task> get tasks {
    List<Task> result = _tasks;

    // Aplicar filtro de estado
    switch (_filter) {
      case TaskFilter.all:
        break;
      case TaskFilter.pending:
        result = result.where((t) => !t.isCompleted).toList();
        break;
      case TaskFilter.completed:
        result = result.where((t) => t.isCompleted).toList();
        break;
      case TaskFilter.overdue:
        result = result.where((t) => t.isOverdue).toList();
        break;
    }

    // Aplicar filtro de prioridad
    if (_priorityFilter != null) {
      result = result.where((t) => t.priority == _priorityFilter).toList();
    }

    // Aplicar filtro de etiqueta
    if (_tagFilter != null) {
      result = result.where((t) => t.tags.contains(_tagFilter)).toList();
    }

    // Aplicar búsqueda
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((t) {
        return t.title.toLowerCase().contains(query) ||
               (t.description?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return result;
  }

  /// Tareas pendientes (para badge)
  int get pendingCount => _tasks.where((t) => !t.isCompleted).length;

  /// Cargar tareas
  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    _tasks = _repository.getAllSorted();

    _isLoading = false;
    notifyListeners();
  }

  /// Cambiar filtro
  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  /// Cambiar filtro de prioridad
  void setPriorityFilter(TaskPriority? priority) {
    _priorityFilter = priority;
    notifyListeners();
  }

  /// Cambiar filtro de etiqueta
  void setTagFilter(String? tag) {
    _tagFilter = tag;
    notifyListeners();
  }

  /// Buscar
  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Limpiar filtros
  void clearFilters() {
    _filter = TaskFilter.all;
    _priorityFilter = null;
    _tagFilter = null;
    _searchQuery = '';
    notifyListeners();
  }

  /// Agregar tarea
  Future<void> addTask(Task task) async {
    // TODO: Implementar
    // 1. Guardar en repository
    // 2. Recargar lista
  }

  /// Actualizar tarea
  Future<void> updateTask(Task task) async {
    // TODO: Implementar
  }

  /// Toggle completado
  Future<void> toggleComplete(String id) async {
    // TODO: Implementar
    // Usar task.toggleComplete() y recargar
  }

  /// Eliminar tarea
  Future<void> deleteTask(String id) async {
    // TODO: Implementar
  }

  /// Eliminar completadas
  Future<void> deleteCompleted() async {
    // TODO: Implementar
  }
}
```

### 6. Widget PriorityBadge

```dart
// lib/widgets/priority_badge.dart
import 'package:flutter/material.dart';
import '../models/task.dart';

class PriorityBadge extends StatelessWidget {
  final TaskPriority priority;
  final bool showLabel;

  const PriorityBadge({
    super.key,
    required this.priority,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(priority.colorValue);

    if (showLabel) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Text(
          priority.label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
```

### 7. Widget TaskTile (A completar)

```dart
// lib/widgets/task_tile.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import 'priority_badge.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onToggle;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TaskTile({
    super.key,
    required this.task,
    this.onToggle,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar UI completa
    // - Checkbox para completar
    // - Título con tachado si completada
    // - Descripción (si existe)
    // - PriorityBadge
    // - Tags como chips
    // - Indicador de fecha límite
    // - Swipe to delete

    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) => onToggle?.call(),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : null,
        ),
      ),
      trailing: PriorityBadge(priority: task.priority),
      onTap: onTap,
    );
  }
}
```

---

## ✅ Tareas a Completar

### Nivel 1: Básico

- [ ] Generar TypeAdapters con build_runner
- [ ] Completar métodos en `TasksProvider`
- [ ] Implementar `TaskListScreen` básica

### Nivel 2: Intermedio

- [ ] Implementar `TaskTile` completo con todos los elementos
- [ ] Crear `TaskFormScreen` para agregar/editar
- [ ] Implementar filtros funcionales
- [ ] Añadir chips de etiquetas

### Nivel 3: Avanzado

- [ ] UI reactiva con ValueListenableBuilder
- [ ] Animaciones al completar/eliminar
- [ ] Estadísticas en la pantalla principal
- [ ] Notificaciones para tareas vencidas

---

## 🎨 UI Esperada

```
┌─────────────────────────────────────┐
│ Mis Tareas                     🔍   │
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │ Todas │ Pend. │ Compl. │ Venc. │ │
│ └─────────────────────────────────┘ │
│                                     │
│ 📊 4 pendientes · 2 urgentes        │
│                                     │
│ PENDIENTES                          │
│ ┌─────────────────────────────────┐ │
│ │ ☐ Revisar documentación    🔴   │ │
│ │   Urgente · Vence: Hoy          │ │
│ │   [trabajo] [docs]              │ │
│ └─────────────────────────────────┘ │
│ ┌─────────────────────────────────┐ │
│ │ ☐ Preparar presentación    🟠   │ │
│ │   Alta · Vence: Mañana          │ │
│ │   [trabajo]                     │ │
│ └─────────────────────────────────┘ │
│                                     │
│ COMPLETADAS                         │
│ ┌─────────────────────────────────┐ │
│ │ ☑ Comprar víveres          🟢   │ │
│ │   ~~Completada ayer~~           │ │
│ └─────────────────────────────────┘ │
│                                     │
│ 🗑️ Limpiar completadas       [ + ] │
└─────────────────────────────────────┘
```

---

## 📊 Criterios de Evaluación

| Criterio                       | Puntos  |
| ------------------------------ | ------- |
| Hive configurado correctamente | 20      |
| CRUD completo                  | 25      |
| Filtros funcionando            | 20      |
| UI completa y usable           | 20      |
| Código limpio                  | 15      |
| **Total**                      | **100** |

---

## 🔗 Recursos

- [Hive docs](https://docs.hivedb.dev/)
- [hive_flutter](https://pub.dev/packages/hive_flutter)
- [build_runner](https://pub.dev/packages/build_runner)
- [uuid](https://pub.dev/packages/uuid)

---

## ➡️ Siguiente Práctica

[Práctica 04: Caché de Imágenes](./practica-04-cache-imagenes.md)
