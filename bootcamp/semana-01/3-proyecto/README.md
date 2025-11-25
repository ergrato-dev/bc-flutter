# 🚀 Proyecto Integrador - Semana 1

**💻 Nombre del Proyecto:** Sistema de Gestión de Tareas en Dart

**⏱️ Tiempo Total:** 2.5 horas (30min presencial + 2h autónomo)  
**🎯 Dificultad:** ⭐⭐ Intermedio  
**📊 Peso en Evaluación:** 50% de la nota semanal

---

## 🎯 Objetivo del Proyecto

Crear un **sistema de gestión de tareas (To-Do List)** en la consola que combine todos los conceptos aprendidos en la Semana 1:

- Variables y tipos de datos
- Colecciones (List, Map, Set)
- Funciones con diferentes tipos de parámetros
- Estructuras de control
- Programación orientada a objetos básica
- Manejo de entrada/salida en consola

---

## 📋 Descripción del Proyecto

Crearás un **sistema de gestión de tareas** (To-Do List) por consola con las siguientes funcionalidades:

1. **Gestión de Tareas** - Crear, listar, completar, eliminar tareas
2. **Categorías** - Organizar tareas por categorías (Trabajo, Personal, Estudio)
3. **Prioridades** - Asignar niveles de prioridad (Alta, Media, Baja)
4. **Estadísticas** - Ver resumen de tareas completadas vs pendientes
5. **Persistencia** - Guardar/cargar tareas (opcional avanzado)

### Resultado de Consola Esperado:

```
╔══════════════════════════════════════════╗
║   📝 SISTEMA DE GESTIÓN DE TAREAS      ║
╚══════════════════════════════════════════╝

===== MENÚ PRINCIPAL =====
1. 📋 Ver todas las tareas
2. ➕ Agregar nueva tarea
3. ✅ Marcar tarea como completada
4. 🗑️  Eliminar tarea
5. 🔍 Buscar tareas
6. 📊 Ver estadísticas
7. 🏷️  Filtrar por categoría
8. 🔥 Ver tareas por prioridad
0. 🚪 Salir

Selecciona una opción: _

===== LISTA DE TAREAS =====

📌 ALTA PRIORIDAD:
  [1] ❌ Completar proyecto de Dart
      💼 Trabajo | ⏰ 2025-11-25
      📝 Implementar todas las funcionalidades del proyecto

📌 MEDIA PRIORIDAD:
  [2] ❌ Estudiar colecciones en Dart
      📚 Estudio | ⏰ 2025-11-26
      📝 Repasar List, Set y Map

📌 BAJA PRIORIDAD:
  [3] ✅ Hacer ejercicio
      🏠 Personal | ⏰ 2025-11-24
      📝 Rutina de 30 minutos

Total: 3 tareas | ✅ 1 completada | ❌ 2 pendientes

===== ESTADÍSTICAS =====

📊 Resumen General:
   Total de tareas: 10
   ✅ Completadas: 6 (60%)
   ❌ Pendientes: 4 (40%)

📂 Por Categoría:
   💼 Trabajo: 4 tareas
   🏠 Personal: 3 tareas
   📚 Estudio: 3 tareas

🔥 Por Prioridad:
   Alta: 2 tareas
   Media: 5 tareas
   Baja: 3 tareas
```

---

## 🎓 Parte Presencial (30 minutos en clase)

### ¿Qué haremos en clase?

El instructor explicará:

1. **Estructura del proyecto** (10 min)

   - Revisión de requisitos funcionales
   - Demostración del resultado final funcionando
   - Explicación de la rúbrica de evaluación

2. **Setup inicial** (15 min)

   - Crear proyecto Dart en consola
   - Estructura de archivos recomendada
   - Clase `Task` básica
   - Menú principal de opciones

3. **Q&A y Asignación** (5 min)
   - Resolver dudas sobre el proyecto
   - Fecha de entrega
   - Forma de entrega (GitHub)

### Fecha Límite:

**📅 Entregar antes de la próxima sesión (Semana 2)**

### Estructura de Archivos Recomendada:

