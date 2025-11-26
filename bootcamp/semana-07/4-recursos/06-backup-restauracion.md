# 💾 Backup y Restauración de Datos

## 📋 Guía de Backup

> Estrategias para respaldar y restaurar datos en aplicaciones Flutter.

---

## 🎯 Estrategias de Backup

### Tipos de Backup

| Tipo            | Descripción                  | Uso                             |
| --------------- | ---------------------------- | ------------------------------- |
| **Local**       | Copia en el dispositivo      | Protección contra corrupción    |
| **Nube**        | Sincronización con servidor  | Recuperación entre dispositivos |
| **Exportación** | Archivo descargable          | Control del usuario             |
| **Automático**  | Sin intervención del usuario | Transparente                    |
| **Manual**      | Iniciado por usuario         | Control explícito               |

---

## 📁 Backup Local de SQLite

### Implementación Completa

```dart
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Servicio de backup para SQLite
class SqliteBackupService {
  static const String _dbName = 'app.db';
  static const String _backupPrefix = 'backup_';
  static const int _maxBackups = 5; // Mantener últimos 5 backups

  /// Crear backup de la base de datos
  Future<File> createBackup() async {
    final dbPath = await getDatabasesPath();
    final originalPath = join(dbPath, _dbName);
    final originalFile = File(originalPath);

    if (!await originalFile.exists()) {
      throw Exception('Database not found');
    }

    // Directorio de backups
    final backupDir = await _getBackupDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupPath = join(backupDir.path, '$_backupPrefix$timestamp.db');

    // Copiar archivo
    final backupFile = await originalFile.copy(backupPath);

    // Limpiar backups antiguos
    await _cleanOldBackups(backupDir);

    return backupFile;
  }

  /// Restaurar desde backup
  Future<void> restoreBackup(String backupPath) async {
    final backupFile = File(backupPath);

    if (!await backupFile.exists()) {
      throw Exception('Backup file not found');
    }

    final dbPath = await getDatabasesPath();
    final originalPath = join(dbPath, _dbName);

    // Cerrar conexiones activas primero
    // (debe manejarse en la app)

    // Reemplazar base de datos
    await backupFile.copy(originalPath);
  }

  /// Listar backups disponibles
  Future<List<BackupInfo>> listBackups() async {
    final backupDir = await _getBackupDirectory();
    final files = backupDir.listSync()
        .whereType<File>()
        .where((f) => basename(f.path).startsWith(_backupPrefix))
        .toList();

    final backups = <BackupInfo>[];

    for (final file in files) {
      final stat = await file.stat();
      final name = basename(file.path);
      final timestampStr = name.replaceAll(_backupPrefix, '').replaceAll('.db', '');
      final timestamp = int.tryParse(timestampStr);

      backups.add(BackupInfo(
        path: file.path,
        name: name,
        size: stat.size,
        createdAt: timestamp != null
            ? DateTime.fromMillisecondsSinceEpoch(timestamp)
            : stat.modified,
      ));
    }

    // Ordenar por fecha (más reciente primero)
    backups.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return backups;
  }

  /// Eliminar backup específico
  Future<void> deleteBackup(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Obtener directorio de backups
  Future<Directory> _getBackupDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory(join(appDir.path, 'backups'));

    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }

    return backupDir;
  }

  /// Limpiar backups antiguos
  Future<void> _cleanOldBackups(Directory backupDir) async {
    final files = backupDir.listSync()
        .whereType<File>()
        .where((f) => basename(f.path).startsWith(_backupPrefix))
        .toList();

    if (files.length <= _maxBackups) return;

    // Ordenar por fecha de modificación
    files.sort((a, b) {
      final statA = a.statSync();
      final statB = b.statSync();
      return statA.modified.compareTo(statB.modified);
    });

    // Eliminar los más antiguos
    final toDelete = files.take(files.length - _maxBackups);
    for (final file in toDelete) {
      await file.delete();
    }
  }
}

/// Información de un backup
class BackupInfo {
  final String path;
  final String name;
  final int size;
  final DateTime createdAt;

  BackupInfo({
    required this.path,
    required this.name,
    required this.size,
    required this.createdAt,
  });

  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
```

