# 🧪 Testing de Persistencia

## 📋 Guía de Testing

> Estrategias y patrones para testear código de persistencia en Flutter.

---

## 🎯 Tipos de Tests

| Tipo            | Propósito                | Velocidad | Dependencias |
| --------------- | ------------------------ | --------- | ------------ |
| **Unit**        | Lógica de datos/modelos  | ⚡ Rápido | Ninguna      |
| **Integración** | Interacción con storage  | 🔄 Medio  | Mock/Real DB |
| **Widget**      | UI con datos persistidos | 🔄 Medio  | Mocks        |

---

## 🧪 Testing de SharedPreferences

### Setup de Mocks

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Configurar mock antes de cada test
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SettingsService', () {
    test('should save and retrieve dark mode preference', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({});
      final service = SettingsService();
      await service.initialize();

      // Act
      await service.setDarkMode(true);

      // Assert
      expect(service.isDarkMode, true);
    });

    test('should return default value when preference not set', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({});
      final service = SettingsService();
      await service.initialize();

      // Assert
      expect(service.isDarkMode, false); // Default value
    });

    test('should persist values between instances', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({
        'dark_mode': true,
        'language': 'es',
      });

      // Act
      final prefs = await SharedPreferences.getInstance();

      // Assert
      expect(prefs.getBool('dark_mode'), true);
      expect(prefs.getString('language'), 'es');
    });
  });
}
```

### Servicio Testeable

```dart
/// Servicio de settings con inyección de dependencias
class SettingsService {
  SharedPreferences? _prefs;

  // Permite inyectar mock en tests
  SettingsService({SharedPreferences? prefs}) : _prefs = prefs;

  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  bool get isDarkMode => _prefs?.getBool('dark_mode') ?? false;

  Future<void> setDarkMode(bool value) async {
    await _prefs?.setBool('dark_mode', value);
  }

  String get language => _prefs?.getString('language') ?? 'en';

  Future<void> setLanguage(String value) async {
    await _prefs?.setString('language', value);
  }
}

// Test con inyección
void main() {
  test('should work with injected prefs', () async {
    SharedPreferences.setMockInitialValues({'dark_mode': true});
    final prefs = await SharedPreferences.getInstance();
    final service = SettingsService(prefs: prefs);

    expect(service.isDarkMode, true);
  });
}
```

---

## 🗄️ Testing de SQLite

### Database en Memoria

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Inicializar FFI para tests
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('NoteDao', () {
    late Database db;
    late NoteDao noteDao;

    setUp(() async {
      // Crear database en memoria para cada test
      db = await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE notes (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              content TEXT,
              created_at TEXT DEFAULT CURRENT_TIMESTAMP
            )
          ''');
        },
      );

      noteDao = NoteDao(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('should insert and retrieve note', () async {
      // Arrange
      final note = Note(title: 'Test Note', content: 'Content');

      // Act
      final id = await noteDao.insert(note);
      final retrieved = await noteDao.getById(id);

      // Assert
      expect(retrieved, isNotNull);
      expect(retrieved!.title, 'Test Note');
      expect(retrieved.content, 'Content');
    });

    test('should update note', () async {
      // Arrange
      final note = Note(title: 'Original', content: 'Content');
      final id = await noteDao.insert(note);

      // Act
      final updated = note.copyWith(id: id, title: 'Updated');
      await noteDao.update(updated);
      final retrieved = await noteDao.getById(id);

      // Assert
      expect(retrieved!.title, 'Updated');
    });

    test('should delete note', () async {
      // Arrange
      final note = Note(title: 'To Delete', content: 'Content');
      final id = await noteDao.insert(note);

      // Act
      await noteDao.delete(id);
      final retrieved = await noteDao.getById(id);

      // Assert
      expect(retrieved, isNull);
    });

    test('should return all notes ordered by date', () async {
      // Arrange
      await noteDao.insert(Note(title: 'Note 1'));
      await noteDao.insert(Note(title: 'Note 2'));
      await noteDao.insert(Note(title: 'Note 3'));

      // Act
      final notes = await noteDao.getAll();

      // Assert
      expect(notes.length, 3);
    });

    test('should search notes by title', () async {
      // Arrange
      await noteDao.insert(Note(title: 'Flutter Tutorial'));
      await noteDao.insert(Note(title: 'Dart Basics'));
      await noteDao.insert(Note(title: 'Flutter Widgets'));

      // Act
      final results = await noteDao.search('Flutter');

      // Assert
      expect(results.length, 2);
    });
  });
}
```

### Mock de Database

