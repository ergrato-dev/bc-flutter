# Ejercicio 01 — ChangeNotifier Básico

> Construirás un contador con `ChangeNotifier` + `ChangeNotifierProvider` + `Consumer`,
> descomentando código paso a paso.

## 🎯 Objetivos

- Declarar un `ChangeNotifier` con estado privado y `notifyListeners()`
- Exponerlo con `ChangeNotifierProvider`
- Consumirlo con `Consumer<T>`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: El ChangeNotifier

```dart
class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: la app compila, aunque todavía no se ve el contador en pantalla.

---

## Paso 2: ChangeNotifierProvider en la raíz

```dart
ChangeNotifierProvider(
  create: (context) => CounterNotifier(),
  child: const MyApp(),
)
```

**Descomenta la sección `PASO 2`** (reemplaza el `runApp(const MyApp())` de `main()`).

✅ **Verifica**: la app sigue compilando y corriendo sin errores.

---

## Paso 3: Consumer para mostrar y modificar el contador

```dart
Consumer<CounterNotifier>(
  builder: (context, notifier, child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${notifier.count}'),
        ElevatedButton(onPressed: notifier.increment, child: const Text('Sumar')),
      ],
    );
  },
)
```

**Descomenta la sección `PASO 3`** dentro del `body` de `HomeScreen`.

✅ **Verifica**: al tocar "Sumar", el número en pantalla debe aumentar.

---

## ✅ Resultado final

Una pantalla con un contador cuyo estado vive en un `ChangeNotifier`, completamente separado
de la UI que lo muestra.
