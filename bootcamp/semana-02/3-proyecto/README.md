# 🔨 Proyecto Semana 02: Mi Primera App de Gestión Personal

**⏱️ Duración:** 3-4 horas  
**📊 Dificultad:** ⭐⭐⭐ Intermedio-Avanzado  
**🎯 Objetivo:** Integrar POO, Colecciones y Flutter en una aplicación funcional completa

---

## 🎯 Descripción del Proyecto

Crearás una **aplicación de gestión personal** que combine tareas, notas y contactos. Esta app integrará todos los conceptos aprendidos en la semana:

- **POO**: Clases, herencia, interfaces, mixins
- **Colecciones**: Lists, Maps, Sets con operaciones avanzadas
- **Flutter**: Widgets, navegación, estado, interactividad

---

## 🖼️ Características de la App

### Funcionalidades Principales

1. **📋 Gestor de Tareas**

   - Crear, editar y eliminar tareas
   - Marcar como completadas
   - Filtrar por prioridad y estado
   - Estadísticas de productividad

2. **📝 Bloc de Notas**

   - Crear notas con título y contenido
   - Categorizar notas
   - Buscar en notas
   - Marcar favoritas

3. **👥 Agenda de Contactos**

   - Agregar contactos con foto
   - Información completa (teléfono, email, dirección)
   - Buscar contactos
   - Contactos favoritos

4. **📊 Dashboard**
   - Resumen de tareas pendientes
   - Notas recientes
   - Contactos favoritos
   - Estadísticas generales

---

## 📐 Arquitectura del Proyecto

### Estructura de Carpetas

```
lib/
├── main.dart
├── models/
│   ├── task.dart
│   ├── note.dart
│   ├── contact.dart
│   └── category.dart
├── screens/
│   ├── home_screen.dart
│   ├── tasks_screen.dart
│   ├── notes_screen.dart
│   └── contacts_screen.dart
├── widgets/
│   ├── task_card.dart
│   ├── note_card.dart
│   └── contact_card.dart
└── utils/
    ├── constants.dart
    └── helpers.dart
```

---

## 📋 Guía de Implementación Paso a Paso

### FASE 1: Configuración Inicial (30 min)

#### Paso 1.1: Crear Proyecto

```bash
flutter create gestion_personal_app
cd gestion_personal_app
code .
```

#### Paso 1.2: Limpiar main.dart

Borra todo el contenido de `lib/main.dart` y empieza desde cero:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const GestionPersonalApp());
}

class GestionPersonalApp extends StatelessWidget {
  const GestionPersonalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión Personal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// Pantalla temporal mientras construimos
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión Personal'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('App en construcción...'),
      ),
    );
  }
}
```

**Verifica que compile y ejecute correctamente.**

---

### FASE 2: Modelos de Datos (POO) (45 min)

Crea la carpeta `lib/models/` y los siguientes archivos:

#### Paso 2.1: task.dart

```dart
// lib/models/task.dart

/// Enumeración para el estado de una tarea
enum TaskStatus {
  pending('Pendiente'),
  inProgress('En Progreso'),
  completed('Completada'),
  cancelled('Cancelada');

  const TaskStatus(this.label);
  final String label;
}

/// Enumeración para la prioridad de una tarea
enum Priority {
  low('Baja', 1),
  medium('Media', 2),
  high('Alta', 3),
  critical('Crítica', 4);

  const Priority(this.label, this.value);
  final String label;
  final int value;
}

