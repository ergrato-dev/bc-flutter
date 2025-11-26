# 🧪 Práctica 02: Tests Unitarios

## 📋 Información

| Campo | Detalle |
|-------|---------|
| **Nivel** | Intermedio |
| **Duración** | 45 minutos |
| **Requisitos** | Práctica 01, Mockito |

---

## 🎯 Objetivos

- Escribir tests unitarios para casos de uso
- Usar Mockito para crear mocks
- Aplicar el patrón AAA (Arrange, Act, Assert)
- Testear manejo de errores con Either

---

## 📝 Descripción

Crearás tests unitarios completos para los **casos de uso** implementados en la práctica anterior. Aprenderás a mockear el repositorio y verificar el comportamiento correcto.

---

## 🔨 Ejercicio

### Parte 1: Configuración

**pubspec.yaml**

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.7
```

### Parte 2: Mock del Repositorio

**test/features/task/domain/usecases/get_tasks_test.dart**

```dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Importa tus archivos
import 'package:tu_app/core/error/failures.dart';
import 'package:tu_app/core/usecases/usecase.dart';
import 'package:tu_app/features/task/domain/entities/task.dart';
import 'package:tu_app/features/task/domain/repositories/task_repository.dart';
import 'package:tu_app/features/task/domain/usecases/get_tasks.dart';

// Genera el mock automáticamente
@GenerateMocks([TaskRepository])
import 'get_tasks_test.mocks.dart';

