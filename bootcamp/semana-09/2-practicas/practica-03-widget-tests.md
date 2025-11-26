# 🖼️ Práctica 03: Widget Tests

## 📋 Información

| Campo | Detalle |
|-------|---------|
| **Nivel** | Intermedio |
| **Duración** | 45 minutos |
| **Requisitos** | Flutter Test, Práctica 01-02 |

---

## 🎯 Objetivos

- Escribir widget tests con WidgetTester
- Usar finders para localizar widgets
- Simular interacciones de usuario
- Testear widgets con estado

---

## 📝 Descripción

Crearás **widget tests** para los componentes de la UI de la aplicación de tareas. Aprenderás a testear formularios, listas y interacciones complejas.

---

## 🔨 Ejercicio

### Parte 1: Widget TaskItem

Primero, crea el widget a testear:

**lib/features/task/presentation/widgets/task_item.dart**

```dart
import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

/// Widget que muestra una tarea individual en la lista.
class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;

  // Keys para testing
  static const checkboxKey = Key('taskItem_checkbox');
  static const deleteButtonKey = Key('taskItem_deleteButton');

  const TaskItem({
    Key? key,
    required this.task,
    this.onTap,
    this.onToggle,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          key: checkboxKey,
          value: task.isCompleted,
          onChanged: (_) => onToggle?.call(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: task.description != null
            ? Text(
                task.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PriorityIndicator(priority: task.priority),
            IconButton(
              key: deleteButtonKey,
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  final TaskPriority priority;

  const _PriorityIndicator({required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getColor(),
      ),
    );
  }

  Color _getColor() {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }
}
```

### Parte 2: Test de TaskItem

**test/features/task/presentation/widgets/task_item_test.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_app/features/task/domain/entities/task.dart';
import 'package:tu_app/features/task/presentation/widgets/task_item.dart';

