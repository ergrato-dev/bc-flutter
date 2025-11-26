# ⚡ Optimización y Rendimiento

## 📋 Guía de Optimización

> Mejores prácticas para optimizar el rendimiento de persistencia en Flutter.

---

## 🎯 Áreas de Optimización

| Área             | Impacto | Prioridad |
| ---------------- | ------- | --------- |
| Queries SQL      | Alto    | 🔴 Alta   |
| Índices          | Alto    | 🔴 Alta   |
| Batch operations | Alto    | 🔴 Alta   |
| Lazy loading     | Medio   | 🟠 Media  |
| Caché en memoria | Medio   | 🟠 Media  |
| Compactación     | Bajo    | 🟢 Baja   |

---

## 🗄️ Optimización de SQLite

### 1. Índices Estratégicos

```dart
/// Crear índices para consultas frecuentes
class IndexOptimization {
  static Future<void> createOptimalIndexes(Database db) async {
    // Índice para búsquedas por fecha (muy común)
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_notes_created
      ON notes(created_at DESC)
    ''');

    // Índice para filtrado por carpeta
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_notes_folder
      ON notes(folder_id)
    ''');

    // Índice compuesto para filtrado + ordenación
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_notes_folder_date
      ON notes(folder_id, created_at DESC)
    ''');

    // Índice para búsqueda full-text (si usas FTS)
    // Ver sección de búsqueda full-text

    // Índice parcial para elementos activos
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_notes_active
      ON notes(created_at DESC)
      WHERE is_deleted = 0
    ''');
  }

  /// Analizar uso de índices
  static Future<void> analyzeIndexUsage(Database db) async {
    // EXPLAIN QUERY PLAN muestra si se usan índices
    final result = await db.rawQuery('''
      EXPLAIN QUERY PLAN
      SELECT * FROM notes
      WHERE folder_id = 1
      ORDER BY created_at DESC
      LIMIT 20
    ''');

    for (final row in result) {
      print('Query plan: ${row['detail']}');
      // Buscar "USING INDEX" en el resultado
    }
  }
}
```

### 2. Consultas Optimizadas

```dart
/// Patrones de consultas optimizadas
class QueryOptimization {
  final Database _db;

  QueryOptimization(this._db);

  // ✅ BUENO: Seleccionar solo columnas necesarias
  Future<List<Map<String, dynamic>>> getNoteTitles() async {
    return await _db.query(
      'notes',
      columns: ['id', 'title'], // Solo lo necesario
      orderBy: 'created_at DESC',
      limit: 50,
    );
  }

  // ❌ MALO: Seleccionar todo cuando no se necesita
  // SELECT * FROM notes  <- Trae content, attachments, etc.

  // ✅ BUENO: Paginación para grandes conjuntos
  Future<List<Map<String, dynamic>>> getNotesPaginated({
    required int page,
    int pageSize = 20,
  }) async {
    return await _db.query(
      'notes',
      columns: ['id', 'title', 'preview', 'created_at'],
      orderBy: 'created_at DESC',
      limit: pageSize,
      offset: page * pageSize,
    );
  }

  // ✅ BUENO: Usar EXISTS en lugar de COUNT para verificación
  Future<bool> hasNotes(int folderId) async {
    final result = await _db.rawQuery('''
      SELECT EXISTS(
        SELECT 1 FROM notes WHERE folder_id = ?
      ) as has_notes
    ''', [folderId]);
    return result.first['has_notes'] == 1;
  }

  // ❌ MALO: COUNT completo para verificación
  // SELECT COUNT(*) FROM notes WHERE folder_id = ?
  // Luego comparar con 0

  // ✅ BUENO: Búsqueda con LIKE optimizada
  Future<List<Map<String, dynamic>>> searchNotes(String query) async {
    // Añadir % solo al final para usar índice
    return await _db.query(
      'notes',
      where: 'title LIKE ?',
      whereArgs: ['$query%'], // Usa índice en title
    );

    // '%$query%' NO usa índice (escaneo completo)
  }
}
```

### 3. Batch Operations

