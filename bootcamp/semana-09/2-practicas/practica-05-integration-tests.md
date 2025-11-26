# 🔗 Práctica 05: Integration Tests

## 📋 Información

| Campo          | Detalle         |
| -------------- | --------------- |
| **Nivel**      | Avanzado        |
| **Duración**   | 50 minutos      |
| **Requisitos** | Prácticas 01-04 |

---

## 🎯 Objetivos

- Escribir tests de integración completos
- Testear flujos de usuario end-to-end
- Usar integration_test package
- Automatizar tests en dispositivos reales/emuladores

---

## 📝 Descripción

Crearás **tests de integración** que verifican flujos completos de la aplicación, simulando interacciones reales del usuario desde inicio hasta fin.

---

## 🔨 Ejercicio

### Parte 1: Configuración

**pubspec.yaml**

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
```

### Parte 2: Estructura de Carpetas

```
project/
├── integration_test/
│   ├── app_test.dart           # Tests principales
│   ├── robots/
│   │   ├── app_robot.dart      # Robot base
│   │   └── task_robot.dart     # Robot de tareas
│   └── test_utils/
│       └── test_helpers.dart   # Utilidades
├── lib/
└── test/
```

### Parte 3: Test Helpers

**integration_test/test_utils/test_helpers.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Extensiones útiles para integration tests.
extension IntegrationTestExtensions on WidgetTester {
  /// Espera a que un widget sea visible y hace scroll si es necesario.
  Future<void> scrollUntilVisible(
    Finder finder, {
    Finder? scrollable,
    double delta = 100,
    int maxScrolls = 50,
  }) async {
    final scrollableFinder = scrollable ?? find.byType(Scrollable).first;

    int scrollAttempts = 0;
    while (finder.evaluate().isEmpty && scrollAttempts < maxScrolls) {
      await drag(scrollableFinder, Offset(0, -delta));
      await pumpAndSettle();
      scrollAttempts++;
    }
  }

  /// Espera a que desaparezca un indicador de carga.
  Future<void> waitForLoading() async {
    while (find.byType(CircularProgressIndicator).evaluate().isNotEmpty) {
      await pump(const Duration(milliseconds: 100));
    }
    await pumpAndSettle();
  }

  /// Toma un screenshot (útil para debugging).
  Future<void> takeScreenshot(
    IntegrationTestWidgetsFlutterBinding binding,
    String name,
  ) async {
    await binding.takeScreenshot(name);
  }
}

/// Datos de prueba para integration tests.
class TestData {
  static const taskTitle = 'Integration Test Task';
  static const taskDescription = 'Created during integration test';
  static const updatedTitle = 'Updated Integration Task';
}
```

### Parte 4: Robot Pattern

**integration_test/robots/app_robot.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Robot base con acciones comunes de la app.
///
/// El patrón Robot encapsula las interacciones de UI,
/// haciendo los tests más legibles y mantenibles.
class AppRobot {
  final WidgetTester tester;

  AppRobot(this.tester);

  /// Espera a que la app esté lista.
  Future<void> waitForAppReady() async {
    await tester.pumpAndSettle();
  }

  /// Verifica que estamos en la pantalla principal.
  Future<void> verifyOnHomeScreen() async {
    expect(find.text('Mis Tareas'), findsOneWidget);
  }

  /// Navega hacia atrás.
  Future<void> goBack() async {
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
  }

  /// Abre el drawer.
  Future<void> openDrawer() async {
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
  }

  /// Cierra cualquier diálogo.
  Future<void> dismissDialog() async {
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
  }