void main() {
  // Datos de prueba
  final tTask = Task(
    id: '1',
    title: 'Test Task',
    description: 'Test Description',
    createdAt: DateTime(2024, 1, 1),
    priority: TaskPriority.high,
  );

  final tCompletedTask = Task(
    id: '2',
    title: 'Completed Task',
    isCompleted: true,
    createdAt: DateTime(2024, 1, 1),
  );

  // Helper para construir widget con MaterialApp
  Widget createWidgetUnderTest({
    required Task task,
    VoidCallback? onTap,
    VoidCallback? onToggle,
    VoidCallback? onDelete,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: TaskItem(
          task: task,
          onTap: onTap,
          onToggle: onToggle,
          onDelete: onDelete,
        ),
      ),
    );
  }

  group('TaskItem', () {
    testWidgets('should display task title', (tester) async {
      // ARRANGE & ACT
      await tester.pumpWidget(createWidgetUnderTest(task: tTask));

      // ASSERT
      expect(find.text('Test Task'), findsOneWidget);
    });

    testWidgets('should display task description when present', (tester) async {
      // ARRANGE & ACT
      await tester.pumpWidget(createWidgetUnderTest(task: tTask));

      // ASSERT
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('should not display description when null', (tester) async {
      // ARRANGE
      final taskWithoutDescription = Task(
        id: '3',
        title: 'No Description',
        createdAt: DateTime.now(),
      );

      // ACT
      await tester.pumpWidget(
        createWidgetUnderTest(task: taskWithoutDescription),
      );

      // ASSERT - Solo debe haber un Text (el título)
      final textFinder = find.byType(Text);
      // El Card tiene el título, no debería tener subtitle
      expect(
        find.descendant(
          of: find.byType(ListTile),
          matching: find.byType(Text),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should show unchecked checkbox for incomplete task', (tester) async {
      // ARRANGE & ACT
      await tester.pumpWidget(createWidgetUnderTest(task: tTask));

      // ASSERT
      final checkbox = tester.widget<Checkbox>(
        find.byKey(TaskItem.checkboxKey),
      );
      expect(checkbox.value, false);
    });

    testWidgets('should show checked checkbox for completed task', (tester) async {
      // ARRANGE & ACT
      await tester.pumpWidget(createWidgetUnderTest(task: tCompletedTask));

      // ASSERT
      final checkbox = tester.widget<Checkbox>(
        find.byKey(TaskItem.checkboxKey),
      );
      expect(checkbox.value, true);
    });

    testWidgets('should show strikethrough for completed task title', (tester) async {
      // ARRANGE & ACT
      await tester.pumpWidget(createWidgetUnderTest(task: tCompletedTask));

      // ASSERT
      final textWidget = tester.widget<Text>(find.text('Completed Task'));
      expect(
        textWidget.style?.decoration,
        TextDecoration.lineThrough,
      );
    });

    testWidgets('should call onToggle when checkbox is tapped', (tester) async {
      // ARRANGE
      bool toggleCalled = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          task: tTask,
          onToggle: () => toggleCalled = true,
        ),
      );

      // ACT
      await tester.tap(find.byKey(TaskItem.checkboxKey));
      await tester.pump();

      // ASSERT
      expect(toggleCalled, true);
    });

    testWidgets('should call onDelete when delete button is tapped', (tester) async {
      // ARRANGE
      bool deleteCalled = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          task: tTask,
          onDelete: () => deleteCalled = true,
        ),
      );

      // ACT
      await tester.tap(find.byKey(TaskItem.deleteButtonKey));
      await tester.pump();

      // ASSERT
      expect(deleteCalled, true);
    });

    testWidgets('should call onTap when list tile is tapped', (tester) async {
      // ARRANGE
      bool tapCalled = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          task: tTask,
          onTap: () => tapCalled = true,
        ),
      );

      // ACT
      await tester.tap(find.byType(ListTile));
      await tester.pump();

      // ASSERT
      expect(tapCalled, true);
    });

    group('Priority Indicator', () {
      testWidgets('should show red indicator for high priority', (tester) async {
        // ARRANGE
        final highPriorityTask = Task(
          id: '1',
          title: 'High',
          createdAt: DateTime.now(),
          priority: TaskPriority.high,
        );

        // ACT
        await tester.pumpWidget(createWidgetUnderTest(task: highPriorityTask));

        // ASSERT
        final container = tester.widget<Container>(
          find.byWidgetPredicate(
            (widget) =>
                widget is Container &&
                widget.decoration is BoxDecoration &&
                (widget.decoration as BoxDecoration).color == Colors.red,
          ),
        );
        expect(container, isNotNull);
      });

      testWidgets('should show orange indicator for medium priority', (tester) async {
        // ARRANGE
        final mediumPriorityTask = Task(
          id: '1',
          title: 'Medium',
          createdAt: DateTime.now(),
          priority: TaskPriority.medium,
        );

        // ACT
        await tester.pumpWidget(createWidgetUnderTest(task: mediumPriorityTask));

        // ASSERT
        final container = tester.widget<Container>(
          find.byWidgetPredicate(
            (widget) =>
                widget is Container &&
                widget.decoration is BoxDecoration &&
                (widget.decoration as BoxDecoration).color == Colors.orange,
          ),
        );
        expect(container, isNotNull);
      });
    });
  });
}
```

### Parte 3: Widget TaskForm

**lib/features/task/presentation/widgets/task_form.dart**

```dart
import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

/// Formulario para crear o editar una tarea.
class TaskForm extends StatefulWidget {
  final Task? initialTask;
  final void Function(String title, String? description, TaskPriority priority)
      onSubmit;

  // Keys para testing
  static const titleFieldKey = Key('taskForm_titleField');
  static const descriptionFieldKey = Key('taskForm_descriptionField');
  static const priorityDropdownKey = Key('taskForm_priorityDropdown');
  static const submitButtonKey = Key('taskForm_submitButton');

