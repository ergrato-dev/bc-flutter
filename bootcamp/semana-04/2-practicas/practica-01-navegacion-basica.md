# 💻 Práctica 01: Navegación Básica

## 📋 Información General

| Campo | Valor |
|-------|-------|
| **Dificultad** | ⭐ Principiante |
| **Tiempo estimado** | 25 minutos |
| **Conceptos** | Navigator.push, Navigator.pop, pasar datos, retornar resultados |

---

## 🎯 Objetivos

- Implementar navegación básica con push y pop
- Pasar datos entre pantallas usando constructores
- Retornar datos desde una pantalla
- Manejar diferentes tipos de transiciones

---

## 📝 Descripción

Crearás una **app de lista de tareas simple** con dos pantallas:
1. **Lista de Tareas**: Muestra las tareas y permite agregar nuevas
2. **Agregar Tarea**: Formulario para crear una nueva tarea

El flujo será: Lista → Agregar → (retorna tarea) → Lista actualizada

---

## 🔧 Requisitos Técnicos

- Flutter SDK 3.0+
- Nuevo proyecto Flutter
- No se requieren dependencias adicionales

---

## 📋 Instrucciones

### Paso 1: Crear el Proyecto

```bash
flutter create practica_navegacion_basica
cd practica_navegacion_basica
```

### Paso 2: Definir el Modelo de Tarea

Crea el archivo `lib/models/task.dart`:

```dart
/// Modelo que representa una tarea
/// 
/// ¿Qué hace? Define la estructura de datos de una tarea
/// ¿Para qué? Tipar los datos que pasamos entre pantallas
class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  });

  // Crear copia con modificaciones
  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
```

### Paso 3: Crear la Pantalla de Lista

Crea `lib/screens/task_list_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_screen.dart';

/// Pantalla principal con lista de tareas
/// 
/// ¿Qué hace? Muestra las tareas y permite navegar a agregar
/// ¿Cómo? Usa Navigator.push y espera resultado con await
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Lista de tareas (estado local)
  final List<Task> _tasks = [
    Task(id: '1', title: 'Aprender Flutter', description: 'Completar semana 4'),
    Task(id: '2', title: 'Hacer ejercicio', description: '30 minutos'),
  ];

  /// Navega a la pantalla de agregar y espera el resultado
  Future<void> _navigateToAddTask() async {
    // TODO: Implementar navegación con push
    // 1. Usar Navigator.push con await
    // 2. Recibir la nueva tarea como resultado
    // 3. Si no es null, agregarla a la lista
  }

  /// Navega al detalle de una tarea
  void _navigateToTaskDetail(Task task) {
    // TODO: Implementar navegación al detalle
  }

  /// Alterna el estado de completado
  void _toggleTask(int index) {
    setState(() {
      _tasks[index] = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tareas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Text('No hay tareas. ¡Agrega una!'),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => _toggleTask(index),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: task.description.isNotEmpty
                      ? Text(task.description)
                      : null,
                  onTap: () => _navigateToTaskDetail(task),
                  trailing: const Icon(Icons.chevron_right),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### Paso 4: Crear la Pantalla de Agregar Tarea

Crea `lib/screens/add_task_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/task.dart';

/// Pantalla para agregar una nueva tarea
/// 
/// ¿Qué hace? Formulario que retorna una Task al guardar
/// ¿Cómo? Usa Navigator.pop(context, task) para retornar
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Guarda la tarea y retorna a la pantalla anterior
  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
      );

      // TODO: Retornar la tarea con Navigator.pop
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Tarea'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTask,
                  child: const Text('Guardar Tarea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Paso 5: Crear la Pantalla de Detalle

Crea `lib/screens/task_detail_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/task.dart';

/// Pantalla de detalle de una tarea
/// 
/// ¿Qué hace? Muestra información completa de la tarea
/// ¿Cómo? Recibe la tarea por constructor
class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Tarea'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estado
            Row(
              children: [
                Icon(
                  task.isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: task.isCompleted ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  task.isCompleted ? 'Completada' : 'Pendiente',
                  style: TextStyle(
                    color: task.isCompleted ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Título
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            
            // Descripción
            if (task.description.isNotEmpty) ...[
              Text(
                'Descripción:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(task.description),
            ],
            
            const Spacer(),
            
            // Botón volver
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Paso 6: Actualizar main.dart

```dart
import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}
```

---

## 🎨 Resultado Esperado

1. Pantalla inicial con lista de tareas
2. FAB que navega a formulario de agregar
3. Formulario que retorna la nueva tarea
4. Tap en tarea navega al detalle
5. Botón back regresa a la lista

---

## 💡 Pistas

<details>
<summary>Pista 1: Navegar con push</summary>

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const AddTaskScreen(),
  ),
);
```
</details>

<details>
<summary>Pista 2: Esperar resultado</summary>

```dart
final result = await Navigator.push<Task>(
  context,
  MaterialPageRoute(
    builder: (context) => const AddTaskScreen(),
  ),
);

if (result != null) {
  setState(() {
    _tasks.add(result);
  });
}
```
</details>

<details>
<summary>Pista 3: Retornar datos con pop</summary>

```dart
Navigator.pop(context, newTask);
```
</details>

---

## ✅ Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| Navegación push funcional | 2 |
| Retorno de datos con pop | 2 |
| Paso de datos por constructor | 1 |
| Código limpio y documentado | 1 |
| **Total** | **6** |

---

## 🚀 Desafío Extra

1. Agregar transición personalizada con `PageRouteBuilder`
2. Implementar edición de tareas existentes
3. Agregar confirmación antes de salir del formulario con `PopScope`