```
proyecto-tareas/
├── bin/
│   └── main.dart                 # Punto de entrada
├── lib/
│   ├── models/
│   │   └── task.dart            # Clase Task + Enums
│   ├── services/
│   │   └── task_manager.dart   # Lógica de gestión
│   └── utils/
│       └── console_ui.dart      # Utilidades de UI consola
├── pubspec.yaml
└── README.md
```

---

## 🏠 Trabajo Autónomo (2 horas)

### Requisitos Funcionales:

#### 1. Clase Task y Enums (Obligatorio - 20 min)

- [ ] Clase `Task` con propiedades: id, title, description, category, priority, isCompleted, dueDate
- [ ] Enum `Priority` con valores: High, Medium, Low
- [ ] Enum `Category` con valores: Work, Personal, Study
- [ ] Constructor de Task con parámetros nombrados
- [ ] Método `toString()` para imprimir tarea formateada
- [ ] Getters para emojis según categoría/prioridad/estado

#### 2. Gestión Básica de Tareas (Obligatorio - 30 min)

- [ ] Clase `TaskManager` que maneje una lista de tareas
- [ ] Método `addTask()` para agregar nueva tarea
- [ ] Método `listTasks()` para mostrar todas las tareas
- [ ] Método `completeTask(int id)` para marcar como completada
- [ ] Método `deleteTask(int id)` para eliminar tarea
- [ ] Lista debe ordenarse por prioridad (Alta > Media > Baja)

#### 3. Funcionalidades Avanzadas (Obligatorio - 40 min)

- [ ] Método `filterByCategory(Category)` para filtrar por categoría
- [ ] Método `filterByPriority(Priority)` para filtrar por prioridad
- [ ] Método `searchTasks(String query)` para buscar por texto en título/descripción
- [ ] Método `getStatistics()` que retorne un Map con:
  - Total de tareas
  - Tareas completadas vs pendientes (con porcentajes)
  - Tareas por categoría
  - Tareas por prioridad

#### 4. Menú Interactivo (Obligatorio - 30 min)

- [ ] Menú principal con 8+ opciones
- [ ] Captura de entrada del usuario con `stdin.readLineSync()`
- [ ] Validación de opciones inválidas
- [ ] Loop continuo hasta que el usuario elija salir (opción 0)
- [ ] Mensajes claros y emojis para mejor UX
- [ ] Manejo de errores (ej: ID de tarea no existe, entrada inválida)

---

## 💻 Guía de Implementación

### Paso 1: Setup Inicial (5 min)

```bash
# Crear proyecto Dart
dart create -t console proyecto_tareas

cd proyecto_tareas

# Agregar dependencia para entrada de usuario
# Editar pubspec.yaml y agregar:
```

**pubspec.yaml:**

```yaml
name: proyecto_tareas
description: Sistema de gestión de tareas CLI
version: 1.0.0

environment:
  sdk: ^3.0.0

dependencies:
  # Sin dependencias extras necesarias
```

---

### Paso 2: Clase Task (20 min)

**Archivo:** `lib/models/task.dart`

