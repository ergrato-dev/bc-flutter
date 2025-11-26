# 📚 Documentación Oficial

## 📋 Referencias Oficiales

> Enlaces a la documentación oficial de todas las tecnologías de persistencia.

---

## 🎯 Flutter Oficial

### Flutter Docs

| Recurso                    | Descripción                 | Link                                                                                                                          |
| -------------------------- | --------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Cookbook - Persistence** | Guías oficiales paso a paso | [flutter.dev/cookbook/persistence](https://docs.flutter.dev/cookbook/persistence)                                             |
| **SQLite Guide**           | Persistir con SQLite        | [flutter.dev/cookbook/persistence/sqlite](https://docs.flutter.dev/cookbook/persistence/sqlite)                               |
| **Key-Value Storage**      | SharedPreferences           | [flutter.dev/cookbook/persistence/key-value](https://docs.flutter.dev/cookbook/persistence/key-value)                         |
| **Reading/Writing Files**  | Sistema de archivos         | [flutter.dev/cookbook/persistence/reading-writing-files](https://docs.flutter.dev/cookbook/persistence/reading-writing-files) |

### Flutter API Reference

| Recurso          | Descripción      | Link                                                                                            |
| ---------------- | ---------------- | ----------------------------------------------------------------------------------------------- |
| **dart:io**      | File I/O         | [api.dart.dev/dart-io](https://api.dart.dev/stable/dart-io/dart-io-library.html)                |
| **dart:convert** | JSON encoding    | [api.dart.dev/dart-convert](https://api.dart.dev/stable/dart-convert/dart-convert-library.html) |
| **dart:async**   | Futures, Streams | [api.dart.dev/dart-async](https://api.dart.dev/stable/dart-async/dart-async-library.html)       |

---

## 📦 Paquetes - Pub.dev

### SharedPreferences

| Elemento               | Link                                                                                                                        |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **Página del paquete** | [pub.dev/packages/shared_preferences](https://pub.dev/packages/shared_preferences)                                          |
| **API Reference**      | [pub.dev/documentation/shared_preferences](https://pub.dev/documentation/shared_preferences/latest/)                        |
| **Changelog**          | [pub.dev/packages/shared_preferences/changelog](https://pub.dev/packages/shared_preferences/changelog)                      |
| **GitHub**             | [github.com/flutter/packages/shared_preferences](https://github.com/flutter/packages/tree/main/packages/shared_preferences) |

**Versión recomendada**: `^2.2.2`

---

### sqflite

| Elemento               | Link                                                                             |
| ---------------------- | -------------------------------------------------------------------------------- |
| **Página del paquete** | [pub.dev/packages/sqflite](https://pub.dev/packages/sqflite)                     |
| **API Reference**      | [pub.dev/documentation/sqflite](https://pub.dev/documentation/sqflite/latest/)   |
| **GitHub**             | [github.com/nicecamera/sqflite](https://github.com/nicecamera/sqflite)           |
| **Wiki**               | [github.com/nicecamera/sqflite/wiki](https://github.com/nicecamera/sqflite/wiki) |

**Versión recomendada**: `^2.3.0`

#### Documentación Detallada sqflite

| Sección                                                                                             | Contenido       |
| --------------------------------------------------------------------------------------------------- | --------------- |
| [Getting Started](https://github.com/nicecamera/sqflite/blob/master/sqflite/doc/getting_started.md) | Primeros pasos  |
| [Opening a database](https://github.com/nicecamera/sqflite/blob/master/sqflite/doc/opening_db.md)   | Abrir/crear DB  |
| [SQL Helper](https://github.com/nicecamera/sqflite/blob/master/sqflite/doc/sql.md)                  | Operaciones SQL |
| [Migration](https://github.com/nicecamera/sqflite/blob/master/sqflite/doc/migration.md)             | Migraciones     |
| [How to](https://github.com/nicecamera/sqflite/blob/master/sqflite/doc/how_to.md)                   | Recetas comunes |

---

### path

| Elemento               | Link                                                                     |
| ---------------------- | ------------------------------------------------------------------------ |
| **Página del paquete** | [pub.dev/packages/path](https://pub.dev/packages/path)                   |
| **API Reference**      | [pub.dev/documentation/path](https://pub.dev/documentation/path/latest/) |

**Versión recomendada**: `^1.8.3`

---

### path_provider

| Elemento                | Link                                                                                       |
| ----------------------- | ------------------------------------------------------------------------------------------ |
| **Página del paquete**  | [pub.dev/packages/path_provider](https://pub.dev/packages/path_provider)                   |
| **API Reference**       | [pub.dev/documentation/path_provider](https://pub.dev/documentation/path_provider/latest/) |
| **Supported Platforms** | Android, iOS, Linux, macOS, Windows                                                        |

**Versión recomendada**: `^2.1.1`

#### Directorios Disponibles

| Método                               | Android          | iOS                           | Uso                    |
| ------------------------------------ | ---------------- | ----------------------------- | ---------------------- |
| `getTemporaryDirectory()`            | Cache dir        | NSCachesDirectory             | Cache temporal         |
| `getApplicationDocumentsDirectory()` | App files        | NSDocumentDirectory           | Documentos del usuario |
| `getApplicationSupportDirectory()`   | App files        | NSApplicationSupportDirectory | Datos de la app        |
| `getExternalStorageDirectory()`      | External storage | N/A                           | Almacenamiento externo |

---

### Hive

| Elemento                  | Link                                                                       |
| ------------------------- | -------------------------------------------------------------------------- |
| **Página del paquete**    | [pub.dev/packages/hive](https://pub.dev/packages/hive)                     |
| **hive_flutter**          | [pub.dev/packages/hive_flutter](https://pub.dev/packages/hive_flutter)     |
| **hive_generator**        | [pub.dev/packages/hive_generator](https://pub.dev/packages/hive_generator) |
| **Documentación oficial** | [docs.hivedb.dev](https://docs.hivedb.dev/)                                |
| **GitHub**                | [github.com/hivedb/hive](https://github.com/hivedb/hive)                   |

**Versiones recomendadas**:

- `hive: ^2.2.3`
- `hive_flutter: ^1.1.0`
- `hive_generator: ^2.0.1`

#### Documentación Hive

| Sección         | Contenido               | Link                                                                            |
| --------------- | ----------------------- | ------------------------------------------------------------------------------- |
| Getting Started | Instalación y setup     | [docs.hivedb.dev/#/getting-started](https://docs.hivedb.dev/#/getting-started/) |
| Boxes           | Almacenamiento de datos | [docs.hivedb.dev/#/boxes](https://docs.hivedb.dev/#/boxes/)                     |
| TypeAdapters    | Tipos personalizados    | [docs.hivedb.dev/#/custom-objects](https://docs.hivedb.dev/#/custom-objects/)   |
| Encryption      | Boxes encriptados       | [docs.hivedb.dev/#/encryption](https://docs.hivedb.dev/#/encryption/)           |
| Best Practices  | Recomendaciones         | [docs.hivedb.dev/#/best-practices](https://docs.hivedb.dev/#/best-practices/)   |

---

### flutter_secure_storage

| Elemento               | Link                                                                                                         |
| ---------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Página del paquete** | [pub.dev/packages/flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)                   |
| **API Reference**      | [pub.dev/documentation/flutter_secure_storage](https://pub.dev/documentation/flutter_secure_storage/latest/) |
| **GitHub**             | [github.com/mogol/flutter_secure_storage](https://github.com/mogol/flutter_secure_storage)                   |

**Versión recomendada**: `^9.0.0`

---

### connectivity_plus

| Elemento               | Link                                                                                               |
| ---------------------- | -------------------------------------------------------------------------------------------------- |
| **Página del paquete** | [pub.dev/packages/connectivity_plus](https://pub.dev/packages/connectivity_plus)                   |
| **API Reference**      | [pub.dev/documentation/connectivity_plus](https://pub.dev/documentation/connectivity_plus/latest/) |

**Versión recomendada**: `^5.0.2`

---

## 📖 SQLite Oficial

### SQLite Documentation

| Recurso            | Descripción        | Link                                                                       |
| ------------------ | ------------------ | -------------------------------------------------------------------------- |
| **SQLite Home**    | Página principal   | [sqlite.org](https://www.sqlite.org/)                                      |
| **SQL Syntax**     | Referencia SQL     | [sqlite.org/lang.html](https://www.sqlite.org/lang.html)                   |
| **Core Functions** | Funciones SQL      | [sqlite.org/lang_corefunc.html](https://www.sqlite.org/lang_corefunc.html) |
| **Date Functions** | Funciones de fecha | [sqlite.org/lang_datefunc.html](https://www.sqlite.org/lang_datefunc.html) |
| **FTS5**           | Full-text search   | [sqlite.org/fts5.html](https://www.sqlite.org/fts5.html)                   |

### SQLite Tutorial

| Recurso              | Descripción       | Link                                                  |
| -------------------- | ----------------- | ----------------------------------------------------- |
| **SQLite Tutorial**  | Tutorial completo | [sqlitetutorial.net](https://www.sqlitetutorial.net/) |
| **W3Schools SQLite** | Referencia rápida | [w3schools.com](https://www.w3schools.com/sql/)       |

---

## 🔧 Herramientas de Desarrollo

### build_runner

| Elemento               | Link                                                                                     |
| ---------------------- | ---------------------------------------------------------------------------------------- |
| **Página del paquete** | [pub.dev/packages/build_runner](https://pub.dev/packages/build_runner)                   |
| **Documentación**      | [pub.dev/documentation/build_runner](https://pub.dev/documentation/build_runner/latest/) |

**Versión recomendada**: `^2.4.6`

### Comandos comunes

```bash
# Generar código una vez
dart run build_runner build

# Generar en modo watch
dart run build_runner watch

# Limpiar y regenerar
dart run build_runner build --delete-conflicting-outputs
```

---

## 🧪 Testing

### sqflite_common_ffi

| Elemento               | Link                                                                               |
| ---------------------- | ---------------------------------------------------------------------------------- |
| **Página del paquete** | [pub.dev/packages/sqflite_common_ffi](https://pub.dev/packages/sqflite_common_ffi) |
| **Uso**                | Tests de SQLite en desktop/CI                                                      |

**Versión recomendada**: `^2.3.0`

---

## 📱 Plataformas Específicas

### Android

| Recurso               | Tema               | Link                                                                                            |
| --------------------- | ------------------ | ----------------------------------------------------------------------------------------------- |
| Data and file storage | Storage overview   | [developer.android.com](https://developer.android.com/training/data-storage)                    |
| SharedPreferences     | Key-value          | [developer.android.com](https://developer.android.com/training/data-storage/shared-preferences) |
| Room Database         | SQLite abstraction | [developer.android.com](https://developer.android.com/training/data-storage/room)               |

### iOS

| Recurso         | Tema           | Link                                                                                        |
| --------------- | -------------- | ------------------------------------------------------------------------------------------- |
| Data Management | Overview       | [developer.apple.com](https://developer.apple.com/documentation/foundation/data_management) |
| UserDefaults    | Key-value      | [developer.apple.com](https://developer.apple.com/documentation/foundation/userdefaults)    |
| Core Data       | Database       | [developer.apple.com](https://developer.apple.com/documentation/coredata)                   |
| Keychain        | Secure storage | [developer.apple.com](https://developer.apple.com/documentation/security/keychain_services) |

---

## 📋 Quick Reference Card

### URLs Esenciales

```
Flutter Persistence Cookbook:
https://docs.flutter.dev/cookbook/persistence

sqflite:
https://pub.dev/packages/sqflite

Hive:
https://docs.hivedb.dev/

SharedPreferences:
https://pub.dev/packages/shared_preferences

path_provider:
https://pub.dev/packages/path_provider

SQLite Reference:
https://www.sqlite.org/lang.html
```

---

## 🔄 Versionado y Compatibilidad

### Matriz de Versiones (Enero 2024)

| Paquete            | Versión | Flutter Min | Dart Min |
| ------------------ | ------- | ----------- | -------- |
| shared_preferences | 2.2.2   | 3.3.0       | 3.1      |
| sqflite            | 2.3.0   | 3.3.0       | 3.1      |
| hive               | 2.2.3   | 2.5.0       | 2.17     |
| hive_flutter       | 1.1.0   | 2.5.0       | 2.17     |
| path_provider      | 2.1.1   | 3.3.0       | 3.1      |
| path               | 1.8.3   | N/A         | 2.17     |

---

## 💡 Tips para Usar Documentación

1. **Busca en GitHub Issues** - Para problemas específicos
2. **Lee el CHANGELOG** - Cambios entre versiones
3. **Revisa ejemplos** - En la carpeta /example del repo
4. **Compara versiones** - Antes de actualizar
5. **Sigue las migration guides** - Para actualizaciones mayores

---

> 📌 **Consejo**: Guarda esta página como referencia. La documentación oficial es siempre la fuente más confiable y actualizada.
