# Cubit — Estado Simple con emit()

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es un `Cubit` y en qué se parece/diferencia de un `AsyncNotifier` de Riverpod
- Por qué el estado se modela con varias clases (`Equatable`) en vez de una sola `AsyncValue`
- Cómo consumir un Cubit desde la UI con `BlocBuilder`/`BlocListener`/`BlocConsumer`

## 📋 Conceptos Clave

### 1. Cubit — la unidad más simple de flutter_bloc

Un `Cubit<State>` mantiene un estado y lo cambia llamando a `emit()` desde dentro de sus propios
métodos — sin clases de evento, sin `mapEventToState`. Es la traducción más directa de lo que ya
sabías hacer con Riverpod:

```dart
// AsyncNotifier (semana 5-9)
class ItemsNotifier extends AsyncNotifier<List<Item>> {
  @override
  Future<List<Item>> build() async {
    return ref.watch(itemsRepositoryProvider).fetchItems();
  }
}

// Cubit (semana 10) — mismo trabajo, mecánica distinta
class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit(this._getItems) : super(const ItemsInitial());
  final GetItems _getItems;

  Future<void> fetchItems() async {
    emit(const ItemsLoading());
    try {
      emit(ItemsLoaded(await _getItems()));
    } catch (e) {
      emit(ItemsError('$e'));
    }
  }
}
```

La diferencia central: `AsyncNotifier.build()` se ejecuta **solo** al observarse por primera vez
(automático). Un Cubit no ejecuta nada solo — `fetchItems()` hay que llamarlo explícitamente
(por eso `HomeScreen` lo llama en `initState()`).

### 2. Por qué varias clases de estado en vez de una AsyncValue

`AsyncValue<T>` de Riverpod ya traía loading/data/error empaquetado en un solo tipo genérico.
Bloc no tiene ese tipo — cada feature define sus propias clases de estado:

```dart
sealed class ItemsState extends Equatable {
  const ItemsState();
  @override
  List<Object?> get props => [];
}

class ItemsInitial extends ItemsState {
  const ItemsInitial();
}

class ItemsLoading extends ItemsState { const ItemsLoading(); }

class ItemsLoaded extends ItemsState {
  const ItemsLoaded(this.items);
  final List<Item> items;
  @override
  List<Object?> get props => [items];
}

class ItemsError extends ItemsState {
  const ItemsError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
```

`sealed class` (Dart 3) obliga al compilador a exigirte cubrir todos los casos en un `switch` —
si agregas un nuevo estado y olvidas manejarlo en la UI, no compila. `Equatable` te da `==` y
`hashCode` automáticos por `props` — sin esto, dos instancias de `ItemsLoaded` con la misma
lista se considerarían distintas, y Bloc no reconstruiría la UI de forma óptima.

### 3. Consumir un Cubit desde la UI

```dart
BlocBuilder<ItemsCubit, ItemsState>(
  builder: (context, state) {
    return switch (state) {
      ItemsInitial() || ItemsLoading() => const CircularProgressIndicator(),
      ItemsError(:final message) => Text(message),
      ItemsLoaded(:final items) => ListView(children: [...]),
    };
  },
)
```

| Widget | Rol | Equivalente Riverpod |
|---|---|---|
| `BlocBuilder` | Reconstruye la UI en cada estado nuevo | `ref.watch(provider)` |
| `BlocListener` | Efectos secundarios (SnackBar, navegación), sin reconstruir | `ref.listen(provider, ...)` |
| `BlocConsumer` | Ambos combinados | — |
| `context.read<Cubit>()` | Llama un método sin observar cambios | `ref.read(provider.notifier)` |
| `context.watch<Cubit>()` | Observa el estado dentro de `build()` | `ref.watch(provider)` |

### 4. Proveer un Cubit — BlocProvider en vez de ProviderScope

```dart
MultiBlocProvider(
  providers: [
    BlocProvider.value(value: getIt<ItemsCubit>()),
    BlocProvider.value(value: getIt<FavoritesCubit>()),
  ],
  child: MaterialApp.router(...),
)
```

`BlocProvider.value()` expone una instancia **ya creada** (por `get_it`, ver teoría 05) — a
diferencia de `BlocProvider(create: (context) => Cubit())`, que crearía una instancia nueva cada
vez que el provider se reconstruye. Como este proyecto quiere un solo `ItemsCubit` para toda la
sesión (igual que `keepAlive: true` en Riverpod), `.value()` es la opción correcta.

## ✅ Checklist de Verificación

- [ ] Sé la diferencia entre `AsyncNotifier.build()` (automático) y un método de Cubit (manual)
- [ ] Sé por qué Bloc usa varias clases de estado con `Equatable` en vez de un tipo genérico
- [ ] Sé cuándo usar `BlocBuilder`, `BlocListener` y `BlocConsumer`
- [ ] Sé por qué este proyecto usa `BlocProvider.value()` en vez de `BlocProvider(create: ...)`

## 📚 Próximo paso

[Bloc — Eventos y Estados →](04-bloc-eventos-y-estados.md)
