# MultiProvider y Organización de Providers

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo exponer varios notifiers con `MultiProvider`
- Dónde colocar los providers en el árbol (scoping)
- Cómo un notifier puede depender de otro con `ProxyProvider` (nivel introductorio)

## 📋 Conceptos Clave

### 1. El problema: varios ChangeNotifierProvider anidados

```dart
// Funciona, pero se vuelve ilegible con 4-5 providers
ChangeNotifierProvider(
  create: (context) => ThemeNotifier(),
  child: ChangeNotifierProvider(
    create: (context) => CartNotifier(),
    child: ChangeNotifierProvider(
      create: (context) => FavoritesNotifier(),
      child: const MyApp(),
    ),
  ),
)
```

### 2. MultiProvider: la forma legible

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => ThemeNotifier()),
    ChangeNotifierProvider(create: (context) => CartNotifier()),
    ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
  ],
  child: const MyApp(),
)
```

`MultiProvider` aplana la lista de providers — funcionalmente idéntico al anidamiento manual,
pero mucho más legible al crecer.

### 3. Dónde colocar los providers (scoping)

No todo tiene que vivir en la raíz de la app. Coloca cada provider en el **punto más bajo del
árbol que lo necesite**:

```dart
// Si SOLO la pantalla de checkout necesita CartNotifier, no lo pongas en main()
GoRoute(
  path: '/checkout',
  builder: (context, state) => ChangeNotifierProvider(
    create: (context) => CartNotifier(),
    child: const CheckoutScreen(),
  ),
),
```

> 💡 **Regla práctica**: si el estado se usa en 2+ pantallas no relacionadas jerárquicamente
> (como favoritos, visible en la lista Y en el detalle), va en la raíz con `MultiProvider`. Si
> es local a una sola pantalla o flujo, va ahí mismo — evita "contaminar" el estado global con
> algo que no lo necesita.

### 4. ProxyProvider: un notifier que depende de otro (vistazo introductorio)

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => AuthNotifier()),
    ChangeNotifierProxyProvider<AuthNotifier, CartNotifier>(
      create: (context) => CartNotifier(),
      update: (context, auth, previousCart) => previousCart!..updateUserId(auth.userId),
    ),
  ],
  child: const MyApp(),
)
```

Verás este patrón con más profundidad cuando conectes autenticación real en semana 9 — por
ahora basta con saber que existe para cuando un notifier necesite reaccionar a cambios de otro.

## ⚠️ Errores Comunes

- Poner absolutamente todos los providers en la raíz de la app "por si acaso" — infla el
  estado global innecesariamente. Evalúa el scoping real de cada uno.
- Olvidar que `MultiProvider` no cambia el comportamiento de cada provider individual — solo
  organiza la sintaxis. Los errores de `notifyListeners()` faltante siguen siendo posibles.

## 📚 Recursos Adicionales

- [provider — MultiProvider class](https://pub.dev/documentation/provider/latest/provider/MultiProvider-class.html)
- [provider — ProxyProvider](https://pub.dev/documentation/provider/latest/provider/ProxyProvider-class.html)

## ✅ Checklist de Verificación

- [ ] Puedo exponer varios notifiers con MultiProvider
- [ ] Sé decidir si un provider va en la raíz o en una pantalla específica
- [ ] Conozco la existencia de ProxyProvider para notifiers dependientes
