# 📊 Ejemplos de Datos - NotesVault

## Estructuras de Base de Datos

### SQLite Schema - Notes

```sql
CREATE TABLE notes (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT,
  color INTEGER NOT NULL DEFAULT 4294967295,
  is_favorite INTEGER NOT NULL DEFAULT 0,
  is_deleted INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  deleted_at TEXT,
  sync_status TEXT NOT NULL DEFAULT 'pending',
  server_id TEXT,
  error_message TEXT
);

CREATE TABLE note_tags (
  note_id TEXT NOT NULL,
  tag_id TEXT NOT NULL,
  PRIMARY KEY (note_id, tag_id),
  FOREIGN KEY (note_id) REFERENCES notes (id) ON DELETE CASCADE
);

CREATE TABLE sync_queue (
  id TEXT PRIMARY KEY,
  note_id TEXT NOT NULL,
  operation_type TEXT NOT NULL,
  payload TEXT,
  timestamp TEXT NOT NULL,
  retry_count INTEGER DEFAULT 0
);

-- Índices
CREATE INDEX idx_notes_deleted ON notes (is_deleted);
CREATE INDEX idx_notes_favorite ON notes (is_favorite);
CREATE INDEX idx_notes_sync ON notes (sync_status);
CREATE INDEX idx_notes_updated ON notes (updated_at);
```

---

## Datos de Ejemplo

### Notas de Ejemplo

```dart
final sampleNotes = [
  Note(
    id: 'note_001',
    title: 'Reunión de Proyecto',
    content: '''
Puntos a discutir:
- Revisión del sprint anterior
- Planificación del próximo sprint
- Asignación de tareas
- Fecha de entrega: Viernes

Participantes:
- María (Product Owner)
- Carlos (Tech Lead)
- Ana (Designer)
''',
    color: 0xFFFFF9C4, // Amarillo
    isFavorite: true,
    isDeleted: false,
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    updatedAt: DateTime.now().subtract(Duration(hours: 3)),
    syncStatus: SyncStatus.synced,
    serverId: 'srv_123abc',
    tagIds: ['tag_work', 'tag_meeting'],
  ),
  
  Note(
    id: 'note_002',
    title: 'Lista de Compras',
    content: '''
Supermercado:
☐ Leche
☐ Pan
☐ Huevos
☐ Frutas
☐ Verduras

Farmacia:
☐ Vitaminas
☐ Protector solar
''',
    color: 0xFFC8E6C9, // Verde
    isFavorite: false,
    isDeleted: false,
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    updatedAt: DateTime.now().subtract(Duration(hours: 1)),
    syncStatus: SyncStatus.pending,
    tagIds: ['tag_personal', 'tag_shopping'],
  ),
  
  Note(
    id: 'note_003',
    title: 'Ideas App Flutter',
    content: '''
Características para la nueva app:

1. Autenticación biométrica
2. Modo offline completo
3. Sincronización en segundo plano
4. Notificaciones push
5. Widget para home screen

Tecnologías:
- Flutter 3.x
- Firebase Auth
- SQLite + Hive
- Provider / Riverpod
''',
    color: 0xFFBBDEFB, // Azul
    isFavorite: true,
    isDeleted: false,
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    updatedAt: DateTime.now(),
    syncStatus: SyncStatus.error,
    errorMessage: 'Error de conexión al servidor',
    tagIds: ['tag_work', 'tag_ideas', 'tag_flutter'],
  ),
  
  Note(
    id: 'note_004',
    title: 'Receta: Pasta Carbonara',
    content: '''
Ingredientes (4 personas):
- 400g spaghetti
- 200g panceta
- 4 yemas de huevo
- 100g parmesano rallado
- Pimienta negra
- Sal

Preparación:
1. Cocer la pasta al dente
2. Dorar la panceta en sartén
3. Mezclar yemas con queso
4. Combinar todo fuera del fuego
5. Añadir pimienta al gusto
''',
    color: 0xFFFFCCBC, // Naranja
    isFavorite: false,
    isDeleted: false,
    createdAt: DateTime.now().subtract(Duration(days: 10)),
    updatedAt: DateTime.now().subtract(Duration(days: 10)),
    syncStatus: SyncStatus.synced,
    serverId: 'srv_456def',
    tagIds: ['tag_personal', 'tag_recipes'],
  ),
  
  Note(
    id: 'note_005',
    title: 'Nota Eliminada',
    content: ponentesEsta nota está en la papelera',
    color: 0xFFCFD8DC, // Gris
    isFavorite: false,
    isDeleted: true,
    createdAt: DateTime.now().subtract(Duration(days: 15)),
    updatedAt: DateTime.now().subtract(Duration(days: 3)),
    deletedAt: DateTime.now().subtract(Duration(days: 3)),
    syncStatus: SyncStatus.synced,
    serverId: 'srv_789ghi',
    tagIds: [],
  ),
];
```

