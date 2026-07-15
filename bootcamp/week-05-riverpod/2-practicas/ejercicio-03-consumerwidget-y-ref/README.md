# Ejercicio 03 — ConsumerWidget, ref y Composición de Providers

> Construirás un carrito simple donde un provider deriva su valor de otro (composición),
> descomentando código paso a paso. Es el ejercicio más largo de la semana.

## 🎯 Objetivos

- Declarar un `Notifier` con una lista de elementos
- Declarar un provider funcional que **depende** de otro con `ref.watch`
- Usar `ref.listen()` para un efecto secundario (SnackBar)

## 📋 Requisitos

- Ejercicios 01 y 02 completados

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

---

## Paso 1: CartNotifier

```dart
@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  List<String> build() => [];

  void addItem(String item) => state = [...state, item];
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye descomentar `part 'main.g.dart';` junto a los imports). Regenera con build_runner.

---

## Paso 2: Provider derivado (composición)

```dart
@riverpod
int cartItemCount(Ref ref) {
  final items = ref.watch(cartProvider); // depende de CartNotifier
  return items.length;
}
```

**Descomenta la sección `PASO 2`.** Regenera con build_runner.

✅ **Verifica**: `cartItemCountProvider` no tiene su propio método para agregar elementos — solo
se recalcula automáticamente cuando `cartProvider` cambia.

---

## Paso 3: ConsumerWidget + ref.listen para un efecto secundario

```dart
ref.listen(cartItemCountProvider, (previous, next) {
  if (next == 3) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Ya tienes 3 productos!')),
    );
  }
});
```

**Descomenta la sección `PASO 3`** (incluye el `ref.listen` dentro de `build()` de
`HomeContent`, y reemplaza el `body:` de `HomeScreen` por `body: const Center(child: HomeContent())`).
Regenera con build_runner.

✅ **Verifica**: agrega productos uno por uno. Al llegar exactamente al tercero, debe aparecer
un `SnackBar` — ni antes ni en los siguientes.

---

## ✅ Resultado final

Dos providers relacionados (uno deriva del otro) consumidos desde un `ConsumerWidget` que
además reacciona a un umbral específico con `ref.listen` — la composición que reemplaza a
`ProxyProvider` de Provider (semana 4).
