# 🗄️ Módulo 02: SQLite con sqflite

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- [ ] Diseñar esquemas de base de datos relacionales
- [ ] Implementar operaciones CRUD completas
- [ ] Manejar relaciones entre tablas (1:N, N:N)
- [ ] Ejecutar consultas SQL avanzadas
- [ ] Gestionar migraciones de esquema

---

## 📚 Contenido

### 1. ¿Qué es SQLite?

**SQLite** es un motor de base de datos relacional **embebido**, ideal para almacenamiento local en dispositivos móviles.

#### Características

| Característica     | Descripción                  |
| ------------------ | ---------------------------- |
| **Tipo**           | Base de datos relacional SQL |
| **Almacenamiento** | Archivo único en disco       |
| **Transacciones**  | Soporta ACID                 |
| **Capacidad**      | Hasta 281 TB teóricos        |
| **Velocidad**      | Muy rápido para lecturas     |

#### Cuándo Usar SQLite

```
✅ Datos estructurados con relaciones
✅ Necesidad de consultas complejas (JOIN, WHERE, ORDER BY)
✅ Grandes cantidades de registros (miles+)
✅ Integridad referencial importante
✅ Búsquedas y filtros avanzados

❌ Datos simples sin estructura (usar SharedPreferences)
❌ Necesidad de sincronización en tiempo real (usar Firebase)
❌ Archivos binarios grandes (usar file system)
```

---

### 2. Instalación y Configuración

#### Dependencias

```yaml
# pubspec.yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
```

```bash
flutter pub get
```

#### Imports

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
```

---

### 3. Configuración de la Base de Datos

#### Patrón Singleton para Database

```dart
/**
 * DatabaseHelper: Clase helper para gestionar SQLite.
 *
 * ¿Qué hace?
 * Proporciona una única instancia de la base de datos
 * y métodos para operaciones CRUD.
 *
 * ¿Por qué singleton?
 * - Evita múltiples conexiones abiertas
 * - Garantiza consistencia
 * - Mejor rendimiento
 */
class DatabaseHelper {
  // Singleton
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Getter para la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  // Inicialización
  Future<Database> _initDB(String fileName) async {
    // Obtener ruta del directorio de bases de datos
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    // Abrir/crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  // Crear tablas
  Future<void> _createDB(Database db, int version) async {
    // Tabla de usuarios
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        avatar TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // Tabla de notas
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        content TEXT,
        color INTEGER DEFAULT 0xFFFFFFFF,
        is_pinned INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Tabla de etiquetas
    await db.execute('''
      CREATE TABLE tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL,
        color INTEGER DEFAULT 0xFF2196F3
      )
    ''');

    // Tabla pivote notas-etiquetas (relación N:N)
    await db.execute('''
      CREATE TABLE note_tags (
        note_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        PRIMARY KEY (note_id, tag_id),
        FOREIGN KEY (note_id) REFERENCES notes (id) ON DELETE CASCADE,
        FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE
      )
    ''');

    // Índices para mejorar rendimiento
    await db.execute('CREATE INDEX idx_notes_user ON notes (user_id)');
    await db.execute('CREATE INDEX idx_notes_pinned ON notes (is_pinned)');
  }

  // Migraciones
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Migración de versión 1 a 2
      await db.execute('ALTER TABLE notes ADD COLUMN archived INTEGER DEFAULT 0');
    }
    if (oldVersion < 3) {
      // Migración de versión 2 a 3
      await db.execute('ALTER TABLE users ADD COLUMN phone TEXT');
    }
  }

  // Cerrar conexión
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
```

---

### 4. Modelos de Datos

```dart
/**
 * User: Modelo de usuario.
 *
 * Incluye métodos de serialización para SQLite.
 */
class User {
  final int? id;
  final String name;
  final String email;
  final String? avatar;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.createdAt,
    this.updatedAt,
  });

  // Convertir a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Crear desde Map de SQLite
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      avatar: map['avatar'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
    );
  }

  // copyWith para inmutabilidad
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/**
 * Note: Modelo de nota.
 */
class Note {
  final int? id;
  final int userId;
  final String title;
  final String? content;
  final int color;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<Tag>? tags; // Para joins

  Note({
    this.id,
    required this.userId,
    required this.title,
    this.content,
    this.color = 0xFFFFFFFF,
    this.isPinned = false,
    required this.createdAt,
    this.updatedAt,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'color': color,
      'is_pinned': isPinned ? 1 : 0, // SQLite no tiene bool
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      content: map['content'],
      color: map['color'] ?? 0xFFFFFFFF,
      isPinned: map['is_pinned'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
    );
  }

  Note copyWith({
    int? id,
    int? userId,
    String? title,
    String? content,
    int? color,
    bool? isPinned,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Tag>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
    );
  }
}

/**
 * Tag: Modelo de etiqueta.
 */
class Tag {
  final int? id;
  final String name;
  final int color;