```dart
/**
 * Clase Task - Representa una tarea en el sistema
 *
 * ¿Qué hace?
 * Modelo de datos para almacenar información de una tarea
 *
 * ¿Para qué?
 * Encapsular todos los datos relacionados con una tarea
 *
 * ¿Cómo funciona?
 * Usa enums para categoría y prioridad, garantizando valores válidos
 */

import 'dart:io';

enum Priority {
  High,
  Medium,
  Low;

  // Método helper para convertir int a Priority
  static Priority fromInt(int value) {
    switch (value) {
      case 1:
        return Priority.High;
      case 2:
        return Priority.Medium;
      case 3:
        return Priority.Low;
      default:
        return Priority.Medium;
    }
  }
}

enum Category {
  Work,
  Personal,
  Study;

  // Método helper para convertir int a Category
  static Category fromInt(int value) {
    switch (value) {
      case 1:
        return Category.Work;
      case 2:
        return Category.Personal;
      case 3:
        return Category.Study;
      default:
        return Category.Personal;
    }
  }
}

class Task {
  final int id;
  String title;
  String description;
  Category category;
  Priority priority;
  bool isCompleted;
  DateTime dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    this.isCompleted = false,
    required this.dueDate,
  });

  // Convertir prioridad a emoji
  String get priorityEmoji {
    switch (priority) {
      case Priority.High:
        return '🔥';
      case Priority.Medium:
        return '📌';
      case Priority.Low:
        return '💤';
    }
  }

  // Nombre de prioridad en español
  String get priorityName {
    switch (priority) {
      case Priority.High:
        return 'Alta';
      case Priority.Medium:
        return 'Media';
      case Priority.Low:
        return 'Baja';
    }
  }

  // Convertir categoría a emoji
  String get categoryEmoji {
    switch (category) {
      case Category.Work:
        return '💼';
      case Category.Personal:
        return '🏠';
      case Category.Study:
        return '📚';
    }
  }

  // Nombre de categoría en español
  String get categoryName {
    switch (category) {
      case Category.Work:
        return 'Trabajo';
      case Category.Personal:
        return 'Personal';
      case Category.Study:
        return 'Estudio';
    }
  }

  // Status emoji
  String get statusEmoji => isCompleted ? '✅' : '❌';

  // Valor numérico de prioridad para ordenamiento
  int get priorityValue {
    switch (priority) {
      case Priority.High:
        return 3;
      case Priority.Medium:
        return 2;
      case Priority.Low:
        return 1;
    }
  }

  @override
  String toString() {
    final dateStr = '${dueDate.year}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}';
    return '''
  [$id] $statusEmoji $title
      $categoryEmoji $categoryName | $priorityEmoji $priorityName | ⏰ $dateStr
      📝 $description
''';
  }

  // Versión compacta para listas
  String toCompactString() {
    return '[$id] $statusEmoji $title ($categoryEmoji $categoryName | $priorityEmoji $priorityName)';
  }
}
```

---

### Paso 3: TaskManager (40 min)

**Archivo:** `lib/services/task_manager.dart`