void main() {
  // Declarar variables de test
  late GetTasks usecase;
  late MockTaskRepository mockRepository;

  // Configuración antes de cada test
  setUp(() {
    mockRepository = MockTaskRepository();
    usecase = GetTasks(mockRepository);
  });

  // Datos de prueba
  final tTasks = [
    Task(
      id: '1',
      title: 'Test Task 1',
      description: 'Description 1',
      createdAt: DateTime(2024, 1, 1),
      priority: TaskPriority.high,
    ),
    Task(
      id: '2',
      title: 'Test Task 2',
      createdAt: DateTime(2024, 1, 2),
      priority: TaskPriority.low,
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // GRUPO DE TESTS: GetTasks
  // ═══════════════════════════════════════════════════════════════
  group('GetTasks', () {
    test(
      'should return list of tasks when repository call is successful',
      () async {
        // ARRANGE - Preparar
        // Configurar el mock para retornar las tareas de prueba
        when(mockRepository.getTasks())
            .thenAnswer((_) async => Right(tTasks));

        // ACT - Actuar
        // Ejecutar el caso de uso
        final result = await usecase(const NoParams());

        // ASSERT - Verificar
        // Verificar que el resultado es correcto
        expect(result, Right(tTasks));
        
        // Verificar que el repositorio fue llamado exactamente una vez
        verify(mockRepository.getTasks()).called(1);
        
        // Verificar que no se hicieron otras llamadas
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return ServerFailure when repository call fails',
      () async {
        // ARRANGE
        const tFailure = ServerFailure(message: 'Server error');
        when(mockRepository.getTasks())
            .thenAnswer((_) async => const Left(tFailure));

        // ACT
        final result = await usecase(const NoParams());

        // ASSERT
        expect(result, const Left(tFailure));
        verify(mockRepository.getTasks()).called(1);
      },
    );

    test(
      'should return empty list when there are no tasks',
      () async {
        // ARRANGE
        when(mockRepository.getTasks())
            .thenAnswer((_) async => const Right([]));

        // ACT
        final result = await usecase(const NoParams());

        // ASSERT
        expect(result, const Right(<Task>[]));
        verify(mockRepository.getTasks()).called(1);
      },
    );
  });
}
```

### Parte 3: Test de CreateTask

**test/features/task/domain/usecases/create_task_test.dart**

```dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tu_app/core/error/failures.dart';
import 'package:tu_app/features/task/domain/entities/task.dart';
import 'package:tu_app/features/task/domain/repositories/task_repository.dart';
import 'package:tu_app/features/task/domain/usecases/create_task.dart';

@GenerateMocks([TaskRepository])
import 'create_task_test.mocks.dart';

void main() {
  late CreateTask usecase;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    usecase = CreateTask(mockRepository);
  });

  // Datos de prueba
  final tCreatedTask = Task(
    id: 'generated-id',
    title: 'New Task',
    description: 'Task description',
    createdAt: DateTime.now(),
    priority: TaskPriority.medium,
  );

  group('CreateTask', () {
    test(
      'should create task when title is valid',
      () async {
        // ARRANGE
        const tParams = CreateTaskParams(
          title: 'New Task',
          description: 'Task description',
        );

        // Configurar mock - usar any matcher para la tarea
        when(mockRepository.createTask(any))
            .thenAnswer((_) async => Right(tCreatedTask));

        // ACT
        final result = await usecase(tParams);

        // ASSERT
        expect(result.isRight(), true);
        
        // Verificar que se llamó al repositorio con una tarea válida
        final captured = verify(mockRepository.createTask(captureAny))
            .captured
            .single as Task;
        
        expect(captured.title, 'New Task');
        expect(captured.description, 'Task description');
      },
    );

    test(
      'should return ValidationFailure when title is empty',
      () async {
        // ARRANGE
        const tParams = CreateTaskParams(title: '');

        // ACT
        final result = await usecase(tParams);

        // ASSERT
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(
              (failure as ValidationFailure).message,
              'El título no puede estar vacío',
            );
          },
          (_) => fail('Should return failure'),
        );
        
        // Verificar que NO se llamó al repositorio
        verifyNever(mockRepository.createTask(any));
      },
    );

    test(
      'should return ValidationFailure when title is only whitespace',
      () async {
        // ARRANGE
        const tParams = CreateTaskParams(title: '   ');

        // ACT
        final result = await usecase(tParams);

        // ASSERT
        expect(result.isLeft(), true);
        verifyNever(mockRepository.createTask(any));
      },
    );

    test(
      'should trim title and description before creating',
      () async {
        // ARRANGE
        const tParams = CreateTaskParams(
          title: '  Trimmed Title  ',
          description: '  Trimmed Description  ',
        );

        when(mockRepository.createTask(any))
            .thenAnswer((_) async => Right(tCreatedTask));

        // ACT
        await usecase(tParams);

        // ASSERT
        final captured = verify(mockRepository.createTask(captureAny))
            .captured
            .single as Task;
        
        expect(captured.title, 'Trimmed Title');
        expect(captured.description, 'Trimmed Description');
      },
    );

    test(
      'should set correct priority when provided',
      () async {
        // ARRANGE
        const tParams = CreateTaskParams(
          title: 'High Priority Task',
          priority: TaskPriority.high,
        );

        when(mockRepository.createTask(any))
            .thenAnswer((_) async => Right(tCreatedTask));

        // ACT
        await usecase(tParams);

        // ASSERT
        final captured = verify(mockRepository.createTask(captureAny))
            .captured
            .single as Task;
        
        expect(captured.priority, TaskPriority.high);
      },
    );

    test(
      'should use medium priority by default',
      () async {
        // ARRANGE
        const tParams = CreateTaskParams(title: 'Default Priority Task');

        when(mockRepository.createTask(any))
            .thenAnswer((_) async => Right(tCreatedTask));

        // ACT
        await usecase(tParams);

        // ASSERT
        final captured = verify(mockRepository.createTask(captureAny))
            .captured
            .single as Task;
        
        expect(captured.priority, TaskPriority.medium);
      },
    );

    test(
      'should return ServerFailure when repository fails',
      () async {
        // ARRANGE
        const tParams = CreateTaskParams(title: 'Valid Task');
        const tFailure = ServerFailure(message: 'Database error');

        when(mockRepository.createTask(any))
            .thenAnswer((_) async => const Left(tFailure));

        // ACT
        final result = await usecase(tParams);

        // ASSERT
        expect(result, const Left(tFailure));
      },
    );
  });
}
```

### Parte 4: Test de DeleteTask

**test/features/task/domain/usecases/delete_task_test.dart**

```dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tu_app/core/error/failures.dart';
import 'package:tu_app/features/task/domain/repositories/task_repository.dart';
import 'package:tu_app/features/task/domain/usecases/delete_task.dart';

@GenerateMocks([TaskRepository])
import 'delete_task_test.mocks.dart';