```dart
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';

@GenerateMocks([Database])
import 'note_dao_test.mocks.dart';

void main() {
  group('NoteRepository with mock', () {
    late MockDatabase mockDb;
    late NoteRepository repository;

    setUp(() {
      mockDb = MockDatabase();
      repository = NoteRepository(mockDb);
    });

    test('should call db.query when getting all notes', () async {
      // Arrange
      when(mockDb.query(
        'notes',
        orderBy: anyNamed('orderBy'),
      )).thenAnswer((_) async => [
        {'id': 1, 'title': 'Note 1', 'content': 'Content 1'},
        {'id': 2, 'title': 'Note 2', 'content': 'Content 2'},
      ]);

      // Act
      final notes = await repository.getAll();

      // Assert
      verify(mockDb.query('notes', orderBy: anyNamed('orderBy'))).called(1);
      expect(notes.length, 2);
    });

    test('should handle database errors', () async {
      // Arrange
      when(mockDb.query(any)).thenThrow(DatabaseException('Error'));

      // Act & Assert
      expect(
        () => repository.getAll(),
        throwsA(isA<DatabaseException>()),
      );
    });
  });
}
```

---

## 📦 Testing de Hive

### Setup para Tests

```dart
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    // Crear directorio temporal para Hive
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);

    // Registrar adapters
    Hive.registerAdapter(TaskAdapter());
  });

  tearDownAll(() async {
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  group('TaskRepository', () {
    late Box<Task> box;
    late TaskRepository repository;

    setUp(() async {
      box = await Hive.openBox<Task>('tasks_test_${DateTime.now().millisecondsSinceEpoch}');
      repository = TaskRepository(box);
    });

    tearDown(() async {
      await box.clear();
      await box.close();
    });

    test('should add task', () async {
      // Arrange
      final task = Task(title: 'Test Task');

      // Act
      await repository.add(task);

      // Assert
      expect(box.length, 1);
      expect(box.values.first.title, 'Test Task');
    });

    test('should get all tasks', () async {
      // Arrange
      await box.add(Task(title: 'Task 1'));
      await box.add(Task(title: 'Task 2'));

      // Act
      final tasks = repository.getAll();

      // Assert
      expect(tasks.length, 2);
    });

    test('should toggle task completion', () async {
      // Arrange
      final task = Task(title: 'Task', isCompleted: false);
      final key = await box.add(task);

      // Act
      await repository.toggleComplete(key);

      // Assert
      expect(box.get(key)!.isCompleted, true);
    });

    test('should filter completed tasks', () async {
      // Arrange
      await box.add(Task(title: 'Pending', isCompleted: false));
      await box.add(Task(title: 'Done', isCompleted: true));
      await box.add(Task(title: 'Also Done', isCompleted: true));

      // Act
      final completed = repository.getCompleted();

      // Assert
      expect(completed.length, 2);
    });
  });
}
```

### Mock de Box

```dart
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';

@GenerateMocks([Box])
import 'task_repository_test.mocks.dart';

void main() {
  group('TaskRepository with mock box', () {
    late MockBox<Task> mockBox;
    late TaskRepository repository;

    setUp(() {
      mockBox = MockBox<Task>();
      repository = TaskRepository(mockBox);
    });

    test('should call box.add when adding task', () async {
      // Arrange
      final task = Task(title: 'New Task');
      when(mockBox.add(any)).thenAnswer((_) async => 0);

      // Act
      await repository.add(task);

      // Assert
      verify(mockBox.add(task)).called(1);
    });

    test('should return values from box', () {
      // Arrange
      final tasks = [
        Task(title: 'Task 1'),
        Task(title: 'Task 2'),
      ];
      when(mockBox.values).thenReturn(tasks);

      // Act
      final result = repository.getAll();

      // Assert
      expect(result.length, 2);
    });
  });
}
```

---

## 🔌 Integration Tests

### Test End-to-End

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Notes App Integration', () {
    testWidgets('should create and display note', (tester) async {
      // Arrange
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Act - Crear nota
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(Key('note_title_field')),
        'Test Note',
      );
      await tester.enterText(
        find.byKey(Key('note_content_field')),
        'Test Content',
      );

      await tester.tap(find.byKey(Key('save_button')));
      await tester.pumpAndSettle();

      // Assert - Verificar que aparece en la lista
      expect(find.text('Test Note'), findsOneWidget);

      // Act - Abrir nota
      await tester.tap(find.text('Test Note'));
      await tester.pumpAndSettle();

      // Assert - Verificar contenido
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('should persist data after restart', (tester) async {
      // Primera ejecución
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Crear nota
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key('note_title_field')), 'Persistent');
      await tester.tap(find.byKey(Key('save_button')));
      await tester.pumpAndSettle();

      // Simular reinicio
      await tester.pumpWidget(Container()); // Destruir app
      await tester.pumpWidget(MyApp()); // Reiniciar
      await tester.pumpAndSettle();

      // Verificar que los datos persisten
      expect(find.text('Persistent'), findsOneWidget);
    });
  });
}
```

---

## 🏗️ Test Fixtures

### Factory de Datos de Prueba

```dart
/// Factory para crear datos de prueba
class TestDataFactory {
  static int _noteCounter = 0;
  static int _taskCounter = 0;