```dart
/**
 * TaskManager - Gestor de tareas del sistema
 *
 * ¿Qué hace?
 * Maneja todas las operaciones CRUD sobre tareas
 *
 * ¿Para qué?
 * Centralizar la lógica de negocio de gestión de tareas
 *
 * ¿Cómo funciona?
 * Mantiene una lista de tareas y proporciona métodos para manipularla
 */

import '../models/task.dart';

class TaskManager {
  final List<Task> _tasks = [];
  int _nextId = 1;

  // Agregar nueva tarea
  void addTask({
    required String title,
    required String description,
    required Category category,
    required Priority priority,
    required DateTime dueDate,
  }) {
    final task = Task(
      id: _nextId++,
      title: title,
      description: description,
      category: category,
      priority: priority,
      dueDate: dueDate,
    );

    _tasks.add(task);
    print('\n✅ Tarea agregada exitosamente: "$title"');
  }

  // Listar todas las tareas ordenadas por prioridad
  List<Task> listTasks() {
    final sortedTasks = List<Task>.from(_tasks);
    sortedTasks.sort((a, b) => b.priorityValue.compareTo(a.priorityValue));
    return sortedTasks;
  }

  // Obtener tarea por ID
  Task? getTaskById(int id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  // Marcar tarea como completada
  bool completeTask(int id) {
    final task = getTaskById(id);
    if (task == null) {
      print('\n❌ Error: No existe tarea con ID $id');
      return false;
    }

    if (task.isCompleted) {
      print('\n⚠️  La tarea "${ task.title}" ya estaba completada');
      return false;
    }

    task.isCompleted = true;
    print('\n✅ Tarea "${task.title}" marcada como completada');
    return true;
  }

  // Eliminar tarea
  bool deleteTask(int id) {
    final task = getTaskById(id);
    if (task == null) {
      print('\n❌ Error: No existe tarea con ID $id');
      return false;
    }

    _tasks.remove(task);
    print('\n🗑️  Tarea "${task.title}" eliminada exitosamente');
    return true;
  }

  // Filtrar por categoría
  List<Task> filterByCategory(Category category) {
    return _tasks.where((task) => task.category == category).toList();
  }

  // Filtrar por prioridad
  List<Task> filterByPriority(Priority priority) {
    return _tasks.where((task) => task.priority == priority).toList();
  }

  // Buscar tareas por texto
  List<Task> searchTasks(String query) {
    final lowerQuery = query.toLowerCase();
    return _tasks.where((task) {
      return task.title.toLowerCase().contains(lowerQuery) ||
             task.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Obtener estadísticas
  Map<String, dynamic> getStatistics() {
    final total = _tasks.length;
    final completed = _tasks.where((t) => t.isCompleted).length;
    final pending = total - completed;

    final completedPercent = total > 0 ? (completed / total * 100).toStringAsFixed(1) : '0.0';
    final pendingPercent = total > 0 ? (pending / total * 100).toStringAsFixed(1) : '0.0';

    // Contar por categoría
    final workTasks = _tasks.where((t) => t.category == Category.Work).length;
    final personalTasks = _tasks.where((t) => t.category == Category.Personal).length;
    final studyTasks = _tasks.where((t) => t.category == Category.Study).length;

    // Contar por prioridad
    final highPriority = _tasks.where((t) => t.priority == Priority.High).length;
    final mediumPriority = _tasks.where((t) => t.priority == Priority.Medium).length;
    final lowPriority = _tasks.where((t) => t.priority == Priority.Low).length;

    return {
      'total': total,
      'completed': completed,
      'pending': pending,
      'completedPercent': completedPercent,
      'pendingPercent': pendingPercent,
      'workTasks': workTasks,
      'personalTasks': personalTasks,
      'studyTasks': studyTasks,
      'highPriority': highPriority,
      'mediumPriority': mediumPriority,
      'lowPriority': lowPriority,
    };
  }

  // Mostrar tareas agrupadas por prioridad
  void displayTasksByPriority() {
    final highPriority = filterByPriority(Priority.High);
    final mediumPriority = filterByPriority(Priority.Medium);
    final lowPriority = filterByPriority(Priority.Low);

    print('\n' + '=' * 50);
    print('===== TAREAS POR PRIORIDAD =====');
    print('=' * 50);

    if (highPriority.isNotEmpty) {
      print('\n🔥 ALTA PRIORIDAD (${highPriority.length}):\n');
      for (var task in highPriority) {
        print(task);
      }
    }

    if (mediumPriority.isNotEmpty) {
      print('\n📌 MEDIA PRIORIDAD (${mediumPriority.length}):\n');
      for (var task in mediumPriority) {
        print(task);
      }
    }

    if (lowPriority.isNotEmpty) {
      print('\n💤 BAJA PRIORIDAD (${lowPriority.length}):\n');
      for (var task in lowPriority) {
        print(task);
      }
    }

    if (_tasks.isEmpty) {
      print('\n📭 No hay tareas registradas');
    }
  }

  // Mostrar estadísticas formateadas
  void displayStatistics() {
    final stats = getStatistics();

    print('\n' + '=' * 50);
    print('===== ESTADÍSTICAS =====');
    print('=' * 50);

    print('\n📊 Resumen General:');
    print('   Total de tareas: ${stats['total']}');
    print('   ✅ Completadas: ${stats['completed']} (${stats['completedPercent']}%)');
    print('   ❌ Pendientes: ${stats['pending']} (${stats['pendingPercent']}%)');

    print('\n📂 Por Categoría:');
    print('   💼 Trabajo: ${stats['workTasks']} tareas');
    print('   🏠 Personal: ${stats['personalTasks']} tareas');
    print('   📚 Estudio: ${stats['studyTasks']} tareas');

    print('\n🔥 Por Prioridad:');
    print('   Alta: ${stats['highPriority']} tareas');
    print('   Media: ${stats['mediumPriority']} tareas');
    print('   Baja: ${stats['lowPriority']} tareas');
  }
}
```

