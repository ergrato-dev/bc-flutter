# 📊 Ejemplos de Datos - LifeTracker Pro

## 📋 Índice

1. [Modelos de Dominio](#modelos-de-dominio)
2. [Datos de Prueba](#datos-de-prueba)
3. [Esquema de Base de Datos](#esquema-de-base-de-datos)
4. [Respuestas de API](#respuestas-de-api)

---

## 🏗️ Modelos de Dominio

### Habit (Hábito)

```dart
// lib/domain/entities/habit.dart

import 'package:equatable/equatable.dart';

enum HabitFrequency { daily, weekly, custom }
enum HabitCategory { health, productivity, learning, social, personal }

class Habit extends Equatable {
  final String id;
  final String title;
  final String? description;
  final HabitCategory category;
  final HabitFrequency frequency;
  final List<int>? customDays; // 1=Mon, 7=Sun
  final int targetCount;       // Para hábitos cuantificables
  final String? unit;          // "vasos", "minutos", etc.
  final TimeOfDay? reminderTime;
  final Color color;
  final String icon;
  final DateTime createdAt;
  final bool isArchived;

  const Habit({
    required this.id,
    required this.title,
    this.description,
    required this.category,
    this.frequency = HabitFrequency.daily,
    this.customDays,
    this.targetCount = 1,
    this.unit,
    this.reminderTime,
    required this.color,
    this.icon = '✓',
    required this.createdAt,
    this.isArchived = false,
  });

  @override
  List<Object?> get props => [
    id, title, description, category, frequency,
    customDays, targetCount, unit, reminderTime,
    color, icon, createdAt, isArchived,
  ];
}
```

### HabitCompletion (Registro de Hábito)

```dart
// lib/domain/entities/habit_completion.dart

class HabitCompletion extends Equatable {
  final String id;
  final String habitId;
  final DateTime date;
  final int count;           // Progreso (ej: 5 de 8 vasos)
  final String? note;
  final DateTime completedAt;

  const HabitCompletion({
    required this.id,
    required this.habitId,
    required this.date,
    this.count = 1,
    this.note,
    required this.completedAt,
  });

  bool get isCompleted => count >= targetCount;

  @override
  List<Object?> get props => [id, habitId, date, count, note, completedAt];
}
```

### Task (Tarea)

```dart
// lib/domain/entities/task.dart

enum TaskPriority { low, medium, high, urgent }
enum TaskStatus { pending, inProgress, completed, cancelled }

class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime? dueDate;
  final DateTime? dueTime;
  final String? categoryId;
  final List<String> tags;
  final List<SubTask> subtasks;
  final String? recurrenceRule;
  final DateTime createdAt;
  final DateTime? completedAt;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
    this.dueDate,
    this.dueTime,
    this.categoryId,
    this.tags = const [],
    this.subtasks = const [],
    this.recurrenceRule,
    required this.createdAt,
    this.completedAt,
  });

  int get completedSubtasks => subtasks.where((s) => s.isCompleted).length;
  double get progress => subtasks.isEmpty 
      ? (status == TaskStatus.completed ? 1.0 : 0.0)
      : completedSubtasks / subtasks.length;

  @override
  List<Object?> get props => [
    id, title, description, priority, status,
    dueDate, dueTime, categoryId, tags, subtasks,
    recurrenceRule, createdAt, completedAt,
  ];
}

class SubTask extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;

  const SubTask({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [id, title, isCompleted];
}
```

### JournalEntry (Entrada de Diario)

```dart
// lib/domain/entities/journal_entry.dart

enum Mood { terrible, bad, okay, good, great }

class JournalEntry extends Equatable {
  final String id;
  final DateTime date;
  final Mood mood;
  final String? content;
  final List<String> tags;
  final List<String> gratitudes;      // 3 cosas por las que agradecer
  final List<String> imageUrls;
  final Map<String, dynamic>? metadata; // Datos adicionales
  final DateTime createdAt;
  final DateTime? updatedAt;

  const JournalEntry({
    required this.id,
    required this.date,
    required this.mood,
    this.content,
    this.tags = const [],
    this.gratitudes = const [],
    this.imageUrls = const [],
    this.metadata,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id, date, mood, content, tags,
    gratitudes, imageUrls, metadata, createdAt, updatedAt,
  ];
}
```

### DashboardStats (Estadísticas)

```dart
// lib/domain/entities/dashboard_stats.dart

class DashboardStats extends Equatable {
  final int totalHabits;
  final int completedHabitsToday;
  final double habitCompletionRate;
  final int currentStreak;
  final int longestStreak;
  
  final int totalTasksToday;
  final int completedTasksToday;
  final int overdueTasks;
  
  final List<MoodEntry> weeklyMoods;
  final int journalEntriesThisWeek;
  
  final DateTime generatedAt;

  const DashboardStats({
    required this.totalHabits,
    required this.completedHabitsToday,
    required this.habitCompletionRate,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalTasksToday,
    required this.completedTasksToday,
    required this.overdueTasks,
    required this.weeklyMoods,
    required this.journalEntriesThisWeek,
    required this.generatedAt,
  });

  @override
  List<Object?> get props => [
    totalHabits, completedHabitsToday, habitCompletionRate,
    currentStreak, longestStreak, totalTasksToday,
    completedTasksToday, overdueTasks, weeklyMoods,
    journalEntriesThisWeek, generatedAt,
  ];
}

class MoodEntry {
  final DateTime date;
  final Mood? mood;

  const MoodEntry({required this.date, this.mood});
}
```

---

## 🧪 Datos de Prueba

### Hábitos de Ejemplo

```dart
// test/fixtures/habit_fixtures.dart

class HabitFixtures {
  static final List<Habit> sampleHabits = [
    Habit(
      id: 'habit_001',
      title: 'Morning Exercise',
      description: '30 minutos de ejercicio cardiovascular',
      category: HabitCategory.health,
      frequency: HabitFrequency.daily,
      targetCount: 1,
      reminderTime: const TimeOfDay(hour: 7, minute: 0),
      color: const Color(0xFF66BB6A),
      icon: '🏃',
      createdAt: DateTime(2024, 1, 1),
    ),
    Habit(
      id: 'habit_002',
      title: 'Drink Water',
      description: 'Beber 8 vasos de agua al día',
      category: HabitCategory.health,
      frequency: HabitFrequency.daily,
      targetCount: 8,
      unit: 'vasos',
      color: const Color(0xFF29B6F6),
      icon: '💧',
      createdAt: DateTime(2024, 1, 1),
    ),
    Habit(
      id: 'habit_003',
      title: 'Read 30 min',
      description: 'Leer un libro durante 30 minutos',
      category: HabitCategory.learning,
      frequency: HabitFrequency.daily,
      targetCount: 30,
      unit: 'minutos',
      reminderTime: const TimeOfDay(hour: 21, minute: 0),
      color: const Color(0xFFAB47BC),
      icon: '📚',
      createdAt: DateTime(2024, 1, 5),
    ),
    Habit(
      id: 'habit_004',
      title: 'Meditate',
      description: '10 minutos de meditación',
      category: HabitCategory.personal,
      frequency: HabitFrequency.daily,
      targetCount: 10,
      unit: 'minutos',
      reminderTime: const TimeOfDay(hour: 6, minute: 30),
      color: const Color(0xFFFF7043),
      icon: '🧘',
      createdAt: DateTime(2024, 1, 3),
    ),
    Habit(
      id: 'habit_005',
      title: 'Weekly Review',
      description: 'Revisar metas y planificar la semana',
      category: HabitCategory.productivity,
      frequency: HabitFrequency.weekly,
      customDays: [7], // Domingo
      targetCount: 1,
      color: const Color(0xFF5C6BC0),
      icon: '📋',
      createdAt: DateTime(2024, 1, 1),
    ),
  ];

  static final List<HabitCompletion> sampleCompletions = [
    HabitCompletion(
      id: 'comp_001',
      habitId: 'habit_001',
      date: DateTime.now(),
      count: 1,
      completedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    HabitCompletion(
      id: 'comp_002',
      habitId: 'habit_002',
      date: DateTime.now(),
      count: 5,
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    HabitCompletion(
      id: 'comp_003',
      habitId: 'habit_003',
      date: DateTime.now().subtract(const Duration(days: 1)),
      count: 30,
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];
}
```

### Tareas de Ejemplo

```dart
// test/fixtures/task_fixtures.dart

class TaskFixtures {
  static final List<Task> sampleTasks = [
    Task(
      id: 'task_001',
      title: 'Completar documentación del proyecto',
      description: 'Escribir README y documentación técnica',
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      dueDate: DateTime.now().add(const Duration(days: 2)),
      tags: ['trabajo', 'documentación'],
      subtasks: [
        const SubTask(id: 'st_001', title: 'Escribir README', isCompleted: true),
        const SubTask(id: 'st_002', title: 'Documentar API', isCompleted: false),
        const SubTask(id: 'st_003', title: 'Crear diagramas', isCompleted: false),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Task(
      id: 'task_002',
      title: 'Comprar víveres',
      description: 'Ir al supermercado',
      priority: TaskPriority.medium,
      status: TaskStatus.pending,
      dueDate: DateTime.now(),
      tags: ['personal', 'compras'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Task(
      id: 'task_003',
      title: 'Llamar al médico',
      description: 'Agendar cita de control',
      priority: TaskPriority.urgent,
      status: TaskStatus.pending,
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      tags: ['salud'],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Task(
      id: 'task_004',
      title: 'Preparar presentación',
      description: 'Presentación para reunión del viernes',
      priority: TaskPriority.high,
      status: TaskStatus.completed,
      dueDate: DateTime.now().subtract(const Duration(days: 2)),
      tags: ['trabajo'],
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      completedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
}
```

### Entradas de Diario de Ejemplo

```dart
// test/fixtures/journal_fixtures.dart

class JournalFixtures {
  static final List<JournalEntry> sampleEntries = [
    JournalEntry(
      id: 'journal_001',
      date: DateTime.now(),
      mood: Mood.good,
      content: '''
Hoy fue un día productivo. Logré completar todas mis tareas 
principales y tuve tiempo para hacer ejercicio. Me siento 
satisfecho con mi progreso en el proyecto.
      ''',
      tags: ['productivo', 'ejercicio'],
      gratitudes: [
        'Mi salud',
        'El apoyo de mi equipo',
        'El buen clima de hoy',
      ],
      createdAt: DateTime.now(),
    ),
    JournalEntry(
      id: 'journal_002',
      date: DateTime.now().subtract(const Duration(days: 1)),
      mood: Mood.great,
      content: '''
¡Día increíble! Recibí buenas noticias sobre el proyecto y 
celebramos en equipo. La presentación fue un éxito.
      ''',
      tags: ['celebración', 'trabajo', 'éxito'],
      gratitudes: [
        'Las oportunidades',
        'Mi familia',
        'Los logros del equipo',
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    JournalEntry(
      id: 'journal_003',
      date: DateTime.now().subtract(const Duration(days: 2)),
      mood: Mood.okay,
      content: '''
Día regular. Algunas cosas salieron bien, otras no tanto.
Mañana será mejor.
      ''',
      tags: ['reflexión'],
      gratitudes: [
        'Un techo sobre mi cabeza',
        'Comida en la mesa',
        'Personas que me quieren',
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
}
```

---

## 💾 Esquema de Base de Datos

### SQLite Schema

```sql
-- database/schema.sql

-- Tabla de Hábitos
CREATE TABLE habits (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    category TEXT NOT NULL,
    frequency TEXT NOT NULL DEFAULT 'daily',
    custom_days TEXT,  -- JSON array [1,2,3,4,5]
    target_count INTEGER DEFAULT 1,
    unit TEXT,
    reminder_hour INTEGER,
    reminder_minute INTEGER,
    color INTEGER NOT NULL,
    icon TEXT DEFAULT '✓',
    created_at INTEGER NOT NULL,
    is_archived INTEGER DEFAULT 0
);

-- Tabla de Completions de Hábitos
CREATE TABLE habit_completions (
    id TEXT PRIMARY KEY,
    habit_id TEXT NOT NULL,
    date TEXT NOT NULL,  -- YYYY-MM-DD
    count INTEGER DEFAULT 1,
    note TEXT,
    completed_at INTEGER NOT NULL,
    FOREIGN KEY (habit_id) REFERENCES habits(id) ON DELETE CASCADE
);

-- Índice para búsquedas rápidas
CREATE INDEX idx_completions_habit_date ON habit_completions(habit_id, date);

-- Tabla de Tareas
CREATE TABLE tasks (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    priority TEXT DEFAULT 'medium',
    status TEXT DEFAULT 'pending',
    due_date TEXT,
    due_time TEXT,
    category_id TEXT,
    tags TEXT,  -- JSON array
    recurrence_rule TEXT,
    created_at INTEGER NOT NULL,
    completed_at INTEGER
);

-- Tabla de Subtareas
CREATE TABLE subtasks (
    id TEXT PRIMARY KEY,
    task_id TEXT NOT NULL,
    title TEXT NOT NULL,
    is_completed INTEGER DEFAULT 0,
    sort_order INTEGER DEFAULT 0,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

-- Tabla de Journal
CREATE TABLE journal_entries (
    id TEXT PRIMARY KEY,
    date TEXT NOT NULL UNIQUE,  -- YYYY-MM-DD
    mood TEXT NOT NULL,
    content TEXT,
    tags TEXT,  -- JSON array
    gratitudes TEXT,  -- JSON array
    image_urls TEXT,  -- JSON array
    metadata TEXT,  -- JSON object
    created_at INTEGER NOT NULL,
    updated_at INTEGER
);

-- Índice para búsqueda por fecha
CREATE INDEX idx_journal_date ON journal_entries(date);

-- Tabla de Configuración
CREATE TABLE settings (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL
);

-- Datos iniciales de configuración
INSERT INTO settings (key, value) VALUES
    ('theme_mode', 'system'),
    ('notifications_enabled', 'true'),
    ('daily_reminder_time', '09:00'),
    ('first_day_of_week', '1');
```

### Migraciones

```dart
// lib/data/local/database_migrations.dart

class DatabaseMigrations {
  static const migrations = <int, String>{
    1: '''
      CREATE TABLE habits (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        category TEXT NOT NULL,
        frequency TEXT NOT NULL DEFAULT 'daily',
        custom_days TEXT,
        target_count INTEGER DEFAULT 1,
        unit TEXT,
        reminder_hour INTEGER,
        reminder_minute INTEGER,
        color INTEGER NOT NULL,
        icon TEXT DEFAULT '✓',
        created_at INTEGER NOT NULL,
        is_archived INTEGER DEFAULT 0
      );
    ''',
    2: '''
      CREATE TABLE habit_completions (
        id TEXT PRIMARY KEY,
        habit_id TEXT NOT NULL,
        date TEXT NOT NULL,
        count INTEGER DEFAULT 1,
        note TEXT,
        completed_at INTEGER NOT NULL,
        FOREIGN KEY (habit_id) REFERENCES habits(id) ON DELETE CASCADE
      );
      CREATE INDEX idx_completions_habit_date ON habit_completions(habit_id, date);
    ''',
    3: '''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        priority TEXT DEFAULT 'medium',
        status TEXT DEFAULT 'pending',
        due_date TEXT,
        due_time TEXT,
        category_id TEXT,
        tags TEXT,
        recurrence_rule TEXT,
        created_at INTEGER NOT NULL,
        completed_at INTEGER
      );
    ''',
    4: '''
      CREATE TABLE subtasks (
        id TEXT PRIMARY KEY,
        task_id TEXT NOT NULL,
        title TEXT NOT NULL,
        is_completed INTEGER DEFAULT 0,
        sort_order INTEGER DEFAULT 0,
        FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
      );
    ''',
    5: '''
      CREATE TABLE journal_entries (
        id TEXT PRIMARY KEY,
        date TEXT NOT NULL UNIQUE,
        mood TEXT NOT NULL,
        content TEXT,
        tags TEXT,
        gratitudes TEXT,
        image_urls TEXT,
        metadata TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER
      );
      CREATE INDEX idx_journal_date ON journal_entries(date);
    ''',
  };
}
```

---

## 🌐 Respuestas de API

### Backup/Sync Response

```json
{
  "status": "success",
  "data": {
    "backup_id": "bkp_2024_01_15_143022",
    "timestamp": "2024-01-15T14:30:22Z",
    "stats": {
      "habits": 5,
      "habit_completions": 127,
      "tasks": 23,
      "journal_entries": 45
    },
    "size_bytes": 45678
  }
}
```

### Restore Response

```json
{
  "status": "success",
  "data": {
    "restored_from": "bkp_2024_01_15_143022",
    "items_restored": {
      "habits": 5,
      "habit_completions": 127,
      "tasks": 23,
      "journal_entries": 45
    },
    "conflicts_resolved": 2,
    "timestamp": "2024-01-16T10:15:00Z"
  }
}
```

### Analytics Event

```json
{
  "event_name": "habit_completed",
  "params": {
    "habit_id": "habit_001",
    "habit_category": "health",
    "streak_count": 15,
    "completion_time": "morning",
    "is_first_completion_today": true
  },
  "timestamp": "2024-01-15T07:30:00Z",
  "user_properties": {
    "app_version": "1.0.0",
    "platform": "android",
    "days_since_install": 30
  }
}
```

---

## 🔗 Navegación

| ⬅️ Anterior                        | 🏠 Índice                 | Siguiente ➡️         |
| ---------------------------------- | ------------------------- | -------------------- |
| [Guía Diseño](./GUIA-DISENO.md)    | [Semana 10](../README.md) | [Recursos](../4-recursos/) |