### Etiquetas de Ejemplo (Hive)

```dart
final sampleTags = [
  Tag(
    id: 'tag_work',
    name: 'Trabajo',
    color: 0xFF2196F3, // Blue
    usageCount: 15,
  ),
  Tag(
    id: 'tag_personal',
    name: 'Personal',
    color: 0xFF4CAF50, // Green
    usageCount: 12,
  ),
  Tag(
    id: 'tag_ideas',
    name: 'Ideas',
    color: 0xFF9C27B0, // Purple
    usageCount: 8,
  ),
  Tag(
    id: 'tag_meeting',
    name: 'Reunión',
    color: 0xFFFF9800, // Orange
    usageCount: 6,
  ),
  Tag(
    id: 'tag_shopping',
    name: 'Compras',
    color: 0xFFE91E63, // Pink
    usageCount: 4,
  ),
  Tag(
    id: 'tag_flutter',
    name: 'Flutter',
    color: 0xFF00BCD4, // Cyan
    usageCount: 5,
  ),
  Tag(
    id: 'tag_recipes',
    name: 'Recetas',
    color: 0xFFFF5722, // Deep Orange
    usageCount: 3,
  ),
  Tag(
    id: 'tag_urgent',
    name: 'Urgente',
    color: 0xFFF44336, // Red
    usageCount: 2,
  ),
];
```

### Preferencias de Usuario (SharedPreferences)

```dart
// Claves
class PrefsKeys {
  static const String isDarkMode = 'is_dark_mode';
  static const String fontSize = 'font_size';
  static const String viewMode = 'view_mode';
  static const String sortBy = 'sort_by';
  static const String sortAscending = 'sort_ascending';
  static const String showSyncIndicator = 'show_sync_indicator';
  static const String trashRetentionDays = 'trash_retention_days';
  static const String lastBackupDate = 'last_backup_date';
  static const String onboardingComplete = 'onboarding_complete';
}

// Valores por defecto
class PrefsDefaults {
  static const bool isDarkMode = false;
  static const double fontSize = 16.0;
  static const String viewMode = 'grid';
  static const String sortBy = 'updated_at';
  static const bool sortAscending = false;
  static const bool showSyncIndicator = true;
  static const int trashRetentionDays = 30;
}

// Ejemplo de datos guardados
{
  "is_dark_mode": false,
  "font_size": 16.0,
  "view_mode": "grid",
  "sort_by": "updated_at",
  "sort_ascending": false,
  "show_sync_indicator": true,
  "trash_retention_days": 30,
  "last_backup_date": "2024-01-15T10:30:00.000Z",
  "onboarding_complete": true
}
```

---

## Formato de Exportación (JSON)

### Export completo

```json
{
  "version": "1.0",
  "exported_at": "2024-01-15T10:30:00.000Z",
  "app_version": "1.0.0",
  "data": {
    "notes": [
      {
        "id": "note_001",
        "title": "Reunión de Proyecto",
        "content": "Puntos a discutir:\n- Revisión del sprint...",
        "color": 4294965444,
        "is_favorite": true,
        "created_at": "2024-01-13T08:00:00.000Z",
        "updated_at": "2024-01-15T07:00:00.000Z",
        "tags": ["Trabajo", "Reunión"]
      },
      {
        "id": "note_002",
        "title": "Lista de Compras",
        "content": "Supermercado:\n☐ Leche...",
        "color": 4291356873,
        "is_favorite": false,
        "created_at": "2024-01-14T12:00:00.000Z",
        "updated_at": "2024-01-15T09:00:00.000Z",
        "tags": ["Personal", "Compras"]
      }
    ],
    "tags": [
      {
        "id": "tag_work",
        "name": "Trabajo",
        "color": 4280391411
      },
      {
        "id": "tag_personal",
        "name": "Personal",
        "color": 4283215696
      }
    ],
    "settings": {
      "is_dark_mode": false,
      "font_size": 16.0,
      "view_mode": "grid"
    }
  },
  "stats": {
    "total_notes": 2,
    "total_tags": 2,
    "total_characters": 1234
  }
}
```

