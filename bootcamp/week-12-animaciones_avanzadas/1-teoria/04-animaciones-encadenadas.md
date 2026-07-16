# Animaciones Encadenadas: Interval y TweenSequence

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo hacer que dos animaciones ocurran en momentos distintos de un mismo controller con
  `Interval`
- Cómo animar un valor a través de **varios** tramos con `TweenSequence`
- Por qué esto reemplaza la tentación de usar varios `AnimationController` encadenados a mano

## 📋 Conceptos Clave

### 1. El problema: secuencia, no simultaneidad

Hasta ahora, todos los `Tween` derivados de un mismo controller corren **en simultáneo** — si el
controller va de 0.0 a 1.0 en 600ms, todos los `Tween` interpolan durante esos mismos 600ms. Pero
muchas animaciones de producto son **secuenciales**: un ícono que primero escala y luego cambia de
color, o una lista de tarjetas que aparecen una tras otra (efecto "stagger").

### 2. Interval — reservar un tramo del controller para una animación

`Interval` recorta la línea de tiempo 0.0–1.0 del controller en un sub-rango, y lo re-mapea a
0.0–1.0 para esa animación específica:

```dart
late final Animation<double> _scale = Tween<double>(begin: 1.0, end: 1.3).animate(
  CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.5, curve: Curves.easeOut), // corre en la primera mitad
  ),
);

late final Animation<Color?> _color = ColorTween(begin: Colors.grey, end: Colors.red).animate(
  CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.5, 1.0, curve: Curves.easeIn), // corre en la segunda mitad
  ),
);
```

Con un solo `_controller.forward()` de, digamos, 600ms: el escalado ocurre en los primeros 300ms,
el cambio de color en los últimos 300ms — secuencial, con un solo controller y un solo
`.forward()`.

### 3. TweenSequence — varios tramos para el mismo valor

Cuando un **mismo** valor necesita pasar por más de dos puntos (no solo begin→end), usa
`TweenSequence` con pesos relativos (`weight`) que determinan qué fracción del tiempo total ocupa
cada tramo:

```dart
late final Animation<double> _bounce = TweenSequence<double>([
  TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
  TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
]).animate(_controller);
```

Este es el patrón exacto de un "bounce" de like: crece al 50% del tiempo, luego vuelve a su
tamaño original en el 50% restante — con un solo `_controller.forward()` (sin necesitar
`reverse()` manual).

### 4. Por qué no encadenar varios AnimationController

Es tentador resolver "primero A, después B" con dos controllers y un `.then()` en el `Future` que
retorna `.forward()`. Funciona, pero duplica el manejo de ciclo de vida (dos controllers que
inicializar y hacer `dispose()`) para algo que `Interval`/`TweenSequence` resuelven con **un
solo** controller. Reserva múltiples controllers para animaciones genuinamente independientes
(que el usuario puede disparar en momentos distintos, no como parte de una sola secuencia).

## ✅ Checklist de Verificación

- [ ] Sé usar `Interval` para que dos `Tween` del mismo controller corran en momentos distintos
- [ ] Sé usar `TweenSequence` cuando un valor pasa por más de dos puntos
- [ ] Sé por qué preferir `Interval`/`TweenSequence` sobre encadenar varios
      `AnimationController` con `.then()`

## 📚 Próximo paso

[CustomPainter Animado →](05-custompainter-animado.md)
