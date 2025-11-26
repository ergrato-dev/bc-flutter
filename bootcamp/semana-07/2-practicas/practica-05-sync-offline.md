# 💻 Práctica 05: Sincronización Offline

## 🎯 Objetivo

Implementar una aplicación de **notas** con **sincronización offline-first**, donde los datos se guardan localmente y se sincronizan con un servidor cuando hay conexión.

---

## 📋 Requisitos

### Funcionales

1. **Gestión de Notas Offline**

   - CRUD completo sin conexión
   - Las operaciones se guardan en SQLite
   - Funcionamiento completo sin internet

2. **Cola de Sincronización**

   - Registrar operaciones pendientes
   - Sincronizar cuando hay conexión
   - Resolver conflictos básicos

3. **Indicadores de Estado**

   - Nota sincronizada ✓
   - Nota pendiente de sincronizar ⏳
   - Nota con error de sincronización ⚠️
   - Estado de conexión global

4. **Sincronización Automática**
   - Detectar cambios de conectividad
   - Sincronizar al recuperar conexión
   - Sincronización manual con botón

### Modelo de Datos

```dart
class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  SyncStatus syncStatus;  // synced, pending, error
  String? serverId;       // ID en el servidor
}

class SyncOperation {
  String id;
  String noteId;
  OperationType type;     // create, update, delete
  DateTime timestamp;
  String? payload;        // JSON de la nota
  int retryCount;
}
```

---

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart
├── models/
│   ├── note.dart
│   └── sync_operation.dart
├── database/
│   └── database_helper.dart
├── services/
│   ├── api_service.dart          (simulado)
│   ├── sync_service.dart
│   └── connectivity_service.dart
├── repositories/
│   └── note_repository.dart
├── providers/
│   ├── notes_provider.dart
│   └── sync_provider.dart
├── screens/
│   ├── notes_list_screen.dart
│   └── note_editor_screen.dart
└── widgets/
    ├── note_card.dart
    ├── sync_status_badge.dart
    └── connectivity_banner.dart
```

---

## 📝 Código Base

### 1. Modelos

```dart
// lib/models/note.dart
import 'package:uuid/uuid.dart';

enum SyncStatus { synced, pending, error }

/**
 * Note: Modelo de nota con estado de sincronización.
 */
class Note {
  final String id;           // ID local (UUID)
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncStatus syncStatus;
  final String? serverId;    // ID en el servidor remoto
  final String? errorMessage; // Mensaje si hay error de sync

  Note({
    String? id,
    required this.title,
    required this.content,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.syncStatus = SyncStatus.pending,
    this.serverId,
    this.errorMessage,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'sync_status': syncStatus.name,
    'server_id': serverId,
    'error_message': errorMessage,
  };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
    id: map['id'],
    title: map['title'],
    content: map['content'],
    createdAt: DateTime.parse(map['created_at']),
    updatedAt: DateTime.parse(map['updated_at']),
    syncStatus: SyncStatus.values.firstWhere(
      (s) => s.name == map['sync_status'],
      orElse: () => SyncStatus.pending,
    ),
    serverId: map['server_id'],
    errorMessage: map['error_message'],
  );

  /// Para enviar al servidor
  Map<String, dynamic> toServerJson() => {
    'title': title,
    'content': content,
    'client_id': id,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    String? serverId,
    String? errorMessage,
  }) => Note(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    serverId: serverId ?? this.serverId,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
```

```dart
// lib/models/sync_operation.dart
import 'package:uuid/uuid.dart';

enum OperationType { create, update, delete }

/**
 * SyncOperation: Operación pendiente de sincronizar.
 */
class SyncOperation {
  final String id;
  final String noteId;
  final OperationType type;
  final DateTime timestamp;
  final String? payload;    // JSON de la nota
  final int retryCount;

  SyncOperation({
    String? id,
    required this.noteId,
    required this.type,
    DateTime? timestamp,
    this.payload,
    this.retryCount = 0,
  })  : id = id ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id,
    'note_id': noteId,
    'type': type.name,
    'timestamp': timestamp.toIso8601String(),
    'payload': payload,
    'retry_count': retryCount,
  };

  factory SyncOperation.fromMap(Map<String, dynamic> map) => SyncOperation(
    id: map['id'],
    noteId: map['note_id'],
    type: OperationType.values.firstWhere((t) => t.name == map['type']),
    timestamp: DateTime.parse(map['timestamp']),
    payload: map['payload'],
    retryCount: map['retry_count'] ?? 0,
  );

  SyncOperation copyWith({int? retryCount}) => SyncOperation(
    id: id,
    noteId: noteId,
    type: type,
    timestamp: timestamp,
    payload: payload,
    retryCount: retryCount ?? this.retryCount,
  );
}
```

### 2. Database Helper

```dart
// lib/database/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes_offline.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Tabla de notas
    await db.execute('''
      CREATE TABLE notes (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        sync_status TEXT NOT NULL DEFAULT 'pending',
        server_id TEXT,
        error_message TEXT
      )
    ''');

    // Tabla de operaciones pendientes
    await db.execute('''
      CREATE TABLE sync_queue (
        id TEXT PRIMARY KEY,
        note_id TEXT NOT NULL,
        type TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        payload TEXT,
        retry_count INTEGER DEFAULT 0
      )
    ''');

    // Índices
    await db.execute('CREATE INDEX idx_notes_sync ON notes (sync_status)');
    await db.execute('CREATE INDEX idx_queue_timestamp ON sync_queue (timestamp)');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