---

### Paso 4: Utilidades de Consola (20 min)

**Archivo:** `lib/utils/console_ui.dart`

```dart
/**
 * Utilidades de UI para consola
 *
 * ¿Qué hace?
 * Funciones helper para mejorar la interfaz de consola
 *
 * ¿Para qué?
 * Código más limpio y reutilizable para UI
 */

import 'dart:io';

class ConsoleUI {
  // Limpiar pantalla (funciona en la mayoría de terminales)
  static void clearScreen() {
    print('\x1B[2J\x1B[0;0H');
  }

  // Mostrar header principal
  static void showHeader() {
    print('\n' + '╔' + '═' * 48 + '╗');
    print('║   📝 SISTEMA DE GESTIÓN DE TAREAS            ║');
    print('╚' + '═' * 48 + '╝');
  }

  // Mostrar menú principal
  static void showMenu() {
    print('\n' + '=' * 50);
    print('===== MENÚ PRINCIPAL =====');
    print('=' * 50);
    print('1. 📋 Ver todas las tareas');
    print('2. ➕ Agregar nueva tarea');
    print('3. ✅ Marcar tarea como completada');
    print('4. 🗑️  Eliminar tarea');
    print('5. 🔍 Buscar tareas');
    print('6. 📊 Ver estadísticas');
    print('7. 🏷️  Filtrar por categoría');
    print('8. 🔥 Ver tareas por prioridad');
    print('0. 🚪 Salir');
    print('=' * 50);
  }

  // Leer entrada del usuario
  static String? readLine(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync();
  }

  // Leer número entero
  static int? readInt(String prompt) {
    final input = readLine(prompt);
    if (input == null) return null;
    return int.tryParse(input);
  }

  // Pausar ejecución
  static void pause() {
    print('\nPresiona Enter para continuar...');
    stdin.readLineSync();
  }

  // Mostrar mensaje de error
  static void showError(String message) {
    print('\n❌ Error: $message');
  }

  // Mostrar mensaje de éxito
  static void showSuccess(String message) {
    print('\n✅ $message');
  }
}
```

---

### Paso 5: Main con Menú Interactivo (30 min)

**Archivo:** `bin/main.dart`

