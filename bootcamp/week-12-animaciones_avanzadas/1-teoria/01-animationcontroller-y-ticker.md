# AnimationController y Ticker

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es un `AnimationController` y en qué se diferencia de los widgets `Animated*` de semana 11
- Cómo conectarlo al ciclo de vida de un `StatefulWidget` con `TickerProviderStateMixin`
- Los métodos que controlan el tiempo: `forward`, `reverse`, `repeat`, `stop`

## 📋 Conceptos Clave

### 1. Por qué necesitas control explícito

En semana 11, cada `Animated*` decidía solo cuándo animar: cambiabas un valor (`_expanded`),
Flutter interpolaba. Eso alcanza mientras el cambio sea "de un valor a otro, una vez". Pero hay
casos que no encajan ahí:

- Un spinner que gira **indefinidamente** (no hay "valor final")
- Pausar la animación a mitad de camino porque el usuario navegó a otra pantalla
- Sincronizar el progreso con un gesto de arrastre en vez de un evento discreto

`AnimationController` te da el reloj mismo: tú decides cuándo arranca, en qué dirección corre y
cuándo se detiene.

### 2. El mixin obligatorio: TickerProviderStateMixin

Un `AnimationController` necesita un `Ticker` — la señal que dispara un nuevo frame ~60 veces por
segundo. Ese `Ticker` lo provee el `State` de tu widget agregando un mixin:

```dart
class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this, // el mixin provee el Ticker
  );

  @override
  void dispose() {
    _controller.dispose(); // obligatorio — ver archivo 06
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child: const FlutterLogo());
  }
}
```

`SingleTickerProviderStateMixin` alcanza cuando el `State` maneja **un solo**
`AnimationController`. Si necesitas dos o más controllers en el mismo `State`, usa
`TickerProviderStateMixin` (sin "Single") — provee un `vsync` por controller.

### 3. El valor que produce el controller

Un `AnimationController` es en sí mismo una `Animation<double>` que va de `0.0` a `1.0` (por
defecto). `RotationTransition` en el ejemplo usa ese valor directamente como fracción de vuelta
completa. Para la mayoría de casos necesitarás transformar ese rango 0.0–1.0 en el valor real que
quieres animar — eso es lo que resuelve `Tween` (archivo 02).

### 4. Los métodos de control

| Método | Qué hace |
|---|---|
| `.forward()` | Corre de `0.0` hacia `1.0` |
| `.reverse()` | Corre de `1.0` hacia `0.0` (o desde el valor actual hacia `0.0`) |
| `.repeat()` | Corre en loop — útil para spinners; acepta `reverse: true` para ir y volver |
| `.stop()` | Detiene en el valor actual, sin completar |
| `.reset()` | Vuelve instantáneamente a `0.0`, sin animar |

```dart
ElevatedButton(
  onPressed: () {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  },
  child: const Text('Toggle'),
)
```

Este patrón (`isCompleted` ? reverse : forward) es el equivalente explícito de lo que
`AnimatedContainer` hacía solo con `_expanded = !_expanded` en semana 11 — la diferencia es que
aquí tú decides el punto exacto de pausa/reversa, no solo el destino final.

## ✅ Checklist de Verificación

- [ ] Sé por qué un `AnimatedContainer` no alcanza para un loop infinito o una pausa a mitad de
      camino
- [ ] Sé agregar `SingleTickerProviderStateMixin` y pasar `vsync: this`
- [ ] Sé la diferencia entre `forward`/`reverse`/`repeat`/`stop`/`reset`
- [ ] Sé que un `AnimationController` sin transformar produce valores `0.0`–`1.0`

## 📚 Próximo paso

[Tween y Animation<T> →](02-tween-y-animation.md)
