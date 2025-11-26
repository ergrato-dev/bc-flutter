# 🧊 Práctica 04: BLoC Tests

## 📋 Información

| Campo          | Detalle                  |
| -------------- | ------------------------ |
| **Nivel**      | Avanzado                 |
| **Duración**   | 50 minutos               |
| **Requisitos** | BLoC, bloc_test, Mockito |

---

## 🎯 Objetivos

- Testear BLoCs con bloc_test
- Verificar transiciones de estado
- Mockear dependencias del BLoC
- Testear manejo de errores

---

## 📝 Descripción

Crearás **tests completos para un BLoC** de tareas usando el paquete `bloc_test`. Aprenderás a verificar eventos, estados y transiciones.

---

## 🔨 Ejercicio

### Parte 1: Configuración

**pubspec.yaml**

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  dartz: ^0.10.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.5
  mockito: ^5.4.4
  build_runner: ^2.4.7
```

### Parte 2: Implementar TaskBloc

**lib/features/task/presentation/bloc/task_event.dart**

```dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

/// Clase base para todos los eventos del TaskBloc.
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar todas las tareas.
class LoadTasks extends TaskEvent {
  const LoadTasks();
}

/// Evento para crear una nueva tarea.
class CreateTaskEvent extends TaskEvent {
  final String title;
  final String? description;
  final TaskPriority priority;

  const CreateTaskEvent({
    required this.title,
    this.description,
    this.priority = TaskPriority.medium,
  });

  @override
  List<Object?> get props => [title, description, priority];
}

/// Evento para actualizar una tarea.
class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

/// Evento para eliminar una tarea.
class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

/// Evento para cambiar estado de completitud.
class ToggleTaskEvent extends TaskEvent {
  final String taskId;

  const ToggleTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}
```

**lib/features/task/presentation/bloc/task_state.dart**

```dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

/// Clase base para todos los estados del TaskBloc.
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial.
class TaskInitial extends TaskState {
  const TaskInitial();
}

/// Estado de carga.
class TaskLoading extends TaskState {
  const TaskLoading();
}

/// Estado con lista de tareas cargadas.
class TasksLoaded extends TaskState {
  final List<Task> tasks;

  const TasksLoaded(this.tasks);

  /// Tareas pendientes.
  List<Task> get pendingTasks =>
      tasks.where((t) => !t.isCompleted).toList();

  /// Tareas completadas.
  List<Task> get completedTasks =>
      tasks.where((t) => t.isCompleted).toList();

  @override
  List<Object?> get props => [tasks];
}

/// Estado de error.
class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Estado de operación exitosa (para snackbar/toast).
class TaskOperationSuccess extends TaskState {
  final String message;
  final List<Task> tasks;

  const TaskOperationSuccess({
    required this.message,
    required this.tasks,
  });

  @override
  List<Object?> get props => [message, tasks];
}
```

**lib/features/task/presentation/bloc/task_bloc.dart**

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';
import '../../../../core/usecases/usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

/// BLoC para gestionar el estado de las tareas.
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(const TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleTaskEvent>(_onToggleTask);
  }

  /// Lista interna de tareas para mantener estado.
  List<Task> _tasks = [];

  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoading());

    final result = await getTasks(const NoParams());

    result.fold(
      (failure) => emit(TaskError(failure.message)),
      (tasks) {
        _tasks = tasks;
        emit(TasksLoaded(tasks));
      },
    );
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoading());

    final params = CreateTaskParams(
      title: event.title,
      description: event.description,
      priority: event.priority,
    );

    final result = await createTask(params);

    result.fold(
      (failure) => emit(TaskError(failure.message)),
      (task) {
        _tasks = [..._tasks, task];
        emit(TaskOperationSuccess(
          message: 'Tarea creada exitosamente',
          tasks: _tasks,
        ));
      },
    );
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoading());

    final params = UpdateTaskParams(task: event.task);
    final result = await updateTask(params);

    result.fold(
      (failure) => emit(TaskError(failure.message)),
      (task) {
        _tasks = _tasks.map((t) => t.id == task.id ? task : t).toList();
        emit(TaskOperationSuccess(
          message: 'Tarea actualizada',
          tasks: _tasks,
        ));
      },
    );
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoading());

    final params = DeleteTaskParams(id: event.taskId);
    final result = await deleteTask(params);

    result.fold(
      (failure) => emit(TaskError(failure.message)),
      (_) {
        _tasks = _tasks.where((t) => t.id != event.taskId).toList();
        emit(TaskOperationSuccess(
          message: 'Tarea eliminada',
          tasks: _tasks,
        ));
      },
    );
  }

  Future<void> _onToggleTask(
    ToggleTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final taskIndex = _tasks.indexWhere((t) => t.id == event.taskId);
    if (taskIndex == -1) {
      emit(const TaskError('Tarea no encontrada'));
      return;
    }

    final task = _tasks[taskIndex];
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);

    add(UpdateTaskEvent(updatedTask));
  }
}
```

