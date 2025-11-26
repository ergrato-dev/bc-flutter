# 📚 Teoría - Semana 07: Persistencia de Datos

## Módulos de Aprendizaje

Esta semana cubre las técnicas fundamentales para almacenar datos localmente en aplicaciones Flutter.

| # | Módulo | Duración | Temas |
|---|--------|----------|-------|
| 01 | [SharedPreferences](./01-shared-preferences.md) | 45 min | Almacenamiento clave-valor, preferencias de usuario |
| 02 | [SQLite con sqflite](./02-sqlite-sqflite.md) | 60 min | Bases de datos relacionales, CRUD, migraciones |
| 03 | [Hive y Almacenamiento de Archivos](./03-hive-archivos.md) | 60 min | NoSQL rápido, file system, path_provider |

---

## 🎯 Objetivos por Módulo

### Módulo 01: SharedPreferences
- Almacenar preferencias de usuario
- Guardar configuraciones de la app
- Manejar datos primitivos persistentes
- Implementar tema oscuro/claro persistente

### Módulo 02: SQLite con sqflite
- Diseñar esquemas de base de datos
- Implementar operaciones CRUD completas
- Manejar relaciones entre tablas
- Gestionar migraciones de esquema

### Módulo 03: Hive y Archivos
- Usar Hive para almacenamiento NoSQL
- Guardar objetos complejos con TypeAdapters
- Manejar archivos con path_provider
- Implementar caché de imágenes

---

## 📦 Dependencias de la Semana

```yaml
dependencies:
  # Preferencias
  shared_preferences: ^2.2.2
  
  # SQLite
  sqflite: ^2.3.0
  path: ^1.8.3
  
  # Hive (NoSQL)
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Sistema de archivos
  path_provider: ^2.1.1

dev_dependencies:
  # Generador Hive
  hive_generator: ^2.0.1
  build_runner: ^2.4.7
```

---

## 🔄 Flujo de Aprendizaje Recomendado

```
SharedPreferences → SQLite → Hive → Archivos
      ↓               ↓         ↓        ↓
  Preferencias    Relacional  NoSQL   Binarios
```

1. **Empezar** con SharedPreferences (más simple)
2. **Avanzar** a SQLite para datos estructurados
3. **Explorar** Hive para rendimiento y facilidad
4. **Completar** con manejo de archivos

---

## 📖 Recursos Complementarios

- [Documentación SharedPreferences](https://pub.dev/packages/shared_preferences)
- [Documentación sqflite](https://pub.dev/packages/sqflite)
- [Documentación Hive](https://docs.hivedb.dev/)
- [Documentación path_provider](https://pub.dev/packages/path_provider)
