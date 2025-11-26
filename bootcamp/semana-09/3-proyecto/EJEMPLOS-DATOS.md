# 📊 Ejemplos de Datos - TaskManager Pro

## 📋 Contenido

1. [Entidades de Dominio](#-entidades-de-dominio)
2. [Modelos de Datos](#-modelos-de-datos)
3. [Datos de Prueba](#-datos-de-prueba)
4. [Mocks para Testing](#-mocks-para-testing)
5. [Fixtures JSON](#-fixtures-json)

---

## 🏛️ Entidades de Dominio

### Task Entity

```dart
// lib/features/task/domain/entities/task.dart

import 'package:equatable/equatable.dart';

/// Entidad Task del dominio.
///
/// Representa una tarea en la aplicación.
/// Inmutable y usa Equatable para comparaciones.
class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;
  final TaskPriority priority;
  final String? categoryId;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.categoryId,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    TaskPriority? priority,
    String? categoryId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
    id, title, description, isCompleted,
    createdAt, dueDate, priority, categoryId,
  ];
}

/// Niveles de prioridad de tarea.
enum TaskPriority {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case TaskPriority.low:
        return 'Baja';
      case TaskPriority.medium:
        return 'Media';
      case TaskPriority.high:
        return 'Alta';
    }
  }
}
```

### Category Entity

```dart
// lib/features/task/domain/entities/category.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Entidad Category del dominio.
///
/// Permite organizar tareas en grupos.
class Category extends Equatable {
  final String id;
  final String name;
  final Color color;
  final IconData icon;

  const Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  Category copyWith({
    String? id,
    String? name,
    Color? color,
    IconData? icon,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  @override
  List<Object?> get props => [id, name, color, icon];
}
```

---

## 💾 Modelos de Datos

### TaskModel

```dart
// lib/features/task/data/models/task_model.dart

import '../../domain/entities/task.dart';

/// Modelo de datos para persistencia de Task.
class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    super.description,
    super.isCompleted,
    required super.createdAt,
    super.dueDate,
    super.priority,
    super.categoryId,
  });

  /// Crea TaskModel desde JSON (SQLite).
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isCompleted: (json['is_completed'] as int) == 1,
      createdAt: DateTime.parse(json['created_at'] as String),
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      priority: TaskPriority.values[json['priority'] as int],
      categoryId: json['category_id'] as String?,
    );
  }

  /// Convierte a JSON para SQLite.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'priority': priority.index,
      'category_id': categoryId,
    };
  }

  /// Crea TaskModel desde entidad Task.
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      dueDate: task.dueDate,
      priority: task.priority,
      categoryId: task.categoryId,
    );
  }
}
```

### CategoryModel

```dart
// lib/features/task/data/models/category_model.dart

import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';

/// Modelo de datos para persistencia de Category.
class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.color,
    required super.icon,
  });

  /// Crea CategoryModel desde JSON.
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: Color(json['color'] as int),
      icon: IconData(
        json['icon'] as int,
        fontFamily: 'MaterialIcons',
      ),
    );
  }

  /// Convierte a JSON para SQLite.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
      'icon': icon.codePoint,
    };
  }

  /// Crea CategoryModel desde entidad.
  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      color: category.color,
      icon: category.icon,
    );
  }
}
```

---

## 🧪 Datos de Prueba

### Tareas de Ejemplo

```dart
// test/fixtures/task_fixtures.dart

import 'package:task_manager/features/task/domain/entities/task.dart';

/// Datos de prueba para tests.
class TaskFixtures {
  // Tarea básica pendiente
  static final basicTask = Task(
    id: 'task-001',
    title: 'Comprar víveres',
    description: 'Ir al supermercado a comprar frutas y verduras',
    isCompleted: false,
    createdAt: DateTime(2024, 1, 15, 10, 30),
    dueDate: DateTime(2024, 1, 16, 18, 0),
    priority: TaskPriority.high,
    categoryId: 'cat-personal',
  );

  // Tarea completada
  static final completedTask = Task(
    id: 'task-002',
    title: 'Enviar reporte semanal',
    description: 'Preparar y enviar el reporte de ventas',
    isCompleted: true,
    createdAt: DateTime(2024, 1, 10, 9, 0),
    dueDate: DateTime(2024, 1, 12, 17, 0),
    priority: TaskPriority.medium,
    categoryId: 'cat-trabajo',
  );

  // Tarea sin descripción
  static final taskWithoutDescription = Task(
    id: 'task-003',
    title: 'Llamar al dentista',
    isCompleted: false,
    createdAt: DateTime(2024, 1, 14, 14, 0),
    priority: TaskPriority.low,
  );

  // Tarea sin fecha límite
  static final taskWithoutDueDate = Task(
    id: 'task-004',
    title: 'Leer libro de arquitectura',
    description: 'Clean Architecture de Robert C. Martin',
    isCompleted: false,
    createdAt: DateTime(2024, 1, 1, 12, 0),
    priority: TaskPriority.low,
    categoryId: 'cat-estudio',
  );

  // Tarea urgente
  static final urgentTask = Task(
    id: 'task-005',
    title: 'Pagar facturas',
    description: 'Pagar luz, agua y gas antes del vencimiento',
    isCompleted: false,
    createdAt: DateTime(2024, 1, 15, 8, 0),
    dueDate: DateTime(2024, 1, 15, 23, 59),
    priority: TaskPriority.high,
    categoryId: 'cat-personal',
  );

  // Lista de tareas para tests de lista
  static final taskList = [
    basicTask,
    completedTask,
    taskWithoutDescription,
    taskWithoutDueDate,
    urgentTask,
  ];

  // Lista vacía
  static const emptyList = <Task>[];

  // Lista solo con pendientes
  static List<Task> get pendingTasks =>
      taskList.where((t) => !t.isCompleted).toList();

  // Lista solo con completadas
  static List<Task> get completedTasks =>
      taskList.where((t) => t.isCompleted).toList();

  // Lista por prioridad
  static List<Task> get highPriorityTasks =>
      taskList.where((t) => t.priority == TaskPriority.high).toList();
}
```

### Categorías de Ejemplo

```dart
// test/fixtures/category_fixtures.dart

import 'package:flutter/material.dart';
import 'package:task_manager/features/task/domain/entities/category.dart';

/// Datos de prueba para categorías.
class CategoryFixtures {
  static const personal = Category(
    id: 'cat-personal',
    name: 'Personal',
    color: Colors.blue,
    icon: Icons.person,
  );

  static const trabajo = Category(
    id: 'cat-trabajo',
    name: 'Trabajo',
    color: Colors.orange,
    icon: Icons.work,
  );

  static const estudio = Category(
    id: 'cat-estudio',
    name: 'Estudio',
    color: Colors.green,
    icon: Icons.school,
  );

  static const salud = Category(
    id: 'cat-salud',
    name: 'Salud',
    color: Colors.red,
    icon: Icons.favorite,
  );

  static const categoryList = [
    personal,
    trabajo,
    estudio,
    salud,
  ];
}
```

---

## 🎭 Mocks para Testing

### Mock del Repositorio

```dart
// test/mocks/mock_task_repository.dart

import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/features/task/domain/entities/task.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';
import '../fixtures/task_fixtures.dart';

@GenerateMocks([TaskRepository])
import 'mock_task_repository.mocks.dart';

/// Helper para configurar mocks de TaskRepository.
class TaskRepositoryMockHelper {
  final MockTaskRepository mockRepository;

  TaskRepositoryMockHelper(this.mockRepository);

  /// Configura mock para retornar lista de tareas exitosamente.
  void whenGetTasksSuccess([List<Task>? tasks]) {
    when(mockRepository.getTasks()).thenAnswer(
      (_) async => Right(tasks ?? TaskFixtures.taskList),
    );
  }

  /// Configura mock para retornar error en getTasks.
  void whenGetTasksFailure([Failure? failure]) {
    when(mockRepository.getTasks()).thenAnswer(
      (_) async => Left(failure ?? const ServerFailure()),
    );
  }

  /// Configura mock para crear tarea exitosamente.
  void whenCreateTaskSuccess(Task taskToReturn) {
    when(mockRepository.createTask(any)).thenAnswer(
      (_) async => Right(taskToReturn),
    );
  }

  /// Configura mock para error al crear tarea.
  void whenCreateTaskFailure([Failure? failure]) {
    when(mockRepository.createTask(any)).thenAnswer(
      (_) async => Left(failure ?? const ServerFailure()),
    );
  }

  /// Configura mock para actualizar tarea exitosamente.
  void whenUpdateTaskSuccess(Task updatedTask) {
    when(mockRepository.updateTask(any)).thenAnswer(
      (_) async => Right(updatedTask),
    );
  }

  /// Configura mock para eliminar tarea exitosamente.
  void whenDeleteTaskSuccess() {
    when(mockRepository.deleteTask(any)).thenAnswer(
      (_) async => const Right(null),
    );
  }
}
```

### Mock del Data Source

```dart
// test/mocks/mock_local_datasource.dart

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/task/data/datasources/task_local_datasource.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import '../fixtures/task_fixtures.dart';

@GenerateMocks([TaskLocalDataSource])
import 'mock_local_datasource.mocks.dart';

/// Helper para configurar mocks del LocalDataSource.
class LocalDataSourceMockHelper {
  final MockTaskLocalDataSource mockDataSource;

  LocalDataSourceMockHelper(this.mockDataSource);

  /// Retorna lista de TaskModel.
  void whenGetTasksSuccess([List<TaskModel>? models]) {
    final taskModels = models ??
        TaskFixtures.taskList
            .map((t) => TaskModel.fromEntity(t))
            .toList();

    when(mockDataSource.getTasks()).thenAnswer(
      (_) async => taskModels,
    );
  }

  /// Lanza excepción al obtener tareas.
  void whenGetTasksThrows([Exception? exception]) {
    when(mockDataSource.getTasks()).thenThrow(
      exception ?? Exception('Database error'),
    );
  }

  /// Retorna TaskModel al crear.
  void whenCreateTaskSuccess(TaskModel model) {
    when(mockDataSource.createTask(any)).thenAnswer(
      (_) async => model,
    );
  }
}
```

---

## 📄 Fixtures JSON

### tasks.json

```json
{
  "tasks": [
    {
      "id": "task-001",
      "title": "Comprar víveres",
      "description": "Ir al supermercado a comprar frutas y verduras",
      "is_completed": 0,
      "created_at": "2024-01-15T10:30:00.000Z",
      "due_date": "2024-01-16T18:00:00.000Z",
      "priority": 2,
      "category_id": "cat-personal"
    },
    {
      "id": "task-002",
      "title": "Enviar reporte semanal",
      "description": "Preparar y enviar el reporte de ventas",
      "is_completed": 1,
      "created_at": "2024-01-10T09:00:00.000Z",
      "due_date": "2024-01-12T17:00:00.000Z",
      "priority": 1,
      "category_id": "cat-trabajo"
    },
    {
      "id": "task-003",
      "title": "Llamar al dentista",
      "description": null,
      "is_completed": 0,
      "created_at": "2024-01-14T14:00:00.000Z",
      "due_date": null,
      "priority": 0,
      "category_id": null
    }
  ]
}
```

### categories.json

```json
{
  "categories": [
    {
      "id": "cat-personal",
      "name": "Personal",
      "color": 4280391411,
      "icon": 59389
    },
    {
      "id": "cat-trabajo",
      "name": "Trabajo",
      "color": 4294940672,
      "icon": 59475
    },
    {
      "id": "cat-estudio",
      "name": "Estudio",
      "color": 4283215696,
      "icon": 59404
    }
  ]
}
```

### Cargar Fixtures en Tests

```dart
// test/helpers/fixture_loader.dart

import 'dart:convert';
import 'dart:io';

/// Carga fixtures JSON para tests.
class FixtureLoader {
  /// Lee un archivo JSON de fixtures.
  static Map<String, dynamic> loadJson(String fileName) {
    final file = File('test/fixtures/$fileName');
    return json.decode(file.readAsStringSync()) as Map<String, dynamic>;
  }

  /// Carga lista de tareas desde JSON.
  static List<Map<String, dynamic>> loadTasks() {
    final data = loadJson('tasks.json');
    return (data['tasks'] as List).cast<Map<String, dynamic>>();
  }

  /// Carga lista de categorías desde JSON.
  static List<Map<String, dynamic>> loadCategories() {
    final data = loadJson('categories.json');
    return (data['categories'] as List).cast<Map<String, dynamic>>();
  }
}

// Uso en tests:
// final tasksJson = FixtureLoader.loadTasks();
// final taskModels = tasksJson.map((j) => TaskModel.fromJson(j)).toList();
```

---

## 🗄️ Schema de Base de Datos

### SQLite Schema

```sql
-- Tabla de tareas
CREATE TABLE tasks (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    is_completed INTEGER NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL,
    due_date TEXT,
    priority INTEGER NOT NULL DEFAULT 1,
    category_id TEXT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Tabla de categorías
CREATE TABLE categories (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    color INTEGER NOT NULL,
    icon INTEGER NOT NULL
);

-- Índices para optimización
CREATE INDEX idx_tasks_is_completed ON tasks(is_completed);
CREATE INDEX idx_tasks_priority ON tasks(priority);
CREATE INDEX idx_tasks_due_date ON tasks(due_date);
CREATE INDEX idx_tasks_category_id ON tasks(category_id);
```

### Implementación SQLite

```dart
// lib/features/task/data/datasources/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Helper para operaciones de base de datos SQLite.
class DatabaseHelper {
  static const _databaseName = 'task_manager.db';
  static const _databaseVersion = 1;

  // Singleton
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        is_completed INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        due_date TEXT,
        priority INTEGER NOT NULL DEFAULT 1,
        category_id TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        color INTEGER NOT NULL,
        icon INTEGER NOT NULL
      )
    ''');

    // Crear índices
    await db.execute(
      'CREATE INDEX idx_tasks_is_completed ON tasks(is_completed)',
    );
    await db.execute(
      'CREATE INDEX idx_tasks_priority ON tasks(priority)',
    );
  }
}
```

---

> **Nota**: Usa estos datos de ejemplo para tus tests y para pre-poblar la base de datos durante el desarrollo.
