# Testing de Cubits con bloc_test

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué probar un Cubit a mano (suscribirse y acumular estados) es repetitivo
- Cómo usar `blocTest` para expresar el mismo test de forma declarativa
- Cómo combinar `blocTest` con mocks de `mocktail`
- Cómo testear el estado inicial y el de error de un Cubit

## 📋 Conceptos Clave

### 1. El problema: probar un Cubit a mano

Un Cubit emite una secuencia de estados a lo largo del tiempo (`Stream<State>`). Probarlo "a
mano" implica suscribirse, acumular emisiones en una lista, y comparar al final — código
repetitivo en cada test.

```dart
// Sin bloc_test — funciona, pero se repite en cada test.
test('ItemsCubit emite loading y loaded', () async {
  final cubit = ItemsCubit(GetItems(mockRepository));
  final states = <ItemsState>[];
  final subscription = cubit.stream.listen(states.add);

  await cubit.fetchItems();
  await subscription.cancel();

  expect(states, [isA<ItemsLoading>(), isA<ItemsLoaded>()]);
});
```

### 2. `blocTest` — la misma prueba, declarativa

```dart
import 'package:bloc_test/bloc_test.dart';

blocTest<ItemsCubit, ItemsState>(
  'emite [ItemsLoading, ItemsLoaded] cuando fetchItems tiene éxito',
  build: () => ItemsCubit(GetItems(mockRepository)),
  act: (cubit) => cubit.fetchItems(),
  expect: () => [isA<ItemsLoading>(), isA<ItemsLoaded>()],
);
```

`build` crea el Cubit bajo prueba; `act` ejecuta la acción; `expect` es la lista de estados
esperados **después** del estado inicial (el estado con el que se construyó el Cubit no cuenta).

### 3. Combinando con mocktail

```dart
group('ItemsCubit', () {
  late MockItemsRepository repository;

  setUp(() => repository = MockItemsRepository());

  blocTest<ItemsCubit, ItemsState>(
    'emite ItemsLoaded con los items del repository',
    build: () {
      when(() => repository.getItems()).thenAnswer(
        (_) async => const [Item(id: '1', name: 'Laptop', description: 'Portátil')],
      );
      return ItemsCubit(GetItems(repository));
    },
    act: (cubit) => cubit.fetchItems(),
    expect: () => [
      isA<ItemsLoading>(),
      isA<ItemsLoaded>().having((s) => s.items, 'items', hasLength(1)),
    ],
  );

  blocTest<ItemsCubit, ItemsState>(
    'emite ItemsError cuando el repository lanza',
    build: () {
      when(() => repository.getItems()).thenThrow(Exception('sin conexión'));
      return ItemsCubit(GetItems(repository));
    },
    act: (cubit) => cubit.fetchItems(),
    expect: () => [isA<ItemsLoading>(), isA<ItemsError>()],
  );
});
```

`.having((s) => s.items, 'items', hasLength(1))` inspecciona un campo específico del estado —
más preciso que comparar el objeto completo.

### 4. `seed` — arrancar desde un estado que no es el inicial

```dart
blocTest<FavoritesCubit, Set<String>>(
  'toggle quita un id ya presente',
  build: () => FavoritesCubit(GetFavoriteIds(repository), ToggleFavorite(repository)),
  seed: () => {'1'}, // el Cubit "ya estaba" en este estado antes del test
  act: (cubit) => cubit.toggle('1'),
  expect: () => [<String>{}],
);
```

### 5. Casos de Uso Móvil

`AuthCubit.login()` (semana 9-14) es el ejemplo canónico: un `blocTest` cubre `[AuthLoading,
AuthAuthenticated]` con credenciales válidas, y otro `[AuthLoading, AuthError]` con el mock
lanzando una excepción — sin backend real, sin esperar la respuesta de `dummyjson.com`.

## ⚠️ Errores Comunes

- **Incluir el estado inicial en `expect`**: `blocTest` ya lo excluye — agregarlo hace que el
  test falle comparando una lista con un elemento de más.
- **No usar `isA<T>()`** cuando el estado no implementa `==`/`Equatable` correctamente: comparar
  instancias directamente puede fallar por referencia, no por valor.
- **Reutilizar la misma instancia de mock entre tests** sin `setUp()`: los `when()` de un test
  contaminan el siguiente si el mock no se recrea.

## 📚 Recursos Adicionales

- [bloc_test — pub.dev](https://pub.dev/packages/bloc_test)
- [Bloc — Testing (documentación oficial)](https://bloclibrary.dev/testing/)

## ✅ Checklist de Verificación

Antes de continuar, verifica que entiendes:

- [ ] Qué hacen `build`, `act` y `expect` en `blocTest`
- [ ] Por qué el estado inicial no va en `expect`
- [ ] Para qué sirve `seed`
