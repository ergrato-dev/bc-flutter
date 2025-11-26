# 💻 Práctica 02: Base de Datos de Contactos

## 🎯 Objetivo

Crear una aplicación de gestión de contactos con **SQLite** implementando operaciones CRUD completas y búsqueda.

---

## 📋 Requisitos

### Funcionales

1. **Lista de Contactos**

   - Mostrar todos los contactos ordenados alfabéticamente
   - Mostrar avatar (iniciales), nombre y teléfono
   - Pull to refresh

2. **Agregar Contacto**

   - Formulario: nombre, teléfono, email, notas
   - Validación de campos
   - Teléfono único

3. **Ver/Editar Contacto**

   - Pantalla de detalle
   - Modo edición
   - Confirmación al guardar

4. **Eliminar Contacto**

   - Swipe to delete en la lista
   - Diálogo de confirmación
   - Opción deshacer (Snackbar)

5. **Búsqueda**
   - Buscar por nombre o teléfono
   - Resultados en tiempo real

### Modelo de Datos

```dart
class Contact {
  int? id;
  String name;
  String phone;
  String? email;
  String? notes;
  bool isFavorite;
  DateTime createdAt;
  DateTime? updatedAt;
}
```

---

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart
├── database/
│   └── database_helper.dart
├── models/
│   └── contact.dart
├── repositories/
│   └── contact_repository.dart
├── providers/
│   └── contacts_provider.dart
├── screens/
│   ├── contact_list_screen.dart
│   ├── contact_detail_screen.dart
│   └── contact_form_screen.dart
└── widgets/
    ├── contact_tile.dart
    └── contact_avatar.dart
```

---

## 📝 Código Base

### 1. Modelo Contact

```dart
// lib/models/contact.dart

/**
 * Contact: Modelo de contacto para SQLite.
 */
class Contact {
  final int? id;
  final String name;
  final String phone;
  final String? email;
  final String? notes;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    this.email,
    this.notes,
    this.isFavorite = false,
    required this.createdAt,
    this.updatedAt,
  });

  /// Convertir a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'notes': notes,
      'is_favorite': isFavorite ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Crear desde Map de SQLite
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      notes: map['notes'],
      isFavorite: map['is_favorite'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
    );
  }

  /// Obtener iniciales para avatar
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  /// copyWith para inmutabilidad
  Contact copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? notes,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      notes: notes ?? this.notes,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() => 'Contact(id: $id, name: $name, phone: $phone)';
}
```

### 2. Database Helper

```dart
// lib/database/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/**
 * DatabaseHelper: Singleton para gestionar SQLite.
 */
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
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
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT UNIQUE NOT NULL,
        email TEXT,
        notes TEXT,
        is_favorite INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // Índices para búsqueda rápida
    await db.execute('CREATE INDEX idx_contact_name ON contacts (name)');
    await db.execute('CREATE INDEX idx_contact_phone ON contacts (phone)');

    // Datos de ejemplo
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    final now = DateTime.now().toIso8601String();

    await db.insert('contacts', {
      'name': 'María García',
      'phone': '+34 612 345 678',
      'email': 'maria@example.com',
      'notes': 'Compañera de trabajo',
      'is_favorite': 1,
      'created_at': now,
    });

    await db.insert('contacts', {
      'name': 'Carlos López',
      'phone': '+34 623 456 789',
      'email': 'carlos@example.com',
      'is_favorite': 0,
      'created_at': now,
    });

    await db.insert('contacts', {
      'name': 'Ana Martínez',
      'phone': '+34 634 567 890',
      'email': 'ana@example.com',
      'notes': 'Cliente importante',
      'is_favorite': 1,
      'created_at': now,
    });
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
```

### 3. Repository

```dart
// lib/repositories/contact_repository.dart
import '../database/database_helper.dart';
import '../models/contact.dart';

/**
 * ContactRepository: Capa de acceso a datos para contactos.
 */
class ContactRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Obtener todos los contactos
  Future<List<Contact>> getAll() async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      'contacts',
      orderBy: 'is_favorite DESC, name ASC',
    );

    return maps.map((m) => Contact.fromMap(m)).toList();
  }

  /// Obtener contacto por ID
  Future<Contact?> getById(int id) async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return Contact.fromMap(maps.first);
  }

  /// Buscar contactos
  Future<List<Contact>> search(String query) async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      'contacts',
      where: 'name LIKE ? OR phone LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'name ASC',
    );

    return maps.map((m) => Contact.fromMap(m)).toList();
  }

  /// Obtener favoritos
  Future<List<Contact>> getFavorites() async {
    final db = await _dbHelper.database;

    final maps = await db.query(
      'contacts',
      where: 'is_favorite = 1',
      orderBy: 'name ASC',
    );

    return maps.map((m) => Contact.fromMap(m)).toList();
  }

  /// Crear contacto
  Future<int> create(Contact contact) async {
    final db = await _dbHelper.database;
    return await db.insert('contacts', contact.toMap());
  }

  /// Actualizar contacto
  Future<int> update(Contact contact) async {
    final db = await _dbHelper.database;

    final updatedContact = contact.copyWith(
      updatedAt: DateTime.now(),
    );

    return await db.update(
      'contacts',
      updatedContact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  /// Toggle favorito
  Future<void> toggleFavorite(int id) async {
    final db = await _dbHelper.database;

    await db.rawUpdate('''
      UPDATE contacts
      SET is_favorite = CASE WHEN is_favorite = 1 THEN 0 ELSE 1 END,
          updated_at = ?
      WHERE id = ?
    ''', [DateTime.now().toIso8601String(), id]);
  }

  /// Eliminar contacto
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Verificar si teléfono existe
  Future<bool> phoneExists(String phone, {int? excludeId}) async {
    final db = await _dbHelper.database;

    String where = 'phone = ?';
    List<dynamic> whereArgs = [phone];

    if (excludeId != null) {
      where += ' AND id != ?';
      whereArgs.add(excludeId);
    }

    final result = await db.query(
      'contacts',
      where: where,
      whereArgs: whereArgs,
    );

    return result.isNotEmpty;
  }

  /// Contar contactos
  Future<int> count() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM contacts');
    return result.first['count'] as int;
  }
}
```

### 4. Provider (A completar)

```dart
// lib/providers/contacts_provider.dart
import 'package:flutter/foundation.dart';
import '../models/contact.dart';
import '../repositories/contact_repository.dart';

/**
 * ContactsProvider: Estado reactivo para contactos.
 *
 * TODO: Implementar toda la lógica de estado
 */
class ContactsProvider extends ChangeNotifier {
  final ContactRepository _repository = ContactRepository();

  List<Contact> _contacts = [];
  List<Contact> _searchResults = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  // Getters
  List<Contact> get contacts => _searchQuery.isEmpty ? _contacts : _searchResults;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSearching => _searchQuery.isNotEmpty;