void main() {
  late DeleteTask usecase;
  late MockTaskRepository mockRepository;

  setUp(() {
    mockRepository = MockTaskRepository();
    usecase = DeleteTask(mockRepository);
  });

  group('DeleteTask', () {
    test(
      'should delete task when id is valid',
      () async {
        // ARRANGE
        const tParams = DeleteTaskParams(id: 'task-123');
        
        when(mockRepository.deleteTask('task-123'))
            .thenAnswer((_) async => const Right(null));

        // ACT
        final result = await usecase(tParams);

        // ASSERT
        expect(result, const Right(null));
        verify(mockRepository.deleteTask('task-123')).called(1);
      },
    );

    test(
      'should return ValidationFailure when id is empty',
      () async {
        // ARRANGE
        const tParams = DeleteTaskParams(id: '');

        // ACT
        final result = await usecase(tParams);

        // ASSERT
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'El ID de la tarea es requerido');
          },
          (_) => fail('Should return failure'),
        );
        verifyNever(mockRepository.deleteTask(any));
      },
    );

    test(
      'should return ServerFailure when task not found',
      () async {
        // ARRANGE
        const tParams = DeleteTaskParams(id: 'non-existent');
        const tFailure = ServerFailure(
          message: 'Task not found',
          code: 404,
        );

        when(mockRepository.deleteTask('non-existent'))
            .thenAnswer((_) async => const Left(tFailure));

        // ACT
        final result = await usecase(tParams);

        // ASSERT
        expect(result, const Left(tFailure));
      },
    );
  });
}
```

### Parte 5: Test de la Entidad Task

**test/features/task/domain/entities/task_test.dart**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_app/features/task/domain/entities/task.dart';

void main() {
  group('Task Entity', () {
    final tTask = Task(
      id: '1',
      title: 'Test Task',
      description: 'Description',
      createdAt: DateTime(2024, 1, 1),
      priority: TaskPriority.medium,
    );

    test('should be equatable', () {
      // Dos tareas con los mismos valores deben ser iguales
      final tTask2 = Task(
        id: '1',
        title: 'Test Task',
        description: 'Description',
        createdAt: DateTime(2024, 1, 1),
        priority: TaskPriority.medium,
      );

      expect(tTask, equals(tTask2));
    });

    test('should not be equal when id differs', () {
      final tTask2 = Task(
        id: '2', // Diferente ID
        title: 'Test Task',
        description: 'Description',
        createdAt: DateTime(2024, 1, 1),
        priority: TaskPriority.medium,
      );

      expect(tTask, isNot(equals(tTask2)));
    });

    group('copyWith', () {
      test('should return same task when no parameters provided', () {
        final copy = tTask.copyWith();
        expect(copy, equals(tTask));
      });

      test('should update title when provided', () {
        final copy = tTask.copyWith(title: 'Updated Title');
        
        expect(copy.title, 'Updated Title');
        expect(copy.id, tTask.id); // Otros campos sin cambios
        expect(copy.description, tTask.description);
      });

      test('should update isCompleted', () {
        expect(tTask.isCompleted, false);
        
        final copy = tTask.copyWith(isCompleted: true);
        
        expect(copy.isCompleted, true);
        expect(copy.title, tTask.title);
      });

      test('should update priority', () {
        final copy = tTask.copyWith(priority: TaskPriority.high);
        
        expect(copy.priority, TaskPriority.high);
        expect(tTask.priority, TaskPriority.medium); // Original sin cambios
      });
    });

    group('default values', () {
      test('should have isCompleted as false by default', () {
        final task = Task(
          id: '1',
          title: 'Task',
          createdAt: DateTime.now(),
        );

        expect(task.isCompleted, false);
      });

      test('should have medium priority by default', () {
        final task = Task(
          id: '1',
          title: 'Task',
          createdAt: DateTime.now(),
        );

        expect(task.priority, TaskPriority.medium);
      });

      test('should allow null description and dueDate', () {
        final task = Task(
          id: '1',
          title: 'Task',
          createdAt: DateTime.now(),
        );

        expect(task.description, isNull);
        expect(task.dueDate, isNull);
      });
    });
  });
}
```

### Parte 6: Generar Mocks y Ejecutar

```bash
# Generar archivos de mock
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar tests
flutter test

# Ejecutar con cobertura
flutter test --coverage

# Ver reporte de cobertura (requiere lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## ✅ Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| Mocks generados correctamente | 15 |
| Tests de GetTasks (3+ tests) | 20 |
| Tests de CreateTask (5+ tests) | 25 |
| Tests de DeleteTask (3+ tests) | 20 |
| Tests de Task entity (5+ tests) | 15 |
| Patrón AAA aplicado | 5 |
| **Total** | **100** |

---

## 🎁 Bonus

1. Agregar tests para `UpdateTask`
2. Alcanzar 100% de cobertura en el dominio
3. Crear tests parametrizados para múltiples escenarios
4. Agregar tests de rendimiento (benchmarks)

---

## 📚 Recursos

- [Flutter Testing](https://docs.flutter.dev/cookbook/testing/unit/introduction)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Test Coverage](https://docs.flutter.dev/testing/code-coverage)
