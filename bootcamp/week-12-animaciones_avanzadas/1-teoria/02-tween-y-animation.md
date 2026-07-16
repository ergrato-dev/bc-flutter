# Tween y Animation&lt;T&gt;

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo `Tween` transforma el rango `0.0`–`1.0` de un controller en el valor real que necesitas
- Qué es `CurvedAnimation` y por qué sigue siendo necesaria una `Curve` (igual que semana 11)
- Los `Tween` más comunes: `Tween<double>`, `ColorTween`, `Tween<Offset>`

## 📋 Conceptos Clave

### 1. El problema: 0.0–1.0 casi nunca es el valor que quieres

Un `AnimationController` produce un `double` entre `0.0` y `1.0`. Pero tu UI casi nunca necesita
exactamente eso — quieres un ancho entre `100` y `300`, un color entre gris y rojo, una posición
entre dos puntos. `Tween` hace esa traducción:

```dart
class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _scale = Tween<double>(
    begin: 1.0,
    end: 1.4,
  ).animate(_controller);

  // ...
}
```

`_scale` ahora es una `Animation<double>` que va de `1.0` a `1.4` — sigue disparándose por el
mismo `_controller`, pero produce el rango que tu UI necesita.

### 2. CurvedAnimation — la curva sigue existiendo aquí

`Curves` no era exclusivo de los widgets `Animated*` de semana 11 — es una propiedad de
**cualquier** animación en Flutter. Para aplicar una curva a un `Tween` conectado a un
`AnimationController`, envuelve el controller en un `CurvedAnimation` antes de pasarlo al `Tween`:

```dart
late final Animation<double> _scale = Tween<double>(begin: 1.0, end: 1.4).animate(
  CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
);
```

Sin `CurvedAnimation`, el `Tween` interpola linealmente el progreso del controller — el mismo
efecto "mecánico" que `Curves.linear` producía en los widgets implícitos.

### 3. Tween para otros tipos: Color, Offset

`Tween<T>` funciona con cualquier tipo que sepa interpolarse — Flutter ya provee variantes para
los casos comunes:

```dart
late final Animation<Color?> _color = ColorTween(
  begin: Colors.grey.shade300,
  end: Colors.red,
).animate(_controller);

late final Animation<Offset> _slide = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(0, -0.2), // fracciones del tamaño del widget, no píxeles
).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
```

`ColorTween` interpola componente por componente (R, G, B, alpha) — evita escribir esa
interpolación a mano. `Tween<Offset>` es lo que usa `SlideTransition` (ver archivo 03) para mover
un widget relativo a su propio tamaño.

### 4. Un controller, varias animaciones

Nada impide derivar **varios** `Tween` del mismo `AnimationController` — es la forma normal de
animar varias propiedades sincronizadas con un solo reloj, en vez de un `AnimationController` por
propiedad:

```dart
late final Animation<double> _scale = Tween(begin: 1.0, end: 1.3).animate(_controller);
late final Animation<Color?> _color = ColorTween(begin: Colors.grey, end: Colors.red)
    .animate(_controller);
```

Ambas comparten el mismo `_controller.forward()` — un ícono de favorito que crece **y** cambia de
color al mismo tiempo, con una sola llamada.

## ✅ Checklist de Verificación

- [ ] Sé por qué el valor crudo de un `AnimationController` casi nunca es el que necesitas
- [ ] Sé aplicar una `Curve` con `CurvedAnimation` a una animación conectada a un controller
- [ ] Conozco `ColorTween` y `Tween<Offset>` además de `Tween<double>`
- [ ] Sé que un mismo controller puede alimentar varios `Tween` sincronizados

## 📚 Próximo paso

[AnimatedBuilder →](03-animatedbuilder.md)