  const TaskForm({
    Key? key,
    this.initialTask,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  TaskPriority _selectedPriority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialTask?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialTask?.description ?? '',
    );
    _selectedPriority =
        widget.initialTask?.priority ?? TaskPriority.medium;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _titleController.text,
        _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        _selectedPriority,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            key: TaskForm.titleFieldKey,
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Título',
              hintText: 'Ingresa el título de la tarea',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'El título es requerido';
              }
              if (value.length < 3) {
                return 'El título debe tener al menos 3 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: TaskForm.descriptionFieldKey,
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descripción (opcional)',
              hintText: 'Agrega una descripción',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<TaskPriority>(
            key: TaskForm.priorityDropdownKey,
            value: _selectedPriority,
            decoration: const InputDecoration(
              labelText: 'Prioridad',
            ),
            items: TaskPriority.values.map((priority) {
              return DropdownMenuItem(
                value: priority,
                child: Text(_priorityToString(priority)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedPriority = value);
              }
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            key: TaskForm.submitButtonKey,
            onPressed: _handleSubmit,
            child: Text(widget.initialTask == null ? 'Crear' : 'Actualizar'),
          ),
        ],
      ),
    );
  }

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

### Parte 4: Test de TaskForm

**test/features/task/presentation/widgets/task_form_test.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_app/features/task/domain/entities/task.dart';
import 'package:tu_app/features/task/presentation/widgets/task_form.dart';

