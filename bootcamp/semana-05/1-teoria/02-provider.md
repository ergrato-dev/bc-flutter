# Módulo 02: Provider (ChangeNotifier)

## 🎯 Objetivos

- Entender `Provider` y `ChangeNotifier` como solución sencilla para estado compartido.
- Implementar `ChangeNotifierProvider`, `Consumer`, y `Selector`.
- Conocer `MultiProvider` y patrones de organización.

---

## 1. ¿Por qué Provider?

`Provider` es una solución oficial, ligera y fácil de entender. Funciona bien para la mayoría de apps pequeñas y medianas.

---

## 2. Ejemplo básico

```dart
class CartModel extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get items => List.unmodifiable(_items);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}

// En main.dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: MyApp(),
    ),
  );
}

// Consumir
class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final count = context.select<CartModel, int>((c) => c.items.length);
    return Stack(
      children: [ Icon(Icons.shopping_cart), Text('\\$count') ],
    );
  }
}
```

---

## 3. `Consumer` vs `Selector` vs `context.watch()`

- `Consumer<T>`: reconstruye solo el widget contenido cuando `notifyListeners()`.
- `Selector<T, R>`: selecciona un fragmento del modelo y reconstruye solo cuando ese fragmento cambia (mejor rendimiento).
- `context.watch<T>() / read<T>() / select<T, R>()`: helpers útiles dentro de `build()` o handlers.

---

## 4. Organización y `MultiProvider`

Usa `MultiProvider` para registrar varios providers en la raíz:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthModel()),
    ChangeNotifierProvider(create: (_) => CartModel()),
  ],
  child: MyApp(),
)
```

---

## 5. Ejercicio (45 min)

- Implementar `CartModel` y mostrar un listado de productos.
- Agregar botón "Agregar al carrito" que use `notifyListeners()`.
- Mostrar contador en `AppBar` usando `Selector`.

---

## Recursos
- Provider package: https://pub.dev/packages/provider
- Artículos y buenas prácticas en `4-recursos`