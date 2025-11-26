# 🛠️ Práctica 01: Estructura Clean Architecture

## 📋 Información

| Campo | Detalle |
|-------|---------|
| **Nivel** | Intermedio |
| **Duración** | 45 minutos |
| **Requisitos** | Dart, Flutter básico |

---

## 🎯 Objetivos

- Implementar la estructura de carpetas de Clean Architecture
- Crear entidades del dominio
- Definir interfaces de repositorio
- Implementar casos de uso

---

## 📝 Descripción

En esta práctica crearás la **estructura base** de una aplicación de tareas siguiendo los principios de **Clean Architecture**. Te enfocarás en la **capa de dominio**, que es el corazón de la arquitectura.

---

## 🔨 Ejercicio

### Parte 1: Estructura de Carpetas

Crea la siguiente estructura en tu proyecto:

```
lib/
├── core/
│   ├── error/
│   │   ├── failures.dart
│   │   └── exceptions.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── constants/
│       └── app_constants.dart
├── features/
│   └── task/
│       ├── domain/
│       │   ├── entities/
│       │   │   └── task.dart
│       │   ├── repositories/
│       │   │   └── task_repository.dart
│       │   └── usecases/
│       │       ├── get_tasks.dart
│       │       ├── create_task.dart
│       │       ├── update_task.dart
│       │       └── delete_task.dart
│       ├── data/
│       │   ├── models/
│       │   ├── datasources/
│       │   └── repositories/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
└── main.dart
```

### Parte 2: Implementar Core

**lib/core/error/failures.dart**

```dart
/// Clase base abstracta para todos los fallos de la aplicación.
///
/// Proporciona una interfaz común para manejar errores de negocio
/// de manera consistente en toda la aplicación.
///
/// Ejemplo de uso:
/// ```dart
/// final Either<Failure, User> result = await repository.getUser(id);
/// result.fold(
///   (failure) => print(failure.message),
///   (user) => print(user.name),
/// );
/// ```
abstract class Failure {
  final String message;
  final int? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Fallo de servidor - problemas de conexión o respuesta del backend.
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Error de servidor',
    super.code,
  });
}

/// Fallo de cache - problemas con almacenamiento local.
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Error de caché local',
    super.code,
  });
}

/// Fallo de red - sin conexión a internet.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Sin conexión a internet',
    super.code,
  });
}

/// Fallo de validación - datos inválidos.
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}
```

**lib/core/error/exceptions.dart**

```dart
/// Excepción lanzada cuando hay un error del servidor.
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({
    this.message = 'Error de servidor',
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

/// Excepción lanzada cuando hay un error de caché.
class CacheException implements Exception {
  final String message;

  const CacheException({
    this.message = 'Error de caché',
  });

  @override
  String toString() => 'CacheException: $message';
}

/// Excepción lanzada cuando no hay conexión a internet.
class NetworkException implements Exception {
  final String message;

  const NetworkException({
    this.message = 'Sin conexión a internet',
  });

  @override
  String toString() => 'NetworkException: $message';
}
```

**lib/core/usecases/usecase.dart**

```dart
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Interfaz base para todos los casos de uso.
///
/// Define un contrato común que todos los casos de uso deben seguir,
/// facilitando el testing y manteniendo consistencia.
///
/// Tipo [T]: El tipo de dato que retorna el caso de uso.
/// Tipo [Params]: Los parámetros que necesita el caso de uso.
///
/// Ejemplo:
/// ```dart
/// class GetUser implements UseCase<User, GetUserParams> {
///   @override
///   Future<Either<Failure, User>> call(GetUserParams params) async {
///     return await repository.getUser(params.id);
///   }
/// }
/// ```
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Clase para casos de uso que no requieren parámetros.
class NoParams {
  const NoParams();
}
```

### Parte 3: Implementar Entidad Task

**lib/features/task/domain/entities/task.dart**

```dart
import 'package:equatable/equatable.dart';

/// Entidad que representa una tarea en el dominio.
///
/// Esta es una entidad de negocio pura, sin dependencias de
/// frameworks o implementaciones específicas.
///
/// Principio: Las entidades son el corazón de la aplicación y
/// no deben cambiar por razones externas (UI, BD, etc.).
class Task extends Equatable {
  /// Identificador único de la tarea.
  final String id;

  /// Título descriptivo de la tarea.
  final String title;

  /// Descripción detallada (opcional).
  final String? description;

  /// Indica si la tarea está completada.
  final bool isCompleted;

  /// Fecha de creación de la tarea.
  final DateTime createdAt;

  /// Fecha de vencimiento (opcional).
  final DateTime? dueDate;

  /// Prioridad de la tarea.
  final TaskPriority priority;

  /// Constructor constante para inmutabilidad.
  const Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
    this.priority = TaskPriority.medium,
  });

  /// Crea una copia de la tarea con valores modificados.
  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    TaskPriority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }

  /// Propiedades usadas para comparación de igualdad.
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
        createdAt,
        dueDate,
        priority,
      ];
}