  Tag({
    this.id,
    required this.name,
    this.color = 0xFF2196F3,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'color': color,
  };

  factory Tag.fromMap(Map<String, dynamic> map) => Tag(
    id: map['id'],
    name: map['name'],
    color: map['color'] ?? 0xFF2196F3,
  );
}
```

---

### 5. Operaciones CRUD

#### CREATE (Insertar)

```dart
/**
 * Métodos de inserción en DatabaseHelper.
 */
class DatabaseHelper {
  // ... código anterior ...

  // ===== CREATE =====

  /// Insertar un usuario
  Future<int> insertUser(User user) async {
    final db = await database;

    // insert() retorna el ID del nuevo registro
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Insertar una nota
  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  /// Insertar múltiples registros en transacción
  Future<void> insertMultipleNotes(List<Note> notes) async {
    final db = await database;

    // Batch para múltiples operaciones eficientes
    final batch = db.batch();

    for (final note in notes) {
      batch.insert('notes', note.toMap());
    }

    // Ejecutar todas las operaciones
    await batch.commit(noResult: true);
  }

  /// Insertar con transacción manual
  Future<int> insertNoteWithTags(Note note, List<int> tagIds) async {
    final db = await database;

    return await db.transaction((txn) async {
      // Insertar nota
      final noteId = await txn.insert('notes', note.toMap());

      // Insertar relaciones con etiquetas
      for (final tagId in tagIds) {
        await txn.insert('note_tags', {
          'note_id': noteId,
          'tag_id': tagId,
        });
      }

      return noteId;
    });
  }
}
```

#### READ (Consultar)

```dart
class DatabaseHelper {
  // ... código anterior ...

  // ===== READ =====

  /// Obtener todos los usuarios
  Future<List<User>> getAllUsers() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  /// Obtener usuario por ID
  Future<User?> getUserById(int id) async {
    final db = await database;

    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return User.fromMap(maps.first);
  }

  /// Obtener usuario por email
  Future<User?> getUserByEmail(String email) async {
    final db = await database;

    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isEmpty) return null;
    return User.fromMap(maps.first);
  }

  /// Obtener notas de un usuario
  Future<List<Note>> getNotesByUser(int userId) async {
    final db = await database;

    final maps = await db.query(
      'notes',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'is_pinned DESC, created_at DESC',
    );

    return maps.map((m) => Note.fromMap(m)).toList();
  }

  /// Buscar notas por título
  Future<List<Note>> searchNotes(String query) async {
    final db = await database;

    final maps = await db.query(
      'notes',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'created_at DESC',
    );

    return maps.map((m) => Note.fromMap(m)).toList();
  }

  /// Consulta SQL raw
  Future<List<Note>> getRecentNotes(int limit) async {
    final db = await database;

    final maps = await db.rawQuery('''
      SELECT * FROM notes
      WHERE is_pinned = 0
      ORDER BY created_at DESC
      LIMIT ?
    ''', [limit]);

    return maps.map((m) => Note.fromMap(m)).toList();
  }

  /// JOIN: Obtener nota con sus etiquetas
  Future<Note?> getNoteWithTags(int noteId) async {
    final db = await database;

    // Obtener nota
    final noteMaps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [noteId],
    );

    if (noteMaps.isEmpty) return null;

    // Obtener etiquetas con JOIN
    final tagMaps = await db.rawQuery('''
      SELECT t.* FROM tags t
      INNER JOIN note_tags nt ON t.id = nt.tag_id
      WHERE nt.note_id = ?
    ''', [noteId]);

    final tags = tagMaps.map((m) => Tag.fromMap(m)).toList();

    return Note.fromMap(noteMaps.first).copyWith(tags: tags);
  }

  /// Contar registros
  Future<int> countNotes(int userId) async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM notes WHERE user_id = ?',
      [userId],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Paginación
  Future<List<Note>> getNotesPaginated({
    required int userId,
    required int page,
    int pageSize = 20,
  }) async {
    final db = await database;

    final maps = await db.query(
      'notes',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
      limit: pageSize,
      offset: page * pageSize,
    );

    return maps.map((m) => Note.fromMap(m)).toList();
  }
}
```

#### UPDATE (Actualizar)

```dart
class DatabaseHelper {
  // ... código anterior ...

  // ===== UPDATE =====

