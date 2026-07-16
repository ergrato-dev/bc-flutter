# Buenas Prácticas y Rendimiento en Animaciones

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué una animación mal hecha puede bajar el frame rate percibido de toda la pantalla
- Cómo `const` y `RepaintBoundary` limitan qué se redibuja durante una animación
- Una checklist para decidir cuándo migrar de implícita a explícita (gancho a semana 12)

## 📋 Conceptos Clave

### 1. El costo real de una animación

Cada widget `Animated*` reconstruye su `build()` en **cada frame** mientras dura la transición —
a 60fps, una animación de 300ms ejecuta ~18 rebuilds. Si ese `build()` reconstruye un subárbol
grande (una pantalla completa en vez de solo la tarjeta que cambia), el costo se multiplica por
18 innecesariamente. Esto es una extensión directa de lo que ya conoces de Riverpod/`setState`
desde semana 4-5: minimizar qué se reconstruye, solo que aquí el rebuild ocurre automáticamente
en cada frame de la animación, no una sola vez por evento de usuario.

### 2. const en el subárbol que no cambia

El `child` de un `AnimatedContainer` que no depende de la propiedad animada debe ser `const` — así
Flutter no lo reconstruye en cada frame, solo reposiciona/redimensiona el `RenderObject` ya
existente.

```dart
AnimatedContainer(
  duration: AppMotion.medium,
  height: _expanded ? 220 : 96,
  // ✅ child const: no se reconstruye en cada uno de los ~18 frames de la transición
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Contenido estático'),
  ),
)
```

### 3. RepaintBoundary — aislar el repintado

Cuando un widget animado vive dentro de una lista o de un árbol con hermanos costosos de pintar
(imágenes grandes, gráficos), envolverlo en `RepaintBoundary` evita que Flutter tenga que
repintar esos hermanos en cada frame de la animación — el motor de renderizado cachea la capa de
cada `RepaintBoundary` por separado.

```dart
RepaintBoundary(
  child: AnimatedContainer(
    duration: AppMotion.medium,
    color: _isFavorite ? Colors.red : Colors.grey,
    child: const Icon(Icons.favorite),
  ),
)
```

Úsalo con criterio: cada `RepaintBoundary` tiene su propio costo de memoria (una capa de
composición extra). No lo agregues "por si acaso" en cada widget — reserva su uso para el caso
concreto de un elemento que anima frecuentemente al lado de contenido costoso de pintar (esto lo
verificarás con DevTools en semana 16, no a simple vista).

### 4. Cuándo una implícita ya no alcanza (gancho a semana 12)

| Síntoma | Qué falta |
|---|---|
| Necesitas **pausar** la animación a mitad de camino | `AnimationController` (`.stop()`) |
| Necesitas **repetir en loop** (ej. un spinner custom) | `AnimationController.repeat()` |
| Necesitas **encadenar** varias animaciones en secuencia | `AnimationController` + `Interval`/`TweenSequence` |
| Necesitas sincronizar la animación con un **gesto de arrastre** (ej. swipe-to-dismiss con física) | `AnimationController` manejado por el gesto, no por un valor de estado |
| Necesitas dibujar algo custom que cambia cuadro a cuadro (ej. un gráfico animado) | `CustomPainter` + `AnimatedBuilder` |

Si tu animación no aparece en esta tabla, una implícita (`AnimatedContainer`, `Hero`,
`AnimatedSwitcher`) resuelve el caso sin la complejidad adicional de gestionar manualmente el
ciclo de vida de un `AnimationController` (`initState`/`dispose`). No adelantes semana 12 sin
necesidad — la mayoría de animaciones de producto no la requieren.

## ✅ Checklist de Verificación

- [ ] Sé por qué un `Animated*` ejecuta rebuilds en cada frame y qué implica en costo
- [ ] Sé marcar `const` el subárbol que no depende del valor animado
- [ ] Sé cuándo un `RepaintBoundary` tiene sentido y por qué no se usa "por si acaso" en todo
- [ ] Sé identificar al menos dos síntomas que indican que hace falta `AnimationController`
      (semana 12) en vez de una animación implícita

## 📚 Recursos Adicionales

- [Flutter docs — Animations overview](https://docs.flutter.dev/ui/animations)
- [Flutter docs — Hero animations](https://docs.flutter.dev/ui/animations/hero-animations)
- [Material Design — Motion](https://m3.material.io/styles/motion/overview)