---

## Cola de Sincronización

### Estructura sync_queue

```dart
final sampleSyncQueue = [
  SyncOperation(
    id: 'sync_001',
    noteId: 'note_002',
    type: OperationType.create,
    payload: jsonEncode({
      'title': 'Lista de Compras',
      'content': 'Supermercado...',
      'color': 4291356873,
      'created_at': '2024-01-14T12:00:00.000Z',
    }),
    timestamp: DateTime.now().subtract(Duration(minutes: 30)),
    retryCount: 0,
  ),
  SyncOperation(
    id: 'sync_002',
    noteId: 'note_003',
    type: OperationType.update,
    payload: jsonEncode({
      'title': 'Ideas App Flutter',
      'content': 'Actualizado...',
      'updated_at': '2024-01-15T10:00:00.000Z',
    }),
    timestamp: DateTime.now().subtract(Duration(minutes: 15)),
    retryCount: 2,
  ),
  SyncOperation(
    id: 'sync_003',
    noteId: 'note_deleted',
    type: OperationType.delete,
    payload: null,
    timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    retryCount: 0,
  ),
];
```

---

## Estadísticas de Ejemplo

```dart
class AppStats {
  final int totalNotes;
  final int favoriteNotes;
  final int deletedNotes;
  final int totalTags;
  final int pendingSync;
  final int syncErrors;
  final int cacheSizeBytes;
  final DateTime? lastSyncTime;
  
  static AppStats example = AppStats(
    totalNotes: 42,
    favoriteNotes: 8,
    deletedNotes: 3,
    totalTags: 12,
    pendingSync: 5,
    syncErrors: 1,
    cacheSizeBytes: 2457600, // ~2.4 MB
    lastSyncTime: DateTime.now().subtract(Duration(hours: 2)),
  );
}
```

---

## Código de Inicialización

### Insertar datos de ejemplo

```dart
class SampleDataSeeder {
  final DatabaseHelper _db;
  final Box<Tag> _tagBox;
  
  Future<void> seedData() async {
    // Verificar si ya hay datos
    final db = await _db.database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM notes')
    ) ?? 0;
    
    if (count > 0) return; // Ya tiene datos
    
    // Insertar etiquetas en Hive
    for (final tag in sampleTags) {
      await _tagBox.put(tag.id, tag);
    }
    
    // Insertar notas en SQLite
    final batch = db.batch();
    for (final note in sampleNotes) {
      batch.insert('notes', note.toMap());
      
      // Insertar relaciones con tags
      for (final tagId in note.tagIds) {
        batch.insert('note_tags', {
          'note_id': note.id,
          'tag_id': tagId,
        });
      }
    }
    await batch.commit();
    
    print('✅ Datos de ejemplo insertados');
  }
}
```

### Limpiar datos de prueba

```dart
Future<void> clearAllData() async {
  final db = await _db.database;
  
  // Limpiar SQLite
  await db.delete('note_tags');
  await db.delete('notes');
  await db.delete('sync_queue');
  
  // Limpiar Hive
  await _tagBox.clear();
  
  // Limpiar SharedPreferences (excepto onboarding)
  final prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys().where((k) => k != 'onboarding_complete');
  for (final key in keys) {
    await prefs.remove(key);
  }
  
  print('🗑️ Todos los datos eliminados');
}
```

---

## Queries Útiles

### Notas más recientes

```sql
SELECT * FROM notes 
WHERE is_deleted = 0 
ORDER BY updated_at DESC 
LIMIT 10;
```

### Notas por etiqueta

```sql
SELECT n.* FROM notes n
INNER JOIN note_tags nt ON n.id = nt.note_id
WHERE nt.tag_id = 'tag_work' AND n.is_deleted = 0
ORDER BY n.updated_at DESC;
```

### Contar notas por estado de sync

```sql
SELECT sync_status, COUNT(*) as count 
FROM notes 
WHERE is_deleted = 0 
GROUP BY sync_status;
```

### Notas en papelera antiguas (para auto-delete)

```sql
SELECT * FROM notes 
WHERE is_deleted = 1 
AND deleted_at < datetime('now', '-30 days');
```

### Búsqueda full-text

```sql
SELECT * FROM notes 
WHERE is_deleted = 0 
AND (title LIKE '%búsqueda%' OR content LIKE '%búsqueda%')
ORDER BY 
  CASE WHEN title LIKE '%búsqueda%' THEN 0 ELSE 1 END,
  updated_at DESC;
```
