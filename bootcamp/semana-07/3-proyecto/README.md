# 🔨 Proyecto Integrador - Semana 07

# 📝 NotesVault: App de Notas con Persistencia Completa

## 📋 Descripción

**NotesVault** es una aplicación de notas que implementa **persistencia completa** utilizando múltiples tecnologías de almacenamiento local. La app permite crear, organizar y sincronizar notas con soporte offline-first.

---

## 🎯 Objetivos de Aprendizaje

Al completar este proyecto demostrarás dominio de:

- [ ] SharedPreferences para configuraciones de usuario
- [ ] SQLite para almacenamiento estructurado de notas
- [ ] Hive para datos de alto rendimiento (etiquetas, caché)
- [ ] Archivos para exportación/importación de datos
- [ ] Patrones offline-first con cola de sincronización
- [ ] Arquitectura limpia con Repository Pattern

---

## ⏱️ Tiempo Estimado

| Fase                      | Tiempo      |
| ------------------------- | ----------- |
| Configuración inicial     | 30 min      |
| Base de datos y modelos   | 1h          |
| UI principal              | 1h 30min    |
| Funcionalidades avanzadas | 1h          |
| **Total**                 | **4 horas** |

---

## 📱 Funcionalidades

### Core Features

1. **Gestión de Notas**

   - Crear, editar, eliminar notas
   - Título, contenido, color
   - Fecha de creación/modificación
   - Marcar como favorita

2. **Organización**

   - Etiquetas/categorías
   - Búsqueda por texto
   - Filtros (favoritas, por etiqueta, recientes)
   - Ordenamiento personalizable

3. **Preferencias de Usuario** (SharedPreferences)

   - Tema claro/oscuro
   - Tamaño de fuente
   - Vista de lista/grid
   - Ordenamiento por defecto

4. **Persistencia Híbrida**
   - Notas en SQLite (relacional)
   - Etiquetas en Hive (rápido acceso)
   - Preferencias en SharedPreferences
   - Exportación a archivos JSON

### Features Avanzadas

5. **Sincronización Offline**

   - Indicador de estado de sync
   - Cola de operaciones pendientes
   - Resolución de conflictos básica

6. **Exportar/Importar**

   - Exportar todas las notas a JSON
   - Importar desde archivo JSON
   - Backup automático

7. **Papelera**
   - Notas eliminadas van a papelera
   - Restaurar o eliminar permanentemente
   - Limpieza automática (30 días)

---

## 🏗️ Arquitectura

```
┌─────────────────────────────────────────────────────────────┐
│                        PRESENTACIÓN                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ NotesList   │  │ NoteEditor  │  │ SettingsScreen      │  │
│  │ Screen      │  │ Screen      │  │                     │  │
│  └──────┬──────┘  └──────┬──────┘  └──────────┬──────────┘  │
│         │                │                     │             │
│  ┌──────┴────────────────┴─────────────────────┴──────────┐  │
│  │                    PROVIDERS                           │  │
│  │  NotesProvider  │  SettingsProvider  │  SyncProvider   │  │
│  └──────────────────────────┬────────────────────────────┘  │
└─────────────────────────────┼───────────────────────────────┘
                              │
┌─────────────────────────────┼───────────────────────────────┐
│                        DOMINIO                               │
│  ┌──────────────────────────┴────────────────────────────┐  │
│  │                   REPOSITORIES                         │  │
│  │  NoteRepository  │  TagRepository  │  PrefsRepository  │  │
│  └──────────────────────────┬────────────────────────────┘  │
└─────────────────────────────┼───────────────────────────────┘
                              │
┌─────────────────────────────┼───────────────────────────────┐
│                         DATOS                                │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌─────────────┐  │
│  │  SQLite  │  │   Hive   │  │SharedPref│  │   Files     │  │
│  │  (Notes) │  │  (Tags)  │  │(Settings)│  │ (Export)    │  │
│  └──────────┘  └──────────┘  └──────────┘  └─────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Estructura del Proyecto

```
lib/
├── main.dart
├── app.dart
│
├── config/
│   ├── routes.dart
│   └── theme.dart
│
├── core/
│   ├── constants/
│   │   ├── storage_keys.dart
│   │   └── app_constants.dart
│   └── utils/
│       ├── date_utils.dart
│       └── validators.dart
│
├── data/
│   ├── database/
│   │   └── database_helper.dart
│   ├── models/
│   │   ├── note.dart
│   │   ├── tag.dart
│   │   └── sync_operation.dart
│   └── services/
│       ├── preferences_service.dart
│       ├── file_service.dart
│       └── sync_service.dart
│
├── domain/
│   └── repositories/
│       ├── note_repository.dart
│       ├── tag_repository.dart
│       └── export_repository.dart
│
├── presentation/
│   ├── providers/
│   │   ├── notes_provider.dart
│   │   ├── settings_provider.dart
│   │   └── sync_provider.dart
│   ├── screens/
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   ├── editor/
│   │   │   ├── note_editor_screen.dart
│   │   │   └── widgets/
│   │   ├── settings/
│   │   │   └── settings_screen.dart
│   │   └── trash/
│   │       └── trash_screen.dart
│   └── widgets/
│       ├── note_card.dart
│       ├── tag_chip.dart
│       ├── search_bar.dart
│       └── sync_indicator.dart
│
└── l10n/
    └── app_localizations.dart
