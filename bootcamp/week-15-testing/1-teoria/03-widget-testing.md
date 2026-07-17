# Widget Testing

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo montar un widget en un entorno de test con `pumpWidget`
- Cómo ubicar widgets con `find` y verificar su presencia
- Cómo simular interacción del usuario (`tap`, `enterText`) y avanzar frames
- Por qué un widget test corre sin GPU ni dispositivo real

## 📋 Conceptos Clave

### 1. `testWidgets` — la variante widget de `test`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('muestra el texto inicial', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Text('Hola'))),
    );

    expect(find.text('Hola'), findsOneWidget);
  });
}
```

`WidgetTester` (`tester`) es el objeto que controla el entorno simulado: monta widgets, simula
gestos, avanza el reloj — todo sin un emulador real corriendo detrás.

> 💡 **Diferencia con otros frameworks**: es conceptualmente igual a React Testing Library
> (`render()` + `screen.getByText()`) — la diferencia es que Flutter no necesita un DOM virtual,
> el propio framework de renderizado corre en el entorno de test.

### 2. `find` — localizar widgets

```dart
find.text('Hola');          // por texto exacto visible
find.byType(ElevatedButton); // por tipo de widget
find.byKey(const Key('submit-button')); // por Key explícita
find.byIcon(Icons.favorite); // por ícono
```

Combinar con `expect(finder, findsOneWidget)`, `findsNothing`, `findsWidgets` (uno o más), o
`findsNWidgets(n)`.

### 3. Simular interacción del usuario

```dart
testWidgets('el botón incrementa el contador', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: CounterScreen()));

  expect(find.text('0'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  // pump() avanza UN frame — necesario después de cualquier setState().
  await tester.pump();

  expect(find.text('1'), findsOneWidget);
});
```

Para formularios: `await tester.enterText(find.byKey(const Key('name-field')), 'Laptop');`.

### 4. `pump()` vs. `pumpAndSettle()`

| Método | Cuándo usarlo |
|---|---|
| `pump()` | Avanza un frame — para un `setState()` puntual |
| `pump(Duration(...))` | Avanza el reloj una duración exacta — animaciones con tiempo conocido |
| `pumpAndSettle()` | Avanza hasta que no queden animaciones/Futures pendientes — **nunca** con un spinner indeterminado (ver nota de semana 4, `CircularProgressIndicator` sin `value`), porque nunca termina |

### 5. Proveer dependencias en el test

Igual que en `main()`, un widget que depende de un Cubit/Provider necesita el árbol de
providers montado en el test:

```dart
await tester.pumpWidget(
  MultiBlocProvider(
    providers: [BlocProvider.value(value: fakeCubit)],
    child: const MaterialApp(home: HomeScreen()),
  ),
);
```

### 6. Casos de Uso Móvil

Verificar que un `LoginScreen` muestra un mensaje de error cuando el `AuthCubit` emite
`AuthError` — sin backend real, sin ver la app en el emulador, en milisegundos.

## ⚠️ Errores Comunes

- **`pumpAndSettle()` con una animación infinita**: el test se cuelga (timeout) — usar `pump()`
  puntual en su lugar, como se documentó en semana 4 para `HomeScreen`.
- **Buscar por texto que cambia de idioma/formato**: preferir `find.byKey` para elementos que
  puedan cambiar de texto entre configuraciones.
- **Olvidar envolver en `MaterialApp`**: widgets como `Scaffold`, `Text` con `Theme.of(context)`
  fallan sin un ancestro `MaterialApp`/`Directionality`.

## 📚 Recursos Adicionales

- [Flutter docs — Widget testing cookbook](https://docs.flutter.dev/cookbook/testing/widget/introduction)
- [WidgetTester — API reference](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html)
- [Finder — API reference](https://api.flutter.dev/flutter/flutter_test/Finder-class.html)

## ✅ Checklist de Verificación

Antes de continuar, verifica que entiendes:

- [ ] La diferencia entre `pump()` y `pumpAndSettle()`
- [ ] Al menos tres formas de usar `find`
- [ ] Por qué un widget que usa un Cubit necesita su provider en el test
