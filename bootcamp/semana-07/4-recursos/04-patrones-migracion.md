# 📐 Patrones de Migración de Datos

## 📋 Guía de Migraciones

> Estrategias y patrones para migrar datos de forma segura en Flutter.

---

## 🎯 ¿Por Qué Migrar?

Las migraciones son necesarias cuando:

- ✅ Añades nuevas columnas/campos
- ✅ Eliminas columnas/campos existentes
- ✅ Cambias tipos de datos
- ✅ Renombras tablas o campos
- ✅ Añades índices o constraints
- ✅ Reestructuras relaciones

---

## 🗄️ Migraciones en SQLite/sqflite

### Sistema Básico de Versiones

```dart
/// Sistema básico de migración SQLite
class DatabaseHelper {
  static const String _dbName = 'app.db';
  static const int _dbVersion = 3; // Incrementar con cada migración
  
  static Database? _database;
  
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: onDatabaseDowngradeDelete, // Recrear si baja versión
    );
  }
  
  /// Crear estructura inicial (instalación nueva)
  Future<void> _onCreate(Database db, int version) async {
    // Crear todas las tablas con la estructura más reciente
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        avatar TEXT,
        is_premium INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    
    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        content TEXT,
        published_at TEXT,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');
    
    // Crear índices
    await db.execute('CREATE INDEX idx_posts_user ON posts(user_id)');
    await db.execute('CREATE INDEX idx_posts_published ON posts(published_at)');
  }
  
  /// Migrar de versión anterior a nueva
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Ejecutar cada migración necesaria
    for (var version = oldVersion + 1; version <= newVersion; version++) {
      await _runMigration(db, version);
    }
  }
  
  Future<void> _runMigration(Database db, int version) async {
    switch (version) {
      case 2:
        await _migrateV1ToV2(db);
        break;
      case 3:
        await _migrateV2ToV3(db);
        break;
      // Añadir más casos según sea necesario
    }
  }
  
  /// Migración v1 -> v2: Añadir campo avatar a users
  Future<void> _migrateV1ToV2(Database db) async {
    await db.execute('ALTER TABLE users ADD COLUMN avatar TEXT');
  }
  
  /// Migración v2 -> v3: Añadir campo is_premium y crear tabla posts
  Future<void> _migrateV2ToV3(Database db) async {
    await db.execute('ALTER TABLE users ADD COLUMN is_premium INTEGER DEFAULT 0');
    
    await db.execute('''
      CREATE TABLE IF NOT EXISTS posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        content TEXT,
        published_at TEXT,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');
    
    await db.execute('CREATE INDEX IF NOT EXISTS idx_posts_user ON posts(user_id)');
  }
}
```

### Sistema Avanzado con Clases de Migración

```dart
/// Interfaz para migraciones
abstract class Migration {
  int get version;
  String get description;
  Future<void> up(Database db);
  Future<void> down(Database db); // Opcional: rollback
}

/// Ejemplo de migración concreta
class MigrationV2AddUserAvatar implements Migration {
  @override
  int get version => 2;
  
  @override
  String get description => 'Add avatar column to users table';
  
  @override
  Future<void> up(Database db) async {
    await db.execute('ALTER TABLE users ADD COLUMN avatar TEXT');
  }
  
  @override
  Future<void> down(Database db) async {
    // SQLite no soporta DROP COLUMN directamente
    // Necesitaría recrear la tabla sin la columna
    throw UnimplementedError('Downgrade not supported');
  }
}

/// Gestor de migraciones
class MigrationRunner {
  final List<Migration> _migrations;
  
  MigrationRunner(this._migrations) {
    // Ordenar por versión
    _migrations.sort((a, b) => a.version.compareTo(b.version));
  }
  
  Future<void> migrate(Database db, int oldVersion, int newVersion) async {
    final pendingMigrations = _migrations
        .where((m) => m.version > oldVersion && m.version <= newVersion)
        .toList();
    
    for (final migration in pendingMigrations) {
      print('Running migration ${migration.version}: ${migration.description}');
      await db.transaction((txn) async {
        await migration.up(txn as Database);
      });
    }
  }
}

// Uso
final migrations = [
  MigrationV2AddUserAvatar(),
  MigrationV3AddPosts(),
  MigrationV4AddCategories(),
];

final runner = MigrationRunner(migrations);

// En onUpgrade:
onUpgrade: (db, oldVersion, newVersion) async {
  await runner.migrate(db, oldVersion, newVersion);
}
```

### Patrones de Cambios Comunes en SQLite

