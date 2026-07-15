# Rúbrica de Evaluación — Semana 05

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
| Por qué Riverpod no depende de BuildContext, comparación con Provider | 15 |
| Notifier + reasignar `state` (inmutabilidad) | 20 |
| AsyncValue: 3 estados y por qué usar `.when()` en vez de `.value` | 25 |
| ref.watch() vs ref.read() vs ref.listen() | 20 |
| Composición de providers (ref.watch dentro de otro provider) | 20 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (provider funcional + Notifier) | 30 | Los 3 pasos descomentados y regenerados con build_runner, contador funciona |
| Ejercicio 02 (AsyncNotifier + AsyncValue) | 35 | Los 3 pasos descomentados, spinner→lista→agregar funcionando |
| Ejercicio 03 (ConsumerWidget + composición) | 35 | Los 3 pasos descomentados, SnackBar aparece exactamente al 3er producto |

## 📦 Producto (30%)

Proyecto **Migración a Riverpod + AsyncNotifier**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `ItemsNotifier` con ≥4 elementos del dominio, `.when()` maneja loading/error/data en `HomeScreen` | 25 |
| Buscador funcionando sobre los datos ya cargados | 15 |
| `DetailScreen` resuelve el elemento correctamente (extra o `findItemById`) | 20 |
| Botón de favorito funcional en detalle y lista (FavoritesNotifier) | 20 |
| `flutter analyze` sin errores y `flutter test` pasando (código regenerado con build_runner) | 20 |

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

- Repositorio del estudiante, carpeta `week-05/` con la misma estructura de `3-proyecto/starter/`
  (incluyendo los archivos `*.g.dart` generados)
- Commit final con mensaje `feat(week-05): complete riverpod migration project`
- Fecha límite: fin de la semana 5, antes de iniciar semana 6