```

### 3. API Service (Simulado)

```dart
// lib/services/api_service.dart
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import '../models/note.dart';

/**
 * ApiService: Simula un servidor remoto.
 *
 * En producción, esto haría llamadas HTTP reales.
 * Aquí simulamos latencia y errores aleatorios.
 */
class ApiService {
  // Simular base de datos del servidor
  final Map<String, Map<String, dynamic>> _serverDb = {};
  final Random _random = Random();

  // Simular latencia de red (200-500ms)
  Future<void> _simulateLatency() async {
    await Future.delayed(Duration(milliseconds: 200 + _random.nextInt(300)));
  }

  // Simular error aleatorio (20% de probabilidad)
  bool _shouldFail() => _random.nextDouble() < 0.2;

  /// Crear nota en servidor
  Future<Map<String, dynamic>> createNote(Map<String, dynamic> noteData) async {
    await _simulateLatency();

    if (_shouldFail()) {
      throw Exception('Error de red: No se pudo crear la nota');
    }

    // Generar ID de servidor
    final serverId = 'srv_${DateTime.now().millisecondsSinceEpoch}';
    final serverNote = {
      ...noteData,
      'id': serverId,
      'synced_at': DateTime.now().toIso8601String(),
    };

    _serverDb[serverId] = serverNote;

    return {'server_id': serverId, 'status': 'created'};
  }

  /// Actualizar nota en servidor
  Future<Map<String, dynamic>> updateNote(String serverId, Map<String, dynamic> noteData) async {
    await _simulateLatency();

    if (_shouldFail()) {
      throw Exception('Error de red: No se pudo actualizar');
    }

    if (!_serverDb.containsKey(serverId)) {
      throw Exception('Nota no encontrada en servidor');
    }

    _serverDb[serverId] = {
      ..._serverDb[serverId]!,
      ...noteData,
      'synced_at': DateTime.now().toIso8601String(),
    };

    return {'status': 'updated'};
  }

  /// Eliminar nota del servidor
  Future<Map<String, dynamic>> deleteNote(String serverId) async {
    await _simulateLatency();

    if (_shouldFail()) {
      throw Exception('Error de red: No se pudo eliminar');
    }

    _serverDb.remove(serverId);

    return {'status': 'deleted'};
  }

  /// Obtener todas las notas del servidor
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    await _simulateLatency();

    if (_shouldFail()) {
      throw Exception('Error de red: No se pudieron obtener notas');
    }

    return _serverDb.values.toList();
  }

  /// Verificar conexión
  Future<bool> checkConnection() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return !_shouldFail();
  }
}
```

### 4. Connectivity Service

```dart
// lib/services/connectivity_service.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

/**
 * ConnectivityService: Monitorea estado de conexión.
 *
 * En producción usar package: connectivity_plus
 * Aquí simulamos para simplificar.
 */
class ConnectivityService extends ChangeNotifier {
  bool _isOnline = true;
  Timer? _checkTimer;

  bool get isOnline => _isOnline;

  ConnectivityService() {
    // Simular cambios de conectividad
    _startMonitoring();
  }

  void _startMonitoring() {
    // En producción: escuchar connectivity_plus
    // Aquí simulamos verificación periódica
    _checkTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _checkConnection(),
    );
  }

  Future<void> _checkConnection() async {
    // Simular verificación
    // En producción: hacer ping real o usar connectivity_plus

    // Por ahora, siempre online (cambiar manualmente para probar)
    _updateStatus(true);
  }

  void _updateStatus(bool isOnline) {
    if (_isOnline != isOnline) {
      _isOnline = isOnline;
      notifyListeners();
    }
  }

  /// Simular pérdida de conexión (para testing)
  void simulateOffline() {
    _updateStatus(false);
  }

  /// Simular recuperación de conexión (para testing)
  void simulateOnline() {
    _updateStatus(true);
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    super.dispose();
  }
}
```

### 5. Sync Service (A completar)

```dart
// lib/services/sync_service.dart
import 'dart:convert';
import '../database/database_helper.dart';
import '../models/note.dart';
import '../models/sync_operation.dart';
import 'api_service.dart';