  /// Cargar todos los contactos
  Future<void> loadContacts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _contacts = await _repository.getAll();
    } catch (e) {
      _error = 'Error al cargar contactos: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Buscar contactos
  Future<void> search(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    // TODO: Implementar búsqueda con debounce
    _searchResults = await _repository.search(query);
    notifyListeners();
  }

  /// Limpiar búsqueda
  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    notifyListeners();
  }

  /// Agregar contacto
  Future<bool> addContact(Contact contact) async {
    // TODO: Implementar
    // 1. Verificar que el teléfono no exista
    // 2. Insertar en base de datos
    // 3. Recargar lista
    // 4. Retornar true/false según éxito
    return false;
  }

  /// Actualizar contacto
  Future<bool> updateContact(Contact contact) async {
    // TODO: Implementar
    return false;
  }

  /// Toggle favorito
  Future<void> toggleFavorite(int id) async {
    // TODO: Implementar
  }

  /// Eliminar contacto
  Future<bool> deleteContact(int id) async {
    // TODO: Implementar
    return false;
  }

  /// Restaurar contacto eliminado (para undo)
  Future<void> restoreContact(Contact contact) async {
    // TODO: Implementar
  }
}
```

### 5. Widget ContactTile

```dart
// lib/widgets/contact_tile.dart
import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'contact_avatar.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onDelete;

  const ContactTile({
    super.key,
    required this.contact,
    this.onTap,
    this.onFavoriteToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('contact_${contact.id}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => onDelete?.call(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        leading: ContactAvatar(initials: contact.initials),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(contact.phone),
        trailing: IconButton(
          icon: Icon(
            contact.isFavorite ? Icons.star : Icons.star_border,
            color: contact.isFavorite ? Colors.amber : null,
          ),
          onPressed: onFavoriteToggle,
        ),
        onTap: onTap,
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar contacto'),
        content: Text('¿Eliminar a ${contact.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    ) ?? false;
  }
}
```

### 6. Widget ContactAvatar

```dart
// lib/widgets/contact_avatar.dart
import 'package:flutter/material.dart';

class ContactAvatar extends StatelessWidget {
  final String initials;
  final double size;

  const ContactAvatar({
    super.key,
    required this.initials,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    // Color basado en las iniciales (consistente)
    final colorIndex = initials.codeUnits.fold<int>(0, (a, b) => a + b);
    final color = Colors.primaries[colorIndex % Colors.primaries.length];

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: color.withOpacity(0.2),
      child: Text(
        initials,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.4,
        ),
      ),
    );
  }
}
```

---

## ✅ Tareas a Completar

### Nivel 1: Básico

- [ ] Completar `ContactsProvider` (addContact, updateContact, deleteContact)
- [ ] Implementar `ContactListScreen` con ListView
- [ ] Implementar búsqueda básica

### Nivel 2: Intermedio

- [ ] Implementar `ContactFormScreen` (crear/editar)
- [ ] Validación de formulario (nombre requerido, teléfono válido, email válido)
- [ ] Verificar teléfono único antes de guardar
- [ ] Implementar `ContactDetailScreen`

### Nivel 3: Avanzado

- [ ] Añadir función "Deshacer" al eliminar (Snackbar con acción)
- [ ] Implementar grupos por letra inicial (SliverList)
- [ ] Añadir filtro por favoritos
- [ ] Exportar contactos a JSON

---

## 🎨 UI Esperada

### Lista de Contactos

```
┌─────────────────────────────────────┐
│ Contactos                      🔍   │
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │ 🔎 Buscar contactos...          │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ★ FAVORITOS                         │
│ ┌───┬───────────────────────┬───┐  │
│ │AG │ Ana García            │ ★ │  │
│ │   │ +34 612 345 678       │   │  │
│ └───┴───────────────────────┴───┘  │
│ ┌───┬───────────────────────┬───┐  │
│ │MG │ María García          │ ★ │  │
│ │   │ +34 612 345 678       │   │  │
│ └───┴───────────────────────┴───┘  │
│                                     │
│ TODOS                               │
│ ┌───┬───────────────────────┬───┐  │
│ │CL │ Carlos López          │ ☆ │  │
│ │   │ +34 623 456 789       │   │  │
│ └───┴───────────────────────┴───┘  │
│                                     │
│                              [ + ]  │
└─────────────────────────────────────┘
```

### Formulario

```
┌─────────────────────────────────────┐
│ ← Nuevo Contacto           Guardar  │
├─────────────────────────────────────┤
│                                     │
│         ┌─────────────┐             │
│         │     AG      │             │
│         │   (avatar)  │             │
│         └─────────────┘             │
│                                     │
│  Nombre *                           │
│  ┌─────────────────────────────┐   │
│  │ Ana García                  │   │
│  └─────────────────────────────┘   │
│                                     │
│  Teléfono *                         │
│  ┌─────────────────────────────┐   │
│  │ +34 612 345 678             │   │
│  └─────────────────────────────┘   │
│                                     │
│  Email                              │
│  ┌─────────────────────────────┐   │
│  │ ana@example.com             │   │
│  └─────────────────────────────┘   │
│                                     │
│  Notas                              │
│  ┌─────────────────────────────┐   │
│  │ Cliente importante          │   │
│  │                             │   │
│  └─────────────────────────────┘   │
│                                     │
└─────────────────────────────────────┘
```

---

## 📊 Criterios de Evaluación

| Criterio                    | Puntos  |
| --------------------------- | ------- |
| CRUD completo funcionando   | 35      |
| Búsqueda implementada       | 15      |
| UI/UX de calidad            | 20      |
| Validaciones correctas      | 15      |
| Código limpio y documentado | 15      |
| **Total**                   | **100** |

---

## 🔗 Recursos

- [sqflite docs](https://pub.dev/packages/sqflite)
- [Flutter Forms](https://docs.flutter.dev/cookbook/forms)
- [Dismissible Widget](https://api.flutter.dev/flutter/widgets/Dismissible-class.html)

---

## ➡️ Siguiente Práctica

[Práctica 03: Lista de Tareas con Hive](./practica-03-hive-tasks.md)
