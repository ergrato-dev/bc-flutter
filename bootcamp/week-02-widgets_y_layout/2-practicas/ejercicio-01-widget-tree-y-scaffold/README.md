# Ejercicio 01 — Widget Tree, MaterialApp y Scaffold

> Construirás tu primera pantalla Flutter real, descomentando código paso a paso.

## 🎯 Objetivos

- Levantar una app con `MaterialApp` y `Scaffold`
- Diferenciar `StatelessWidget` de `StatefulWidget` en código real
- Usar `setState` para reaccionar a un toque

## 📋 Requisitos

- SDK de Flutter local configurado (`flutter doctor` sin errores) con emulador/simulador
  corriendo — necesitas **verlo** en pantalla, no solo compilarlo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: MaterialApp + Scaffold

```dart
MaterialApp(
  home: Scaffold(
    appBar: AppBar(title: const Text('Ejercicio 01')),
    body: const Center(child: Text('Hola, Flutter')),
  ),
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: la app debe mostrar una barra superior con el título y el texto centrado.

---

## Paso 2: Un widget StatelessWidget propio

```dart
class Greeting extends StatelessWidget {
  const Greeting({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) => Text('Bienvenido, $name');
}
```

**Descomenta la sección `PASO 2`** (incluye usar `Greeting` dentro del `body`).

✅ **Verifica**: el texto cambia a "Bienvenido, [tu nombre]".

---

## Paso 3: Un StatefulWidget con contador

```dart
class TapCounter extends StatefulWidget {
  const TapCounter({super.key});
  @override
  State<TapCounter> createState() => _TapCounterState();
}
```

**Descomenta la sección `PASO 3`** (la clase completa + su uso en el `body`).

✅ **Verifica**: al tocar el botón, el número en pantalla aumenta — sin recargar la app.

---

## ✅ Resultado final

La pantalla debe mostrar un `AppBar`, un saludo con tu nombre, y un contador que aumenta al
tocar un botón, todo dentro de un único `Scaffold`.
