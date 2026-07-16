# Introducción a Animaciones Implícitas

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué problema resuelven las animaciones en una app móvil (más allá de lo estético)
- La diferencia entre animaciones **implícitas** y **explícitas** en Flutter
- Por qué esta semana empieza por las implícitas y qué queda para semana 12

## 📋 Conceptos Clave

### 1. Por qué animar

Una animación no es decoración: es **feedback**. Cuando un usuario toca "agregar a favoritos" y
el ícono cambia de color de golpe, el cambio es correcto pero invisible como *evento* — el ojo
humano detecta movimiento mucho mejor que un cambio instantáneo de estado. Un `AnimatedContainer`
de 200ms comunica "esto acaba de cambiar" sin una sola línea de texto. Instagram, Uber y Spotify
usan esto constantemente: el corazón que rebota al dar like, el mapa que desliza el marcador en
vez de saltar, la mini-portada que se convierte en el reproductor de pantalla completa.

### 2. Dos familias de animación en Flutter

| | Implícitas (`Animated*`) | Explícitas (`AnimationController`) |
|---|---|---|
| **Qué controlas** | El valor final (`width`, `color`, `opacity`) | El progreso de la animación en sí (0.0 → 1.0) |
| **Quién dispara el cambio** | Un `setState`/rebuild con un valor distinto | Tú, llamando `.forward()`, `.reverse()`, `.repeat()` |
| **Control fino** (pausar, repetir, encadenar) | No | Sí |
| **Curva de aprendizaje** | Baja — cambia una propiedad, listo | Media/alta — gestionas el ciclo de vida del controller |
| **Ejemplos** | `AnimatedContainer`, `AnimatedOpacity`, `Hero` | `CustomPainter` animado, animaciones encadenadas, gestos con física |

Ambas producen resultados visuales similares en casos simples. La diferencia está en **quién
controla el tiempo**: en una implícita, el widget interpola solo entre el valor viejo y el nuevo
cada vez que cambias una propiedad; en una explícita, tú manejas un reloj (`AnimationController`)
y decides exactamente cuándo arranca, pausa o revierte.

### 3. El patrón común de todas las implícitas

Todo widget `Animated*` recibe **la misma tríada de parámetros**:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300), // cuánto dura la transición
  curve: Curves.easeInOut,                      // cómo se distribuye el tiempo (ver archivo 03)
  width: _expanded ? 200 : 100,                 // el valor destino — Flutter interpola el viejo → este
  child: const FlutterLogo(),
)
```

No hay `controller`, no hay `.forward()`. El widget detecta que `width` cambió entre un `build()`
y el siguiente, y anima la transición automáticamente. Esto es exactamente lo mismo que ya
conoces de `setState` desde semana 2 — solo que en vez de saltar al valor nuevo, Flutter dibuja
los cuadros intermedios.

### 4. Qué se aprende esta semana vs. semana 12

- **Semana 11 (esta)**: `AnimatedContainer` y familia, `Curves`/`Duration`, `Hero`,
  `AnimatedSwitcher`, `AnimatedList` — cubren la gran mayoría de animaciones de una app real.
- **Semana 12**: `AnimationController`, `Tween`, `AnimatedBuilder`, `CustomPainter` animado —
  para cuando necesitas control fino (pausar a mitad de camino, encadenar varias animaciones,
  repetir en loop, sincronizar con un gesto de arrastre).

La progresión es deliberada: la mayoría de animaciones de producto (una tarjeta que se expande,
una transición entre pantallas, un ícono que aparece/desaparece) se resuelven con lo de esta
semana, sin tocar un `AnimationController`. Reservar la API explícita para cuando de verdad la
necesitas evita la sobre-ingeniería de animar todo con controllers manuales.

## ✅ Checklist de Verificación

- [ ] Sé explicar por qué una animación es "feedback", no solo estética
- [ ] Sé la diferencia entre animar implícitamente (cambiar un valor) y explícitamente (manejar
      un controller)
- [ ] Reconozco la tríada común (`duration`, `curve`, valor destino) en cualquier widget
      `Animated*`
- [ ] Sé cuándo esta semana no alcanza y hace falta esperar a `AnimationController` (semana 12)

## 📚 Próximo paso

[AnimatedContainer y Widgets Animados Implícitos →](02-animatedcontainer-y-widgets-animados.md)