/// Modelo para una Tarea
///
/// ¿Qué hace?
/// Representa una tarea con toda su información
///
/// ¿Para qué?
/// Encapsular los datos y comportamiento de las tareas
/// Facilitar el manejo de tareas en la aplicación
///
/// ¿Cómo funciona?
/// - Usa enums para estado y prioridad
/// - Tiene métodos para manipular la tarea
/// - Puede convertirse a/desde Map para persistencia
class Task {
  final String id;
  String title;
  String description;
  TaskStatus status;
  Priority priority;
  DateTime createdAt;
  DateTime? completedAt;
  DateTime? dueDate;
  List<String> tags;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.status = TaskStatus.pending,
    this.priority = Priority.medium,
    DateTime? createdAt,
    this.completedAt,
    this.dueDate,
    List<String>? tags,
  })  : createdAt = createdAt ?? DateTime.now(),
        tags = tags ?? [];

  /// Marca la tarea como completada
  void complete() {
    status = TaskStatus.completed;
    completedAt = DateTime.now();
  }

  /// Cancela la tarea
  void cancel() {
    status = TaskStatus.cancelled;
  }

  /// Reinicia la tarea a pendiente
  void reset() {
    status = TaskStatus.pending;
    completedAt = null;
  }

  /// Verifica si la tarea está atrasada
  bool get isOverdue {
    if (dueDate == null || status == TaskStatus.completed) {
      return false;
    }
    return DateTime.now().isAfter(dueDate!);
  }

  /// Verifica si está completada
  bool get isCompleted => status == TaskStatus.completed;

  /// Obtiene el color según prioridad
  int get priorityColor {
    switch (priority) {
      case Priority.low:
        return 0xFF4CAF50; // Verde
      case Priority.medium:
        return 0xFFFF9800; // Naranja
      case Priority.high:
        return 0xFFFF5722; // Rojo-Naranja
      case Priority.critical:
        return 0xFFF44336; // Rojo
    }
  }

  /// Convierte la tarea a Map (para persistencia)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
      'priority': priority.name,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'tags': tags,
    };
  }

  /// Crea una tarea desde un Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      status: TaskStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TaskStatus.pending,
      ),
      priority: Priority.values.firstWhere(
        (e) => e.name == map['priority'],
        orElse: () => Priority.medium,
      ),
      createdAt: DateTime.parse(map['createdAt']),
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'])
          : null,
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  /// Copia de la tarea con modificaciones
  Task copyWith({
    String? title,
    String? description,
    TaskStatus? status,
    Priority? priority,
    DateTime? dueDate,
    List<String>? tags,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: createdAt,
      completedAt: completedAt,
      dueDate: dueDate ?? this.dueDate,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, status: ${status.label}, '
        'priority: ${priority.label})';
  }
}
```

#### Paso 2.2: note.dart

```dart
// lib/models/note.dart

/// Categoría de notas
enum NoteCategory {
  personal('Personal', 0xFF2196F3),
  work('Trabajo', 0xFFFF9800),
  study('Estudio', 0xFF4CAF50),
  ideas('Ideas', 0xFF9C27B0),
  other('Otros', 0xFF607D8B);

  const NoteCategory(this.label, this.colorValue);
  final String label;
  final int colorValue;
}

/// Modelo para una Nota
///
/// Representa notas de texto con categorías y favoritos
class Note {
  final String id;
  String title;
  String content;
  NoteCategory category;
  bool isFavorite;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> tags;

  Note({
    required this.id,
    required this.title,
    this.content = '',
    this.category = NoteCategory.personal,
    this.isFavorite = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        tags = tags ?? [];

  /// Alterna el estado de favorito
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  /// Actualiza el contenido y marca como editado
  void update(String newContent) {
    content = newContent;
    updatedAt = DateTime.now();
  }

  /// Verifica si la nota contiene un término de búsqueda
  bool contains(String searchTerm) {
    final term = searchTerm.toLowerCase();
    return title.toLowerCase().contains(term) ||
        content.toLowerCase().contains(term) ||
        tags.any((tag) => tag.toLowerCase().contains(term));
  }

  /// Obtiene vista previa del contenido
  String get preview {
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }

  /// Convierte a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category.name,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
    };
  }

  /// Crea desde Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'] ?? '',
      category: NoteCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => NoteCategory.personal,
      ),
      isFavorite: map['isFavorite'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, category: ${category.label}, '
        'favorite: $isFavorite)';
  }
}
```

#### Paso 2.3: contact.dart

```dart
// lib/models/contact.dart