/// Enum que representa los niveles de prioridad.
enum TaskPriority {
  low,
  medium,
  high,
}
```

### Parte 4: Implementar Repositorio (Interfaz)

**lib/features/task/domain/repositories/task_repository.dart**

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/task.dart';

/// Interfaz abstracta del repositorio de tareas.
///
/// Define el contrato que debe cumplir cualquier implementación
/// del repositorio, ya sea local, remota o híbrida.
///
/// Beneficios:
/// - Inversión de dependencias (DIP)
/// - Facilita testing con mocks
/// - Permite cambiar implementación sin afectar el dominio
abstract class TaskRepository {
  /// Obtiene todas las tareas.
  ///
  /// Retorna [Right<List<Task>>] si tiene éxito.
  /// Retorna [Left<Failure>] si hay un error.
  Future<Either<Failure, List<Task>>> getTasks();

  /// Obtiene una tarea por su ID.
  ///
  /// [id] - Identificador único de la tarea.
  Future<Either<Failure, Task>> getTaskById(String id);

  /// Crea una nueva tarea.
  ///
  /// [task] - La tarea a crear (sin ID, se genera automáticamente).
  Future<Either<Failure, Task>> createTask(Task task);

  /// Actualiza una tarea existente.
  ///
  /// [task] - La tarea con los datos actualizados.
  Future<Either<Failure, Task>> updateTask(Task task);

  /// Elimina una tarea.
  ///
  /// [id] - Identificador de la tarea a eliminar.
  Future<Either<Failure, void>> deleteTask(String id);

  /// Marca una tarea como completada o pendiente.
  ///
  /// [id] - Identificador de la tarea.
  /// [isCompleted] - Nuevo estado de completitud.
  Future<Either<Failure, Task>> toggleTaskCompletion(
    String id,
    bool isCompleted,
  );

  /// Obtiene tareas filtradas por estado de completitud.
  ///
  /// [isCompleted] - Filtrar por completadas (true) o pendientes (false).
  Future<Either<Failure, List<Task>>> getTasksByStatus(bool isCompleted);
}
```

### Parte 5: Implementar Casos de Uso

**lib/features/task/domain/usecases/get_tasks.dart**

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Caso de uso para obtener todas las tareas.
///
/// Encapsula la lógica de negocio para recuperar la lista de tareas.
/// Sigue el principio de responsabilidad única (SRP).
class GetTasks implements UseCase<List<Task>, NoParams> {
  final TaskRepository repository;

  /// Constructor que recibe el repositorio por inyección de dependencias.
  const GetTasks(this.repository);

  /// Ejecuta el caso de uso.
  ///
  /// Retorna [Either<Failure, List<Task>>]:
  /// - Right: Lista de tareas obtenidas exitosamente
  /// - Left: Fallo con información del error
  @override
  Future<Either<Failure, List<Task>>> call(NoParams params) async {
    return await repository.getTasks();
  }
}
```

**lib/features/task/domain/usecases/create_task.dart**

```dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Caso de uso para crear una nueva tarea.
class CreateTask implements UseCase<Task, CreateTaskParams> {
  final TaskRepository repository;

  const CreateTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(CreateTaskParams params) async {
    // Validación de negocio
    if (params.title.trim().isEmpty) {
      return const Left(ValidationFailure(
        message: 'El título no puede estar vacío',
      ));
    }

    // Crear entidad Task
    final task = Task(
      id: '', // El repositorio generará el ID
      title: params.title.trim(),
      description: params.description?.trim(),
      createdAt: DateTime.now(),
      dueDate: params.dueDate,
      priority: params.priority,
    );

    return await repository.createTask(task);
  }
}

/// Parámetros para crear una tarea.
class CreateTaskParams extends Equatable {
  final String title;
  final String? description;
  final DateTime? dueDate;
  final TaskPriority priority;

  const CreateTaskParams({
    required this.title,
    this.description,
    this.dueDate,
    this.priority = TaskPriority.medium,
  });

  @override
  List<Object?> get props => [title, description, dueDate, priority];
}
```

**lib/features/task/domain/usecases/update_task.dart**

```dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Caso de uso para actualizar una tarea existente.
class UpdateTask implements UseCase<Task, UpdateTaskParams> {
  final TaskRepository repository;

  const UpdateTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(UpdateTaskParams params) async {
    if (params.task.title.trim().isEmpty) {
      return const Left(ValidationFailure(
        message: 'El título no puede estar vacío',
      ));
    }

    return await repository.updateTask(params.task);
  }
}

/// Parámetros para actualizar una tarea.
class UpdateTaskParams extends Equatable {
  final Task task;

  const UpdateTaskParams({required this.task});

  @override
  List<Object?> get props => [task];
}
```

**lib/features/task/domain/usecases/delete_task.dart**

```dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

/// Caso de uso para eliminar una tarea.
class DeleteTask implements UseCase<void, DeleteTaskParams> {
  final TaskRepository repository;

  const DeleteTask(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTaskParams params) async {
    if (params.id.isEmpty) {
      return const Left(ValidationFailure(
        message: 'El ID de la tarea es requerido',
      ));
    }

    return await repository.deleteTask(params.id);
  }
}

/// Parámetros para eliminar una tarea.
class DeleteTaskParams extends Equatable {
  final String id;

  const DeleteTaskParams({required this.id});

  @override
  List<Object?> get props => [id];
}
```

---

## ✅ Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| Estructura de carpetas correcta | 20 |
| Failures y Exceptions implementados | 15 |
| UseCase base con Either | 15 |
| Entidad Task con Equatable | 20 |
| Repositorio con todas las operaciones | 15 |
| Casos de uso con validaciones | 15 |
| **Total** | **100** |

---

## 🎁 Bonus

1. Agregar entidad `Category` para categorizar tareas
2. Crear caso de uso `GetTasksByPriority`
3. Implementar `TaskFilter` con múltiples criterios
4. Agregar validación de fecha (dueDate no puede ser pasada)

---

## 📚 Recursos

- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [dartz package](https://pub.dev/packages/dartz)
- [equatable package](https://pub.dev/packages/equatable)