```

---

## 📊 Modelos de Datos

### Note (SQLite)

```dart
class Note {
  final String id;
  final String title;
  final String content;
  final int color;           // Color como int (0xFFFFFFFF)
  final bool isFavorite;
  final bool isDeleted;      // Soft delete (papelera)
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final SyncStatus syncStatus;
  final String? serverId;
  final List<String> tagIds;  // Referencias a tags
}
```

### Tag (Hive)

```dart
@HiveType(typeId: 0)
class Tag extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int color;

  @HiveField(3)
  int usageCount;  // Para ordenar por popularidad
}
```

### Preferencias (SharedPreferences)

```dart
class AppPreferences {
  bool isDarkMode;
  double fontSize;          // 12-24
  String viewMode;          // 'list' | 'grid'
  String sortBy;            // 'date' | 'title' | 'color'
  bool sortAscending;
  bool showSyncIndicator;
  int trashRetentionDays;   // 7, 14, 30
  String? lastBackupDate;
}
```

---

## 🎨 Diseño de UI

### Pantalla Principal

```
┌─────────────────────────────────────┐
│ NotesVault                🔍  ⋮    │
├─────────────────────────────────────┤
│                                     │
│ [All] [⭐Favorites] [🗑️Trash]      │
│                                     │
│ ┌─────────┐ ┌─────────┐            │
│ │ 🟡      │ │ 🔵      │            │
│ │ Meeting │ │ Ideas   │            │
│ │ Notes   │ │ for app │            │
│ │ ⭐  ☁️✓ │ │     ☁️⏳│            │
│ └─────────┘ └─────────┘            │
│ ┌─────────┐ ┌─────────┐            │
│ │ 🟢      │ │ 🟣      │            │
│ │ Shopping│ │ Travel  │            │
│ │ List    │ │ Plans   │            │
│ │     ☁️✓ │ │ ⭐  ☁️✓│            │
│ └─────────┘ └─────────┘            │
│                                     │
│ ─────────────────────────────────── │
│ Tags: [work] [personal] [+]         │
│                              [ + ]  │
└─────────────────────────────────────┘
```

### Editor de Notas

```
┌─────────────────────────────────────┐
│ ←                       ☁️⏳  💾   │
├─────────────────────────────────────┤
│                                     │
│  Título de la nota                  │
│  ────────────────────────────────   │
│                                     │
│  Contenido de la nota...            │
│  Lorem ipsum dolor sit amet,        │
│  consectetur adipiscing elit.       │
│                                     │
│                                     │
│                                     │
│                                     │
├─────────────────────────────────────┤
│ 🎨 Color  │ 🏷️ Tags  │ ⭐ Fav     │
│ [🟡🔵🟢🟣🔴⬜]                      │
│                                     │
│ Tags: [work ×] [important ×] [+]   │
└─────────────────────────────────────┘
```

### Configuración

```
┌─────────────────────────────────────┐
│ ← Configuración                     │
├─────────────────────────────────────┤
│                                     │
│ APARIENCIA                          │
│ ┌─────────────────────────────────┐ │
│ │ 🌙 Tema oscuro           [═══] │ │
│ │ 🔤 Tamaño fuente           16  │ │
│ │    ○────────●────────○         │ │
│ │ 📋 Vista                 Grid  │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ORDENAMIENTO                        │
│ ┌─────────────────────────────────┐ │
│ │ 📊 Ordenar por          Fecha  │ │
│ │ ↕️ Dirección       Descendente │ │
│ └─────────────────────────────────┘ │
│                                     │
│ DATOS                               │
│ ┌─────────────────────────────────┐ │
│ │ 📤 Exportar notas               │ │
│ │ 📥 Importar notas               │ │
│ │ 🗑️ Retención papelera   30 días│ │
│ │ 💾 Último backup      12/01/24 │ │
│ └─────────────────────────────────┘ │
│                                     │
│ SINCRONIZACIÓN                      │
│ ┌─────────────────────────────────┐ │
│ │ ☁️ Estado: 3 pendientes        │ │
│ │ [Sincronizar ahora]             │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