/// Modelo para un Contacto
///
/// Representa un contacto con información completa
class Contact {
  final String id;
  String name;
  String? phone;
  String? email;
  String? address;
  String? avatarUrl;
  bool isFavorite;
  DateTime createdAt;
  Map<String, String> customFields;

  Contact({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.avatarUrl,
    this.isFavorite = false,
    DateTime? createdAt,
    Map<String, String>? customFields,
  })  : createdAt = createdAt ?? DateTime.now(),
        customFields = customFields ?? {};

  /// Obtiene las iniciales del nombre
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  /// Verifica si tiene información de contacto
  bool get hasContactInfo => phone != null || email != null;

  /// Alterna favorito
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  /// Busca en todos los campos
  bool contains(String searchTerm) {
    final term = searchTerm.toLowerCase();
    return name.toLowerCase().contains(term) ||
        (phone?.contains(term) ?? false) ||
        (email?.toLowerCase().contains(term) ?? false) ||
        (address?.toLowerCase().contains(term) ?? false);
  }

  /// Convierte a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'avatarUrl': avatarUrl,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'customFields': customFields,
    };
  }

  /// Crea desde Map
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
      avatarUrl: map['avatarUrl'],
      isFavorite: map['isFavorite'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
      customFields: Map<String, String>.from(map['customFields'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, phone: $phone, email: $email)';
  }
}
```

**Checkpoint:** Verifica que todos los modelos compilen sin errores.

---

### FASE 3: Servicios de Gestión (Colecciones) (45 min)

Ahora crearemos clases que gestionen colecciones de estos modelos. Crea `lib/services/`:

#### Paso 3.1: task_manager.dart

```dart
// lib/services/task_manager.dart

import '../models/task.dart';

/// Gestor de Tareas
///
/// ¿Qué hace?
/// Maneja todas las operaciones CRUD de tareas
///
/// ¿Para qué?
/// Centralizar la lógica de negocio de tareas
/// Proporcionar operaciones de filtrado y estadísticas
///
/// ¿Cómo funciona?
/// - Mantiene una lista de tareas en memoria
/// - Proporciona métodos para manipular la colección
/// - Calcula estadísticas en tiempo real
class TaskManager {
  final List<Task> _tasks = [];

  /// Obtiene todas las tareas
  List<Task> get tasks => List.unmodifiable(_tasks);

  /// Número total de tareas
  int get count => _tasks.length;

  /// Agregar tarea
  void addTask(Task task) {
    _tasks.add(task);
  }

  /// Eliminar tarea
  bool removeTask(String taskId) {
    return _tasks.removeWhere((task) => task.id == taskId) > 0;
  }