```dart
/**
 * Sistema de Gestión de Tareas - Main
 *
 * Punto de entrada de la aplicación con menú interactivo
 */

import 'dart:io';
import 'package:proyecto_tareas/models/task.dart';
import 'package:proyecto_tareas/services/task_manager.dart';
import 'package:proyecto_tareas/utils/console_ui.dart';

void main() {
  final taskManager = TaskManager();

  // Agregar tareas de ejemplo
  _addSampleTasks(taskManager);

  // Loop principal
  bool running = true;

  while (running) {
    ConsoleUI.clearScreen();
    ConsoleUI.showHeader();
    ConsoleUI.showMenu();

    final option = ConsoleUI.readInt('\nSelecciona una opción: ');

    switch (option) {
      case 1:
        _viewAllTasks(taskManager);
        break;
      case 2:
        _addNewTask(taskManager);
        break;
      case 3:
        _completeTask(taskManager);
        break;
      case 4:
        _deleteTask(taskManager);
        break;
      case 5:
        _searchTasks(taskManager);
        break;
      case 6:
        _viewStatistics(taskManager);
        break;
      case 7:
        _filterByCategory(taskManager);
        break;
      case 8:
        _viewByPriority(taskManager);
        break;
      case 0:
        print('\n👋 ¡Hasta luego! Gracias por usar el sistema.');
        running = false;
        break;
      default:
        ConsoleUI.showError('Opción inválida. Por favor elige 0-8.');
        ConsoleUI.pause();
    }
  }
}

// Ver todas las tareas
void _viewAllTasks(TaskManager manager) {
  final tasks = manager.listTasks();

  print('\n' + '=' * 50);
  print('===== LISTA DE TAREAS =====');
  print('=' * 50);

  if (tasks.isEmpty) {
    print('\n📭 No hay tareas registradas');
  } else {
    for (var task in tasks) {
      print(task);
    }

    final total = tasks.length;
    final completed = tasks.where((t) => t.isCompleted).length;
    final pending = total - completed;

    print('\nTotal: $total tareas | ✅ $completed completada(s) | ❌ $pending pendiente(s)');
  }

  ConsoleUI.pause();
}

// Agregar nueva tarea
void _addNewTask(TaskManager manager) {
  print('\n' + '=' * 50);
  print('===== AGREGAR NUEVA TAREA =====');
  print('=' * 50);

  final title = ConsoleUI.readLine('\n📝 Título de la tarea: ');
  if (title == null || title.trim().isEmpty) {
    ConsoleUI.showError('El título no puede estar vacío');
    ConsoleUI.pause();
    return;
  }

  final description = ConsoleUI.readLine('📄 Descripción: ');
  if (description == null || description.trim().isEmpty) {
    ConsoleUI.showError('La descripción no puede estar vacía');
    ConsoleUI.pause();
    return;
  }

  // Seleccionar categoría
  print('\n📂 Categoría:');
  print('1. 💼 Trabajo');
  print('2. 🏠 Personal');
  print('3. 📚 Estudio');
  final categoryInput = ConsoleUI.readInt('Elige (1-3): ');
  final category = Category.fromInt(categoryInput ?? 2);

  // Seleccionar prioridad
  print('\n🔥 Prioridad:');
  print('1. 🔥 Alta');
  print('2. 📌 Media');
  print('3. 💤 Baja');
  final priorityInput = ConsoleUI.readInt('Elige (1-3): ');
  final priority = Priority.fromInt(priorityInput ?? 2);

  // Fecha de vencimiento
  print('\n⏰ Fecha de vencimiento (YYYY-MM-DD):');
  final dateStr = ConsoleUI.readLine('Fecha: ');
  DateTime dueDate;

  try {
    dueDate = DateTime.parse(dateStr ?? '');
  } catch (e) {
    print('⚠️  Fecha inválida, usando fecha actual');
    dueDate = DateTime.now();
  }

  // Agregar tarea
  manager.addTask(
    title: title.trim(),
    description: description.trim(),
    category: category,
    priority: priority,
    dueDate: dueDate,
  );

  ConsoleUI.pause();
}

// Completar tarea
void _completeTask(TaskManager manager) {
  print('\n' + '=' * 50);
  print('===== MARCAR COMO COMPLETADA =====');
  print('=' * 50);

  // Mostrar tareas pendientes
  final tasks = manager.listTasks().where((t) => !t.isCompleted).toList();

  if (tasks.isEmpty) {
    print('\n✅ No hay tareas pendientes');
    ConsoleUI.pause();
    return;
  }

  print('\n📋 Tareas pendientes:\n');
  for (var task in tasks) {
    print(task.toCompactString());
  }

  final id = ConsoleUI.readInt('\nID de la tarea a completar: ');
  if (id != null) {
    manager.completeTask(id);
  } else {
    ConsoleUI.showError('ID inválido');
  }

  ConsoleUI.pause();
}

// Eliminar tarea
void _deleteTask(TaskManager manager) {
  print('\n' + '=' * 50);
  print('===== ELIMINAR TAREA =====');
  print('=' * 50);

  final tasks = manager.listTasks();

  if (tasks.isEmpty) {
    print('\n📭 No hay tareas para eliminar');
    ConsoleUI.pause();
    return;
  }

  print('\n📋 Todas las tareas:\n');
  for (var task in tasks) {
    print(task.toCompactString());
  }

  final id = ConsoleUI.readInt('\nID de la tarea a eliminar: ');
  if (id != null) {
    final confirmation = ConsoleUI.readLine('¿Estás seguro? (s/n): ');
    if (confirmation?.toLowerCase() == 's') {
      manager.deleteTask(id);
    } else {
      print('\n❌ Operación cancelada');
    }
  } else {
    ConsoleUI.showError('ID inválido');
  }

  ConsoleUI.pause();
}

// Buscar tareas
void _searchTasks(TaskManager manager) {
  print('\n' + '=' * 50);
  print('===== BUSCAR TAREAS =====');
  print('=' * 50);

  final query = ConsoleUI.readLine('\n🔍 Buscar: ');
  if (query == null || query.trim().isEmpty) {
    ConsoleUI.showError('Debes ingresar un término de búsqueda');
    ConsoleUI.pause();
    return;
  }

  final results = manager.searchTasks(query);

  print('\n📋 Resultados (${results.length}):\n');

  if (results.isEmpty) {
    print('No se encontraron tareas con "$query"');
  } else {
    for (var task in results) {
      print(task);
    }
  }

  ConsoleUI.pause();
}

// Ver estadísticas
void _viewStatistics(TaskManager manager) {
  manager.displayStatistics();
  ConsoleUI.pause();
}

// Filtrar por categoría
void _filterByCategory(TaskManager manager) {
  print('\n' + '=' * 50);
  print('===== FILTRAR POR CATEGORÍA =====');
  print('=' * 50);

  print('\n📂 Elige una categoría:');
  print('1. 💼 Trabajo');
  print('2. 🏠 Personal');
  print('3. 📚 Estudio');

  final input = ConsoleUI.readInt('Opción: ');
  final category = Category.fromInt(input ?? 2);

  final tasks = manager.filterByCategory(category);

  print('\n📋 Tareas de ${category.name} (${tasks.length}):\n');

  if (tasks.isEmpty) {
    print('No hay tareas en esta categoría');
  } else {
    for (var task in tasks) {
      print(task);
    }
  }

  ConsoleUI.pause();
}

// Ver tareas por prioridad
void _viewByPriority(TaskManager manager) {
  manager.displayTasksByPriority();
  ConsoleUI.pause();
}

// Agregar tareas de ejemplo
void _addSampleTasks(TaskManager manager) {
  manager.addTask(
    title: 'Completar proyecto de Dart',
    description: 'Implementar todas las funcionalidades del sistema de tareas',
    category: Category.Work,
    priority: Priority.High,
    dueDate: DateTime.now().add(Duration(days: 2)),
  );

  manager.addTask(
    title: 'Estudiar colecciones en Dart',
    description: 'Repasar List, Set, Map y sus métodos',
    category: Category.Study,
    priority: Priority.Medium,
    dueDate: DateTime.now().add(Duration(days: 3)),
  );

  manager.addTask(
    title: 'Hacer ejercicio',
    description: 'Rutina de 30 minutos de cardio',
    category: Category.Personal,
    priority: Priority.Low,
    dueDate: DateTime.now(),
  );

  // Marcar una como completada
  manager.completeTask(3);
}
```

