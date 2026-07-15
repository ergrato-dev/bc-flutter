# Notifier y Estado Mutable

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo declarar un `Notifier` con `@riverpod` para estado que cambia
- Cómo comparar este patrón con `ChangeNotifier` de semana 4
- Buenas prácticas de inmutabilidad al mutar `state`

## 📋 Conceptos Clave

### 1. Tu primer Notifier

```dart
// counter_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_notifier.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0; // estado inicial

  void increment() => state++;
  void reset() => state = 0;
}
```

- `build()` retorna el **estado inicial** (equivalente al constructor de un `ChangeNotifier`).
- `state` es la propiedad que lees y asignas — asignarla **reconstruye automáticamente** a
  todos los widgets que la observan. No hay `notifyListeners()` que recordar llamar.

```dart
// Consumo en un widget:
final count = ref.watch(counterProvider);       // leer y suscribirse
ref.read(counterProvider.notifier).increment();  // llamar un método (como context.read)
```

> 💡 **Comparación directa con Provider (semana 4)**:
>
> | Provider (ChangeNotifier) | Riverpod (Notifier) |
> |---|---|
> | `class X extends ChangeNotifier` | `class X extends _$X` |
> | Constructor / campos privados | `build()` retorna el estado inicial |
> | `notifyListeners()` manual | Automático al asignar `state` |
> | `context.watch<X>()` | `ref.watch(xProvider)` |
> | `context.read<X>().metodo()` | `ref.read(xProvider.notifier).metodo()` |

### 2. Estado inmutable: reasignar, no mutar

```dart
@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  Set<String> build() => {};

  // ✅ BIEN — crea un nuevo Set y reasigna `state`
  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  // ❌ MAL — muta la colección existente sin reasignar `state`
  // void toggleBad(String id) {
  //   state.add(id); // Riverpod NO detecta este cambio — no hay rebuild
  // }
}
```

> ⚠️ **Regla de oro**: Riverpod detecta cambios de estado comparando la **referencia** de
> `state` antes y después. Si mutas la colección existente sin crear una nueva, Riverpod no
> se entera y la UI no se actualiza — el bug más común de esta semana, análogo a "olvidar
> `notifyListeners()`" en semana 4.

### 3. Cuándo mantener el estado como una clase (no solo un tipo primitivo)

```dart
class CartState {
  final List<String> items;
  final bool isCheckingOut;

  const CartState({this.items = const [], this.isCheckingOut = false});

  CartState copyWith({List<String>? items, bool? isCheckingOut}) {
    return CartState(
      items: items ?? this.items,
      isCheckingOut: isCheckingOut ?? this.isCheckingOut,
    );
  }
}

@riverpod
class Cart extends _$Cart {
  @override
  CartState build() => const CartState();

  void addItem(String item) {
    state = state.copyWith(items: [...state.items, item]);
  }
}
```

El patrón `copyWith` es el equivalente Dart de "spread + override" — crea un nuevo objeto
inmutable reutilizando los campos que no cambian. Lo verás con más frecuencia a partir de
semana 6 (respuestas de API con múltiples campos).

## ⚠️ Errores Comunes

- Mutar una colección (`.add()`, `.remove()`) sin reasignar `state` — no dispara rebuild.
- Exponer setters públicos de campos individuales en vez de métodos con nombre de intención
  (`toggle()`, `addItem()`) — dificulta rastrear quién cambió qué y por qué.
- Olvidar `const` en el constructor de clases de estado inmutables cuando es posible.
- **Asumir el nombre del provider generado sin revisar el `.g.dart`**: si tu clase se llama
  `FavoritesNotifier`, el provider generado es `favoritesProvider` — `riverpod_generator`
  **recorta el sufijo `Notifier`** del nombre antes de agregar `Provider`. `ItemsNotifier` →
  `itemsProvider`, no `itemsNotifierProvider`. Si el analyzer marca "Undefined name" en un
  provider que "debería" existir, este es el primer sospechoso.

## 📚 Recursos Adicionales

- [riverpod.dev — Getting started (Notifier)](https://riverpod.dev/docs/introduction/getting_started)
- [Effective Dart — copyWith pattern](https://dart.dev/effective-dart)

## ✅ Checklist de Verificación

- [ ] Puedo declarar un Notifier con @riverpod y mutar su estado
- [ ] Sé por qué mutar una colección sin reasignar `state` no dispara rebuild
- [ ] Puedo escribir un `copyWith` para una clase de estado con varios campos