```dart
/// Operaciones en lote para mejor rendimiento
class BatchOptimization {
  final Database _db;

  BatchOptimization(this._db);

  // ✅ BUENO: Insertar múltiples registros en batch
  Future<void> insertManyNotes(List<Note> notes) async {
    final batch = _db.batch();

    for (final note in notes) {
      batch.insert('notes', note.toMap());
    }

    // Sin resultados (más rápido)
    await batch.commit(noResult: true);
  }

  // ❌ MALO: Insertar uno por uno
  // for (final note in notes) {
  //   await _db.insert('notes', note.toMap());
  // }

  // ✅ BUENO: Transacción para operaciones relacionadas
  Future<void> moveNotesToFolder(List<int> noteIds, int folderId) async {
    await _db.transaction((txn) async {
      final batch = txn.batch();

      for (final id in noteIds) {
        batch.update(
          'notes',
          {'folder_id': folderId, 'updated_at': DateTime.now().toIso8601String()},
          where: 'id = ?',
          whereArgs: [id],
        );
      }

      await batch.commit(noResult: true);
    });
  }

  // ✅ BUENO: Raw SQL para operaciones masivas
  Future<void> markAllAsRead(int folderId) async {
    await _db.rawUpdate('''
      UPDATE notes
      SET is_read = 1, updated_at = ?
      WHERE folder_id = ? AND is_read = 0
    ''', [DateTime.now().toIso8601String(), folderId]);
  }
}
```

### 4. Caché de Consultas

```dart
/// Caché en memoria para consultas frecuentes
class QueryCache<T> {
  final Duration _ttl;
  final Map<String, _CacheEntry<T>> _cache = {};

  QueryCache({Duration ttl = const Duration(minutes: 5)}) : _ttl = ttl;

  T? get(String key) {
    final entry = _cache[key];
    if (entry == null) return null;

    if (DateTime.now().isAfter(entry.expiry)) {
      _cache.remove(key);
      return null;
    }

    return entry.value;
  }

  void set(String key, T value) {
    _cache[key] = _CacheEntry(
      value: value,
      expiry: DateTime.now().add(_ttl),
    );
  }

  void invalidate(String key) => _cache.remove(key);
  void invalidateAll() => _cache.clear();
}

class _CacheEntry<T> {
  final T value;
  final DateTime expiry;

  _CacheEntry({required this.value, required this.expiry});
}

/// Uso en Repository
class CachedNoteRepository {
  final Database _db;
  final QueryCache<List<Note>> _cache = QueryCache();

  CachedNoteRepository(this._db);

  Future<List<Note>> getNotesByFolder(int folderId) async {
    final cacheKey = 'folder_$folderId';

    // Verificar caché
    final cached = _cache.get(cacheKey);
    if (cached != null) return cached;

    // Consultar DB
    final results = await _db.query(
      'notes',
      where: 'folder_id = ?',
      whereArgs: [folderId],
    );

    final notes = results.map((m) => Note.fromMap(m)).toList();

    // Guardar en caché
    _cache.set(cacheKey, notes);

    return notes;
  }

  Future<void> addNote(Note note) async {
    await _db.insert('notes', note.toMap());
    // Invalidar caché relevante
    _cache.invalidate('folder_${note.folderId}');
  }
}
```

---

## 📦 Optimización de Hive

### 1. Lazy Loading

```dart
/// Usar LazyBox para datos grandes
class HiveOptimization {
  /// Para boxes con muchos registros
  static Future<LazyBox<Note>> openNotesLazy() async {
    return await Hive.openLazyBox<Note>('notes');
  }

  /// Leer solo lo necesario
  static Future<List<Note>> getRecentNotes(LazyBox<Note> box, int limit) async {
    final keys = box.keys.toList();
    final recentKeys = keys.reversed.take(limit);

    final notes = <Note>[];
    for (final key in recentKeys) {
      final note = await box.get(key);
      if (note != null) notes.add(note);
    }

    return notes;
  }
}
```

### 2. Compactación

```dart
/// Compactar boxes periódicamente
class HiveCompaction {
  static Future<void> compactIfNeeded(Box box) async {
    // Compactar si hay muchas entradas eliminadas
    // Hive automáticamente compacta, pero podemos forzar

    // Verificar tamaño del archivo vs registros
    final file = File(box.path!);
    final fileSize = await file.length();
    final estimatedSize = box.length * 100; // Estimación muy aproximada

    // Si el archivo es mucho más grande que los datos
    if (fileSize > estimatedSize * 2) {
      await box.compact();
    }
  }

  /// Compactar todos los boxes
  static Future<void> compactAllBoxes() async {
    final boxNames = ['notes', 'settings', 'cache'];

    for (final name in boxNames) {
      if (Hive.isBoxOpen(name)) {
        final box = Hive.box(name);
        await box.compact();
      }
    }
  }
}
```