  /// Crear nota de prueba
  static Note createNote({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
  }) {
    _noteCounter++;
    return Note(
      id: id,
      title: title ?? 'Test Note $_noteCounter',
      content: content ?? 'Content for note $_noteCounter',
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  /// Crear lista de notas
  static List<Note> createNotes(int count) {
    return List.generate(count, (_) => createNote());
  }

  /// Crear tarea de prueba
  static Task createTask({
    String? title,
    bool isCompleted = false,
    int priority = 1,
  }) {
    _taskCounter++;
    return Task(
      title: title ?? 'Test Task $_taskCounter',
      isCompleted: isCompleted,
      priority: priority,
    );
  }

  /// Reset counters
  static void reset() {
    _noteCounter = 0;
    _taskCounter = 0;
  }
}

// Uso en tests
void main() {
  setUp(() {
    TestDataFactory.reset();
  });

  test('should handle multiple notes', () async {
    final notes = TestDataFactory.createNotes(100);
    // ... test with notes
  });
}
```

### Seeder de Base de Datos

```dart
/// Seeder para poblar DB de prueba
class TestDatabaseSeeder {
  final Database _db;

  TestDatabaseSeeder(this._db);

  /// Sembrar datos de prueba
  Future<void> seed() async {
    await _seedFolders();
    await _seedNotes();
    await _seedTags();
  }

  Future<void> _seedFolders() async {
    final batch = _db.batch();

    batch.insert('folders', {'name': 'Personal', 'color': '#FF5733'});
    batch.insert('folders', {'name': 'Work', 'color': '#33FF57'});
    batch.insert('folders', {'name': 'Ideas', 'color': '#3357FF'});

    await batch.commit();
  }

  Future<void> _seedNotes() async {
    final batch = _db.batch();

    for (int i = 1; i <= 10; i++) {
      batch.insert('notes', {
        'title': 'Note $i',
        'content': 'Content for note $i',
        'folder_id': (i % 3) + 1,
        'created_at': DateTime.now()
            .subtract(Duration(days: i))
            .toIso8601String(),
      });
    }

    await batch.commit();
  }

  Future<void> _seedTags() async {
    final batch = _db.batch();

    batch.insert('tags', {'name': 'Important'});
    batch.insert('tags', {'name': 'Urgent'});
    batch.insert('tags', {'name': 'Later'});

    await batch.commit();
  }

  /// Limpiar datos
  Future<void> clear() async {
    await _db.delete('note_tags');
    await _db.delete('notes');
    await _db.delete('folders');
    await _db.delete('tags');
  }
}
```

---

## 📊 Coverage de Tests

### Configuración

```yaml
# pubspec.yaml
dev_dependencies:
  test: ^1.24.0
  mockito: ^5.4.0
  build_runner: ^2.4.0
  sqflite_common_ffi: ^2.3.0
```

### Ejecutar con Coverage

```bash
# Ejecutar tests con coverage
flutter test --coverage

# Generar reporte HTML
genhtml coverage/lcov.info -o coverage/html

# Abrir reporte
open coverage/html/index.html
```

---

## 📋 Checklist de Testing

### Unit Tests

- [ ] Modelos y transformaciones (toMap/fromMap)
- [ ] Validaciones de datos
- [ ] Lógica de negocio

### Integration Tests

- [ ] CRUD operations
- [ ] Queries complejas
- [ ] Migraciones
- [ ] Manejo de errores

### Widget Tests

- [ ] UI con datos mock
- [ ] Estados de carga/error
- [ ] Interacciones de usuario

### E2E Tests

- [ ] Flujos completos
- [ ] Persistencia entre sesiones
- [ ] Escenarios de error

---

## ⚠️ Errores Comunes en Testing

| Error              | Causa                   | Solución                     |
| ------------------ | ----------------------- | ---------------------------- |
| Tests fallan en CI | Dependencias de sistema | Usar sqflite_common_ffi      |
| Estado compartido  | Sin reset entre tests   | setUp/tearDown adecuados     |
| Tests lentos       | DB real en cada test    | DB en memoria                |
| Flaky tests        | Async no esperado       | Usar pumpAndSettle           |
| Mock incompleto    | Métodos no stubbeados   | Verificar todas las llamadas |

---

> 📌 **Regla de Oro**: Si tu código de persistencia no tiene tests, no puedes estar seguro de que funciona. Testea los caminos felices Y los errores.
