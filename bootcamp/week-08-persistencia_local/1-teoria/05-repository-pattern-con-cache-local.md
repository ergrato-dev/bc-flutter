# Repository Pattern con Cache Local

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué estrategia de cache usa este proyecto (network-first con fallback) y por qué
- Cómo decorar un `ItemsRepository` existente con una capa de cache, sin tocar su interfaz
- Por qué la UI (`ItemsNotifier`, `HomeScreen`) no cambia en absoluto esta semana

## 📋 Conceptos Clave

### 1. Tres estrategias de cache, y la que usa este curso

- **Cache-first**: lee del cache primero, solo consulta la red si el cache está vacío. Rápido,
  pero puede mostrar datos viejos indefinidamente si nunca se refresca.
- **Network-first con fallback**: intenta la red primero; si falla (sin conexión, timeout),
  cae al cache. Es la estrategia de este proyecto — simple de razonar, y los datos mostrados
  son siempre los más recientes posibles.
- **Stale-while-revalidate**: muestra el cache de inmediato mientras la red se actualiza en
  segundo plano. Mejor UX percibida, pero más complejo de implementar correctamente — queda
  fuera del alcance de este bootcamp.

![Flujo de CachedItemsRepository: fetchItems() intenta la red vía DioItemsRepository; si tiene éxito, guarda el resultado en el Box de Hive y lo retorna; si falla, lee el Box como fallback y retorna esos datos; si el Box también está vacío, relanza el error original](../0-assets/01-cached-repository-flow.svg)

### 2. El patrón: decorar, no modificar

`DioItemsRepository` (semana 6) ya implementa `ItemsRepository`. En vez de agregarle lógica de
cache directamente (mezclando dos responsabilidades en una clase), este proyecto agrega una
**segunda implementación** de la misma interfaz que envuelve a la primera:

```dart
class CachedItemsRepository implements ItemsRepository {
  CachedItemsRepository(this._remote, this._box);

  final ItemsRepository _remote; // la implementación real (Dio)
  final Box<dynamic> _box;       // el cache local (Hive)

  static const _cacheKey = 'items';

  @override
  Future<List<Item>> fetchItems() async {
    try {
      final items = await _remote.fetchItems();
      await _box.put(_cacheKey, items.map(_toCacheMap).toList());
      return items;
    } catch (_) {
      final cached = _box.get(_cacheKey) as List?;
      if (cached != null) return cached.map(_fromCacheMap).toList();
      rethrow;
    }
  }

  @override
  Future<void> createItem(Item item) => _remote.createItem(item);
}
```

Este es el patrón **Decorator**: `CachedItemsRepository` no sabe nada de Dio, y
`DioItemsRepository` no sabe nada de Hive — cada clase tiene una sola responsabilidad, y se
componen en el punto de construcción:

```dart
@riverpod
ItemsRepository itemsRepository(Ref ref) {
  final dio = DioItemsRepository(ref.watch(dioProvider));
  final box = ref.watch(itemsCacheBoxProvider);
  return CachedItemsRepository(dio, box);
}
```

### 3. Por qué la UI no cambia

`ItemsNotifier` (semana 5-6) solo conoce el contrato `ItemsRepository.fetchItems()` — nunca supo
que había Dio detrás, y tampoco necesita saber que ahora hay Hive. `HomeScreen` sigue llamando
`ref.watch(itemsProvider)` exactamente igual. Esta es la razón por la que se invirtió esfuerzo en
la interfaz `ItemsRepository` desde semana 6: agregar una capa nueva (cache) es un cambio
aislado a la capa de datos, invisible para todo lo demás.

### 4. `createItem()` no usa cache

Un `POST` es una escritura, no una lectura — no tiene sentido "cachear" una creación. Por eso
`CachedItemsRepository.createItem()` delega directamente en `_remote.createItem()`, sin pasar
por el Box. Si el usuario está sin conexión, la creación simplemente falla (como en semana 7) —
implementar una cola de escrituras pendientes ("sync cuando vuelva la conexión") es un patrón
válido, pero queda fuera del alcance de esta semana.

## ✅ Checklist de Verificación

- [ ] Sé explicar la diferencia entre cache-first y network-first con fallback
- [ ] Sé por qué `CachedItemsRepository` es un Decorator y no una modificación de
      `DioItemsRepository`
- [ ] Sé por qué `ItemsNotifier` y `HomeScreen` no necesitan cambios esta semana
- [ ] Sé por qué `createItem()` no pasa por el cache

## 📚 Próximo paso

[Buenas Prácticas de Persistencia Móvil →](06-buenas-practicas-de-persistencia-movil.md)
