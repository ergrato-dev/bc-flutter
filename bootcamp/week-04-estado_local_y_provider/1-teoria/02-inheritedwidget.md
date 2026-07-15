# InheritedWidget: la base de Provider

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es un `InheritedWidget` y cómo Flutter lo usa internamente
- Por qué `Theme.of(context)` y `MediaQuery.of(context)` funcionan sin pasar parámetros
- Por qué Provider existe (para no escribir esto a mano)

## 📋 Conceptos Clave

### 1. Ya has usado InheritedWidget sin saberlo

```dart
final primaryColor = Theme.of(context).colorScheme.primary;
final screenWidth = MediaQuery.of(context).size.width;
```

`Theme.of(context)` y `MediaQuery.of(context)` (semana 2) funcionan porque `MaterialApp`
coloca un `InheritedWidget` arriba en el árbol, y `.of(context)` lo busca hacia arriba desde tu
posición actual. Es el mismo mecanismo que usarás para tu propio estado.

### 2. Un InheritedWidget mínimo (solo para entender el mecanismo)

```dart
class CounterInherited extends InheritedWidget {
  const CounterInherited({super.key, required this.count, required super.child});

  final int count;

  static CounterInherited of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<CounterInherited>();
    assert(result != null, 'No hay un CounterInherited en el árbol');
    return result!;
  }

  @override
  bool updateShouldNotify(CounterInherited oldWidget) => count != oldWidget.count;
}
```

- `context.dependOnInheritedWidgetOfExactType<T>()` busca hacia arriba en el árbol y **además**
  suscribe al widget que llama para reconstruirse cuando el valor cambie.
- `updateShouldNotify` decide si vale la pena reconstruir a los que dependen de este widget —
  evita rebuilds innecesarios si el valor no cambió realmente.

> ⚠️ **No necesitas escribir InheritedWidget a mano en este curso** — este archivo es solo para
> que entiendas qué hace Provider por debajo. En la práctica, siempre usarás
> `ChangeNotifierProvider` (archivo 3), que ya implementa todo esto por ti.

### 3. Por qué Provider existe

Escribir un `InheritedWidget` a mano cada vez que necesitas compartir estado es repetitivo y
propenso a errores (olvidar `updateShouldNotify`, olvidar el `static of()`, etc.). El paquete
**Provider** (mantenido por miembros del equipo de Flutter) envuelve este patrón en una API
declarativa:

```dart
// Esto (que verás en el archivo 3) reemplaza el InheritedWidget de arriba:
ChangeNotifierProvider(
  create: (context) => CounterNotifier(),
  child: const MyApp(),
)
```

## ⚠️ Errores Comunes

- Confundir `InheritedWidget` con estado mutable — el `InheritedWidget` en sí es **inmutable**;
  el patrón para mutar datos y notificar cambios es `ChangeNotifier` (siguiente archivo).
- Llamar `dependOnInheritedWidgetOfExactType` fuera de `build()` — solo funciona ahí, porque
  necesita registrar la suscripción durante la construcción del widget.

## 📚 Recursos Adicionales

- [Flutter — InheritedWidget class](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)
- [Flutter — Sharing state cookbook](https://docs.flutter.dev/cookbook/design/orientation)

## ✅ Checklist de Verificación

- [ ] Entiendo que Theme.of/MediaQuery.of ya usan InheritedWidget internamente
- [ ] Sé qué hace `dependOnInheritedWidgetOfExactType`
- [ ] Entiendo por qué Provider existe (evitar escribir esto a mano)