void main() {
  // Helper para crear widget
  Widget createWidgetUnderTest({
    Task? initialTask,
    required void Function(String, String?, TaskPriority) onSubmit,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: TaskForm(
            initialTask: initialTask,
            onSubmit: onSubmit,
          ),
        ),
      ),
    );
  }

  group('TaskForm', () {
    group('Rendering', () {
      testWidgets('should show empty fields when no initial task', (tester) async {
        // ARRANGE & ACT
        await tester.pumpWidget(
          createWidgetUnderTest(onSubmit: (_, __, ___) {}),
        );

        // ASSERT
        final titleField = tester.widget<TextFormField>(
          find.byKey(TaskForm.titleFieldKey),
        );
        expect(titleField.controller?.text, '');
        
        expect(find.text('Crear'), findsOneWidget);
      });

      testWidgets('should populate fields with initial task data', (tester) async {
        // ARRANGE
        final initialTask = Task(
          id: '1',
          title: 'Existing Task',
          description: 'Existing Description',
          createdAt: DateTime.now(),
          priority: TaskPriority.high,
        );

        // ACT
        await tester.pumpWidget(
          createWidgetUnderTest(
            initialTask: initialTask,
            onSubmit: (_, __, ___) {},
          ),
        );

        // ASSERT
        expect(find.text('Existing Task'), findsOneWidget);
        expect(find.text('Existing Description'), findsOneWidget);
        expect(find.text('Alta'), findsOneWidget);
        expect(find.text('Actualizar'), findsOneWidget);
      });
    });

    group('Validation', () {
      testWidgets('should show error when title is empty', (tester) async {
        // ARRANGE
        await tester.pumpWidget(
          createWidgetUnderTest(onSubmit: (_, __, ___) {}),
        );

        // ACT - Tap submit without entering text
        await tester.tap(find.byKey(TaskForm.submitButtonKey));
        await tester.pumpAndSettle();

        // ASSERT
        expect(find.text('El título es requerido'), findsOneWidget);
      });

      testWidgets('should show error when title is too short', (tester) async {
        // ARRANGE
        await tester.pumpWidget(
          createWidgetUnderTest(onSubmit: (_, __, ___) {}),
        );

        // ACT
        await tester.enterText(find.byKey(TaskForm.titleFieldKey), 'AB');
        await tester.tap(find.byKey(TaskForm.submitButtonKey));
        await tester.pumpAndSettle();

        // ASSERT
        expect(
          find.text('El título debe tener al menos 3 caracteres'),
          findsOneWidget,
        );
      });

      testWidgets('should not show error for valid title', (tester) async {
        // ARRANGE
        String? submittedTitle;
        await tester.pumpWidget(
          createWidgetUnderTest(
            onSubmit: (title, _, __) => submittedTitle = title,
          ),
        );

        // ACT
        await tester.enterText(find.byKey(TaskForm.titleFieldKey), 'Valid Task');
        await tester.tap(find.byKey(TaskForm.submitButtonKey));
        await tester.pumpAndSettle();

        // ASSERT
        expect(submittedTitle, 'Valid Task');
      });
    });

    group('Submit', () {
      testWidgets('should call onSubmit with correct values', (tester) async {
        // ARRANGE
        String? capturedTitle;
        String? capturedDescription;
        TaskPriority? capturedPriority;

        await tester.pumpWidget(
          createWidgetUnderTest(
            onSubmit: (title, description, priority) {
              capturedTitle = title;
              capturedDescription = description;
              capturedPriority = priority;
            },
          ),
        );

        // ACT
        await tester.enterText(
          find.byKey(TaskForm.titleFieldKey),
          'New Task',
        );
        await tester.enterText(
          find.byKey(TaskForm.descriptionFieldKey),
          'Task Description',
        );
        await tester.tap(find.byKey(TaskForm.submitButtonKey));
        await tester.pumpAndSettle();

        // ASSERT
        expect(capturedTitle, 'New Task');
        expect(capturedDescription, 'Task Description');
        expect(capturedPriority, TaskPriority.medium); // Default
      });

      testWidgets('should pass null description when empty', (tester) async {
        // ARRANGE
        String? capturedDescription = 'initial';

        await tester.pumpWidget(
          createWidgetUnderTest(
            onSubmit: (_, description, __) {
              capturedDescription = description;
            },
          ),
        );

        // ACT
        await tester.enterText(find.byKey(TaskForm.titleFieldKey), 'Task');
        // Don't enter description
        await tester.tap(find.byKey(TaskForm.submitButtonKey));
        await tester.pumpAndSettle();

        // ASSERT
        expect(capturedDescription, isNull);
      });
    });

    group('Priority Selection', () {
      testWidgets('should change priority when dropdown value changes', (tester) async {
        // ARRANGE
        TaskPriority? capturedPriority;
        await tester.pumpWidget(
          createWidgetUnderTest(
            onSubmit: (_, __, priority) => capturedPriority = priority,
          ),
        );

        // ACT - Open dropdown
        await tester.tap(find.byKey(TaskForm.priorityDropdownKey));
        await tester.pumpAndSettle();

        // Select high priority
        await tester.tap(find.text('Alta').last);
        await tester.pumpAndSettle();

        // Submit form
        await tester.enterText(find.byKey(TaskForm.titleFieldKey), 'Task');
        await tester.tap(find.byKey(TaskForm.submitButtonKey));
        await tester.pumpAndSettle();

        // ASSERT
        expect(capturedPriority, TaskPriority.high);
      });
    });
  });
}
```

---

## ✅ Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| Widgets implementados correctamente | 20 |
| TaskItem tests (8+ tests) | 30 |
| TaskForm tests (8+ tests) | 30 |
| Uso correcto de finders y keys | 10 |
| Simulación de interacciones | 10 |
| **Total** | **100** |

---

## 🎁 Bonus

1. Agregar tests para scroll en lista de tareas
2. Crear tests para animaciones (usando pump con Duration)
3. Implementar Golden Tests para regresión visual
4. Testear widget con diferentes tamaños de pantalla

---

## 📚 Recursos

- [Widget Testing](https://docs.flutter.dev/cookbook/testing/widget/introduction)
- [Finder API](https://api.flutter.dev/flutter/flutter_test/CommonFinders-class.html)
- [WidgetTester](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html)
