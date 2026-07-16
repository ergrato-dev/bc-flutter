# Buenas Prácticas: Ciclo de Vida y Performance

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué olvidar `dispose()` en un `AnimationController` es una fuga de memoria real, no teórica
- Cuándo usar `SingleTickerProviderStateMixin` vs. `TickerProviderStateMixin`
- Una checklist para decidir si de verdad necesitabas esta semana o si semana 11 alcanzaba

## 📋 Conceptos Clave

### 1. dispose() no es opcional

Un `AnimationController` mantiene un `Ticker` activo — un callback que Flutter invoca en cada
frame **mientras el controller exista**, sin importar si el widget que lo creó sigue montado. Si
el `State` se destruye (el usuario navegó a otra pantalla) sin llamar `_controller.dispose()`, el
`Ticker` sigue corriendo huérfano, consumiendo CPU y memoria indefinidamente — y en modo debug,
Flutter lanza una excepción explícita (`A ... was used after being disposed`) apenas detecta el
error. En producción (modo release), esa excepción no aparece — el leak simplemente ocurre en
silencio, degradando el rendimiento con el tiempo.

```dart
@override
void dispose() {
  _controller.dispose(); // SIEMPRE, sin excepción
  super.dispose();
}
```

Esto es la razón concreta por la que un `AnimationController` exige más disciplina que un
`Animated*` implícito de semana 11 — esos widgets gestionan su propio ciclo de vida internamente;
un controller que tú creas, tú lo destruyes.

### 2. SingleTickerProviderStateMixin vs. TickerProviderStateMixin

| Mixin | Cuándo usarlo |
|---|---|
| `SingleTickerProviderStateMixin` | El `State` maneja exactamente **un** `AnimationController` |
| `TickerProviderStateMixin` | El `State` maneja **dos o más** controllers |

Usar `TickerProviderStateMixin` con un solo controller funciona, pero `Single...` documenta la
intención y tiene un costo mínimamente menor. Si agregas un segundo controller a un `State` que
ya tenía `SingleTickerProviderStateMixin`, Flutter lanza un error en tiempo de desarrollo pidiendo
el cambio — súbelo a `TickerProviderStateMixin` en ese momento, no antes.

### 3. Cuándo esta semana ya no alcanza

Todo lo de semanas 11-12 asume que la animación vive **dentro de un solo widget/pantalla**. Hay un
límite más allá del cual conviene una librería especializada en vez de más `AnimationController`
a mano:

| Síntoma | Qué considerar |
|---|---|
| Docenas de elementos animando con timings distintos y sincronizados (ej. una escena compleja) | Un paquete como `rive` o `lottie` para animaciones diseñadas fuera de código |
| Necesitas física real (resortes, fricción, gestos con inercia) | `SpringSimulation`/`physics` en vez de `Tween` + `Curve` estáticas |
| La animación es puramente decorativa y no depende de datos de la app | Un asset Lottie/Rive exportado desde una herramienta de diseño, sin código de animación en Dart |

Para lo que resuelve este bootcamp (feedback de interacción, transiciones entre pantallas,
indicadores de progreso custom), `AnimationController` + `CustomPainter` es suficiente y no
justifica una dependencia adicional — agregarla sin necesidad sería sobre-ingeniería.

### 4. Checklist antes de escribir un AnimationController

- [ ] ¿El caso aparece en la tabla del archivo 06 de semana 11 (loop, pausa, gesto, dibujo
      custom)? Si no, un `Animated*` implícito probablemente alcanza.
- [ ] ¿El `State` tiene `SingleTickerProviderStateMixin`/`TickerProviderStateMixin` y
      `vsync: this`?
- [ ] ¿`dispose()` llama `_controller.dispose()`?
- [ ] ¿Cada `Tween` usa la `Curve` correcta para su caso (ver semana 11, archivo 03)?
- [ ] Si hay un `CustomPainter`, ¿`shouldRepaint` retorna algo con sentido para su caso (valor
      fijo comparado, o `true` cuando ya usa `repaint:`)?

## ✅ Checklist de Verificación

- [ ] Sé explicar por qué un controller sin `dispose()` es una fuga de memoria real
- [ ] Sé elegir entre `SingleTickerProviderStateMixin` y `TickerProviderStateMixin`
- [ ] Sé reconocer cuándo el caso supera lo que `AnimationController` + `CustomPainter` resuelven
      razonablemente

## 📚 Recursos Adicionales

- [Flutter docs — Animations overview](https://docs.flutter.dev/ui/animations)
- [Flutter docs — AnimationController API](https://api.flutter.dev/flutter/animation/AnimationController-class.html)
- [Flutter docs — CustomPainter API](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html)
