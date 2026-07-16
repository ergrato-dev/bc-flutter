# Curves y Duration

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es una `Curve` y por qué "linear" casi nunca se ve bien
- Las curvas más usadas en apps de producción y cuándo elegir cada una
- Criterios prácticos para elegir `Duration` (no hay un número mágico universal)

## 📋 Conceptos Clave

### 1. Qué resuelve una Curve

`Duration` dice **cuánto tarda** la animación. `Curve` dice **cómo se reparte ese tiempo** entre
el valor inicial y el final. Con `Curves.linear`, el widget avanza a velocidad constante — se ve
mecánico, como un robot. El movimiento natural (una persona empujando un objeto, un objeto que
cae) acelera y desacelera. Por eso casi ninguna animación de producción usa `linear`.

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut, // acelera al inicio, desacelera al final
  width: _expanded ? 200 : 100,
  child: const FlutterLogo(),
)
```

### 2. Curvas más usadas

| Curve | Comportamiento | Cuándo usarla |
|---|---|---|
| `Curves.linear` | Velocidad constante | Casi nunca en UI — útil para barras de progreso reales |
| `Curves.easeIn` | Empieza lento, termina rápido | Elemento que **sale** de la pantalla o se cierra |
| `Curves.easeOut` | Empieza rápido, termina lento | Elemento que **entra** o aparece — se siente "asentado" |
| `Curves.easeInOut` | Lento → rápido → lento | Default seguro para la mayoría de transiciones |
| `Curves.bounceOut` | Rebota al llegar al destino | Feedback lúdico (like, agregar al carrito) — úsalo con moderación |
| `Curves.elasticOut` | Overshoot y vuelve, como un resorte | Igual que bounce: úsalo donde el rebote tenga sentido, no en toda la UI |

Regla práctica: si dudas, `Curves.easeInOut` con 200-300ms es una base segura y profesional.
Reserva `bounceOut`/`elasticOut` para un único punto de énfasis (ej. el ícono de favorito) — usarlas
en toda la interfaz se siente infantil, no premium.

### 3. Duration — no hay un número universal, hay un rango razonable

| Rango | Se siente | Ejemplo |
|---|---|---|
| < 100ms | Instantáneo, casi imperceptible | Cambios de color en un botón al presionar |
| 150-300ms | El punto dulce para la mayoría de micro-interacciones | `AnimatedContainer` de una tarjeta, `AnimatedOpacity` |
| 300-500ms | Notorio, para transiciones entre pantallas | `Hero`, cambios de layout grandes |
| > 500ms | Se siente lento — el usuario percibe la app como "pesada" | Evitar salvo justificación específica (ej. una animación de bienvenida única) |

Material Design documenta 200-300ms como el rango estándar para la mayoría de transiciones — es
la referencia que siguen Android e iOS en sus propios sistemas de diseño. Si tu animación tarda
más de medio segundo y el usuario la dispara repetidamente (ej. cada `setState` de una lista),
vas a generar la sensación de una app lenta, aunque el resto del código sea instantáneo.

### 4. Extraer duration/curve como constantes

Repetir `Duration(milliseconds: 250)` y `Curves.easeInOut` en cada widget animado de la app hace
imposible ajustar el "feel" global después. Extráelos a una clase de constantes:

```dart
// lib/core/theme/app_motion.dart
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);

  static const Curve standard = Curves.easeInOut;
  static const Curve emphasized = Curves.easeOutBack;
}
```

```dart
AnimatedContainer(
  duration: AppMotion.medium,
  curve: AppMotion.standard,
  // ...
)
```

Si más adelante decides que toda la app se siente muy lenta, cambias un solo archivo en vez de
buscar cada `Duration(milliseconds: ...)` hardcodeado.

## ✅ Checklist de Verificación

- [ ] Sé por qué `Curves.linear` se ve mecánico y cuándo sí tiene sentido
- [ ] Sé elegir entre `easeIn`, `easeOut` y `easeInOut` según si el elemento entra o sale
- [ ] Sé el rango de duración razonable para una micro-interacción (150-300ms) vs. una transición
      de pantalla (300-500ms)
- [ ] Sé por qué conviene centralizar `Duration`/`Curve` en constantes en vez de repetirlas

## 📚 Próximo paso

[Hero Animations →](04-hero-animations.md)