---

## 🏆 Criterios de Evaluación

### Funcionalidad (40 puntos)

| Criterio                                          | Puntos |
| ------------------------------------------------- | ------ |
| Clase Task con todos los atributos                | 5      |
| Enums Priority y Category                         | 3      |
| CRUD completo (agregar, listar, editar, eliminar) | 10     |
| Filtros por categoría y prioridad                 | 8      |
| Búsqueda por texto                                | 5      |
| Estadísticas completas                            | 5      |
| Menú interactivo funcionando                      | 4      |

### Calidad del Código (30 puntos)

| Criterio                          | Puntos |
| --------------------------------- | ------ |
| Estructura de archivos organizada | 5      |
| Código limpio y legible           | 5      |
| Comentarios explicativos          | 5      |
| Nomenclatura en inglés            | 5      |
| Manejo de errores                 | 5      |
| Uso correcto de tipos             | 5      |

### Mejores Prácticas (20 puntos)

| Criterio                                      | Puntos |
| --------------------------------------------- | ------ |
| Uso de funciones con parámetros nombrados     | 5      |
| Métodos bien documentados (qué/para qué/cómo) | 5      |
| Ordenamiento de tareas por prioridad          | 3      |
| UI de consola clara y amigable                | 4      |
| Validación de entradas del usuario            | 3      |

### Creatividad y Extras (10 puntos - Opcional)

