# Ejercicio 01 — AnimationController Básico

> Animarás el logo de Flutter creciendo y encogiendo al presionar un botón, usando un
> `AnimationController` con `SingleTickerProviderStateMixin`, descomentando código paso a paso.

## 🎯 Objetivos

- Agregar `SingleTickerProviderStateMixin` y crear un `AnimationController` con `vsync: this`
- Derivar un `Tween<double>` con `CurvedAnimation` del controller
- Usar `ScaleTransition` y alternar `forward()`/`reverse()` según `isCompleted`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: el controller y su dispose

```dart
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ...
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — agrega el mixin, el campo
`_controller` y el método `dispose()`.

---

## Paso 2: Tween con curva

```dart
late final Animation<double> _scale = Tween<double>(begin: 1.0, end: 1.4).animate(
  CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
);
```

**Descomenta la sección `PASO 2`** — agrega este campo debajo de `_controller`.

---

## Paso 3: ScaleTransition + toggle forward/reverse

```dart
GestureDetector(
  onTap: () {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  },
  child: ScaleTransition(scale: _scale, child: const FlutterLogo(size: 120)),
)
```

**Descomenta la sección `PASO 3`** — reemplaza el `GestureDetector` con el `FlutterLogo` estático.

✅ **Verifica**: cada toque alterna entre crecer (`forward`) y volver al tamaño original
(`reverse`) — sin necesitar dos animaciones ni `setState` manual para el tamaño, el
`AnimationController` mismo recuerda en qué punto está (`isCompleted`).

---

## ✅ Resultado final

Un logo que crece/encoge con control explícito del progreso — la base de la animación de "pop" de
favorito que agregarás al `ItemCard` del proyecto de esta semana.