/**
 * SyncService: Gestiona la sincronización offline.
 *
 * Responsabilidades:
 * 1. Encolar operaciones cuando está offline
 * 2. Procesar cola cuando hay conexión
 * 3. Manejar conflictos
 * 4. Actualizar estados de sincronización
 */
class SyncService {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final ApiService _api = ApiService();

  /// Encolar operación de creación
  Future<void> enqueueCreate(Note note) async {
    final db = await _db.database;

    final operation = SyncOperation(
      noteId: note.id,
      type: OperationType.create,
      payload: jsonEncode(note.toServerJson()),
    );

    await db.insert('sync_queue', operation.toMap());
  }

  /// Encolar operación de actualización
  Future<void> enqueueUpdate(Note note) async {
    final db = await _db.database;

    // Verificar si ya hay una operación pendiente para esta nota
    final existing = await db.query(
      'sync_queue',
      where: 'note_id = ?',
      whereArgs: [note.id],
    );

    if (existing.isNotEmpty) {
      // Actualizar payload existente
      await db.update(
        'sync_queue',
        {
          'payload': jsonEncode(note.toServerJson()),
          'timestamp': DateTime.now().toIso8601String(),
        },
        where: 'note_id = ?',
        whereArgs: [note.id],
      );
    } else {
      // Crear nueva operación
      final operation = SyncOperation(
        noteId: note.id,
        type: OperationType.update,
        payload: jsonEncode(note.toServerJson()),
      );
      await db.insert('sync_queue', operation.toMap());
    }
  }

  /// Encolar operación de eliminación
  Future<void> enqueueDelete(String noteId) async {
    final db = await _db.database;

    // Eliminar cualquier operación pendiente para esta nota
    await db.delete(
      'sync_queue',
      where: 'note_id = ?',
      whereArgs: [noteId],
    );

    // Agregar operación de delete
    final operation = SyncOperation(
      noteId: noteId,
      type: OperationType.delete,
    );
    await db.insert('sync_queue', operation.toMap());
  }

  /// Obtener operaciones pendientes
  Future<List<SyncOperation>> getPendingOperations() async {
    final db = await _db.database;
    final maps = await db.query('sync_queue', orderBy: 'timestamp ASC');
    return maps.map((m) => SyncOperation.fromMap(m)).toList();
  }

  /// Contar operaciones pendientes
  Future<int> getPendingCount() async {
    final db = await _db.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM sync_queue');
    return result.first['count'] as int;
  }

  /// Procesar cola de sincronización
  Future<SyncResult> processQueue() async {
    final operations = await getPendingOperations();

    int success = 0;
    int failed = 0;
    final errors = <String>[];

    for (final op in operations) {
      try {
        await _processOperation(op);
        await _removeFromQueue(op.id);
        success++;
      } catch (e) {
        failed++;
        errors.add('${op.noteId}: $e');
        await _incrementRetryCount(op);
      }
    }

    return SyncResult(
      processed: operations.length,
      success: success,
      failed: failed,
      errors: errors,
    );
  }

  /// Procesar una operación
  Future<void> _processOperation(SyncOperation op) async {
    final db = await _db.database;

    switch (op.type) {
      case OperationType.create:
        // TODO: Implementar
        // 1. Llamar a _api.createNote()
        // 2. Actualizar nota local con server_id
        // 3. Cambiar sync_status a 'synced'
        break;

      case OperationType.update:
        // TODO: Implementar
        // 1. Obtener server_id de la nota
        // 2. Llamar a _api.updateNote()
        // 3. Actualizar sync_status
        break;

      case OperationType.delete:
        // TODO: Implementar
        // 1. Obtener server_id (si existe)
        // 2. Llamar a _api.deleteNote()
        // 3. Eliminar de la base local
        break;
    }
  }

  Future<void> _removeFromQueue(String operationId) async {
    final db = await _db.database;
    await db.delete('sync_queue', where: 'id = ?', whereArgs: [operationId]);
  }

  Future<void> _incrementRetryCount(SyncOperation op) async {
    final db = await _db.database;

    // Si excede máximo de reintentos, marcar como error
    if (op.retryCount >= 3) {
      await db.update(
        'notes',
        {
          'sync_status': SyncStatus.error.name,
          'error_message': 'Máximo de reintentos excedido',
        },
        where: 'id = ?',
        whereArgs: [op.noteId],
      );
      await _removeFromQueue(op.id);
    } else {
      await db.update(
        'sync_queue',
        {'retry_count': op.retryCount + 1},
        where: 'id = ?',
        whereArgs: [op.id],
      );
    }
  }
}