---

## 📦 Backup de Hive

### Exportar e Importar Boxes

```dart
import 'dart:io';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// Servicio de backup para Hive
class HiveBackupService {
  /// Exportar box a JSON
  Future<File> exportBoxToJson<T>(String boxName) async {
    final box = Hive.box<T>(boxName);
    final data = <String, dynamic>{};

    // Convertir a Map serializable
    for (final key in box.keys) {
      final value = box.get(key);
      if (value != null) {
        data[key.toString()] = _toSerializable(value);
      }
    }

    // Crear archivo de exportación
    final exportDir = await _getExportDirectory();
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final filePath = '${exportDir.path}/${boxName}_$timestamp.json';

    final file = File(filePath);
    await file.writeAsString(jsonEncode({
      'boxName': boxName,
      'exportedAt': DateTime.now().toIso8601String(),
      'itemCount': data.length,
      'data': data,
    }));

    return file;
  }

  /// Importar box desde JSON
  Future<int> importBoxFromJson<T>(
    String filePath,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final file = File(filePath);

    if (!await file.exists()) {
      throw Exception('Import file not found');
    }

    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    final boxName = json['boxName'] as String;
    final data = json['data'] as Map<String, dynamic>;

    final box = Hive.box<T>(boxName);
    int importedCount = 0;

    for (final entry in data.entries) {
      final item = fromJson(entry.value as Map<String, dynamic>);
      await box.put(entry.key, item);
      importedCount++;
    }

    return importedCount;
  }

  /// Exportar múltiples boxes
  Future<File> exportAllBoxes(List<String> boxNames) async {
    final allData = <String, dynamic>{};

    for (final name in boxNames) {
      final box = Hive.box(name);
      final boxData = <String, dynamic>{};

      for (final key in box.keys) {
        boxData[key.toString()] = _toSerializable(box.get(key));
      }

      allData[name] = boxData;
    }

    final exportDir = await _getExportDirectory();
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final filePath = '${exportDir.path}/full_backup_$timestamp.json';

    final file = File(filePath);
    await file.writeAsString(jsonEncode({
      'exportedAt': DateTime.now().toIso8601String(),
      'boxes': allData,
    }));

    return file;
  }

  /// Copiar archivos de box directamente
  Future<File> backupBoxFiles(String boxName) async {
    final hivePath = Hive.box(boxName).path;
    if (hivePath == null) throw Exception('Box path not found');

    final sourceFile = File(hivePath);
    final backupDir = await _getExportDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final destPath = '${backupDir.path}/${boxName}_$timestamp.hive';

    return await sourceFile.copy(destPath);
  }

  Future<Directory> _getExportDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final exportDir = Directory('${appDir.path}/exports');

    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }

    return exportDir;
  }

  dynamic _toSerializable(dynamic value) {
    if (value == null) return null;
    if (value is num || value is String || value is bool) return value;
    if (value is DateTime) return value.toIso8601String();
    if (value is List) return value.map(_toSerializable).toList();
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), _toSerializable(v)));
    }
    // Para objetos Hive personalizados, necesitan toJson()
    if (value is HiveObject) {
      // Asume que tiene método toJson
      return (value as dynamic).toJson();
    }
    return value.toString();
  }
}
```

---

## ☁️ Backup en la Nube

### Integración con Firebase Storage

```dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Servicio de backup en Firebase Storage
class CloudBackupService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Subir backup a la nube
  Future<String> uploadBackup(File backupFile) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'backup_$timestamp.db';
    final ref = _storage.ref('backups/${user.uid}/$fileName');

    // Subir archivo
    final uploadTask = ref.putFile(
      backupFile,
      SettableMetadata(
        contentType: 'application/octet-stream',
        customMetadata: {
          'uploadedAt': DateTime.now().toIso8601String(),
          'deviceId': await _getDeviceId(),
        },
      ),
    );

    // Esperar y obtener URL
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  /// Descargar backup de la nube
  Future<File> downloadBackup(String fileName) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _storage.ref('backups/${user.uid}/$fileName');
    final tempDir = await getTemporaryDirectory();
    final localFile = File('${tempDir.path}/$fileName');

    await ref.writeToFile(localFile);

    return localFile;
  }

  /// Listar backups disponibles en la nube
  Future<List<CloudBackupInfo>> listCloudBackups() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _storage.ref('backups/${user.uid}');
    final result = await ref.listAll();

    final backups = <CloudBackupInfo>[];

    for (final item in result.items) {
      final metadata = await item.getMetadata();
      backups.add(CloudBackupInfo(
        name: item.name,
        path: item.fullPath,
        size: metadata.size ?? 0,
        createdAt: metadata.timeCreated ?? DateTime.now(),
        downloadUrl: await item.getDownloadURL(),
      ));
    }

    // Ordenar por fecha
    backups.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return backups;
  }

  /// Eliminar backup de la nube
  Future<void> deleteCloudBackup(String fileName) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final ref = _storage.ref('backups/${user.uid}/$fileName');
    await ref.delete();
  }

  Future<String> _getDeviceId() async {
    // Implementar según necesidad
    return 'device_id';
  }
}

class CloudBackupInfo {
  final String name;
  final String path;
  final int size;
  final DateTime createdAt;
  final String downloadUrl;

  CloudBackupInfo({
    required this.name,
    required this.path,
    required this.size,
    required this.createdAt,
    required this.downloadUrl,
  });
}
```

---

## 📤 Exportación para Usuario

### Compartir Backup

```dart
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

/// Servicio de exportación/importación para el usuario
class UserExportService {
  final SqliteBackupService _sqliteBackup;
  final HiveBackupService _hiveBackup;

  UserExportService(this._sqliteBackup, this._hiveBackup);

  /// Exportar todos los datos y compartir
  Future<void> exportAndShare() async {
    // Crear backup de SQLite
    final sqliteBackup = await _sqliteBackup.createBackup();

    // Crear backup de Hive (settings, etc.)
    final hiveBackup = await _hiveBackup.exportAllBoxes(['settings', 'cache']);

    // Crear archivo ZIP con todos los backups
    final zipFile = await _createZipBackup([sqliteBackup, hiveBackup]);

    // Compartir
    await Share.shareXFiles(
      [XFile(zipFile.path)],
      subject: 'App Data Backup',
      text: 'Backup creado el ${DateTime.now().toString()}',
    );
  }

  /// Importar desde archivo seleccionado por usuario
  Future<void> importFromFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip', 'json', 'db'],
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    final path = file.path;
    if (path == null) return;

    if (path.endsWith('.zip')) {
      await _importFromZip(path);
    } else if (path.endsWith('.db')) {
      await _sqliteBackup.restoreBackup(path);
    } else if (path.endsWith('.json')) {
      // Determinar qué tipo de JSON es
      await _importFromJson(path);
    }
  }

  Future<File> _createZipBackup(List<File> files) async {
    // Implementar compresión ZIP
    // Usar package: archive
    throw UnimplementedError();
  }

  Future<void> _importFromZip(String path) async {
    // Implementar extracción y restauración
    throw UnimplementedError();
  }

  Future<void> _importFromJson(String path) async {
    // Implementar importación JSON
    throw UnimplementedError();
  }
}
```

---

## ⏰ Backup Automático

### Implementación con WorkManager

```dart
import 'package:workmanager/workmanager.dart';

/// Configuración de backup automático
class AutoBackupService {
  static const _taskName = 'auto_backup';
  static const _taskUniqueName = 'com.example.app.autobackup';

  /// Inicializar WorkManager
  static Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  /// Programar backup periódico
  static Future<void> scheduleAutoBackup({
    Duration frequency = const Duration(days: 1),
  }) async {
    await Workmanager().registerPeriodicTask(
      _taskUniqueName,
      _taskName,
      frequency: frequency,
      constraints: Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: true,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: true,
      ),
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
  }

  /// Cancelar backup automático
  static Future<void> cancelAutoBackup() async {
    await Workmanager().cancelByUniqueName(_taskUniqueName);
  }
}

/// Callback para WorkManager (debe ser top-level)
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'auto_backup') {
      try {
        // Ejecutar backup
        final backupService = SqliteBackupService();
        await backupService.createBackup();

        // Opcional: subir a la nube
        // await cloudBackupService.uploadBackup(backup);

        return true;
      } catch (e) {
        print('Auto backup failed: $e');
        return false;
      }
    }
    return false;
  });
}
```