```dart
/// Patrones de migración SQLite comunes

// 1. AÑADIR COLUMNA
await db.execute('ALTER TABLE users ADD COLUMN phone TEXT');

// 2. AÑADIR COLUMNA CON DEFAULT
await db.execute('ALTER TABLE users ADD COLUMN status TEXT DEFAULT "active"');

// 3. CREAR NUEVA TABLA
await db.execute('''
  CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
  )
''');

// 4. CREAR ÍNDICE
await db.execute('CREATE INDEX IF NOT EXISTS idx_users_email ON users(email)');

// 5. RENOMBRAR TABLA
await db.execute('ALTER TABLE old_name RENAME TO new_name');

// 6. ELIMINAR TABLA
await db.execute('DROP TABLE IF EXISTS temp_table');

// 7. CAMBIAR TIPO DE COLUMNA (requiere recrear tabla)
Future<void> changeColumnType(Database db) async {
  await db.transaction((txn) async {
    // Crear tabla temporal con nueva estructura
    await txn.execute('''
      CREATE TABLE users_new (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        age INTEGER  -- Antes era TEXT
      )
    ''');
    
    // Copiar datos (con conversión)
    await txn.execute('''
      INSERT INTO users_new (id, name, age)
      SELECT id, name, CAST(age AS INTEGER)
      FROM users
    ''');
    
    // Eliminar tabla original
    await txn.execute('DROP TABLE users');
    
    // Renombrar nueva tabla
    await txn.execute('ALTER TABLE users_new RENAME TO users');
  });
}

// 8. ELIMINAR COLUMNA (SQLite no soporta DROP COLUMN directamente en versiones antiguas)
Future<void> dropColumn(Database db) async {
  await db.transaction((txn) async {
    await txn.execute('''
      CREATE TABLE users_new (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
        -- columna 'deprecated' omitida
      )
    ''');
    
    await txn.execute('''
      INSERT INTO users_new (id, name)
      SELECT id, name FROM users
    ''');
    
    await txn.execute('DROP TABLE users');
    await txn.execute('ALTER TABLE users_new RENAME TO users');
  });
}
```

---

## 📦 Migraciones en Hive

### Estrategia: Campos con Default Value

```dart
/// Hive maneja campos nuevos con defaultValue
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;
  
  @HiveField(1)
  String email;
  
  // Campo añadido después - necesita defaultValue
  @HiveField(2, defaultValue: false)
  bool isPremium;
  
  // Otro campo nuevo
  @HiveField(3, defaultValue: '')
  String avatar;
  
  User({
    required this.name,
    required this.email,
    this.isPremium = false,
    this.avatar = '',
  });
}
```

### Migración Manual de Datos Hive

```dart
/// Migración manual cuando cambia la estructura significativamente
class HiveMigrationService {
  static const String _versionKey = 'hive_schema_version';
  static const int _currentVersion = 2;
  
  Future<void> runMigrations() async {
    final settingsBox = Hive.box('settings');
    final currentVersion = settingsBox.get(_versionKey, defaultValue: 1) as int;
    
    if (currentVersion < _currentVersion) {
      for (var v = currentVersion + 1; v <= _currentVersion; v++) {
        await _runMigration(v);
      }
      await settingsBox.put(_versionKey, _currentVersion);
    }
  }
  
  Future<void> _runMigration(int version) async {
    switch (version) {
      case 2:
        await _migrateV1ToV2();
        break;
    }
  }
  
  /// Ejemplo: Migrar de modelo User v1 a v2
  Future<void> _migrateV1ToV2() async {
    final oldBox = await Hive.openBox('users_v1');
    final newBox = await Hive.openBox<UserV2>('users');
    
    // Copiar datos con transformación
    for (final key in oldBox.keys) {
      final oldData = oldBox.get(key) as Map?;
      if (oldData != null) {
        final newUser = UserV2(
          name: oldData['name'] ?? '',
          email: oldData['email'] ?? '',
          isPremium: false, // Nuevo campo con default
          createdAt: DateTime.now(), // Nuevo campo
        );
        await newBox.put(key, newUser);
      }
    }
    
    // Eliminar box antiguo
    await oldBox.deleteFromDisk();
  }
}
```

### Cambiar TypeId (Peligroso)

```dart
/// ⚠️ NUNCA cambies typeId en producción
/// Si necesitas cambiar la estructura completamente:

// 1. Crear nuevo modelo con nuevo typeId
@HiveType(typeId: 10) // Nuevo ID
class UserV2 extends HiveObject {
  // Nueva estructura
}

// 2. Registrar ambos adapters temporalmente
Hive.registerAdapter(UserAdapter());    // typeId: 0
Hive.registerAdapter(UserV2Adapter());  // typeId: 10

// 3. Migrar datos
Future<void> migrateUsers() async {
  final oldBox = await Hive.openBox<User>('users_old');
  final newBox = await Hive.openBox<UserV2>('users');
  
  for (final user in oldBox.values) {
    final newUser = UserV2(
      // Mapear campos
    );
    await newBox.add(newUser);
  }
  
  await oldBox.deleteFromDisk();
}

// 4. En siguiente versión, eliminar adapter antiguo
```

---

## ⚙️ Migraciones en SharedPreferences

### Versionado de Preferencias

