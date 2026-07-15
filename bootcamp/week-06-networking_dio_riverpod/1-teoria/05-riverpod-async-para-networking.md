# Riverpod Async para Networking

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo el `AsyncNotifier` simulado de semana 5 se convierte en uno con datos reales
- Cómo reintentar una carga fallida con `ref.invalidate()`
- Cómo implementar pull-to-refresh con `RefreshIndicator` + Riverpod

## 📋 Conceptos Clave

### 1. De Future.delayed a una llamada HTTP real

En semana 5, `ItemsNotifier` simulaba una carga de red:

```dart
// Semana 5 — simulado
@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  @override
  Future<List<Item>> build() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const [Item(id: '1', name: 'Elemento de ejemplo 1', ...)];
  }
}
```

El mecanismo de `AsyncNotifier` **no cambia en nada** — solo cambia qué hace `build()` por
dentro. Con el repository del archivo anterior:

```dart
// Semana 6 — real
@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  @override
  Future<List<Item>> build() async {
    final repository = ref.watch(itemsRepositoryProvider);
    return repository.fetchItems();
  }
}
```

`build()` sigue retornando `Future<List<Item>>`; Riverpod sigue exponiéndolo como
`AsyncValue<List<Item>>` con los mismos 3 estados (`loading`/`error`/`data`) que ya manejas con
`.when()` desde semana 5. Si `fetchItems()` lanza una excepción (el repository ya tradujo el
`DioException`), Riverpod la captura automáticamente como `AsyncError` — no necesitas un
`try`/`catch` extra en el Notifier.

### 2. ref.invalidate() — reintentar una carga fallida

Cuando `itemsProvider` cae en `AsyncError`, la forma de "reintentar" es invalidar el provider:
Riverpod vuelve a ejecutar `build()` desde cero.

```dart
itemsAsync.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stackTrace) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$error'),
        ElevatedButton(
          onPressed: () => ref.invalidate(itemsProvider),
          child: const Text('Reintentar'),
        ),
      ],
    ),
  ),
  data: (items) => /* ... */,
)
```

`ref.invalidate(itemsProvider)` marca el estado actual como obsoleto; en el próximo frame,
Riverpod reconstruye el provider (vuelve a mostrar `loading`, luego `data` o `error` según el
resultado).

### 3. ref.refresh() — invalidar y esperar el resultado

`ref.refresh(itemsProvider)` hace lo mismo que `invalidate()`, pero además **retorna** el nuevo
valor (útil si necesitas esperar a que termine, por ejemplo dentro de un `Future`):

```dart
Future<void> _onRefresh(WidgetRef ref) async {
  await ref.refresh(itemsProvider.future);
}
```

| Método | Retorna | Uso típico |
|---|---|---|
| `ref.invalidate(provider)` | `void` | Botón "Reintentar" — no necesitas esperar el resultado |
| `ref.refresh(provider.future)` | `Future<T>` | Pull-to-refresh — `RefreshIndicator` necesita un `Future` que resolver |

### 4. Pull-to-refresh con RefreshIndicator

```dart
RefreshIndicator(
  onRefresh: () => ref.refresh(itemsProvider.future),
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => ItemCard(item: items[index]),
  ),
)
```

> ⚠️ `RefreshIndicator` requiere que su `child` sea **scrolleable** (`ListView`, `GridView`) —
> envolver un `Column` no scrolleable no dispara el gesto de "deslizar para refrescar".

## ✅ Checklist de Verificación

- [ ] Entiendo que `AsyncNotifier` no cambia entre datos simulados y datos reales
- [ ] Sé usar `ref.invalidate()` para reintentar una carga fallida
- [ ] Sé la diferencia entre `ref.invalidate()` y `ref.refresh()`
- [ ] Sé implementar pull-to-refresh con `RefreshIndicator`

## 📚 Próximo paso

[Serialización JSON y Buenas Prácticas →](06-serializacion-json-y-buenas-practicas.md)
