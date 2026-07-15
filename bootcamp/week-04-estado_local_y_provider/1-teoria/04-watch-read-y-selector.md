# context.watch, context.read y Selector

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- La diferencia entre `context.watch<T>()` y `context.read<T>()`
- Cuándo usar cada uno para evitar bugs y rebuilds innecesarios
- Cómo optimizar con `Selector` cuando solo necesitas parte del estado

## 📋 Conceptos Clave

### 1. context.watch<T>() — leer Y suscribirse a cambios

```dart
@override
Widget build(BuildContext context) {
  final notifier = context.watch<CounterNotifier>();
  return Text('${notifier.count}'); // se reconstruye cada vez que count cambia
}
```

Úsalo **dentro de `build()`**, cuando el widget debe mostrar el valor actual y reconstruirse
cuando cambie. Es el equivalente a envolver el widget en un `Consumer<T>`.

### 2. context.read<T>() — leer SIN suscribirse

```dart
ElevatedButton(
  onPressed: () => context.read<CounterNotifier>().increment(),
  child: const Text('Sumar'),
)
```

Úsalo en **callbacks** (`onPressed`, `onTap`, `initState`) donde solo necesitas llamar un
método, no mostrar el valor — `read` no suscribe al widget a cambios futuros.

> ⚠️ **Nunca uses `context.watch()` dentro de un callback** (`onPressed`, etc.) — lanza una
> excepción en runtime. `watch` solo es válido durante `build()`.

### 3. Tabla de decisión

| Situación | Usar |
|---|---|
| Mostrar un valor que debe actualizarse en pantalla | `context.watch<T>()` |
| Llamar un método desde `onPressed`/`onTap` | `context.read<T>()` |
| Necesitas suscribirte a solo **una parte** del estado | `Selector` (ver abajo) |

### 4. Selector: suscribirse solo a lo que importa

```dart
class CartNotifier extends ChangeNotifier {
  final List<String> _items = [];
  String userName = 'Invitado';

  List<String> get items => _items;

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }
}

// Sin Selector: este widget se reconstruye si CUALQUIER campo de CartNotifier cambia,
// aunque solo le importe la cantidad de items.
Consumer<CartNotifier>(
  builder: (context, cart, child) => Text('${cart.items.length} items'),
)

// Con Selector: se reconstruye SOLO si cart.items.length cambia (no si cambia userName)
Selector<CartNotifier, int>(
  selector: (context, cart) => cart.items.length,
  builder: (context, itemCount, child) => Text('$itemCount items'),
)
```

> 💡 **Cuándo vale la pena `Selector`**: en notifiers pequeños (como el que verás en el
> proyecto de esta semana) casi nunca es necesario — la diferencia de performance es
> imperceptible. Vale la pena cuando el notifier tiene varios campos independientes y algunos
> widgets solo necesitan uno de ellos, en pantallas con muchos widgets reconstruyéndose.

## ⚠️ Errores Comunes

- Usar `context.watch()` en un `onPressed` — excepción en runtime ("watch cannot be called
  during build" es al revés; aquí el error es usar watch fuera de build).
- Usar `context.read()` dentro de `build()` cuando el widget debería reconstruirse con el
  cambio — el texto en pantalla queda "congelado" con el valor inicial.
- Usar `Provider.of<T>(context)` (la API antigua, pre-`context.watch`) sin el segundo parámetro
  `listen: false` cuando no quieres suscribirte — `context.read`/`context.watch` son más claros
  y evitan este error.

## 📚 Recursos Adicionales

- [provider — Consumer vs context.watch](https://pub.dev/documentation/provider/latest/provider/Consumer-class.html)
- [provider — Selector class](https://pub.dev/documentation/provider/latest/provider/Selector-class.html)

## ✅ Checklist de Verificación

- [ ] Sé cuándo usar context.watch() vs context.read()
- [ ] Entiendo por qué watch() en un callback lanza una excepción
- [ ] Puedo explicar cuándo vale la pena usar Selector
