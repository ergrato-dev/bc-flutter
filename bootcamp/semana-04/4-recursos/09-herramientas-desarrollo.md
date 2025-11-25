# 🔧 Herramientas de Desarrollo

## 📋 Contenido

Herramientas para debugging, testing y desarrollo de navegación.

---

## 🛠️ Flutter DevTools

### Navigation Debugging

| Herramienta          | Uso                                |
| -------------------- | ---------------------------------- |
| **Widget Inspector** | Ver árbol de widgets de navegación |
| **Performance**      | Medir transiciones                 |
| **Network**          | Debug de deep links                |
| **Logging**          | Eventos de navegación              |

### Instalación

```bash
# Ya incluido con Flutter SDK
flutter pub global activate devtools

# Abrir DevTools
flutter run --debug
# Presionar 'd' en terminal o abrir URL proporcionada
```

### Tips para Navegación

1. **Widget Inspector**: Localiza Navigator en el árbol
2. **Select Widget Mode**: Click en pantalla para ver jerarquía
3. **Performance Overlay**: Verifica transiciones fluidas

---

## 🧩 Extensiones VS Code

### Esenciales para Flutter

| Extensión                    | Publisher       | Función             |
| ---------------------------- | --------------- | ------------------- |
| **Flutter**                  | Dart Code       | Soporte Flutter     |
| **Dart**                     | Dart Code       | Soporte Dart        |
| **Flutter Widget Snippets**  | Alexis Villegas | Snippets de widgets |
| **Awesome Flutter Snippets** | Nash            | Más snippets        |

### Para Navegación

| Extensión                      | Función                 |
| ------------------------------ | ----------------------- |
| **Flutter Navigator Snippets** | Snippets de navegación  |
| **Bracket Pair Colorizer**     | Mejor lectura de código |
| **Error Lens**                 | Ver errores inline      |

### Snippets Útiles

```json
// flutter-nav-push
"Navigator Push": {
  "prefix": "navpush",
  "body": [
    "Navigator.push(",
    "  context,",
    "  MaterialPageRoute(builder: (context) => ${1:Screen}()),",
    ");"
  ]
}

// flutter-nav-named
"Navigator PushNamed": {
  "prefix": "navnamed",
  "body": [
    "Navigator.pushNamed(context, '${1:route}');"
  ]
}
```

---

## 📱 Herramientas de Testing

### Integration Testing

```dart
// test/navigation_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigation test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Tap en botón que navega
    await tester.tap(find.byKey(Key('nav_button')));
    await tester.pumpAndSettle();

    // Verificar que llegamos a nueva pantalla
    expect(find.text('Detail Screen'), findsOneWidget);
  });
}
```

### Widget Testing

```dart
testWidgets('Back button works', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => DetailScreen(),
          );
        },
      ),
    ),
  );

  // Simular back
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();
});
```

---

## 🔍 Debugging de Navegación

### Print Navigation Events

```dart
// En MaterialApp
MaterialApp(
  navigatorObservers: [
    NavigationLogger(),
  ],
);

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('PUSH: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('POP: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint('REPLACE: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
  }
}
```

### Debug Route Stack

```dart
// Ver stack actual
Navigator.of(context).widget.pages.forEach((page) {
  debugPrint('Route: ${page.name}');
});
```

---

## 📊 Análisis de Performance

### Transiciones Fluidas

```dart
// Verificar que transiciones corren a 60fps
import 'package:flutter/scheduler.dart';

void checkFrameRate() {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    final fps = SchedulerBinding.instance.currentFrameTimeStamp;
    debugPrint('Frame time: $fps');
  });
}
```

### Profile Mode

```bash
# Ejecutar en modo profile para medir performance real
flutter run --profile

# Analizar con DevTools
```

---

## 🧪 Herramientas de Mocking

### Mockito para Navigation

```dart
// Mockeando NavigatorObserver
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

testWidgets('Navigation calls observer', (tester) async {
  final mockObserver = MockNavigatorObserver();

  await tester.pumpWidget(
    MaterialApp(
      navigatorObservers: [mockObserver],
      home: HomeScreen(),
    ),
  );

  // Verificar que se llamó didPush
  verify(mockObserver.didPush(any, any));
});
```

---

## ✅ Checklist de Herramientas

- [ ] DevTools instalado y funcionando
- [ ] Extensiones VS Code configuradas
- [ ] Snippets de navegación creados
- [ ] NavigatorObserver para debugging
- [ ] Tests de navegación básicos
