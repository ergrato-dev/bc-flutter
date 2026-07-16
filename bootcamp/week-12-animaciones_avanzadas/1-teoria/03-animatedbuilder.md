# AnimatedBuilder

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué escuchar un `AnimationController` con `setState` reconstruye más de lo necesario
- Cómo `AnimatedBuilder` limita el rebuild al subárbol que de verdad cambia
- Los `*Transition` (`ScaleTransition`, `RotationTransition`, `SlideTransition`) como atajo sobre
  `AnimatedBuilder` para los casos más comunes

## 📋 Conceptos Clave

### 1. El problema: escuchar con setState reconstruye todo el widget

Una forma ingenua de reaccionar a un `AnimationController` es escucharlo con un listener y llamar
`setState` en cada frame:

```dart
// ❌ Evitar: reconstruye TODO el build() del State en cada frame
_controller.addListener(() => setState(() {}));
```

Esto reconstruye el `build()` completo del `State` — si esa pantalla tiene una lista, un
formulario o cualquier hermano costoso, todos se reconstruyen 60 veces por segundo por una
animación que solo afecta un ícono.

### 2. AnimatedBuilder — reconstruir solo el subárbol que cambia

`AnimatedBuilder` recibe la `Animation` a escuchar y un `builder` que retorna **solo** el
subárbol que depende del valor animado. Todo lo que pases en `child` se construye **una sola
vez** y se reutiliza en cada frame, sin reconstruirse:

```dart
AnimatedBuilder(
  animation: _scale,
  builder: (context, child) {
    return Transform.scale(scale: _scale.value, child: child);
  },
  child: const Icon(Icons.favorite, size: 32), // construido una sola vez
)
```

En cada frame, Flutter vuelve a ejecutar `builder` (barato: solo envuelve en `Transform.scale`),
pero **no** reconstruye el `Icon` — lo recibe ya armado en `child` y lo reutiliza. Esto es
análogo al `const child` de semana 11 (archivo 06) — mismo principio, ahora aplicado al patrón
explícito.

### 3. Los *Transition — atajo para los casos comunes

Flutter provee widgets `*Transition` que ya son un `AnimatedBuilder` especializado para las
transformaciones más frecuentes — úsalos cuando encajen, en vez de escribir tu propio
`AnimatedBuilder` desde cero:

| Widget | Anima |
|---|---|
| `ScaleTransition` | Escala (`scale: Animation<double>`) |
| `RotationTransition` | Rotación (`turns: Animation<double>`) |
| `FadeTransition` | Opacidad (`opacity: Animation<double>`) |
| `SlideTransition` | Posición relativa (`position: Animation<Offset>`) |
| `SizeTransition` | Tamaño (ya lo usaste con `AnimatedList` en semana 11) |

```dart
ScaleTransition(
  scale: _scale, // la Animation<double> del archivo 02
  child: const Icon(Icons.favorite, size: 32),
)
```

Este `ScaleTransition` hace exactamente lo mismo que el `AnimatedBuilder` + `Transform.scale` de
arriba, con menos código — resérvate `AnimatedBuilder` manual para cuando combines varias
transformaciones a la vez o dibujes con `CustomPainter` (archivo 05).

### 4. Cuándo escribir el AnimatedBuilder manual en vez de un *Transition

- Necesitas combinar **dos o más** transformaciones en el mismo `builder` (escala + color, por
  ejemplo) sin anidar varios `*Transition`.
- El valor animado alimenta un `CustomPainter` (`repaint: _controller`) en vez de una propiedad de
  widget — ver archivo 05.
- Necesitas lógica condicional dentro del `builder` (ej. cambiar de ícono según el progreso).

## ✅ Checklist de Verificación

- [ ] Sé por qué `addListener` + `setState` reconstruye más de lo necesario
- [ ] Sé el rol del parámetro `child` de `AnimatedBuilder` (construido una sola vez)
- [ ] Conozco al menos tres `*Transition` y qué anima cada uno
- [ ] Sé cuándo un `AnimatedBuilder` manual es preferible a un `*Transition`

## 📚 Próximo paso

[Animaciones Encadenadas: Interval y TweenSequence →](04-animaciones-encadenadas.md)