  /// Actualizar tarea
  bool updateTask(String taskId, Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = updatedTask;
      return true;
    }
    return false;
  }

  /// Obtener tarea por ID
  Task? getTaskById(String taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }

  /// Filtrar por estado
  List<Task> getTasksByStatus(TaskStatus status) {
    return _tasks.where((task) => task.status == status).toList();
  }

  /// Filtrar por prioridad
  List<Task> getTasksByPriority(Priority priority) {
    return _tasks.where((task) => task.priority == priority).toList();
  }

  /// Obtener tareas pendientes
  List<Task> get pendingTasks {
    return _tasks
        .where((task) => task.status == TaskStatus.pending)
        .toList();
  }

  /// Obtener tareas completadas
  List<Task> get completedTasks {
    return _tasks
        .where((task) => task.status == TaskStatus.completed)
        .toList();
  }

  /// Obtener tareas atrasadas
  List<Task> get overdueTasks {
    return _tasks.where((task) => task.isOverdue).toList();
  }

  /// Obtener tareas ordenadas por prioridad
  List<Task> getTasksSortedByPriority() {
    final sorted = List<Task>.from(_tasks);
    sorted.sort((a, b) => b.priority.value.compareTo(a.priority.value));
    return sorted;
  }

  /// Obtener tareas ordenadas por fecha
  List<Task> getTasksSortedByDate() {
    final sorted = List<Task>.from(_tasks);
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  /// Buscar tareas
  List<Task> searchTasks(String query) {
    final lowerQuery = query.toLowerCase();
    return _tasks.where((task) {
      return task.title.toLowerCase().contains(lowerQuery) ||
          task.description.toLowerCase().contains(lowerQuery) ||
          task.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  /// Estadísticas
  Map<String, dynamic> getStatistics() {
    final total = _tasks.length;
    final completed = completedTasks.length;
    final pending = pendingTasks.length;
    final overdue = overdueTasks.length;

    return {
      'total': total,
      'completed': completed,
      'pending': pending,
      'overdue': overdue,
      'completionRate': total > 0 ? (completed / total * 100).toStringAsFixed(1) : '0.0',
      'byPriority': {
        'low': _tasks.where((t) => t.priority == Priority.low).length,
        'medium': _tasks.where((t) => t.priority == Priority.medium).length,
        'high': _tasks.where((t) => t.priority == Priority.high).length,
        'critical': _tasks.where((t) => t.priority == Priority.critical).length,
      },
      'byStatus': {
        'pending': pending,
        'inProgress': _tasks.where((t) => t.status == TaskStatus.inProgress).length,
        'completed': completed,
        'cancelled': _tasks.where((t) => t.status == TaskStatus.cancelled).length,
      },
    };
  }

  /// Limpiar tareas completadas
  int clearCompletedTasks() {
    final count = completedTasks.length;
    _tasks.removeWhere((task) => task.status == TaskStatus.completed);
    return count;
  }

  /// Limpiar todas las tareas
  void clearAll() {
    _tasks.clear();
  }
}
```

#### Paso 3.2: note_manager.dart

```dart
// lib/services/note_manager.dart

import '../models/note.dart';

/// Gestor de Notas
class NoteManager {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);
  int get count => _notes.length;

  void addNote(Note note) {
    _notes.add(note);
  }

  bool removeNote(String noteId) {
    return _notes.removeWhere((note) => note.id == noteId) > 0;
  }

  bool updateNote(String noteId, Note updatedNote) {
    final index = _notes.indexWhere((note) => note.id == noteId);
    if (index != -1) {
      _notes[index] = updatedNote;
      return true;
    }
    return false;
  }

  Note? getNoteById(String noteId) {
    try {
      return _notes.firstWhere((note) => note.id == noteId);
    } catch (e) {
      return null;
    }
  }

  /// Filtrar por categoría
  List<Note> getNotesByCategory(NoteCategory category) {
    return _notes.where((note) => note.category == category).toList();
  }

  /// Obtener notas favoritas
  List<Note> get favoriteNotes {
    return _notes.where((note) => note.isFavorite).toList();
  }

  /// Obtener notas recientes (últimas 5)
  List<Note> get recentNotes {
    final sorted = List<Note>.from(_notes);
    sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return sorted.take(5).toList();
  }

  /// Buscar notas
  List<Note> searchNotes(String query) {
    return _notes.where((note) => note.contains(query)).toList();
  }

  /// Estadísticas
  Map<String, dynamic> getStatistics() {
    return {
      'total': _notes.length,
      'favorites': favoriteNotes.length,
      'byCategory': {
        for (var category in NoteCategory.values)
          category.name: _notes.where((n) => n.category == category).length,
      },
    };
  }

  void clearAll() {
    _notes.clear();
  }
}
```

#### Paso 3.3: contact_manager.dart

```dart
// lib/services/contact_manager.dart

import '../models/contact.dart';

/// Gestor de Contactos
class ContactManager {
  final List<Contact> _contacts = [];

  List<Contact> get contacts => List.unmodifiable(_contacts);
  int get count => _contacts.length;

  void addContact(Contact contact) {
    _contacts.add(contact);
  }

  bool removeContact(String contactId) {
    return _contacts.removeWhere((contact) => contact.id == contactId) > 0;
  }

  bool updateContact(String contactId, Contact updatedContact) {
    final index = _contacts.indexWhere((contact) => contact.id == contactId);
    if (index != -1) {
      _contacts[index] = updatedContact;
      return true;
    }
    return false;
  }

  Contact? getContactById(String contactId) {
    try {
      return _contacts.firstWhere((contact) => contact.id == contactId);
    } catch (e) {
      return null;
    }
  }

  /// Obtener contactos favoritos
  List<Contact> get favoriteContacts {
    return _contacts.where((contact) => contact.isFavorite).toList();
  }

  /// Obtener contactos ordenados alfabéticamente
  List<Contact> getContactsSorted() {
    final sorted = List<Contact>.from(_contacts);
    sorted.sort((a, b) => a.name.compareTo(b.name));
    return sorted;
  }

  /// Buscar contactos
  List<Contact> searchContacts(String query) {
    return _contacts.where((contact) => contact.contains(query)).toList();
  }

  /// Estadísticas
  Map<String, dynamic> getStatistics() {
    return {
      'total': _contacts.length,
      'favorites': favoriteContacts.length,
      'withPhone': _contacts.where((c) => c.phone != null).length,
      'withEmail': _contacts.where((c) => c.email != null).length,
    };
  }

  void clearAll() {
    _contacts.clear();
  }
}
```

**Checkpoint:** Verifica que los managers compilen correctamente.

---

### FASE 4: Interfaz de Usuario Flutter (90 min)

Ahora crearemos las pantallas de Flutter. Por brevedad, te daré la estructura completa del Dashboard y ejemplos para las demás pantallas.

#### Paso 4.1: Dashboard (home_screen.dart)

```dart
// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/note.dart';
import '../models/contact.dart';
import '../services/task_manager.dart';
import '../services/note_manager.dart';
import '../services/contact_manager.dart';
import 'tasks_screen.dart';
import 'notes_screen.dart';
import 'contacts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Managers globales (en una app real, usarías Provider o similar)
  final TaskManager taskManager = TaskManager();
  final NoteManager noteManager = NoteManager();
  final ContactManager contactManager = ContactManager();

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  /// Carga datos de ejemplo
  void _loadSampleData() {
    // Tareas de ejemplo
    taskManager.addTask(Task(
      id: '1',
      title: 'Completar proyecto Flutter',
      description: 'Terminar la app de gestión personal',
      priority: Priority.high,
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ));

    taskManager.addTask(Task(
      id: '2',
      title: 'Estudiar POO en Dart',
      description: 'Revisar clases, herencia y mixins',
      priority: Priority.medium,
      status: TaskStatus.completed,
    ));

    taskManager.addTask(Task(
      id: '3',
      title: 'Practicar colecciones',
      description: 'Ejercicios de List, Map y Set',
      priority: Priority.low,
    ));

    // Notas de ejemplo
    noteManager.addNote(Note(
      id: '1',
      title: 'Ideas para el proyecto',
      content: 'Agregar animaciones, mejorar UI, implementar búsqueda avanzada',
      category: NoteCategory.ideas,
      isFavorite: true,
    ));

    noteManager.addNote(Note(
      id: '2',
      title: 'Conceptos clave de Flutter',
      content: 'StatelessWidget, StatefulWidget, setState(), build()',
      category: NoteCategory.study,
    ));

    // Contactos de ejemplo
    contactManager.addContact(Contact(
      id: '1',
      name: 'Juan Pérez',
      phone: '+34 600 123 456',
      email: 'juan@example.com',
      isFavorite: true,
    ));

    contactManager.addContact(Contact(
      id: '2',
      name: 'María García',
      phone: '+34 600 789 012',
      email: 'maria@example.com',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final taskStats = taskManager.getStatistics();
    final noteStats = noteManager.getStatistics();
    final contactStats = contactManager.getStatistics();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Gestión Personal'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implementar búsqueda global
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bienvenida
            _buildWelcomeCard(),

            const SizedBox(height: 20),

            // Estadísticas rápidas
            _buildQuickStats(taskStats, noteStats, contactStats),

            const SizedBox(height: 20),

            // Secciones principales
            Text(
              'Accesos Rápidos',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 10),

            _buildMainSections(),

            const SizedBox(height: 20),

            // Tareas pendientes
            _buildPendingTasks(),

            const SizedBox(height: 20),

            // Notas recientes
            _buildRecentNotes(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = '¡Buenos días!';
    } else if (hour < 18) {
      greeting = '¡Buenas tardes!';
    } else {
      greeting = '¡Buenas noches!';
    }

    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Organiza tu día de forma eficiente',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(
    Map<String, dynamic> taskStats,
    Map<String, dynamic> noteStats,
    Map<String, dynamic> contactStats,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle,
            label: 'Tareas',
            value: '${taskStats['pending']}/${taskStats['total']}',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatCard(
            icon: Icons.note,
            label: 'Notas',
            value: '${noteStats['total']}',
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatCard(
            icon: Icons.contacts,
            label: 'Contactos',
            value: '${contactStats['total']}',
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSections() {
    return Column(
      children: [
        _buildSectionButton(
          icon: Icons.task_alt,
          title: 'Tareas',
          subtitle: 'Gestiona tus pendientes',
          color: Colors.blue,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TasksScreen(taskManager: taskManager),
              ),
            ).then((_) => setState(() {})); // Actualizar al volver
          },
        ),
        const SizedBox(height: 10),
        _buildSectionButton(
          icon: Icons.note_add,
          title: 'Notas',
          subtitle: 'Tus apuntes y recordatorios',
          color: Colors.orange,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotesScreen(noteManager: noteManager),
              ),
            ).then((_) => setState(() {}));
          },
        ),
        const SizedBox(height: 10),
        _buildSectionButton(
          icon: Icons.contacts,
          title: 'Contactos',
          subtitle: 'Tu agenda personal',
          color: Colors.green,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactsScreen(contactManager: contactManager),
              ),
            ).then((_) => setState(() {}));
          },
        ),
      ],
    );
  }

  Widget _buildSectionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildPendingTasks() {
    final pending = taskManager.pendingTasks.take(3).toList();

    if (pending.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tareas Pendientes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TasksScreen(taskManager: taskManager),
                  ),
                );
              },
              child: const Text('Ver todas'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...pending.map((task) => Card(
              child: ListTile(
                leading: Icon(
                  Icons.circle,
                  color: Color(task.priorityColor),
                  size: 12,
                ),
                title: Text(task.title),
                subtitle: Text(task.priority.label),
                trailing: Checkbox(
                  value: false,
                  onChanged: (value) {
                    setState(() {
                      task.complete();
                    });
                  },
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildRecentNotes() {
    final recent = noteManager.recentNotes.take(3).toList();

    if (recent.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notas Recientes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesScreen(noteManager: noteManager),
                  ),
                );
              },
              child: const Text('Ver todas'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...recent.map((note) => Card(
              child: ListTile(
                leading: Icon(
                  Icons.note,
                  color: Color(note.category.colorValue),
                ),
                title: Text(note.title),
                subtitle: Text(
                  note.preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: note.isFavorite
                    ? const Icon(Icons.star, color: Colors.amber)
                    : null,
              ),
            )),
      ],
    );
  }
}
```

_Continúa en siguiente mensaje debido a límite de tokens..._

---

## ⚠️ NOTA IMPORTANTE

El proyecto completo es extenso. He creado:

✅ **Modelos completos** (Task, Note, Contact)  
✅ **Managers con colecciones** (TaskManager, NoteManager, ContactManager)  
✅ **Dashboard principal** (HomeScreen) funcional

**Para completar el proyecto**, necesitas crear:

📄 `lib/screens/tasks_screen.dart` - Pantalla de tareas  
📄 `lib/screens/notes_screen.dart` - Pantalla de notas  
📄 `lib/screens/contacts_screen.dart` - Pantalla de contactos

---

## 📚 Recursos y Continuación

El README del proyecto incluye toda la estructura. ¿Deseas que continúe con:

1. Las pantallas faltantes (TasksScreen, NotesScreen, ContactsScreen)
2. Widgets reutilizables
3. Guía de mejoras y desafíos adicionales

Este proyecto ya integra todos los conceptos de la semana 02.