  /// Actualizar usuario
  Future<int> updateUser(User user) async {
    final db = await database;

    // Agregar timestamp de actualización
    final updatedUser = user.copyWith(updatedAt: DateTime.now());

    return await db.update(
      'users',
      updatedUser.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  /// Actualizar nota
  Future<int> updateNote(Note note) async {
    final db = await database;

    final updatedNote = note.copyWith(updatedAt: DateTime.now());

    return await db.update(
      'notes',
      updatedNote.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  /// Actualizar campo específico
  Future<int> toggleNotePinned(int noteId, bool isPinned) async {
    final db = await database;

    return await db.update(
      'notes',
      {
        'is_pinned': isPinned ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [noteId],
    );
  }

  /// Actualización masiva
  Future<int> unpinAllNotes(int userId) async {
    final db = await database;

    return await db.update(
      'notes',
      {'is_pinned': 0},
      where: 'user_id = ? AND is_pinned = 1',
      whereArgs: [userId],
    );
  }

  /// Actualizar con SQL raw
  Future<void> incrementViewCount(int noteId) async {
    final db = await database;

    await db.rawUpdate(
      'UPDATE notes SET view_count = view_count + 1 WHERE id = ?',
      [noteId],
    );
  }
}
```

#### DELETE (Eliminar)

```dart
class DatabaseHelper {
  // ... código anterior ...

  // ===== DELETE =====

  /// Eliminar usuario (cascade elimina sus notas)
  Future<int> deleteUser(int id) async {
    final db = await database;

    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Eliminar nota
  Future<int> deleteNote(int id) async {
    final db = await database;

    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Eliminar múltiples notas
  Future<int> deleteNotes(List<int> ids) async {
    final db = await database;

    // Crear placeholders: ?, ?, ?
    final placeholders = List.filled(ids.length, '?').join(', ');

    return await db.delete(
      'notes',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
  }

  /// Eliminar notas antiguas
  Future<int> deleteOldNotes(int daysOld) async {
    final db = await database;

    final cutoffDate = DateTime.now()
        .subtract(Duration(days: daysOld))
        .toIso8601String();

    return await db.delete(
      'notes',
      where: 'created_at < ? AND is_pinned = 0',
      whereArgs: [cutoffDate],
    );
  }

  /// Eliminar todos los registros de una tabla
  Future<void> clearTable(String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }

  /// Eliminar toda la base de datos
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    await close();
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
```

---

### 6. Repository Pattern

```dart
/**
 * NoteRepository: Abstracción sobre DatabaseHelper.
 *
 * ¿Para qué?
 * - Separar lógica de persistencia de la UI
 * - Facilitar testing con mocks
 * - Permitir cambiar implementación (SQLite -> Firebase)
 */
abstract class INoteRepository {
  Future<List<Note>> getAll();
  Future<Note?> getById(int id);
  Future<List<Note>> search(String query);
  Future<int> create(Note note);
  Future<int> update(Note note);
  Future<int> delete(int id);
}

class NoteRepository implements INoteRepository {
  final DatabaseHelper _db;

  NoteRepository(this._db);

  @override
  Future<List<Note>> getAll() => _db.getAllNotes();

  @override
  Future<Note?> getById(int id) => _db.getNoteById(id);

  @override
  Future<List<Note>> search(String query) => _db.searchNotes(query);

  @override
  Future<int> create(Note note) => _db.insertNote(note);

  @override
  Future<int> update(Note note) => _db.updateNote(note);

  @override
  Future<int> delete(int id) => _db.deleteNote(id);
}

// Uso con Provider
class NoteProvider extends ChangeNotifier {
  final INoteRepository _repository;

  List<Note> _notes = [];
  bool _isLoading = false;
  String? _error;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  NoteProvider(this._repository);

  Future<void> loadNotes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _notes = await _repository.getAll();
    } catch (e) {
      _error = 'Error al cargar notas: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addNote(Note note) async {
    try {
      final id = await _repository.create(note);
      _notes.add(note.copyWith(id: id));
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error al crear nota: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeNote(int id) async {
    try {
      await _repository.delete(id);
      _notes.removeWhere((n) => n.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error al eliminar: $e';
      notifyListeners();
      return false;
    }
  }
}
```

---

### 7. Buenas Prácticas

#### ✅ Hacer

```dart
// 1. Usar transacciones para operaciones múltiples
await db.transaction((txn) async {
  await txn.insert(...);
  await txn.update(...);
});

// 2. Usar índices en columnas frecuentemente consultadas
await db.execute('CREATE INDEX idx_user_email ON users (email)');

// 3. Usar parámetros en consultas (evitar SQL injection)
db.query('users', where: 'email = ?', whereArgs: [email]);

// 4. Cerrar la base de datos cuando no se use
@override
void dispose() {
  DatabaseHelper.instance.close();
  super.dispose();
}

// 5. Manejar migraciones correctamente
Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) { /* migración */ }
}
```

#### ❌ Evitar

```dart
// 1. NO concatenar strings en consultas
db.rawQuery('SELECT * FROM users WHERE email = "$email"'); // SQL Injection!

// 2. NO crear múltiples instancias de Database
final db1 = await openDatabase('db.db');
final db2 = await openDatabase('db.db'); // Conflicto

// 3. NO olvidar await en operaciones
db.insert('users', user.toMap()); // Sin await puede fallar silenciosamente

// 4. NO usar DELETE sin WHERE (a menos que sea intencional)
db.delete('notes'); // ¡Elimina todo!

// 5. NO ignorar errores
try {
  await db.insert(...);
} catch (e) {
  // Siempre manejar el error
  print('Error: $e');
}
```

---

## 📖 Recursos

- [Documentación sqflite](https://pub.dev/packages/sqflite)
- [SQLite Tutorial](https://www.sqlitetutorial.net/)
- [Flutter Cookbook - SQLite](https://docs.flutter.dev/cookbook/persistence/sqlite)

---

## ➡️ Siguiente Módulo

[03 - Hive y Almacenamiento de Archivos](./03-hive-archivos.md) - NoSQL rápido y manejo del file system.
