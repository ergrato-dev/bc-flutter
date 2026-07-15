# AsyncNotifier y AsyncValue

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo declarar un provider asíncrono con `@riverpod` y `build()` retornando `Future<T>`
- Qué es `AsyncValue<T>` y cómo manejar sus 3 estados con `.when()`
- Cómo mutar estado async manteniendo coherencia (`ref.mounted`)

## 📋 Conceptos Clave

### 1. Un provider que carga datos de forma asíncrona

```dart
// items_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_notifier.g.dart';

@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  @override
  Future<List<String>> build() async {
    // Simula una llamada de red (semana 6 la reemplazará por Dio real)
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Elemento 1', 'Elemento 2', 'Elemento 3'];
  }
}
```

Cuando `build()` retorna `Future<T>` (en vez de `T`), Riverpod genera automáticamente un
provider cuyo tipo observado es `AsyncValue<T>`, no `T` directamente.

### 2. AsyncValue: los 3 estados de una operación asíncrona

```dart
final itemsAsync = ref.watch(itemsProvider); // AsyncValue<List<String>>
```

`AsyncValue<T>` representa exactamente lo mismo que ya viste en semana 1 con `Future<T>`, pero
observable y reconstruible por Riverpod:

| Estado | Cuándo ocurre |
|---|---|
| `AsyncLoading` | Mientras `build()` todavía no resuelve |
| `AsyncData<T>` | `build()` resolvió con un valor |
| `AsyncError` | `build()` lanzó una excepción |

### 3. `.when()`: la forma segura de manejar los 3 estados

```dart
itemsAsync.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stackTrace) => Center(child: Text('Error: $error')),
  data: (items) => ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => ListTile(title: Text(items[index])),
  ),
)
```

> ⚠️ **Usa siempre `.when()`, no `.value` directamente**: en Riverpod 3.x, `AsyncValue.value`
> retorna `null` tanto si todavía está cargando como si hubo un error — no distingue los casos.
> `.when()` te obliga a manejar los 3 estados explícitamente, evitando pantallas en blanco
> silenciosas.

### 4. Mutar estado async: agregar un elemento

```dart
@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  @override
  Future<List<String>> build() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Elemento 1', 'Elemento 2'];
  }

  Future<void> addItem(String name) async {
    final current = await future; // espera el valor actual, sea cual sea su estado
    state = AsyncData([...current, name]);
  }
}
```

`future` (dentro del notifier) espera a que `build()` haya resuelto, sin importar si ya
terminó o todavía está en curso — evita condiciones de carrera al mutar antes de que la carga
inicial termine.

### 5. ref.mounted: evitar mutar tras destruirse

```dart
Future<void> addItem(String name) async {
  final current = await future;
  await Future.delayed(const Duration(seconds: 1)); // otra operación async
  if (!ref.mounted) return; // el provider pudo haberse destruido mientras esperabas
  state = AsyncData([...current, name]);
}
```

Si el usuario navega fuera de la pantalla mientras `addItem` todavía espera, el provider
`autoDispose` puede destruirse antes de que la función continúe. `ref.mounted` evita mutar un
estado que ya no existe.

## ⚠️ Errores Comunes

- Usar `itemsAsync.value` directamente en la UI en vez de `.when()` — no distingue loading de
  error, y puede mostrar `null`/pantalla vacía sin explicación.
- Mutar `state` con una lista nueva sin pasar por `AsyncData(...)` — el tipo no compila,
  porque `state` es `AsyncValue<List<T>>`, no `List<T>` directamente.
- No verificar `ref.mounted` tras un `await` adicional dentro de un método del notifier.

## 📚 Recursos Adicionales

- [riverpod.dev — What's new in Riverpod 3.0 (AsyncValue)](https://riverpod.dev/docs/whats_new)
- [Riverpod — AsyncValue class (API)](https://pub.dev/documentation/riverpod/latest/riverpod/AsyncValue-class.html)

## ✅ Checklist de Verificación

- [ ] Puedo declarar un provider async con build() retornando Future<T>
- [ ] Puedo manejar los 3 estados de AsyncValue con .when()
- [ ] Sé por qué usar `.when()` en vez de `.value` directamente
- [ ] Entiendo para qué sirve `ref.mounted` al mutar estado async