---

## 🔄 Sincronización Incremental

### Backup de Cambios Únicamente

```dart
/// Servicio de backup incremental
class IncrementalBackupService {
  final Database _db;

  IncrementalBackupService(this._db);

  /// Obtener cambios desde último backup
  Future<List<Map<String, dynamic>>> getChangesSince(DateTime lastBackup) async {
    final tables = ['notes', 'folders', 'tags'];
    final changes = <Map<String, dynamic>>[];

    for (final table in tables) {
      final rows = await _db.query(
        table,
        where: 'updated_at > ?',
        whereArgs: [lastBackup.toIso8601String()],
      );

      for (final row in rows) {
        changes.add({
          'table': table,
          'operation': 'upsert',
          'data': row,
        });
      }

      // Obtener eliminados (requiere tabla de deleted_items)
      final deleted = await _db.query(
        'deleted_items',
        where: 'table_name = ? AND deleted_at > ?',
        whereArgs: [table, lastBackup.toIso8601String()],
      );

      for (final row in deleted) {
        changes.add({
          'table': table,
          'operation': 'delete',
          'id': row['item_id'],
        });
      }
    }

    return changes;
  }

  /// Aplicar cambios incrementales
  Future<void> applyChanges(List<Map<String, dynamic>> changes) async {
    await _db.transaction((txn) async {
      for (final change in changes) {
        final table = change['table'] as String;
        final operation = change['operation'] as String;

        if (operation == 'upsert') {
          final data = change['data'] as Map<String, dynamic>;
          await txn.insert(
            table,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        } else if (operation == 'delete') {
          final id = change['id'];
          await txn.delete(table, where: 'id = ?', whereArgs: [id]);
        }
      }
    });
  }
}
```

---

## 📋 UI de Gestión de Backups

```dart
/// Pantalla de gestión de backups
class BackupManagementScreen extends StatefulWidget {
  @override
  State<BackupManagementScreen> createState() => _BackupManagementScreenState();
}

class _BackupManagementScreenState extends State<BackupManagementScreen> {
  final _backupService = SqliteBackupService();
  List<BackupInfo> _backups = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBackups();
  }

  Future<void> _loadBackups() async {
    setState(() => _isLoading = true);
    _backups = await _backupService.listBackups();
    setState(() => _isLoading = false);
  }

  Future<void> _createBackup() async {
    try {
      await _backupService.createBackup();
      await _loadBackups();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup creado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear backup: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestión de Backups')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _backups.length,
              itemBuilder: (context, index) {
                final backup = _backups[index];
                return ListTile(
                  leading: Icon(Icons.backup),
                  title: Text(backup.name),
                  subtitle: Text(
                    '${backup.formattedSize} - ${backup.createdAt.toString().substring(0, 16)}',
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'restore',
                        child: Text('Restaurar'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Eliminar'),
                      ),
                    ],
                    onSelected: (value) async {
                      if (value == 'restore') {
                        // Confirmar y restaurar
                      } else if (value == 'delete') {
                        await _backupService.deleteBackup(backup.path);
                        await _loadBackups();
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createBackup,
        icon: Icon(Icons.add),
        label: Text('Crear Backup'),
      ),
    );
  }
}
```

---

## 📋 Checklist de Backup

### Implementación

- [ ] Backup local automático
- [ ] Rotación de backups antiguos
- [ ] Backup en la nube (opcional)
- [ ] Exportación para el usuario
- [ ] Restauración funcional

### Seguridad

- [ ] Encriptar backups sensibles
- [ ] Verificar integridad del backup
- [ ] Validar antes de restaurar

### UX

- [ ] Indicador de progreso
- [ ] Confirmación antes de restaurar
- [ ] Mensajes de error claros
- [ ] Información del último backup

---

> 📌 **Regla de Oro**: Un backup que no se ha probado restaurar no es un backup.