```dart
/// Sistema de migración para SharedPreferences
class PreferencesMigration {
  static const String _versionKey = 'prefs_version';
  static const int _currentVersion = 3;
  
  final SharedPreferences _prefs;
  
  PreferencesMigration(this._prefs);
  
  Future<void> migrate() async {
    final currentVersion = _prefs.getInt(_versionKey) ?? 1;
    
    if (currentVersion < _currentVersion) {
      for (var v = currentVersion + 1; v <= _currentVersion; v++) {
        await _runMigration(v);
      }
      await _prefs.setInt(_versionKey, _currentVersion);
    }
  }
  
  Future<void> _runMigration(int version) async {
    switch (version) {
      case 2:
        await _migrateV1ToV2();
        break;
      case 3:
        await _migrateV2ToV3();
        break;
    }
  }
  
  /// v1 -> v2: Renombrar clave
  Future<void> _migrateV1ToV2() async {
    // theme -> app_theme
    final oldValue = _prefs.getString('theme');
    if (oldValue != null) {
      await _prefs.setString('app_theme', oldValue);
      await _prefs.remove('theme');
    }
  }
  
  /// v2 -> v3: Cambiar formato de datos
  Future<void> _migrateV2ToV3() async {
    // Antes: fontSize era String ('small', 'medium', 'large')
    // Ahora: fontSize es int (12, 14, 16)
    final oldSize = _prefs.getString('fontSize');
    if (oldSize != null) {
      final newSize = switch (oldSize) {
        'small' => 12,
        'medium' => 14,
        'large' => 16,
        _ => 14,
      };
      await _prefs.remove('fontSize');
      await _prefs.setInt('font_size', newSize);
    }
  }
}

// Uso en main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  await PreferencesMigration(prefs).migrate();
  
  runApp(MyApp());
}
```

---

## 🛡️ Estrategias de Seguridad

### 1. Backup Antes de Migrar

```dart
/// Crear backup antes de migración peligrosa
Future<void> safeMigration(Database db) async {
  final dbPath = await getDatabasesPath();
  final originalPath = join(dbPath, 'app.db');
  final backupPath = join(dbPath, 'app_backup_${DateTime.now().millisecondsSinceEpoch}.db');
  
  // Crear backup
  final originalFile = File(originalPath);
  await originalFile.copy(backupPath);
  
  try {
    // Ejecutar migración
    await _performMigration(db);
    
    // Si éxito, eliminar backup
    final backupFile = File(backupPath);
    if (await backupFile.exists()) {
      await backupFile.delete();
    }
  } catch (e) {
    // Si falla, restaurar backup
    final backupFile = File(backupPath);
    await backupFile.copy(originalPath);
    rethrow;
  }
}
```

### 2. Validación Post-Migración

```dart
/// Validar que la migración fue exitosa
Future<bool> validateMigration(Database db) async {
  try {
    // Verificar que las tablas existen
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table'"
    );
    final tableNames = tables.map((t) => t['name'] as String).toSet();
    
    final requiredTables = {'users', 'posts', 'categories'};
    if (!requiredTables.every(tableNames.contains)) {
      return false;
    }
    
    // Verificar que las columnas existen
    final userColumns = await db.rawQuery('PRAGMA table_info(users)');
    final columnNames = userColumns.map((c) => c['name'] as String).toSet();
    
    final requiredColumns = {'id', 'name', 'email', 'avatar', 'is_premium'};
    if (!requiredColumns.every(columnNames.contains)) {
      return false;
    }
    
    return true;
  } catch (e) {
    return false;
  }
}
```

### 3. Migración Transaccional

```dart
/// Usar transacción para migración atómica
Future<void> transactionalMigration(Database db) async {
  await db.transaction((txn) async {
    // Paso 1
    await txn.execute('ALTER TABLE users ADD COLUMN status TEXT DEFAULT "active"');
    
    // Paso 2
    await txn.execute('UPDATE users SET status = "verified" WHERE verified = 1');
    
    // Paso 3
    await txn.execute('CREATE INDEX idx_users_status ON users(status)');
    
    // Si cualquier paso falla, todo se revierte
  });
}
```

---

## 📋 Checklist de Migración

### Antes de Migrar
- [ ] Incrementar versión de base de datos
- [ ] Documentar los cambios
- [ ] Crear backup de datos de prueba
- [ ] Probar migración en desarrollo

### Durante la Migración
- [ ] Usar transacciones donde sea posible
- [ ] Manejar errores apropiadamente
- [ ] Preservar datos existentes
- [ ] Validar integridad de datos

### Después de Migrar
- [ ] Verificar estructura de datos
- [ ] Probar funcionalidad afectada
- [ ] Limpiar datos temporales
- [ ] Documentar para rollback si es necesario

---

## ⚠️ Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| Pérdida de datos | Migración sin backup | Siempre hacer backup |
| Migración incompleta | Sin transacción | Usar transacciones |
| Versión incorrecta | Olvidar incrementar versión | Incrementar siempre |
| TypeId duplicado (Hive) | Reutilizar typeId | Usar IDs únicos |
| Campo sin default (Hive) | Nuevo campo sin defaultValue | Añadir defaultValue |

---

> 📌 **Regla de Oro**: Nunca ejecutes migraciones destructivas sin backup y sin probar en desarrollo primero.