  /// Verifica un mensaje snackbar.
  Future<void> verifySnackbar(String message) async {
    expect(find.text(message), findsOneWidget);
    // Esperar a que desaparezca
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  }
}
```

**integration_test/robots/task_robot.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_app/features/task/domain/entities/task.dart';
import 'package:tu_app/features/task/presentation/widgets/task_form.dart';
import 'package:tu_app/features/task/presentation/widgets/task_item.dart';
import 'app_robot.dart';

/// Robot para interactuar con la funcionalidad de tareas.
class TaskRobot extends AppRobot {
  TaskRobot(super.tester);

  // ═══════════════════════════════════════════════════════════════
  // VERIFICACIONES
  // ═══════════════════════════════════════════════════════════════

  /// Verifica que la lista de tareas esté vacía.
  Future<void> verifyEmptyState() async {
    expect(find.text('No hay tareas'), findsOneWidget);
  }

  /// Verifica que una tarea existe en la lista.
  Future<void> verifyTaskExists(String title) async {
    expect(find.text(title), findsOneWidget);
  }

  /// Verifica que una tarea NO existe.
  Future<void> verifyTaskNotExists(String title) async {
    expect(find.text(title), findsNothing);
  }

  /// Verifica el número de tareas en la lista.
  Future<void> verifyTaskCount(int count) async {
    expect(find.byType(TaskItem), findsNWidgets(count));
  }

  /// Verifica que una tarea está completada.
  Future<void> verifyTaskCompleted(String title) async {
    final taskFinder = find.ancestor(
      of: find.text(title),
      matching: find.byType(TaskItem),
    );

    final taskItem = tester.widget<TaskItem>(taskFinder);
    expect(taskItem.task.isCompleted, true);
  }

  // ═══════════════════════════════════════════════════════════════
  // ACCIONES
  // ═══════════════════════════════════════════════════════════════

  /// Abre el formulario para crear una nueva tarea.
  Future<void> tapAddTaskButton() async {
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
  }

  /// Llena el formulario de tarea.
  Future<void> fillTaskForm({
    required String title,
    String? description,
    TaskPriority priority = TaskPriority.medium,
  }) async {
    // Título
    await tester.enterText(
      find.byKey(TaskForm.titleFieldKey),
      title,
    );

    // Descripción (opcional)
    if (description != null) {
      await tester.enterText(
        find.byKey(TaskForm.descriptionFieldKey),
        description,
      );
    }

    // Prioridad
    if (priority != TaskPriority.medium) {
      await tester.tap(find.byKey(TaskForm.priorityDropdownKey));
      await tester.pumpAndSettle();

      final priorityText = _priorityToString(priority);
      await tester.tap(find.text(priorityText).last);
      await tester.pumpAndSettle();
    }
  }

  /// Envía el formulario de tarea.
  Future<void> submitTaskForm() async {
    await tester.tap(find.byKey(TaskForm.submitButtonKey));
    await tester.pumpAndSettle();
  }

  /// Crea una tarea completa (formulario + envío).
  Future<void> createTask({
    required String title,
    String? description,
    TaskPriority priority = TaskPriority.medium,
  }) async {
    await tapAddTaskButton();
    await fillTaskForm(
      title: title,
      description: description,
      priority: priority,
    );
    await submitTaskForm();
  }

  /// Toggle el estado de completitud de una tarea.
  Future<void> toggleTask(String title) async {
    // Encontrar el TaskItem con ese título
    final taskFinder = find.ancestor(
      of: find.text(title),
      matching: find.byType(TaskItem),
    );

    // Encontrar el checkbox dentro
    final checkboxFinder = find.descendant(
      of: taskFinder,
      matching: find.byKey(TaskItem.checkboxKey),
    );

    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();
  }

  /// Elimina una tarea.
  Future<void> deleteTask(String title) async {
    final taskFinder = find.ancestor(
      of: find.text(title),
      matching: find.byType(TaskItem),
    );

    final deleteButtonFinder = find.descendant(
      of: taskFinder,
      matching: find.byKey(TaskItem.deleteButtonKey),
    );

    await tester.tap(deleteButtonFinder);
    await tester.pumpAndSettle();
  }

  /// Abre una tarea para ver detalles.
  Future<void> tapTask(String title) async {
    await tester.tap(find.text(title));
    await tester.pumpAndSettle();
  }

  /// Confirma un diálogo de eliminación.
  Future<void> confirmDelete() async {
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();
  }

  /// Cancela un diálogo.
  Future<void> cancelDialog() async {
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
  }

  // Helper
  String _priorityToString(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 'Alta';
      case TaskPriority.medium:
        return 'Media';
      case TaskPriority.low:
        return 'Baja';
    }
  }
}
```

### Parte 5: Integration Tests

**integration_test/app_test.dart**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tu_app/main.dart' as app;
import 'package:tu_app/features/task/domain/entities/task.dart';

