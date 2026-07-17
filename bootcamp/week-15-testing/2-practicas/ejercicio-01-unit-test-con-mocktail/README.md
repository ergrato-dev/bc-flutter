# Ejercicio 01 — Unit Test con mocktail

> Escribe un unit test para un use case, simulando su repository con `mocktail` — sin red, sin
> Flutter, en milisegundos.

## 🎯 Objetivos

- Declarar un mock con `class MockX extends Mock implements X`
- Programar su comportamiento con `when().thenAnswer()`
- Verificar el resultado con `expect` y la interacción con `verify`

## 📋 Requisitos

- Teoría 01 y 02 de esta semana completadas

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter test
```

> A diferencia de los ejercicios de otras semanas, aquí no hace falta emulador/simulador — el
> archivo que vas a completar es `test/get_items_test.dart`, no `lib/main.dart` (que ya está
> completo).

---

## Paso 1: declarar el mock

`lib/domain.dart` ya tiene `Item`, `ItemsRepository` (interfaz) y `GetItems` (use case) listos —
no los modifiques.

```dart
// Ejemplo explicativo (no el código del ejercicio):
class MockItemsRepository extends Mock implements ItemsRepository {}
```

**Abre `starter/test/get_items_test.dart`** y descomenta la sección `PASO 1`.

## Paso 2: programar el mock y escribir el test

```dart
// Ejemplo explicativo (no el código del ejercicio):
test('GetItems retorna la lista del repository', () async {
  final repository = MockItemsRepository();
  when(() => repository.getItems()).thenAnswer(
    (_) async => const [Item(id: '1', name: 'Laptop', description: 'Portátil')],
  );

  final result = await GetItems(repository)();

  expect(result, hasLength(1));
  verify(() => repository.getItems()).called(1);
});
```

**Descomenta la sección `PASO 2`** en `starter/test/get_items_test.dart`.

✅ **Verifica**: `flutter test` debe mostrar `All tests passed!` — si ves `MissingStubError`,
revisa que el `when()` esté antes de llamar a `GetItems(repository)()`.

## ✅ Resultado final

`test/get_items_test.dart` verifica que `GetItems` retorna exactamente lo que el mock del
repository programó, sin tocar red ni ninguna base de datos real.
