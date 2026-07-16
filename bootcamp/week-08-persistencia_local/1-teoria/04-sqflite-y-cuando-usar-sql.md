# sqflite y Cuándo Usar SQL

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es `sqflite` y en qué se diferencia de Hive
- Cómo se ve una tabla y una consulta mínima con `sqflite`
- Un criterio claro para elegir entre `shared_preferences`, Hive y `sqflite`

## 📋 Conceptos Clave

### 1. sqflite — SQLite dentro de tu app

`sqflite` es un wrapper de SQLite (el motor de base de datos relacional embebido más usado del
mundo — el mismo que usan Android, iOS, Chrome y VS Code internamente). A diferencia de Hive
(clave-valor), `sqflite` guarda **tablas relacionadas entre sí** y se consulta con SQL completo.

```dart
final db = await openDatabase(
  join(await getDatabasesPath(), 'app.db'),
  onCreate: (db, version) => db.execute(
    'CREATE TABLE items(id TEXT PRIMARY KEY, name TEXT, description TEXT)',
  ),
  version: 1,
);

await db.insert('items', {'id': '1', 'name': 'Elemento A', 'description': 'Desc A'});

final rows = await db.query('items', where: 'name LIKE ?', whereArgs: ['%A%']);
```

### 2. Qué gana SQL que Hive no tiene

- **Relaciones entre tablas**: un `Pedido` con múltiples `ItemsDelPedido`, consultados con `JOIN`
  en una sola query, en vez de recorrer múltiples Boxes a mano.
- **Filtros y ordenamientos complejos**: `WHERE precio > 100 AND categoria = 'x' ORDER BY fecha
  DESC` — Hive solo te da "todos los valores del Box", filtrar es responsabilidad tuya en Dart.
- **Índices**: para miles de filas con búsquedas frecuentes, un índice SQL es mucho más rápido
  que recorrer una lista en memoria.

El costo es más código de infraestructura: definir el esquema, escribir migraciones (`onUpgrade`
al subir `version`), y mapear filas (`Map<String, Object?>`) hacia/desde tus modelos a mano —
Hive con Map directo (archivo anterior) es más simple para casos que no necesitan estas
garantías.

### 3. Criterio de decisión

| Necesitas... | Usa |
|---|---|
| Guardar 1 preferencia simple (tema, idioma, ids favoritos) | `shared_preferences` |
| Cachear una lista que llega de una API, sin relaciones | Hive/`hive_ce` |
| Datos con relaciones (pedidos → items, usuarios → posts) o queries complejas | `sqflite` |
| Un token o contraseña | Ninguno de los tres — `flutter_secure_storage` (semana 9) |

### 4. Por qué esta semana no implementa sqflite

El proyecto de esta semana cachea una lista plana de elementos, sin relaciones — exactamente el
caso donde Hive es la opción correcta y `sqflite` sería sobre-ingeniería. Conocer el criterio de
decisión (esta tabla) es el objetivo de aprendizaje; escribir SQL a mano queda fuera del alcance
de este bootcamp, pero ahora sabes cuándo pedirlo en un proyecto real.

## ✅ Checklist de Verificación

- [ ] Sé explicar en qué se diferencia `sqflite` de Hive (relacional vs clave-valor)
- [ ] Sé leer una tabla, un `INSERT` y un `SELECT` mínimos de `sqflite`
- [ ] Sé elegir entre `shared_preferences`, Hive y `sqflite` según el tipo de dato
- [ ] Sé por qué el proyecto de esta semana usa Hive y no `sqflite`

## 📚 Próximo paso

[Repository Pattern con Cache Local →](05-repository-pattern-con-cache-local.md)
