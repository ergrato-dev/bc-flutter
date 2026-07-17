# Ejercicio 03 — bloc_test de un Cubit

> Prueba los tres estados de un Cubit (`ItemsLoading`, `ItemsLoaded`, `ItemsError`) con
> `blocTest`, combinado con un repository mockeado.

## 🎯 Objetivos

- Usar `blocTest` para expresar `build`/`act`/`expect` de forma declarativa
- Combinar `blocTest` con `mocktail` para simular éxito y error del repository
- Verificar el contenido de un estado con `.having(...)`

## 📋 Requisitos

- Teoría 02 y 04 de esta semana completadas

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter test
```

> El archivo que vas a completar es `test/items_cubit_test.dart` — `lib/` ya está completo.

---

## Paso 1: caso de éxito

```dart
// Ejemplo explicativo (no el código del ejercicio):
blocTest<ItemsCubit, ItemsState>(
  'emite [ItemsLoading, ItemsLoaded] cuando el repository responde',
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
```

**Abre `starter/test/items_cubit_test.dart`** y descomenta la sección `PASO 1`.

## Paso 2: caso de error

```dart
// Ejemplo explicativo (no el código del ejercicio):
blocTest<ItemsCubit, ItemsState>(
  'emite [ItemsLoading, ItemsError] cuando el repository lanza',
  build: () {
    when(() => repository.getItems()).thenThrow(Exception('sin conexión'));
    return ItemsCubit(GetItems(repository));
  },
  act: (cubit) => cubit.fetchItems(),
  expect: () => [isA<ItemsLoading>(), isA<ItemsError>()],
);
```

**Descomenta la sección `PASO 2`** en `starter/test/items_cubit_test.dart`.

✅ **Verifica**: `flutter test` debe mostrar `All tests passed!` con ambos `blocTest` en verde.

## ✅ Resultado final

`test/items_cubit_test.dart` cubre tanto el camino feliz como el de error de `ItemsCubit`, sin
tocar ninguna API real.
