# 🖼️ Módulo 3: Widget Testing en Flutter

## 📋 Contenido

1. [Introducción](#-introducción)
2. [WidgetTester](#-widgettester)
3. [Finders](#-finders)
4. [Matchers de Widgets](#-matchers-de-widgets)
5. [Interacciones](#-interacciones)
6. [Testing con Estado](#-testing-con-estado)
7. [Testing con Provider](#-testing-con-provider)
8. [Testing con BLoC](#-testing-con-bloc)
9. [Golden Tests](#-golden-tests)

---

## 🎯 Objetivos

- Usar WidgetTester para tests de UI
- Encontrar widgets con finders
- Simular interacciones de usuario
- Testear widgets con state management
- Crear golden tests para regresiones visuales

---

## 📖 Introducción

### ¿Qué son Widget Tests?

Los **Widget Tests** (también llamados Component Tests) verifican el comportamiento de widgets individuales o árboles de widgets pequeños sin necesidad de un dispositivo real.

### Diferencias con otros tipos de tests

| Característica | Unit Test     | Widget Test  | Integration Test     |
| -------------- | ------------- | ------------ | -------------------- |
| Velocidad      | Muy rápida    | Rápida       | Lenta                |
| Dependencias   | Ninguna       | Flutter Test | Dispositivo/Emulador |
| Scope          | Función/Clase | Widget/Árbol | App completa         |
| Confianza      | Baja          | Media        | Alta                 |

### Configuración Básica

```dart
/// test/widgets/counter_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construir el widget
    await tester.pumpWidget(const MaterialApp(
      home: CounterWidget(),
    ));

    // Verificar estado inicial
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Interactuar
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verificar nuevo estado
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
```

---

## 🔧 WidgetTester

### Métodos Principales

```dart
testWidgets('WidgetTester methods demo', (WidgetTester tester) async {
  // ═══════════════════════════════════════════════════
  // CONSTRUIR WIDGETS
  // ═══════════════════════════════════════════════════

  // pumpWidget: Construye y renderiza el widget
  await tester.pumpWidget(const MyApp());

  // pump: Avanza un frame (procesa setState, animaciones)
  await tester.pump();

  // pump con duración: Avanza tiempo específico
  await tester.pump(const Duration(milliseconds: 500));

  // pumpAndSettle: Avanza hasta que no haya frames pendientes
  // Útil para animaciones
  await tester.pumpAndSettle();

  // pumpAndSettle con timeout
  await tester.pumpAndSettle(
    const Duration(milliseconds: 100),
    EnginePhase.sendSemanticsUpdate,
    const Duration(seconds: 5), // timeout
  );

  // ═══════════════════════════════════════════════════
  // INTERACCIONES
  // ═══════════════════════════════════════════════════

  // tap: Simula un tap
  await tester.tap(find.byType(ElevatedButton));

  // longPress: Mantener presionado
  await tester.longPress(find.byType(ListTile));

  // enterText: Ingresar texto
  await tester.enterText(find.byType(TextField), 'Hello');

  // drag: Arrastrar widget
  await tester.drag(find.byType(ListView), const Offset(0, -300));

  // fling: Deslizar con velocidad
  await tester.fling(find.byType(ListView), const Offset(0, -500), 1000);

  // ═══════════════════════════════════════════════════
  // OBTENER WIDGETS
  // ═══════════════════════════════════════════════════

  // widget: Obtener el widget encontrado
  final textWidget = tester.widget<Text>(find.text('Hello'));

  // widgetList: Obtener múltiples widgets
  final buttons = tester.widgetList<ElevatedButton>(
    find.byType(ElevatedButton),
  );

  // element: Obtener el Element del widget
  final element = tester.element(find.byType(MyWidget));

  // state: Obtener el State de un StatefulWidget
  final state = tester.state<MyWidgetState>(find.byType(MyWidget));

  // ═══════════════════════════════════════════════════
  // TAMAÑO Y POSICIÓN
  // ═══════════════════════════════════════════════════

  // getSize: Obtener tamaño del widget
  final size = tester.getSize(find.byType(Container));

  // getCenter: Obtener centro del widget
  final center = tester.getCenter(find.byType(Container));

  // getTopLeft, getTopRight, getBottomLeft, getBottomRight
  final topLeft = tester.getTopLeft(find.byType(Container));
});
```

### Diferencia entre pump, pumpAndSettle

```dart
testWidgets('pump vs pumpAndSettle', (WidgetTester tester) async {
  await tester.pumpWidget(const AnimatedWidget());

  // pump(): Avanza UN frame
  // Útil cuando quieres controlar frame por frame
  await tester.tap(find.text('Start Animation'));
  await tester.pump(); // Solo procesa el tap
  expect(find.text('Animating...'), findsOneWidget);

  // pump(Duration): Avanza tiempo específico
  await tester.pump(const Duration(milliseconds: 250));
  // La animación está a mitad de camino

  // pumpAndSettle(): Avanza hasta que NO haya más frames
  // Útil para animaciones, transiciones de página
  await tester.pumpAndSettle();
  expect(find.text('Animation Complete'), findsOneWidget);
});
```

---

## 🔍 Finders

### Finders Básicos

```dart
void main() {
  testWidgets('Finder examples', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              const Text('Hello'),
              const Text('World'),
              ElevatedButton(
                key: const Key('myButton'),
                onPressed: () {},
                child: const Text('Press Me'),
              ),
              const Icon(Icons.star),
              Tooltip(
                message: 'My Tooltip',
                child: const Icon(Icons.info),
              ),
            ],
          ),
        ),
      ),
    );

    // ═══════════════════════════════════════════════════
    // POR TEXTO
    // ═══════════════════════════════════════════════════

    // Texto exacto
    expect(find.text('Hello'), findsOneWidget);

    // Texto que contiene
    expect(find.textContaining('ell'), findsOneWidget);

    // Texto con regex
    expect(
      find.textContaining(RegExp(r'H.*o')),
      findsOneWidget,
    );

    // ═══════════════════════════════════════════════════
    // POR TIPO
    // ═══════════════════════════════════════════════════

    // Por tipo de widget
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(3)); // Hello, World, Press Me

    // Por tipo de icono
    expect(find.byIcon(Icons.star), findsOneWidget);

    // ═══════════════════════════════════════════════════
    // POR KEY
    // ═══════════════════════════════════════════════════

    // Por Key exacta
    expect(find.byKey(const Key('myButton')), findsOneWidget);

    // Por ValueKey
    expect(find.byKey(const ValueKey('myButton')), findsOneWidget);

    // ═══════════════════════════════════════════════════
    // POR TOOLTIP
    // ═══════════════════════════════════════════════════

    expect(find.byTooltip('My Tooltip'), findsOneWidget);

    // ═══════════════════════════════════════════════════
    // POR WIDGET ESPECÍFICO
    // ═══════════════════════════════════════════════════

    // Por instancia exacta de widget
    const myText = Text('Specific');
    expect(find.byWidget(myText), findsNothing); // No está en el árbol

    // ═══════════════════════════════════════════════════
    // POR SEMÁNTICA
    // ═══════════════════════════════════════════════════

    expect(find.bySemanticsLabel('Hello'), findsOneWidget);
  });
}
```

### Finders Avanzados

```dart
testWidgets('Advanced finders', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Column(
        children: [
          Container(
            color: Colors.red,
            child: const Text('Red Container'),
          ),
          Container(
            color: Colors.blue,
            child: Column(
              children: const [
                Text('Blue Container'),
                Text('Nested Text'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ═══════════════════════════════════════════════════
  // DESCENDANT - Buscar dentro de un widget
  // ═══════════════════════════════════════════════════

  // Encontrar Text dentro del Container azul
  expect(
    find.descendant(
      of: find.byWidgetPredicate(
        (widget) => widget is Container && widget.color == Colors.blue,
      ),
      matching: find.byType(Text),
    ),
    findsNWidgets(2), // Blue Container + Nested Text
  );

  // ═══════════════════════════════════════════════════
  // ANCESTOR - Buscar padre de un widget
  // ═══════════════════════════════════════════════════

  // Encontrar Container que contiene 'Nested Text'
  expect(
    find.ancestor(
      of: find.text('Nested Text'),
      matching: find.byType(Container),
    ),
    findsOneWidget,
  );

  // ═══════════════════════════════════════════════════
  // PREDICATE - Condición personalizada
  // ═══════════════════════════════════════════════════

  // Encontrar Container con color específico
  expect(
    find.byWidgetPredicate(
      (widget) => widget is Container && widget.color == Colors.red,
    ),
    findsOneWidget,
  );

  // ═══════════════════════════════════════════════════
  // ELEMENT PREDICATE
  // ═══════════════════════════════════════════════════

  expect(
    find.byElementPredicate(
      (element) => element.widget is Text,
    ),
    findsNWidgets(3),
  );

  // ═══════════════════════════════════════════════════
  // FIRST / LAST
  // ═══════════════════════════════════════════════════

  // Solo el primer resultado
  expect(find.byType(Text).first, findsOneWidget);

  // Solo el último resultado
  expect(find.byType(Text).last, findsOneWidget);

  // Por índice
  expect(find.byType(Text).at(1), findsOneWidget);
});
```

---

## ✅ Matchers de Widgets

### Matchers Básicos

```dart
testWidgets('Widget matchers', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Column(
        children: [
          const Text('Single'),
          const Text('Multiple'),
          const Text('Multiple'),
        ],
      ),
    ),
  );

  // ═══════════════════════════════════════════════════
  // EXISTENCIA
  // ═══════════════════════════════════════════════════

  // Exactamente uno
  expect(find.text('Single'), findsOneWidget);

  // Ninguno
  expect(find.text('NotFound'), findsNothing);

  // Uno o más
  expect(find.text('Multiple'), findsWidgets);

  // Número específico
  expect(find.text('Multiple'), findsNWidgets(2));

  // Al menos N
  expect(find.byType(Text), findsAtLeastNWidgets(3));

  // Exactamente uno (alias)
  expect(find.text('Single'), findsOne);

  // Al menos uno
  expect(find.byType(Text), findsAny);
});
```

### Verificar Propiedades

```dart
testWidgets('Widget property verification', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: const Text('Click Me'),
      ),
    ),
  );

  // Obtener widget y verificar propiedades
  final button = tester.widget<ElevatedButton>(
    find.byType(ElevatedButton),
  );

  expect(button.onPressed, isNotNull);
  expect(button.child, isA<Text>());

  // Verificar texto hijo
  final text = tester.widget<Text>(find.text('Click Me'));
  expect(text.data, equals('Click Me'));
});
```

---

## 👆 Interacciones

### Tap y Press

```dart
testWidgets('Tap interactions', (WidgetTester tester) async {
  int tapCount = 0;
  int longPressCount = 0;

  await tester.pumpWidget(
    MaterialApp(
      home: Column(
        children: [
          ElevatedButton(
            onPressed: () => tapCount++,
            onLongPress: () => longPressCount++,
            child: const Text('Button'),
          ),
        ],
      ),
    ),
  );

  // Tap simple
  await tester.tap(find.text('Button'));
  await tester.pump();
  expect(tapCount, equals(1));

  // Tap múltiple
  await tester.tap(find.text('Button'));
  await tester.tap(find.text('Button'));
  await tester.pump();
  expect(tapCount, equals(3));

  // Long press
  await tester.longPress(find.text('Button'));
  await tester.pump();
  expect(longPressCount, equals(1));

  // Tap en posición específica
  await tester.tapAt(const Offset(100, 100));
  await tester.pump();
});
```

### Text Input

```dart
testWidgets('Text input', (WidgetTester tester) async {
  String? submittedValue;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: TextField(
          key: const Key('input'),
          onSubmitted: (value) => submittedValue = value,
        ),
      ),
    ),
  );

  // Encontrar el TextField
  final textField = find.byKey(const Key('input'));

  // Ingresar texto
  await tester.enterText(textField, 'Hello World');
  await tester.pump();

  // Verificar valor
  expect(find.text('Hello World'), findsOneWidget);

  // Simular envío (Enter)
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();

  expect(submittedValue, equals('Hello World'));

  // Limpiar y escribir nuevo texto
  await tester.enterText(textField, '');
  await tester.enterText(textField, 'New Text');
  await tester.pump();
});
```

### Scroll y Drag

```dart
testWidgets('Scroll and drag', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
        ),
      ),
    ),
  );

  // Verificar que Item 0 es visible
  expect(find.text('Item 0'), findsOneWidget);
  expect(find.text('Item 50'), findsNothing);

  // Scroll hacia abajo
  await tester.drag(
    find.byType(ListView),
    const Offset(0, -500), // Negativo = hacia abajo
  );
  await tester.pumpAndSettle();

  // Fling (scroll rápido)
  await tester.fling(
    find.byType(ListView),
    const Offset(0, -1000),
    3000, // velocidad
  );
  await tester.pumpAndSettle();

  // ScrollUntilVisible - scroll hasta encontrar widget
  await tester.scrollUntilVisible(
    find.text('Item 50'),
    500, // delta de scroll
    scrollable: find.byType(Scrollable),
  );

  expect(find.text('Item 50'), findsOneWidget);
});
```

### Gestos Complejos

```dart
testWidgets('Complex gestures', (WidgetTester tester) async {
  await tester.pumpWidget(const MyGestureWidget());

  // Double tap
  await tester.tap(find.byType(GestureDetector));
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(find.byType(GestureDetector));
  await tester.pump();

  // Swipe
  await tester.drag(
    find.byType(Dismissible),
    const Offset(500, 0), // Swipe hacia la derecha
  );
  await tester.pumpAndSettle();

  // Pinch to zoom (usando TestGesture)
  final center = tester.getCenter(find.byType(InteractiveViewer));
  final gesture1 = await tester.startGesture(center + const Offset(-50, 0));
  final gesture2 = await tester.startGesture(center + const Offset(50, 0));

  // Expandir
  await gesture1.moveBy(const Offset(-50, 0));
  await gesture2.moveBy(const Offset(50, 0));
  await tester.pump();

  // Liberar
  await gesture1.up();
  await gesture2.up();
  await tester.pumpAndSettle();
});
```

---

## 🔄 Testing con Estado

### StatefulWidget

```dart
testWidgets('StatefulWidget test', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: CounterWidget()));

  // Estado inicial
  expect(find.text('Count: 0'), findsOneWidget);

  // Incrementar
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();
  expect(find.text('Count: 1'), findsOneWidget);

  // Decrementar
  await tester.tap(find.byIcon(Icons.remove));
  await tester.pump();
  expect(find.text('Count: 0'), findsOneWidget);

  // Acceder al State directamente
  final state = tester.state<_CounterWidgetState>(
    find.byType(CounterWidget),
  );
  expect(state.count, equals(0));

  // Llamar método del State (no recomendado en producción)
  state.increment();
  await tester.pump();
  expect(find.text('Count: 1'), findsOneWidget);
});
```

### Async Operations

```dart
testWidgets('Async widget test', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: AsyncWidget()));

  // Estado inicial: loading
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
  expect(find.text('Data loaded'), findsNothing);

  // Esperar a que complete la operación async
  await tester.pumpAndSettle();

  // Verificar estado final
  expect(find.byType(CircularProgressIndicator), findsNothing);
  expect(find.text('Data loaded'), findsOneWidget);
});

// Para tests que necesitan controlar el tiempo
testWidgets('Controlled async test', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: TimerWidget()));

  expect(find.text('0 seconds'), findsOneWidget);

  // Avanzar tiempo manualmente
  await tester.pump(const Duration(seconds: 1));
  expect(find.text('1 seconds'), findsOneWidget);

  await tester.pump(const Duration(seconds: 2));
  expect(find.text('3 seconds'), findsOneWidget);
});
```

---

## 📦 Testing con Provider

### Setup con Provider

```dart
testWidgets('Provider widget test', (WidgetTester tester) async {
  // Crear mock del servicio
  final mockService = MockUserService();
  when(mockService.getUser(1)).thenAnswer(
    (_) async => User(id: 1, name: 'Test User'),
  );

  await tester.pumpWidget(
    // Proveer dependencias para el test
    MultiProvider(
      providers: [
        Provider<UserService>.value(value: mockService),
        ChangeNotifierProvider(create: (_) => UserNotifier()),
      ],
      child: const MaterialApp(
        home: UserProfilePage(),
      ),
    ),
  );

  // Verificar loading
  expect(find.byType(CircularProgressIndicator), findsOneWidget);

  // Esperar carga
  await tester.pumpAndSettle();

  // Verificar datos
  expect(find.text('Test User'), findsOneWidget);
});
```

### Testing ChangeNotifier

```dart
testWidgets('ChangeNotifier test', (WidgetTester tester) async {
  final notifier = CounterNotifier();

  await tester.pumpWidget(
    ChangeNotifierProvider.value(
      value: notifier,
      child: MaterialApp(
        home: Consumer<CounterNotifier>(
          builder: (context, counter, child) {
            return Text('Count: ${counter.count}');
          },
        ),
      ),
    ),
  );

  expect(find.text('Count: 0'), findsOneWidget);

  // Modificar el notifier
  notifier.increment();
  await tester.pump();

  expect(find.text('Count: 1'), findsOneWidget);
});
```

---

## 🧊 Testing con BLoC

### BLoC Widget Test

```dart
testWidgets('BLoC widget test', (WidgetTester tester) async {
  final mockUserBloc = MockUserBloc();

  // Configurar estado inicial
  when(() => mockUserBloc.state).thenReturn(UserInitial());

  await tester.pumpWidget(
    BlocProvider<UserBloc>.value(
      value: mockUserBloc,
      child: const MaterialApp(
        home: UsersPage(),
      ),
    ),
  );

  // Verificar estado inicial
  expect(find.byType(CircularProgressIndicator), findsNothing);

  // Simular cambio de estado
  whenListen(
    mockUserBloc,
    Stream.fromIterable([
      UserLoading(),
      UsersLoaded([User(id: 1, name: 'Test')]),
    ]),
    initialState: UserInitial(),
  );

  // Trigger rebuild
  await tester.pump();
  expect(find.byType(CircularProgressIndicator), findsOneWidget);

  await tester.pumpAndSettle();
  expect(find.text('Test'), findsOneWidget);
});
```

### Con bloc_test Package

```dart
import 'package:bloc_test/bloc_test.dart';

// Mock del BLoC
class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

void main() {
  group('UsersPage', () {
    late MockUserBloc mockUserBloc;

    setUp(() {
      mockUserBloc = MockUserBloc();
    });

    testWidgets('renders loading indicator when loading', (tester) async {
      when(() => mockUserBloc.state).thenReturn(UserLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: const UsersPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders user list when loaded', (tester) async {
      final users = [
        User(id: 1, name: 'User 1'),
        User(id: 2, name: 'User 2'),
      ];
      when(() => mockUserBloc.state).thenReturn(UsersLoaded(users));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: const UsersPage(),
          ),
        ),
      );

      expect(find.text('User 1'), findsOneWidget);
      expect(find.text('User 2'), findsOneWidget);
    });

    testWidgets('adds LoadUsers event on refresh', (tester) async {
      when(() => mockUserBloc.state).thenReturn(UsersLoaded([]));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: const UsersPage(),
          ),
        ),
      );

      // Simular pull to refresh
      await tester.drag(find.byType(RefreshIndicator), const Offset(0, 300));
      await tester.pumpAndSettle();

      verify(() => mockUserBloc.add(LoadUsers())).called(1);
    });
  });
}
```

---

## 🖼️ Golden Tests

### ¿Qué son Golden Tests?

Los **Golden Tests** comparan screenshots de widgets con imágenes de referencia ("goldens") para detectar regresiones visuales.

### Crear Golden Test

```dart
testWidgets('MyWidget golden test', (WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: MyWidget(),
    ),
  );

  await expectLater(
    find.byType(MyWidget),
    matchesGoldenFile('goldens/my_widget.png'),
  );
});
```

### Generar/Actualizar Goldens

```bash
# Generar imágenes golden
flutter test --update-goldens

# Ejecutar tests comparando con goldens existentes
flutter test
```

### Configuración para CI/CD

```dart
// test/flutter_test_config.dart
import 'dart:async';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts(); // Cargar fuentes para consistencia
  return testMain();
}
```

### Golden Test Avanzado

```dart
testWidgets('MyWidget multi-device golden', (WidgetTester tester) async {
  final devices = [
    Device.phone,
    Device.iphone11,
    Device.tabletLandscape,
  ];

  for (final device in devices) {
    await tester.binding.setSurfaceSize(device.size);

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: device.size),
          child: const MyWidget(),
        ),
      ),
    );

    await expectLater(
      find.byType(MyWidget),
      matchesGoldenFile('goldens/my_widget_${device.name}.png'),
    );
  }
});
```

---

## ✅ Best Practices

### Estructura de Tests

```dart
void main() {
  // Grupo por funcionalidad
  group('LoginPage', () {
    // Setup común
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
    });

    group('form validation', () {
      testWidgets('shows error when email is empty', (tester) async {
        // ...
      });

      testWidgets('shows error when password is too short', (tester) async {
        // ...
      });
    });

    group('authentication', () {
      testWidgets('calls login on submit', (tester) async {
        // ...
      });

      testWidgets('shows error on failure', (tester) async {
        // ...
      });
    });
  });
}
```

### Helper Functions

```dart
// test/helpers/pump_app.dart
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }

  Future<void> pumpAppWithBloc<B extends Bloc<dynamic, dynamic>>({
    required B bloc,
    required Widget child,
  }) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider<B>.value(
          value: bloc,
          child: child,
        ),
      ),
    );
  }
}

// Uso
testWidgets('test', (tester) async {
  await tester.pumpApp(const MyWidget());
});
```

### Keys para Testing

```dart
// lib/features/login/presentation/pages/login_page.dart
class LoginPage extends StatelessWidget {
  // Definir keys como constantes
  static const emailFieldKey = Key('login_emailField');
  static const passwordFieldKey = Key('login_passwordField');
  static const submitButtonKey = Key('login_submitButton');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(key: emailFieldKey),
        TextField(key: passwordFieldKey),
        ElevatedButton(key: submitButtonKey, onPressed: () {}),
      ],
    );
  }
}

// test/login_page_test.dart
testWidgets('login flow', (tester) async {
  // Usar keys en lugar de tipos o texto
  await tester.enterText(find.byKey(LoginPage.emailFieldKey), 'test@test.com');
  await tester.enterText(find.byKey(LoginPage.passwordFieldKey), 'password');
  await tester.tap(find.byKey(LoginPage.submitButtonKey));
});
```

---

## 📖 Recursos

- [Flutter Widget Testing](https://docs.flutter.dev/cookbook/testing/widget/introduction)
- [bloc_test Package](https://pub.dev/packages/bloc_test)
- [golden_toolkit Package](https://pub.dev/packages/golden_toolkit)

---

> **Duración estimada:** 1 hora
