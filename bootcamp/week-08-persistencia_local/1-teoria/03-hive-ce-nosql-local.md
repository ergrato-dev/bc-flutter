# Hive/hive_ce — NoSQL Local

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es un `Box` de Hive y cómo abrir uno
- Cómo guardar y leer `Map`/listas sin necesitar un `TypeAdapter`
- Cuándo sí vale la pena generar un `TypeAdapter` con `hive_ce_generator`

## 📋 Conceptos Clave

### 1. Box — la unidad de almacenamiento de Hive

Un **Box** es el equivalente a una tabla o colección: un contenedor clave-valor persistente en
disco. A diferencia de `SharedPreferences`, un Box puede guardar `Map`, `List` y objetos Dart
completos, no solo primitivos.

```dart
await Hive.initFlutter(); // una vez, antes de abrir cualquier Box
final box = await Hive.openBox('items_cache');

await box.put('items', [
  {'id': '1', 'name': 'Elemento A', 'description': 'Descripción A'},
  {'id': '2', 'name': 'Elemento B', 'description': 'Descripción B'},
]);

final cached = box.get('items') as List?; // null si nunca se guardó nada
```

`Hive.initFlutter()` reemplaza a `Hive.init()` (la versión pura de Dart) — configura
automáticamente el directorio de almacenamiento correcto en cada plataforma.

### 2. Guardar Map/List directamente vs generar un TypeAdapter

Hive acepta `Map<String, dynamic>` y `List` con valores de tipos primitivos **sin configuración
adicional** — es la opción más rápida y la que usa el proyecto de esta semana:

```dart
await box.put('items', items.map((i) => {
  'id': i.id,
  'name': i.name,
  'description': i.description,
}).toList());
```

La alternativa es registrar un **TypeAdapter** generado (`@HiveType`/`@HiveField` +
`build_runner`), que te permite guardar instancias de tu clase directamente:

```dart
@HiveType(typeId: 0)
class CachedItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  CachedItem(this.id, this.name);
}
```

```bash
dart run build_runner build --delete-conflicting-outputs
```

| | Map/List directo | TypeAdapter generado |
|---|---|---|
| Setup | Ninguno | `@HiveType`, `build_runner` |
| Seguridad de tipos al leer | Manual (`as Map`, casts) | Automática |
| Cuándo usarlo | Cache simple, prototipos, pocas clases | Modelos que cambian poco y se leen en muchos lugares |

Este bootcamp usa Map/List directo para mantener el foco en el patrón de cache (archivo 5), no
en la generación de código — ya practicaste `build_runner` con Riverpod en semana 5.

### 3. Boxes tipados

`Hive.openBox('items_cache')` retorna `Box<dynamic>`. Puedes tipar el Box si sabes qué vas a
guardar (`Box<List>`, `Box<String>`), lo que te da autocompletado y errores en tiempo de
compilación al leer:

```dart
final box = await Hive.openBox<List>('items_cache');
final List? cached = box.get('items'); // ya tipado, sin cast
```

### 4. Cerrar y limpiar

```dart
await box.clear();       // borra todo el contenido, mantiene el Box abierto
await box.close();       // libera el archivo — normalmente no necesitas llamarlo tú mismo
await Hive.deleteBoxFromDisk('items_cache'); // borra el archivo completo
```

`box.clear()` es el que usarás con más frecuencia: por ejemplo, al cerrar sesión (archivo 6).

## ✅ Checklist de Verificación

- [ ] Sé abrir un `Box` con `Hive.initFlutter()` + `Hive.openBox()`
- [ ] Sé guardar y leer un `Map`/`List` en un Box sin `TypeAdapter`
- [ ] Sé qué trade-off implica generar un `TypeAdapter` vs guardar `Map` directo
- [ ] Sé limpiar un Box con `box.clear()`

## 📚 Próximo paso

[sqflite y Cuándo Usar SQL →](04-sqflite-y-cuando-usar-sql.md)
