# 📄 Cheatsheet: SQLite con sqflite

## 📋 Referencia Rápida

> Guía de consulta rápida para SQLite/sqflite en Flutter.

---

## 🚀 Setup Inicial

### Dependencias

```yaml
# pubspec.yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
```

### Instalación

```bash
flutter pub get
```

---

## 📝 Abrir/Crear Base de Datos

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'my_database.db');
  
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT UNIQUE,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');
    },
  );
}
```

---

## 🗃️ Tipos de Datos SQLite

| SQLite | Dart | Ejemplo |
|--------|------|---------|
| `INTEGER` | `int` | `id INTEGER PRIMARY KEY` |
| `TEXT` | `String` | `name TEXT NOT NULL` |
| `REAL` | `double` | `price REAL` |
| `BLOB` | `Uint8List` | `image BLOB` |
| `NULL` | `null` | Cualquier columna nullable |

---

## ➕ INSERT (Crear)

### Método rawInsert

```dart
final id = await db.rawInsert('''
  INSERT INTO users (name, email) VALUES (?, ?)
''', ['Juan', 'juan@email.com']);
```

### Método insert

```dart
final id = await db.insert(
  'users',
  {'name': 'Juan', 'email': 'juan@email.com'},
  conflictAlgorithm: ConflictAlgorithm.replace,
);
```

### Insert con todas las opciones

```dart
final id = await db.insert(
  'users',                              // tabla
  {'name': 'Juan', 'email': 'juan@email.com'}, // datos
  conflictAlgorithm: ConflictAlgorithm.replace, // conflicto
  nullColumnHack: null,                 // para inserts vacíos
);
```

---

## 📖 SELECT (Leer)

### Método rawQuery

```dart
// Obtener todos
final List<Map<String, dynamic>> results = await db.rawQuery(
  'SELECT * FROM users'
);

// Con parámetros
final results = await db.rawQuery(
  'SELECT * FROM users WHERE id = ?',
  [1]
);
```

### Método query

```dart
// Básico
final results = await db.query('users');

// Con todas las opciones
final results = await db.query(
  'users',                    // tabla
  columns: ['id', 'name'],    // columnas (null = todas)
  where: 'id = ?',            // condición WHERE
  whereArgs: [1],             // argumentos
  groupBy: null,              // GROUP BY
  having: null,               // HAVING
  orderBy: 'name ASC',        // ORDER BY
  limit: 10,                  // LIMIT
  offset: 0,                  // OFFSET
  distinct: false,            // DISTINCT
);
```

### Patrones Comunes de SELECT

```dart
// Obtener uno por ID
final user = (await db.query(
  'users',
  where: 'id = ?',
  whereArgs: [id],
  limit: 1,
)).firstOrNull;

// Buscar por texto (LIKE)
final results = await db.query(
  'users',
  where: 'name LIKE ?',
  whereArgs: ['%juan%'],
);

// Múltiples condiciones
final results = await db.query(
  'users',
  where: 'active = ? AND created_at > ?',
  whereArgs: [1, '2024-01-01'],
);

// IN clause
final results = await db.rawQuery(
  'SELECT * FROM users WHERE id IN (?, ?, ?)',
  [1, 2, 3],
);

// Contar registros
final count = Sqflite.firstIntValue(
  await db.rawQuery('SELECT COUNT(*) FROM users')
);
```

---

## ✏️ UPDATE (Actualizar)

### Método rawUpdate

```dart
final rowsAffected = await db.rawUpdate(
  'UPDATE users SET name = ? WHERE id = ?',
  ['Nuevo Nombre', 1],
);
```

### Método update

```dart
final rowsAffected = await db.update(
  'users',
  {'name': 'Nuevo Nombre', 'email': 'nuevo@email.com'},
  where: 'id = ?',
  whereArgs: [1],
  conflictAlgorithm: ConflictAlgorithm.replace,
);
```

---

## 🗑️ DELETE (Eliminar)

### Método rawDelete

```dart
final rowsDeleted = await db.rawDelete(
  'DELETE FROM users WHERE id = ?',
  [1],
);
```

### Método delete

```dart
final rowsDeleted = await db.delete(
  'users',
  where: 'id = ?',
  whereArgs: [1],
);

// Eliminar todos los registros
final rowsDeleted = await db.delete('users');
```

---

## 🔄 Transacciones

### Básica

```dart
await db.transaction((txn) async {
  await txn.insert('users', {'name': 'Juan'});
  await txn.insert('profiles', {'user_id': 1, 'bio': 'Hola'});
});
```

### Con Rollback Automático (en error)

```dart
try {
  await db.transaction((txn) async {
    await txn.insert('users', {'name': 'Juan'});
    throw Exception('Error forzado'); // Rollback automático
    await txn.insert('profiles', {'user_id': 1});
  });
} catch (e) {
  print('Transacción cancelada: $e');
}
```

---

## 📊 Batch Operations

```dart
final batch = db.batch();

// Añadir operaciones al batch
batch.insert('users', {'name': 'Juan'});
batch.insert('users', {'name': 'Ana'});
batch.insert('users', {'name': 'Carlos'});
batch.update('users', {'active': 1}, where: 'id = ?', whereArgs: [1]);

// Ejecutar todo
final results = await batch.commit();