class SyncResult {
  final int processed;
  final int success;
  final int failed;
  final List<String> errors;

  SyncResult({
    required this.processed,
    required this.success,
    required this.failed,
    required this.errors,
  });

  bool get hasErrors => failed > 0;
  String get summary => 'Sincronizadas: $success/$processed';
}
```

### 6. Widget SyncStatusBadge

```dart
// lib/widgets/sync_status_badge.dart
import 'package:flutter/material.dart';
import '../models/note.dart';

class SyncStatusBadge extends StatelessWidget {
  final SyncStatus status;
  final String? errorMessage;

  const SyncStatusBadge({
    super.key,
    required this.status,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _getMessage(),
      child: Icon(
        _getIcon(),
        size: 16,
        color: _getColor(),
      ),
    );
  }

  IconData _getIcon() {
    switch (status) {
      case SyncStatus.synced:
        return Icons.cloud_done;
      case SyncStatus.pending:
        return Icons.cloud_upload;
      case SyncStatus.error:
        return Icons.cloud_off;
    }
  }

  Color _getColor() {
    switch (status) {
      case SyncStatus.synced:
        return Colors.green;
      case SyncStatus.pending:
        return Colors.orange;
      case SyncStatus.error:
        return Colors.red;
    }
  }

  String _getMessage() {
    switch (status) {
      case SyncStatus.synced:
        return 'Sincronizada';
      case SyncStatus.pending:
        return 'Pendiente de sincronizar';
      case SyncStatus.error:
        return errorMessage ?? 'Error de sincronización';
    }
  }
}
```

### 7. Widget ConnectivityBanner

```dart
// lib/widgets/connectivity_banner.dart
import 'package:flutter/material.dart';

class ConnectivityBanner extends StatelessWidget {
  final bool isOnline;
  final VoidCallback? onRetry;

  const ConnectivityBanner({
    super.key,
    required this.isOnline,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isOnline) return const SizedBox.shrink();

    return MaterialBanner(
      content: const Text('Sin conexión. Los cambios se sincronizarán automáticamente.'),
      backgroundColor: Colors.orange[100],
      leading: const Icon(Icons.wifi_off, color: Colors.orange),
      actions: [
        TextButton(
          onPressed: onRetry,
          child: const Text('Reintentar'),
        ),
      ],
    );
  }
}
```

---

## ✅ Tareas a Completar

### Nivel 1: Básico

- [ ] Completar `NoteRepository` con operaciones CRUD
- [ ] Implementar `NotesProvider` con estado local
- [ ] Crear UI básica de lista y editor

### Nivel 2: Intermedio

- [ ] Completar `SyncService._processOperation()` para cada tipo
- [ ] Implementar `SyncProvider` que escuche conectividad
- [ ] Sincronización automática al cambiar a online
- [ ] Mostrar indicadores de estado en cada nota

### Nivel 3: Avanzado

- [ ] Resolver conflictos (última modificación gana)
- [ ] Pull-to-sync manual
- [ ] Sincronización selectiva (solo errores)
- [ ] Logs de sincronización visibles

---

## 🎨 UI Esperada

```
┌─────────────────────────────────────┐
│ 📝 Mis Notas              🔄 ⚙️    │
├─────────────────────────────────────┤
│ ⚠️ Sin conexión - Cambios locales   │
├─────────────────────────────────────┤
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Reunión del lunes          ☁️✓ │ │
│ │ Temas a discutir...            │ │
│ │ Hace 2 horas                   │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Lista de compras          ☁️⏳ │ │
│ │ Leche, pan, huevos...          │ │
│ │ Hace 5 minutos · Pendiente     │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Ideas proyecto            ☁️❌ │ │
│ │ Nueva app de...                │ │
│ │ Error: Reintentar              │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ─────────────────────────────────── │
│ 3 notas · 2 pendientes · 1 error   │
│                              [ + ]  │
└─────────────────────────────────────┘
```

---

## 📊 Criterios de Evaluación

| Criterio               | Puntos  |
| ---------------------- | ------- |
| CRUD offline funcional | 25      |
| Cola de sincronización | 25      |
| Procesamiento de cola  | 20      |
| Indicadores de estado  | 15      |
| Manejo de errores      | 15      |
| **Total**              | **100** |

---

## 🔗 Recursos

- [Offline-first architecture](https://developer.android.com/topic/architecture/data-layer/offline-first)
- [sqflite docs](https://pub.dev/packages/sqflite)
- [connectivity_plus](https://pub.dev/packages/connectivity_plus)

---

## 🎓 Proyecto Final

Esta práctica es la base del proyecto integrador de la semana:
**[App de Notas con Persistencia Completa](../3-proyecto/README.md)**
