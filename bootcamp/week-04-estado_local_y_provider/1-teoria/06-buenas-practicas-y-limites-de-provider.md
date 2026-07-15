# Buenas Prácticas y Límites de Provider

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo separar lógica de negocio (notifier) de presentación (widgets)
- Buenas prácticas de inmutabilidad dentro de un ChangeNotifier
- Las limitaciones de Provider que motivan usar Riverpod desde la próxima semana

## 📋 Conceptos Clave

### 1. El notifier no debe conocer widgets

```dart
// ✅ BIEN — el notifier solo conoce datos y lógica de negocio
class FavoritesNotifier extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

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

// ❌ MAL — el notifier no debería mostrar SnackBars, navegar, ni conocer BuildContext
class BadNotifier extends ChangeNotifier {
  void toggle(String id, BuildContext context) {
    // ...
    ScaffoldMessenger.of(context).showSnackBar(/* ... */); // acoplamiento indebido
  }
}
```

> 💡 **Por qué importa**: un notifier que no depende de `BuildContext` ni de widgets es
> trivial de testear con `flutter_test` sin necesidad de montar ningún widget — solo
> instancias y verificas llamadas a métodos.

### 2. Inmutabilidad de las colecciones expuestas

```dart
class FavoritesNotifier extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  // ✅ BIEN — expone una copia inmutable, nadie puede mutarla desde afuera
  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  // ❌ MAL — expone la referencia mutable directamente
  // Set<String> get favoriteIds => _favoriteIds;
}
```

Si expones la colección mutable directamente, cualquier widget podría modificarla sin pasar
por `toggle()` — rompiendo `notifyListeners()` y generando bugs difíciles de rastrear.

### 3. Testing de un ChangeNotifier

```dart
test('toggle agrega y quita un id de favoritos', () {
  final notifier = FavoritesNotifier();
  expect(notifier.isFavorite('1'), isFalse);

  notifier.toggle('1');
  expect(notifier.isFavorite('1'), isTrue);

  notifier.toggle('1');
  expect(notifier.isFavorite('1'), isFalse);
});
```

Nota que este test **no necesita `flutter_test`/widgets** — es un test unitario puro de Dart,
porque el notifier no depende de nada de Flutter más que `ChangeNotifier`.

### 4. Dónde colocar el ChangeNotifierProvider: dentro de MyApp, no en runApp()

```dart
// ❌ MAL — el provider queda FUERA del widget MyApp
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(routerConfig: appRouter);
}
```

```dart
// ✅ BIEN — el provider vive DENTRO de MyApp.build()
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesNotifier(),
      child: MaterialApp.router(routerConfig: appRouter),
    );
  }
}
```

> ⚠️ **Esto no es solo estilo**: en `flutter_test`, `testWidgets` monta el widget que le pasas
> con `tester.pumpWidget(...)` — típicamente `const MyApp()`. Si el `ChangeNotifierProvider`
> quedó en `runApp()` (fuera de `MyApp`), el código de `main()` **nunca se ejecuta en el
> test**, y cualquier `Consumer`/`context.watch` dentro de la app lanza
> `ProviderNotFoundException` apenas se intenta pintar la pantalla — un bug real que aparece
> exactamente así al escribir el primer test de la app (lo verificarás tú mismo en el proyecto
> de esta semana).

### 5. Los límites de Provider (por qué viene Riverpod)

Provider es simple y suficiente para el estado de esta semana, pero tiene limitaciones que
notarás al escalar:

| Limitación de Provider | Cómo lo resuelve Riverpod (semana 5) |
|---|---|
| Necesita `BuildContext` para leer el estado | Providers accesibles sin `context`, incluso fuera de widgets |
| Errores de tipo ("no provider found") solo aparecen en **runtime** | Verificados en **tiempo de compilación** |
| Combinar/derivar estado de varios providers requiere `ProxyProvider` (verboso) | Composición de providers mucho más simple |
| Difícil de testear con múltiples configuraciones en paralelo | Overrides de providers diseñados para testing desde el inicio |

> 💡 Esto no significa que Provider sea "malo" — sigue siendo una opción válida y muy usada en
> apps reales. Este curso lo enseña primero precisamente porque su simplicidad ayuda a entender
> los conceptos base antes de pasar a la herramienta más potente.

## ⚠️ Errores Comunes

- Poner lógica de negocio compleja directamente en widgets "porque es más rápido" — reduce
  testabilidad y reutilización.
- Exponer colecciones mutables sin copia — bugs de mutación externa no rastreada.
- Sentir que hay que "dominar" Provider al 100% antes de avanzar — el objetivo de esta semana
  es el modelo mental (notifier + notifyListeners + watch/read), que se reutiliza en Riverpod.

## 📚 Recursos Adicionales

- [provider — Best practices (README)](https://pub.dev/packages/provider)
- [Flutter — Testing ChangeNotifier](https://docs.flutter.dev/cookbook/testing/unit/introduction)

## ✅ Checklist de Verificación

- [ ] Puedo escribir un ChangeNotifier sin dependencias de BuildContext ni widgets
- [ ] Sé por qué exponer colecciones con `Set.unmodifiable`/copias es más seguro
- [ ] Sé por qué el ChangeNotifierProvider debe ir dentro de MyApp, no en runApp()
- [ ] Puedo nombrar al menos 2 limitaciones de Provider que Riverpod resuelve
