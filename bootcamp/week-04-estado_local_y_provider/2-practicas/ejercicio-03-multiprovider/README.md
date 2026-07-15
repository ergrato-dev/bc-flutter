# Ejercicio 03 — MultiProvider

> Combinarás dos notifiers independientes (`ThemeNotifier` y `CounterNotifier`) con
> `MultiProvider`, descomentando código paso a paso.

## 🎯 Objetivos

- Declarar dos `ChangeNotifier` independientes
- Exponerlos juntos con `MultiProvider`
- Consumir ambos desde la misma pantalla sin que se interfieran entre sí

## 📋 Requisitos

- Ejercicios 01 y 02 completados

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: ThemeNotifier

```dart
class ThemeNotifier extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

---

## Paso 2: CounterNotifier (ya conocido del ejercicio 01)

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

**Descomenta la sección `PASO 2`.**

---

## Paso 3: MultiProvider + consumo de ambos

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => ThemeNotifier()),
    ChangeNotifierProvider(create: (context) => CounterNotifier()),
  ],
  child: const MyApp(),
)
```

**Descomenta la sección `PASO 3`** (incluye reemplazar `runApp(const MyApp())` en `main()` y
descomentar `HomeContent`, usado como `body` de `HomeScreen`).

✅ **Verifica**: el botón "Cambiar tema" debe cambiar el color de fondo del `Scaffold`
(`isDark`), y el botón "Sumar" debe aumentar el contador — **cada uno debe funcionar de forma
independiente**, sin afectar al otro.

---

## ✅ Resultado final

Una pantalla con dos fuentes de estado completamente independientes, ambas expuestas con un
solo `MultiProvider` — la forma legible de combinar varios notifiers.