### 3. Estructura de Datos Optimizada

```dart
/// Modelo optimizado para Hive
@HiveType(typeId: 0)
class NoteOptimized extends HiveObject {
  @HiveField(0)
  String title;

  // Almacenar preview separado del contenido completo
  @HiveField(1)
  String preview; // Primeros 200 caracteres

  // El contenido completo puede cargarse solo cuando se necesita
  @HiveField(2)
  String? _fullContent;

  // Almacenar fechas como int (más eficiente)
  @HiveField(3)
  int createdAtMs; // Milliseconds since epoch

  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(createdAtMs);

  // Lazy load del contenido completo
  Future<String> getFullContent() async {
    if (_fullContent != null) return _fullContent!;
    // Cargar desde almacenamiento separado si es muy grande
    return preview; // Fallback
  }

  NoteOptimized({
    required this.title,
    required this.preview,
    String? fullContent,
    DateTime? createdAt,
  }) : _fullContent = fullContent,
       createdAtMs = (createdAt ?? DateTime.now()).millisecondsSinceEpoch;
}
```

---

## 💾 Optimización de SharedPreferences

### Batch de Escrituras

```dart
/// Agrupar escrituras de SharedPreferences
class PrefsOptimization {
  final SharedPreferences _prefs;
  final Map<String, dynamic> _pendingWrites = {};
  Timer? _writeTimer;

  PrefsOptimization(this._prefs);

  /// Escritura diferida (batch)
  void setDeferred(String key, dynamic value) {
    _pendingWrites[key] = value;

    // Programar escritura si no hay una pendiente
    _writeTimer?.cancel();
    _writeTimer = Timer(Duration(milliseconds: 100), _flushWrites);
  }

  Future<void> _flushWrites() async {
    if (_pendingWrites.isEmpty) return;

    final writes = Map<String, dynamic>.from(_pendingWrites);
    _pendingWrites.clear();

    for (final entry in writes.entries) {
      final value = entry.value;
      if (value is String) {
        await _prefs.setString(entry.key, value);
      } else if (value is int) {
        await _prefs.setInt(entry.key, value);
      } else if (value is bool) {
        await _prefs.setBool(entry.key, value);
      } else if (value is double) {
        await _prefs.setDouble(entry.key, value);
      }
    }
  }

  /// Forzar escritura inmediata
  Future<void> flush() async {
    _writeTimer?.cancel();
    await _flushWrites();
  }
}
```

---

## 🔍 Full-Text Search (FTS)

### SQLite FTS5

```dart
/// Implementación de búsqueda full-text
class FullTextSearch {
  final Database _db;

  FullTextSearch(this._db);

  /// Crear tabla FTS
  Future<void> createFtsTable() async {
    // Crear tabla FTS5 virtual
    await _db.execute('''
      CREATE VIRTUAL TABLE IF NOT EXISTS notes_fts USING fts5(
        title,
        content,
        content='notes',
        content_rowid='id'
      )
    ''');

    // Triggers para mantener sincronizado
    await _db.execute('''
      CREATE TRIGGER IF NOT EXISTS notes_ai AFTER INSERT ON notes BEGIN
        INSERT INTO notes_fts(rowid, title, content)
        VALUES (new.id, new.title, new.content);
      END
    ''');

    await _db.execute('''
      CREATE TRIGGER IF NOT EXISTS notes_ad AFTER DELETE ON notes BEGIN
        INSERT INTO notes_fts(notes_fts, rowid, title, content)
        VALUES('delete', old.id, old.title, old.content);
      END
    ''');

    await _db.execute('''
      CREATE TRIGGER IF NOT EXISTS notes_au AFTER UPDATE ON notes BEGIN
        INSERT INTO notes_fts(notes_fts, rowid, title, content)
        VALUES('delete', old.id, old.title, old.content);
        INSERT INTO notes_fts(rowid, title, content)
        VALUES (new.id, new.title, new.content);
      END
    ''');
  }

  /// Buscar con FTS
  Future<List<Map<String, dynamic>>> search(String query) async {
    // Escapar caracteres especiales
    final escapedQuery = query.replaceAll('"', '""');

    return await _db.rawQuery('''
      SELECT notes.*,
             highlight(notes_fts, 0, '<mark>', '</mark>') as title_highlighted,
             snippet(notes_fts, 1, '<mark>', '</mark>', '...', 32) as content_snippet
      FROM notes_fts
      JOIN notes ON notes.id = notes_fts.rowid
      WHERE notes_fts MATCH ?
      ORDER BY rank
      LIMIT 50
    ''', ['"$escapedQuery"*']); // Wildcard para prefijos
  }

  /// Reconstruir índice FTS
  Future<void> rebuildFtsIndex() async {
    await _db.execute("INSERT INTO notes_fts(notes_fts) VALUES('rebuild')");
  }
}
```