### Parte 3: Tests del TaskBloc

**test/features/task/presentation/bloc/task_bloc_test.dart**

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tu_app/core/error/failures.dart';
import 'package:tu_app/core/usecases/usecase.dart';
import 'package:tu_app/features/task/domain/entities/task.dart';
import 'package:tu_app/features/task/domain/usecases/create_task.dart';
import 'package:tu_app/features/task/domain/usecases/delete_task.dart';
import 'package:tu_app/features/task/domain/usecases/get_tasks.dart';
import 'package:tu_app/features/task/domain/usecases/update_task.dart';
import 'package:tu_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:tu_app/features/task/presentation/bloc/task_event.dart';
import 'package:tu_app/features/task/presentation/bloc/task_state.dart';

@GenerateMocks([GetTasks, CreateTask, UpdateTask, DeleteTask])
import 'task_bloc_test.mocks.dart';

void main() {
  late TaskBloc bloc;
  late MockGetTasks mockGetTasks;
  late MockCreateTask mockCreateTask;
  late MockUpdateTask mockUpdateTask;
  late MockDeleteTask mockDeleteTask;

  setUp(() {
    mockGetTasks = MockGetTasks();
    mockCreateTask = MockCreateTask();
    mockUpdateTask = MockUpdateTask();
    mockDeleteTask = MockDeleteTask();

    bloc = TaskBloc(
      getTasks: mockGetTasks,
      createTask: mockCreateTask,
      updateTask: mockUpdateTask,
      deleteTask: mockDeleteTask,
    );
  });

  tearDown(() {
    bloc.close();
  });

  // Datos de prueba
  final tTasks = [
    Task(
      id: '1',
      title: 'Task 1',
      createdAt: DateTime(2024, 1, 1),
    ),
    Task(
      id: '2',
      title: 'Task 2',
      isCompleted: true,
      createdAt: DateTime(2024, 1, 2),
    ),
  ];

  final tNewTask = Task(
    id: '3',
    title: 'New Task',
    createdAt: DateTime(2024, 1, 3),
  );

  // ═══════════════════════════════════════════════════════════════
  // TESTS INICIALES
  // ═══════════════════════════════════════════════════════════════

  group('Initial State', () {
    test('should have TaskInitial as initial state', () {
      expect(bloc.state, const TaskInitial());
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TESTS: LoadTasks
  // ═══════════════════════════════════════════════════════════════

  group('LoadTasks', () {
    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TasksLoaded] when getTasks succeeds',
      build: () {
        when(mockGetTasks(const NoParams()))
            .thenAnswer((_) async => Right(tTasks));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadTasks()),
      expect: () => [
        const TaskLoading(),
        TasksLoaded(tTasks),
      ],
      verify: (_) {
        verify(mockGetTasks(const NoParams())).called(1);
      },
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskError] when getTasks fails',
      build: () {
        when(mockGetTasks(const NoParams())).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadTasks()),
      expect: () => [
        const TaskLoading(),
        const TaskError('Server error'),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TasksLoaded] with empty list when no tasks',
      build: () {
        when(mockGetTasks(const NoParams()))
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadTasks()),
      expect: () => [
        const TaskLoading(),
        const TasksLoaded([]),
      ],
    );
  });

  // ═══════════════════════════════════════════════════════════════
  // TESTS: CreateTaskEvent
  // ═══════════════════════════════════════════════════════════════

  group('CreateTaskEvent', () {
    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskOperationSuccess] when createTask succeeds',
      build: () {
        when(mockCreateTask(any)).thenAnswer((_) async => Right(tNewTask));
        return bloc;
      },
      act: (bloc) => bloc.add(const CreateTaskEvent(
        title: 'New Task',
        description: 'Description',
        priority: TaskPriority.high,
      )),
      expect: () => [
        const TaskLoading(),
        isA<TaskOperationSuccess>()
            .having((s) => s.message, 'message', 'Tarea creada exitosamente')
            .having((s) => s.tasks.length, 'tasks length', 1),
      ],
      verify: (_) {
        verify(mockCreateTask(any)).called(1);
      },
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskError] when createTask fails',
      build: () {
        when(mockCreateTask(any)).thenAnswer(
          (_) async => const Left(
            ValidationFailure(message: 'Title is required'),
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const CreateTaskEvent(title: '')),
      expect: () => [
        const TaskLoading(),
        const TaskError('Title is required'),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'adds task to existing list after creation',
      build: () {
        // Primero cargar tareas existentes
        when(mockGetTasks(const NoParams()))
            .thenAnswer((_) async => Right(tTasks));
        when(mockCreateTask(any)).thenAnswer((_) async => Right(tNewTask));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const LoadTasks());
        await Future.delayed(Duration.zero); // Esperar a que LoadTasks complete
        bloc.add(const CreateTaskEvent(title: 'New Task'));
      },
      skip: 2, // Skip LoadTasks states
      expect: () => [
        const TaskLoading(),
        isA<TaskOperationSuccess>()
            .having((s) => s.tasks.length, 'tasks length', 3),
      ],
    );
  });

  // ═══════════════════════════════════════════════════════════════
  // TESTS: UpdateTaskEvent
  // ═══════════════════════════════════════════════════════════════

  group('UpdateTaskEvent', () {
    final updatedTask = tTasks[0].copyWith(title: 'Updated Title');

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskOperationSuccess] when updateTask succeeds',
      build: () {
        when(mockGetTasks(const NoParams()))
            .thenAnswer((_) async => Right(tTasks));
        when(mockUpdateTask(any)).thenAnswer((_) async => Right(updatedTask));
        return bloc;
      },
      seed: () => TasksLoaded(tTasks), // Estado inicial con tareas
      act: (bloc) => bloc.add(UpdateTaskEvent(updatedTask)),
      expect: () => [
        const TaskLoading(),
        isA<TaskOperationSuccess>()
            .having((s) => s.message, 'message', 'Tarea actualizada'),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskError] when updateTask fails',
      build: () {
        when(mockUpdateTask(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Update failed')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateTaskEvent(tTasks[0])),
      expect: () => [
        const TaskLoading(),
        const TaskError('Update failed'),
      ],
    );
  });

  // ═══════════════════════════════════════════════════════════════
  // TESTS: DeleteTaskEvent
  // ═══════════════════════════════════════════════════════════════

  group('DeleteTaskEvent', () {
    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskOperationSuccess] when deleteTask succeeds',
      build: () {
        when(mockGetTasks(const NoParams()))
            .thenAnswer((_) async => Right(tTasks));
        when(mockDeleteTask(any)).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      seed: () => TasksLoaded(tTasks),
      act: (bloc) => bloc.add(const DeleteTaskEvent('1')),
      expect: () => [
        const TaskLoading(),
        isA<TaskOperationSuccess>()
            .having((s) => s.message, 'message', 'Tarea eliminada')
            .having((s) => s.tasks.length, 'tasks length', 1),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskError] when deleteTask fails',
      build: () {
        when(mockDeleteTask(any)).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Delete failed')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const DeleteTaskEvent('1')),
      expect: () => [
        const TaskLoading(),
        const TaskError('Delete failed'),
      ],
    );
  });

  // ═══════════════════════════════════════════════════════════════
  // TESTS: TasksLoaded getters
  // ═══════════════════════════════════════════════════════════════

  group('TasksLoaded', () {
    test('pendingTasks returns only incomplete tasks', () {
      final state = TasksLoaded(tTasks);

      expect(state.pendingTasks.length, 1);
      expect(state.pendingTasks[0].id, '1');
    });

    test('completedTasks returns only completed tasks', () {
      final state = TasksLoaded(tTasks);

      expect(state.completedTasks.length, 1);
      expect(state.completedTasks[0].id, '2');
    });
  });
}
```

### Parte 4: Generar y Ejecutar

```bash
# Generar mocks
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar tests del BLoC
flutter test test/features/task/presentation/bloc/

# Ejecutar con verbose
flutter test --reporter expanded test/features/task/presentation/bloc/
```

---

## ✅ Criterios de Evaluación

| Criterio                      | Puntos  |
| ----------------------------- | ------- |
| Events y States implementados | 15      |
| TaskBloc completo             | 20      |
| Tests LoadTasks (3+ tests)    | 15      |
| Tests CreateTask (3+ tests)   | 15      |
| Tests UpdateTask (2+ tests)   | 10      |
| Tests DeleteTask (2+ tests)   | 10      |
| Tests de State getters        | 10      |
| Uso correcto de bloc_test     | 5       |
| **Total**                     | **100** |

---

## 🎁 Bonus

1. Agregar tests para `ToggleTaskEvent`
2. Implementar tests de concurrencia (eventos simultáneos)
3. Testear `bloc.stream` directamente
4. Agregar tests de timeout para operaciones largas

---

## 📚 Recursos

- [bloc_test Package](https://pub.dev/packages/bloc_test)
- [BLoC Testing](https://bloclibrary.dev/#/testing)
- [blocTest API](https://pub.dev/documentation/bloc_test/latest/bloc_test/blocTest.html)