---

## 📋 Requisitos de Evaluación

### Básico (60 puntos)

| Requisito                          | Puntos |
| ---------------------------------- | ------ |
| CRUD de notas con SQLite           | 15     |
| Etiquetas con Hive                 | 10     |
| Preferencias con SharedPreferences | 10     |
| UI funcional (lista + editor)      | 15     |
| Búsqueda y filtros básicos         | 10     |

### Intermedio (25 puntos)

| Requisito                    | Puntos |
| ---------------------------- | ------ |
| Tema dinámico (claro/oscuro) | 5      |
| Vista grid/list toggleable   | 5      |
| Papelera con soft delete     | 5      |
| Exportar/importar JSON       | 5      |
| Favoritos y ordenamiento     | 5      |

### Avanzado (15 puntos)

| Requisito                     | Puntos |
| ----------------------------- | ------ |
| Indicadores de sincronización | 5      |
| Cola de sync offline          | 5      |
| Backup automático             | 5      |

---

## 🚀 Guía de Implementación

### Fase 1: Setup (30 min)

1. Crear proyecto Flutter
2. Agregar dependencias
3. Configurar estructura de carpetas
4. Crear DatabaseHelper con tablas

### Fase 2: Datos (1h)

1. Implementar modelos (Note, Tag)
2. Crear NoteRepository (SQLite)
3. Crear TagRepository (Hive)
4. Crear PreferencesService

### Fase 3: UI Principal (1h 30min)

1. HomeScreen con lista/grid de notas
2. NoteCard widget
3. NoteEditorScreen
4. Barra de búsqueda
5. Filtros y chips de tags

### Fase 4: Features (1h)

1. SettingsScreen con preferencias
2. Tema dinámico
3. Papelera
4. Exportar/importar

---

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Estado
  provider: ^6.1.1

  # Persistencia
  sqflite: ^2.3.0
  path: ^1.8.3
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.2.2
  path_provider: ^2.1.1

  # Utilidades
  uuid: ^4.2.1
  intl: ^0.18.1
  share_plus: ^7.2.1
  file_picker: ^6.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  hive_generator: ^2.0.1
  build_runner: ^2.4.7
```

---

## ✅ Checklist de Entrega

### Funcionalidad

- [ ] Crear nota con título, contenido, color
- [ ] Editar y eliminar notas
- [ ] Agregar/quitar etiquetas
- [ ] Buscar por texto
- [ ] Filtrar por etiqueta
- [ ] Marcar favoritos
- [ ] Cambiar vista list/grid
- [ ] Tema claro/oscuro
- [ ] Papelera funcional
- [ ] Exportar a JSON
- [ ] Importar desde JSON

### Código

- [ ] Nomenclatura en inglés
- [ ] Comentarios explicativos
- [ ] Código modular y limpio
- [ ] Repository pattern aplicado
- [ ] Provider para estado

### Documentación

- [ ] README del proyecto
- [ ] Comentarios en código
- [ ] Capturas de pantalla

---

## 📚 Recursos

- [Ver Guía de Diseño](./GUIA-DISENO.md)
- [Ver Ejemplos de Datos](./EJEMPLOS-DATOS.md)
- [Teoría Semana 07](../1-teoria/README.md)
