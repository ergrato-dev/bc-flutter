# Migración desde Provider y Buenas Prácticas

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo migrar un `ChangeNotifier` de semana 4 a un `Notifier` de Riverpod
- Cómo testear un Notifier sin montar ningún widget
- Por qué Riverpod es el estándar del resto del bootcamp

## 📋 Conceptos Clave

### 1. Migración lado a lado: FavoritesProvider → FavoritesNotifier

```dart
// ANTES (semana 4, Provider)
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggle(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }
}
```

```dart
// DESPUÉS (semana 5, Riverpod)
part 'favorites_notifier.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  Set<String> build() => {};

  bool isFavorite(String id) => state.contains(id);

  void toggle(String id) {
    state = state.contains(id) ? ({...state}..remove(id)) : {...state, id};
  }
}
```

Cambios clave: `ChangeNotifier` → `_$FavoritesNotifier`, constructor/campo privado → `build()`,
`notifyListeners()` desaparece (automático al asignar `state`), y la mutación pasa de
`_favoriteIds.add/remove` (colección mutable) a reasignar `state` con una copia (inmutable).

### 2. Migración en los widgets consumidores

```dart
// ANTES — Provider
final isFavorite = context.watch<FavoritesProvider>().isFavorite(item.id);
context.read<FavoritesProvider>().toggle(item.id);

// DESPUÉS — Riverpod
final isFavorite = ref.watch(favoritesProvider).contains(item.id);
ref.read(favoritesProvider.notifier).toggle(item.id);
```

### 3. Testing sin widgets

```dart
test('toggle agrega y quita un id de favoritos', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);

  expect(container.read(favoritesProvider), isEmpty);

  container.read(favoritesProvider.notifier).toggle('1');
  expect(container.read(favoritesProvider), {'1'});

  container.read(favoritesProvider.notifier).toggle('1');
  expect(container.read(favoritesProvider), isEmpty);
});
```

`ProviderContainer` es el equivalente de `ProviderScope` pero para tests — te permite leer y
mutar providers sin montar ningún widget, ni siquiera con `flutter_test`. Nota que esto es
prácticamente idéntico al test de `ChangeNotifier` de semana 4 (archivo 6), salvo que aquí ni
siquiera necesitas instanciar la clase manualmente: el `container` la gestiona.

### 4. Por qué esto ya no cambia

A partir de esta semana, Riverpod es el estándar del bootcamp para **todo** estado nuevo:
networking (semana 6), formularios (semana 7), persistencia (semana 8), autenticación
(semana 9). Semana 10 introduce Bloc/Cubit como alternativa dentro de Clean Architecture — pero
no reemplaza lo aprendido aquí, lo complementa como una segunda herramienta para tu caja de
herramientas profesional.

## ⚠️ Errores Comunes

- Dejar código de Provider (`ChangeNotifierProvider`, `context.watch<T>()`) mezclado con código
  Riverpod nuevo — a partir de esta semana, todo el estado nuevo usa `ref`, no `context.watch`.
- Olvidar `addTearDown(container.dispose)` en los tests — deja el `ProviderContainer` sin
  liberar entre tests, pudiendo causar interferencia entre casos de prueba.
- Migrar la mutación de estado literalmente (mismo código, solo cambiar la clase base) sin
  ajustar a inmutabilidad — ver teoría 03 de esta semana sobre reasignar vs mutar `state`.

## 📚 Recursos Adicionales

- [riverpod.dev — Testing](https://riverpod.dev/docs/introduction/getting_started)
- [Riverpod — ProviderContainer class (API)](https://pub.dev/documentation/riverpod/latest/riverpod/ProviderContainer-class.html)

## ✅ Checklist de Verificación

- [ ] Puedo migrar un ChangeNotifier simple a un Notifier de Riverpod
- [ ] Puedo testear un Notifier con ProviderContainer sin montar widgets
- [ ] Entiendo que Riverpod es el estándar del resto del bootcamp (no vuelve a cambiar hasta que Bloc se sume, no reemplace, en semana 10)
