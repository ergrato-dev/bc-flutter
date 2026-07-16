# Rúbrica de Evaluación — Semana 12

## Distribución de Puntaje

| Tipo de Evidencia    | Peso | Instrumento             |
| -------------------- | ---- | ------------------------ |
| Conocimiento 🧠      | 30%  | Cuestionario teórico     |
| Desempeño 💪         | 40%  | Ejercicios en clase      |
| Producto 📦          | 30%  | Proyecto entregable      |

**Mínimo aprobatorio**: 70% en cada tipo de evidencia.

## 🧠 Conocimiento (30%)

| Criterio | Puntos |
|---|---|
| `AnimationController` — ciclo de vida, `vsync`, `forward`/`reverse`/`repeat` | 20 |
| `Tween`/`ColorTween` y `CurvedAnimation` | 15 |
| `AnimatedBuilder` — por qué reconstruye menos que `setState` manual | 15 |
| `Interval` y `TweenSequence` para animaciones secuenciales | 15 |
| `CustomPainter` — `Canvas`, `Paint`, el parámetro `repaint`, `shouldRepaint` | 20 |
| Por qué `dispose()` de un controller no es opcional | 15 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (AnimationController básico) | 30 | Los pasos descomentados, logo que escala con forward/reverse según `isCompleted`, `dispose()` correcto |
| Ejercicio 02 (Tween + AnimatedBuilder encadenado) | 35 | Los pasos descomentados, escala y color secuenciados con `Interval` en un solo `AnimatedBuilder` |
| Ejercicio 03 (CustomPainter animado) | 35 | Los pasos descomentados, anillo animado con `AnimationController.repeat()` conectado vía `repaint` |

## 📦 Producto (30%)

Proyecto **Animaciones Avanzadas**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `LoadingRing` funcional — `CustomPainter` animado reemplazando `CircularProgressIndicator` | 30 |
| `_FavoriteButton` con "pop" de escala (`TweenSequence`) al marcar/desmarcar favorito | 25 |
| Todos los `AnimationController` liberados correctamente en `dispose()` | 20 |
| Animaciones implícitas de semana 11 (Hero, AnimatedSwitcher) sin romper | 10 |
| `flutter analyze` sin errores y `flutter test` pasando | 15 |

### Criterios transversales

- ✅ Implementación coherente con el dominio asignado
- ✅ Sin copia de implementaciones de otros aprendices
- ✅ App funcional en emulador/simulador iOS y/o Android
- ✅ `flutter analyze` sin errores
- ✅ `flutter test` pasando (verificable con Docker:
  `docker compose run --rm flutter flutter test`)

## Escala de Calificación

| Rango | Nivel |
|---|---|
| 90-100% | Sobresaliente |
| 80-89% | Notable |
| 70-79% | Aprobado |
| < 70% | No aprobado (requiere recuperación) |

## Formato de Entrega

- Repositorio del estudiante, carpeta `week-12/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-12): complete advanced animations project`
- Fecha límite: fin de la semana 12, antes de iniciar semana 13
