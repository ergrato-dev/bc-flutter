# Glosario — Semana 12: Animaciones Avanzadas

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

---

**AnimatedBuilder**
Widget que reconstruye solo el subárbol dependiente de una `Animation`, reutilizando el `child`
construido una sola vez — evita reconstruir todo el `build()` de un `State` en cada frame.

**AnimationController**
Objeto que produce el reloj de una animación explícita — controla `forward()`, `reverse()`,
`repeat()` y `stop()`, y por defecto emite valores entre `0.0` y `1.0`.

**CurvedAnimation**
Envoltorio que aplica una `Curve` (igual que en semana 11) a una animación conectada a un
`AnimationController`, en vez de a un widget `Animated*` implícito.

**CustomPainter**
Clase que dibuja directamente sobre un `Canvas` con `Paint` — la puerta de salida cuando ningún
widget de Flutter provee la forma que necesitas.

**Interval**
Curva que recorta un sub-rango del progreso `0.0`–`1.0` de un controller y lo re-mapea a
`0.0`–`1.0` para una animación específica — permite que dos animaciones del mismo controller
corran en momentos distintos.

**repaint** (parámetro de `CustomPainter`)
`Listenable` que, al notificar un cambio, dispara automáticamente `paint()` — pasar un
`AnimationController` aquí conecta el reloj de la animación al repintado, sin `AnimatedBuilder`.

**shouldRepaint**
Método de `CustomPainter` que decide si un repintado es necesario — retorna `true` sin costo
cuando el painter ya usa `repaint:`, o compara el campo relevante cuando recibe un valor fijo.

**Ticker**
Señal que dispara un callback en cada frame (~60 veces por segundo) — provista al
`AnimationController` mediante `vsync: this` en un `State` con `TickerProviderStateMixin`.

**TickerProviderStateMixin / SingleTickerProviderStateMixin**
Mixins que proveen el `Ticker` que necesita un `AnimationController`. `Single...` para exactamente
un controller por `State`; `TickerProviderStateMixin` (sin "Single") para dos o más.

**Tween&lt;T&gt;**
Objeto que transforma el rango `0.0`–`1.0` de un `AnimationController` en el valor real que
necesita la UI (`Tween<double>`, `ColorTween`, `Tween<Offset>`, etc.).

**TweenSequence**
Secuencia de varios `Tween` con pesos relativos (`weight`) que un mismo valor recorre en tramos —
usado para animaciones tipo "bounce" (crece y vuelve) con un solo `.forward()`.

**\*Transition** (`ScaleTransition`, `RotationTransition`, `FadeTransition`, `SlideTransition`)
Widgets que son un `AnimatedBuilder` ya especializado para la transformación más común — atajo
sobre escribir el `AnimatedBuilder` manual cuando el caso encaja en uno de ellos.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../../docs/plan-estudios.md)