---

## 📊 Métricas de Rendimiento

### Medir Tiempo de Operaciones

```dart
/// Utilidad para medir rendimiento
class PerformanceMonitor {
  static final Map<String, List<int>> _measurements = {};

  /// Medir duración de operación
  static Future<T> measure<T>(String name, Future<T> Function() operation) async {
    final stopwatch = Stopwatch()..start();

    try {
      return await operation();
    } finally {
      stopwatch.stop();
      _recordMeasurement(name, stopwatch.elapsedMilliseconds);
    }
  }

  static void _recordMeasurement(String name, int ms) {
    _measurements.putIfAbsent(name, () => []);
    _measurements[name]!.add(ms);

    // Mantener últimas 100 mediciones
    if (_measurements[name]!.length > 100) {
      _measurements[name]!.removeAt(0);
    }
  }

  /// Obtener estadísticas
  static Map<String, Map<String, num>> getStats() {
    final stats = <String, Map<String, num>>{};

    for (final entry in _measurements.entries) {
      final values = entry.value;
      if (values.isEmpty) continue;

      final sorted = List<int>.from(values)..sort();
      final sum = values.reduce((a, b) => a + b);

      stats[entry.key] = {
        'count': values.length,
        'avg': sum / values.length,
        'min': sorted.first,
        'max': sorted.last,
        'p95': sorted[(sorted.length * 0.95).floor()],
      };
    }

    return stats;
  }

  /// Imprimir reporte
  static void printReport() {
    final stats = getStats();

    print('=== Performance Report ===');
    for (final entry in stats.entries) {
      print('${entry.key}:');
      print('  Count: ${entry.value['count']}');
      print('  Avg: ${entry.value['avg']?.toStringAsFixed(2)}ms');
      print('  Min: ${entry.value['min']}ms');
      print('  Max: ${entry.value['max']}ms');
      print('  P95: ${entry.value['p95']}ms');
    }
  }
}

// Uso
final notes = await PerformanceMonitor.measure(
  'getNotesByFolder',
  () => noteRepository.getNotesByFolder(folderId),
);
```

---

## 📋 Checklist de Optimización

### SQLite

- [ ] Índices en columnas de WHERE/ORDER BY frecuentes
- [ ] Índices compuestos para queries complejos
- [ ] Usar batch para múltiples operaciones
- [ ] Seleccionar solo columnas necesarias
- [ ] Paginación para grandes conjuntos
- [ ] Transacciones para operaciones relacionadas

### Hive

- [ ] LazyBox para datos grandes
- [ ] Compactación periódica
- [ ] Estructura de datos optimizada
- [ ] Tipos primitivos cuando sea posible

### General

- [ ] Caché en memoria para queries frecuentes
- [ ] Operaciones pesadas en isolates
- [ ] Monitoreo de rendimiento
- [ ] Pruebas de carga

---

## ⚠️ Anti-patrones de Rendimiento

| Anti-patrón         | Problema                  | Solución             |
| ------------------- | ------------------------- | -------------------- |
| N+1 queries         | Múltiples queries en loop | JOIN o batch         |
| SELECT \*           | Trae datos innecesarios   | Columnas específicas |
| Sin índices         | Escaneo completo de tabla | Crear índices        |
| Sin paginación      | Carga todos los datos     | LIMIT/OFFSET         |
| Sync en main thread | Bloquea UI                | Isolates             |
| Sin caché           | Queries repetidas         | Caché en memoria     |

---

> 📌 **Regla de Oro**: Mide antes de optimizar. No optimices prematuramente, pero tampoco ignores problemas de rendimiento evidentes.
