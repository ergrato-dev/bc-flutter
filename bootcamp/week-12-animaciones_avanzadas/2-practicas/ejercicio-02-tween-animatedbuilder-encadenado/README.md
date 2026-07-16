# Ejercicio 02 — Tween y AnimatedBuilder Encadenado

> Animarás un cuadro que primero escala y luego cambia de color, usando `Interval` para repartir
> ambas animaciones en tramos distintos del mismo controller, combinadas en un solo
> `AnimatedBuilder`, descomentando código paso a paso.

## 🎯 Objetivos

- Repartir dos animaciones en tramos distintos de un mismo controller con `Interval`
- Combinar dos `Tween` (`Tween<double>` y `ColorTween`) en un único `AnimatedBuilder`
- Reconocer por qué el `child` de `AnimatedBuilder` no se reconstruye en cada frame

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
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

---

## Paso 2: dos Tween en tramos distintos con Interval

```dart
late final Animation<double> _scale = Tween<double>(begin: 1.0, end: 1.5).animate(
  CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
  ),
);

late final Animation<Color?> _color = ColorTween(
  begin: Colors.indigo.shade200,
  end: Colors.red,
).animate(
  CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
  ),
);
```

**Descomenta la sección `PASO 2`** — el escalado corre en la primera mitad de la `duration`, el
color en la segunda mitad.

---

## Paso 3: un solo AnimatedBuilder combinando ambas

```dart
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) {
    return Transform.scale(
      scale: _scale.value,
      child: DecoratedBox(
        decoration: BoxDecoration(color: _color.value, borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  },
  child: const SizedBox(width: 80, height: 80),
)
```

**Descomenta la sección `PASO 3`** — reemplaza el `Container` estático por este `AnimatedBuilder`,
y conecta el botón a `_controller.forward(from: 0)`.

✅ **Verifica**: al presionar el botón, el cuadro primero crece (mitad indigo claro) y luego,
mientras sigue del mismo tamaño, cambia a rojo — dos animaciones secuenciales con **un solo**
controller y un solo `AnimatedBuilder`. El `SizedBox` pasado como `child` no se reconstruye en
cada uno de los frames — solo el `Transform.scale`/`DecoratedBox` que sí dependen del valor
animado.

---

## ✅ Resultado final

Dos animaciones secuenciales (escala → color) combinadas en un `AnimatedBuilder` — el mismo
patrón para cualquier caso donde necesites varias propiedades animando en momentos distintos del
mismo reloj.
