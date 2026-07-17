# Ejercicio 02 — Widget Test de un Formulario

> Escribe un widget test que llena un campo de texto, toca el botón, y verifica el mensaje de
> confirmación — sin abrir ningún emulador.

## 🎯 Objetivos

- Montar un widget con `pumpWidget`
- Simular texto de usuario con `enterText` y un toque con `tap`
- Avanzar el frame con `pump()` y verificar el resultado con `find`/`expect`

## 📋 Requisitos

- Teoría 03 de esta semana completada

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter test
```

> El archivo que vas a completar es `test/widget_test.dart` — `lib/main.dart` ya está completo.

---

## Paso 1: montar el widget y verificar el estado inicial

```dart
// Ejemplo explicativo (no el código del ejercicio):
testWidgets('muestra el formulario vacío al inicio', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: FormScreen()));

  expect(find.byKey(const Key('name-field')), findsOneWidget);
  expect(find.text('¡Hola!'), findsNothing);
});
```

**Abre `starter/test/widget_test.dart`** y descomenta la sección `PASO 1`.

## Paso 2: llenar el campo y tocar el botón

```dart
// Ejemplo explicativo (no el código del ejercicio):
await tester.enterText(find.byKey(const Key('name-field')), 'Ana');
await tester.tap(find.byKey(const Key('submit-button')));
await tester.pump();

expect(find.text('¡Hola, Ana!'), findsOneWidget);
```

**Descomenta la sección `PASO 2`** en `starter/test/widget_test.dart`.

## Paso 3: verificar la validación (campo vacío)

```dart
// Ejemplo explicativo (no el código del ejercicio):
await tester.tap(find.byKey(const Key('submit-button')));
await tester.pump();

expect(find.text('El nombre es obligatorio'), findsOneWidget);
```

**Descomenta la sección `PASO 3`** en `starter/test/widget_test.dart`.

✅ **Verifica**: `flutter test` debe mostrar `All tests passed!` con los tres tests en verde.

## ✅ Resultado final

`test/widget_test.dart` cubre el formulario completo: estado inicial, envío válido y validación
de campo vacío — sin necesitar un emulador ni ver la app corriendo.