// Sin esperar resultados (más rápido)
await batch.commit(noResult: true);
```

---

## 🔧 Migraciones

### Versión Simple

```dart
final db = await openDatabase(
  path,
  version: 2,
  onCreate: (db, version) async {
    // Crear todas las tablas (nueva instalación)
    await db.execute('CREATE TABLE users (...)');
    await db.execute('CREATE TABLE profiles (...)');
  },
  onUpgrade: (db, oldVersion, newVersion) async {
    if (oldVersion < 2) {
      // Migración v1 -> v2
      await db.execute('ALTER TABLE users ADD COLUMN avatar TEXT');
    }
  },
);
```

### Sistema de Migraciones Organizado

```dart
final _migrations = <int, Future<void> Function(Database)>{
  2: (db) async {
    await db.execute('ALTER TABLE users ADD COLUMN avatar TEXT');
  },
  3: (db) async {
    await db.execute('CREATE TABLE settings (...)');
  },
  4: (db) async {
    await db.execute('CREATE INDEX idx_users_email ON users(email)');
  },
};

onUpgrade: (db, oldVersion, newVersion) async {
  for (var version = oldVersion + 1; version <= newVersion; version++) {
    final migration = _migrations[version];
    if (migration != null) {
      await migration(db);
    }
  }
}
```

---

## 📐 Crear Tablas - Patrones

### Tabla Básica

```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
)
```

### Con Foreign Key

```sql
CREATE TABLE posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  content TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
)
```

### Con Índices

```sql
CREATE TABLE products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  category TEXT,
  price REAL
);

CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_price ON products(price);
```

### Tabla de Relación (Many-to-Many)

```sql
CREATE TABLE post_tags (
  post_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  PRIMARY KEY (post_id, tag_id),
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
)
```

---

## 🔍 Operadores SQL Comunes

| Operador | Ejemplo | Descripción |
|----------|---------|-------------|
| `=` | `WHERE id = 1` | Igual |
| `<>` o `!=` | `WHERE id <> 1` | Diferente |
| `>`, `<`, `>=`, `<=` | `WHERE price > 10` | Comparación |
| `LIKE` | `WHERE name LIKE '%juan%'` | Patrón |
| `IN` | `WHERE id IN (1, 2, 3)` | Lista de valores |
| `BETWEEN` | `WHERE price BETWEEN 10 AND 50` | Rango |
| `IS NULL` | `WHERE email IS NULL` | Es nulo |
| `IS NOT NULL` | `WHERE email IS NOT NULL` | No es nulo |
| `AND` | `WHERE a = 1 AND b = 2` | Y lógico |
| `OR` | `WHERE a = 1 OR b = 2` | O lógico |

---

## 🎯 Patrón DAO Rápido

```dart
class UserDao {
  final Database _db;
  
  UserDao(this._db);
  
  Future<int> insert(User user) async {
    return await _db.insert('users', user.toMap());
  }
  
  Future<List<User>> getAll() async {
    final maps = await _db.query('users', orderBy: 'name ASC');
    return maps.map((m) => User.fromMap(m)).toList();
  }
  
  Future<User?> getById(int id) async {
    final maps = await _db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return User.fromMap(maps.first);
  }
  
  Future<int> update(User user) async {
    return await _db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
  
  Future<int> delete(int id) async {
    return await _db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
```

---

## 🗂️ Modelo con toMap/fromMap

```dart
class User {
  final int? id;
  final String name;
  final String email;
  final DateTime createdAt;
  
  User({
    this.id,
    required this.name,
    required this.email,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
  
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }
  
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
```

---

## ⚠️ Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| `DatabaseException` | SQL inválido | Verificar sintaxis |
| `UNIQUE constraint` | Duplicado en columna UNIQUE | Usar ConflictAlgorithm |
| `FOREIGN KEY constraint` | Referencia inválida | Verificar que existe el registro |
| `no such table` | Tabla no existe | Verificar onCreate |
| `no such column` | Columna no existe | Verificar migración |

---

## 💡 Tips Rápidos

1. **Usar `?` para parámetros** (previene SQL injection)
2. **Índices en columnas** frecuentemente buscadas
3. **Transacciones** para múltiples operaciones relacionadas
4. **Batch** para inserts masivos
5. **Cerrar database** al terminar: `db.close()`
6. **Singleton** para la instancia de Database
7. **No bloquear UI** - operaciones en aislates si es pesado

---

## 🔒 Habilitar Foreign Keys

```dart
final db = await openDatabase(
  path,
  version: 1,
  onConfigure: (db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  },
  onCreate: (db, version) async {
    // ...
  },
);
```

---

## 📊 Funciones de Agregación

```dart
// COUNT
final count = Sqflite.firstIntValue(
  await db.rawQuery('SELECT COUNT(*) FROM users WHERE active = 1')
);

// SUM
final sum = Sqflite.firstIntValue(
  await db.rawQuery('SELECT SUM(amount) FROM orders')
);

// AVG
final avg = (await db.rawQuery(
  'SELECT AVG(price) as average FROM products'
)).first['average'];

// MIN / MAX
final max = Sqflite.firstIntValue(
  await db.rawQuery('SELECT MAX(score) FROM games')
);
```

---

> 📌 **Recuerda**: SQLite es ideal para datos estructurados y relacionales. Usa transacciones para mantener la integridad de los datos.