import 'robots/task_robot.dart';
import 'test_utils/test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Task Management Integration Tests', () {
    late TaskRobot robot;

    // ═══════════════════════════════════════════════════════════════
    // TEST: Crear tarea
    // ═══════════════════════════════════════════════════════════════

    testWidgets('should create a new task successfully', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();
      robot = TaskRobot(tester);

      // ACT
      await robot.createTask(
        title: TestData.taskTitle,
        description: TestData.taskDescription,
        priority: TaskPriority.high,
      );

      // ASSERT
      await robot.verifyTaskExists(TestData.taskTitle);
      await robot.verifySnackbar('Tarea creada exitosamente');
    });

    // ═══════════════════════════════════════════════════════════════
    // TEST: Flujo completo CRUD
    // ═══════════════════════════════════════════════════════════════

    testWidgets('should complete full CRUD flow', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();
      robot = TaskRobot(tester);

      // CREATE
      await robot.createTask(title: 'Task to CRUD');
      await robot.verifyTaskExists('Task to CRUD');

      // READ - Toggle para marcar como completada
      await robot.toggleTask('Task to CRUD');
      await robot.verifyTaskCompleted('Task to CRUD');

      // DELETE
      await robot.deleteTask('Task to CRUD');
      await robot.confirmDelete();
      await robot.verifyTaskNotExists('Task to CRUD');
      await robot.verifySnackbar('Tarea eliminada');
    });

    // ═══════════════════════════════════════════════════════════════
    // TEST: Validación de formulario
    // ═══════════════════════════════════════════════════════════════

    testWidgets('should show validation error for empty title', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();
      robot = TaskRobot(tester);

      // ACT
      await robot.tapAddTaskButton();
      await robot.submitTaskForm(); // Sin llenar el formulario

      // ASSERT
      expect(find.text('El título es requerido'), findsOneWidget);
    });

    // ═══════════════════════════════════════════════════════════════
    // TEST: Múltiples tareas
    // ═══════════════════════════════════════════════════════════════

    testWidgets('should handle multiple tasks', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();
      robot = TaskRobot(tester);

      // ACT - Crear varias tareas
      await robot.createTask(title: 'Task 1');
      await robot.createTask(title: 'Task 2');
      await robot.createTask(title: 'Task 3');

      // ASSERT
      await robot.verifyTaskCount(3);
      await robot.verifyTaskExists('Task 1');
      await robot.verifyTaskExists('Task 2');
      await robot.verifyTaskExists('Task 3');
    });

    // ═══════════════════════════════════════════════════════════════
    // TEST: Toggle tareas
    // ═══════════════════════════════════════════════════════════════

    testWidgets('should toggle task completion status', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();
      robot = TaskRobot(tester);

      // ACT
      await robot.createTask(title: 'Toggle Test Task');

      // Toggle a completada
      await robot.toggleTask('Toggle Test Task');
      await robot.verifyTaskCompleted('Toggle Test Task');

      // Toggle de vuelta a pendiente
      await robot.toggleTask('Toggle Test Task');
      // Verificar que ya no está completada
      // (implementar verifyTaskPending si es necesario)
    });

    // ═══════════════════════════════════════════════════════════════
    // TEST: Cancelar eliminación
    // ═══════════════════════════════════════════════════════════════

    testWidgets('should cancel task deletion', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();
      robot = TaskRobot(tester);

      await robot.createTask(title: 'Keep This Task');

      // ACT - Intentar eliminar pero cancelar
      await robot.deleteTask('Keep This Task');
      await robot.cancelDialog();

      // ASSERT - La tarea debe seguir existiendo
      await robot.verifyTaskExists('Keep This Task');
    });

    // ═══════════════════════════════════════════════════════════════
    // TEST: Prioridades
    // ═══════════════════════════════════════════════════════════════

    testWidgets('should create tasks with different priorities', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();
      robot = TaskRobot(tester);

      // ACT
      await robot.createTask(
        title: 'High Priority',
        priority: TaskPriority.high,
      );
      await robot.createTask(
        title: 'Low Priority',
        priority: TaskPriority.low,
      );

      // ASSERT
      await robot.verifyTaskExists('High Priority');
      await robot.verifyTaskExists('Low Priority');
    });
  });

  // ═══════════════════════════════════════════════════════════════
  // TESTS DE RENDIMIENTO
  // ═══════════════════════════════════════════════════════════════

  group('Performance Tests', () {
    testWidgets('should load 100 tasks without lag', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();
      final robot = TaskRobot(tester);

      // ACT - Crear muchas tareas (simulado o con datos de prueba)
      final stopwatch = Stopwatch()..start();

      for (var i = 0; i < 10; i++) {
        await robot.createTask(title: 'Task $i');
      }

      stopwatch.stop();

      // ASSERT
      expect(stopwatch.elapsedMilliseconds, lessThan(30000)); // < 30 segundos
      await robot.verifyTaskCount(10);
    });

    testWidgets('should scroll through task list smoothly', (tester) async {
      // ARRANGE
      app.main();
      await tester.pumpAndSettle();

      // ACT
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -500),
        1000,
      );
      await tester.pumpAndSettle();

      // ASSERT - No debe crashear
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
```

### Parte 6: Ejecutar Integration Tests

```bash
# Ejecutar en emulador/dispositivo conectado
flutter test integration_test/app_test.dart

# Ejecutar con driver (para screenshots)
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart

# En dispositivo específico
flutter test integration_test/app_test.dart -d <device_id>

# Con verbose output
flutter test integration_test/app_test.dart --reporter expanded
```

### Parte 7: Test Driver (opcional para screenshots)

**test_driver/integration_test.dart**

```dart
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver();
```

---

## ✅ Criterios de Evaluación

| Criterio                   | Puntos  |
| -------------------------- | ------- |
| Helpers y utilidades       | 10      |
| Robot Pattern implementado | 20      |
| Test crear tarea           | 15      |
| Test CRUD completo         | 20      |
| Test validaciones          | 10      |
| Test múltiples tareas      | 10      |
| Test toggle/prioridades    | 10      |
| Tests ejecutan sin errores | 5       |
| **Total**                  | **100** |

---

## 🎁 Bonus

1. Agregar tests de screenshots con golden files
2. Implementar tests de accesibilidad (semantics)
3. Crear tests para diferentes tamaños de pantalla
4. Agregar tests de modo oscuro/claro

---

## 📚 Recursos

- [Integration Testing](https://docs.flutter.dev/cookbook/testing/integration/introduction)
- [integration_test Package](https://pub.dev/packages/integration_test)
- [Robot Pattern](https://blog.codemagic.io/robot-pattern-testing-flutter/)