| Criterio                                    | Puntos |
| ------------------------------------------- | ------ |
| Funcionalidad extra (persistencia, colores) | 5      |
| UI mejorada con bordes/decoraciones         | 3      |
| Características adicionales innovadoras     | 2      |

**Total: 100 puntos**

---

## 🎯 Checklist de Completitud

### Antes de Entregar:

- [ ] Clase `Task` implementada con todos los atributos
- [ ] Enums `Priority` y `Category` funcionando
- [ ] Clase `TaskManager` con todos los métodos CRUD
- [ ] Filtros por categoría y prioridad funcionando
- [ ] Búsqueda de tareas implementada
- [ ] Estadísticas mostrando toda la información requerida
- [ ] Menú interactivo con todas las opciones
- [ ] Manejo de errores en entrada de usuario
- [ ] Código documentado con comentarios qué/para qué/cómo
- [ ] Nomenclatura en inglés
- [ ] README.md con instrucciones de ejecución
- [ ] Código ejecutándose sin errores

---

## 📤 Forma de Entrega

### Repositorio GitHub:

1. Crea un repositorio llamado `dart-task-manager` o similar
2. Sube tu código con commits descriptivos
3. Include un README.md con:
   - Descripción del proyecto
   - Instrucciones de ejecución
   - Screenshots de la app funcionando
   - Características implementadas

### Comando para ejecutar:

```bash
dart run bin/main.dart
```

### Envía por la plataforma:

- Link del repositorio GitHub
- Screenshots de la aplicación funcionando
- Breve descripción de características extras (si las hay)

---

## 💡 Tips para el Éxito

1. **Comienza con lo básico**: Primero haz que funcione, luego mejora
2. **Prueba constantemente**: Ejecuta el programa después de cada cambio
3. **Usa los ejemplos de las prácticas**: Muchos conceptos ya los viste
4. **Divide y conquista**: Implementa una funcionalidad a la vez
5. **Pide ayuda si la necesitas**: Usa el foro, Slack o Discord
6. **Commits frecuentes**: No esperes a terminar todo para hacer commit
7. **Lee los errores**: Dart te da mensajes claros de qué está mal

---

## 🚀 Ideas para Extras (Opcionales)

Si terminas antes y quieres ir más allá:

1. **Persistencia**: Guardar tareas en archivo JSON
2. **Colores en consola**: Usar códigos ANSI para colores
3. **Editar tareas**: Permitir modificar tareas existentes
4. **Subtareas**: Sistema de tareas con subtareas
5. **Recordatorios**: Alertas para tareas próximas a vencer
6. **Etiquetas**: Sistema de tags adicionales
7. **Export**: Exportar tareas a CSV o TXT

---

## 📚 Recursos de Ayuda

- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Dart IO Library](https://api.dart.dev/stable/dart-io/dart-io-library.html)
- [DateTime in Dart](https://api.dart.dev/stable/dart-core/DateTime-class.html)
- Prácticas de la Semana 1 (colecciones, funciones)
- Ejemplos de código de las teorías

---

## 🆘 Problemas Comunes

### Error: "Unhandled exception"

- ✅ Agrega try-catch donde capturas entrada del usuario
- ✅ Valida que los IDs existan antes de usarlos

### Error: "The method 'readLineSync' was called on null"

- ✅ Verifica que importaste `dart:io`
- ✅ Usa `stdin.readLineSync()` correctamente

### Las tareas no se ordenan bien

- ✅ Revisa tu método `compareTo` en el ordenamiento
- ✅ Asegúrate de que `priorityValue` retorna valores correctos

### El menú se ejecuta una sola vez

- ✅ Verifica que tienes un `while (running)` loop
- ✅ Asegúrate de no poner `running = false` por error

---

**🎉 ¡Mucho éxito con tu proyecto!** Este es tu primer sistema completo en Dart. En la Semana 2 convertiremos estos conceptos en una app Flutter real.

---

_Documentación creada: Noviembre 2025_  
_Bootcamp Flutter - Semana 1: Fundamentos de Dart_
