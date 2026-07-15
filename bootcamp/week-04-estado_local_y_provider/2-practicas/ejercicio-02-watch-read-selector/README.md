# Ejercicio 02 — context.watch, context.read y Selector

> Construirás un carrito simple para comparar `context.watch`/`context.read` y observar en
> consola cómo `Selector` evita rebuilds innecesarios, descomentando código paso a paso.

## 🎯 Objetivos

- Usar `context.watch<T>()` para mostrar datos y `context.read<T>()` en un callback
- Comprobar en consola que `Selector` evita reconstrucciones cuando el dato que le importa no cambió
- Evitar el error de usar `watch` fuera de `build()`

## 📋 Requisitos

- Ejercicio 01 completado

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

Mantén la consola visible durante todo el ejercicio — los pasos 2 y 3 se verifican por
`debugPrint`, no solo visualmente.

---

## Paso 1: CartNotifier con dos campos independientes

```dart
class CartNotifier extends ChangeNotifier {
  final List<String> _items = [];
  String storeName = 'Tienda';

  List<String> get items => List.unmodifiable(_items);

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }

  void renameStore(String newName) {
    storeName = newName;
    notifyListeners();
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`. También debes reemplazar la
línea `runApp(const MyApp());` de `main()` por:

```dart
runApp(ChangeNotifierProvider(create: (context) => CartNotifier(), child: const MyApp()));
```

✅ **Verifica**: la app compila y corre (todavía muestra un `Placeholder`, es esperado).

---

## Paso 2: context.watch (mostrar) y context.read (botón)

```dart
final cart = context.watch<CartNotifier>(); // se reconstruye con CUALQUIER cambio
// ...
onPressed: () => context.read<CartNotifier>().addItem('Producto ${cart.items.length + 1}'),
```

**Descomenta la sección `PASO 2`.**

✅ **Verifica**: al tocar "Agregar producto", la lista crece y el widget completo se
reconstruye (verás el `debugPrint('CartFullView rebuild')` en consola cada vez).

---

## Paso 3: Selector — reconstruir solo si cambia la cantidad

```dart
Selector<CartNotifier, int>(
  selector: (context, cart) => cart.items.length,
  builder: (context, itemCount, child) {
    debugPrint('CartCountBadge rebuild (Selector)');
    return Text('$itemCount productos');
  },
)
```

**Descomenta la sección `PASO 3`.**

✅ **Verifica en consola**: toca "Cambiar nombre de tienda" (no agrega productos). Debes ver
`CartFullView rebuild` (porque usa `watch`, reacciona a cualquier cambio) **pero NO**
`CartCountBadge rebuild (Selector)` — porque `items.length` no cambió, aunque `storeName` sí.

---

## ✅ Resultado final

Dos widgets suscritos al mismo `CartNotifier`: uno se reconstruye con cualquier cambio
(`watch`), el otro solo cuando el dato que realmente le importa cambia (`Selector`) —
verificable en la consola, no solo "a simple vista".
