# Rúbrica de Evaluación — Semana 06

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
| Por qué Dio sobre `http` (interceptors, `FormData`, cancel tokens, transformers) | 15 |
| `BaseOptions` e interceptors — rol de cada uno | 20 |
| `DioException` y sus `DioExceptionType` — cuándo ocurre cada uno | 20 |
| Repository pattern — por qué separar Dio de los providers (testabilidad, responsabilidad única) | 25 |
| `ref.invalidate()` vs `ref.refresh()` para reintentar/recargar | 20 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (Dio básico e interceptors) | 30 | Los 3 pasos descomentados, `LogInterceptor` visible en consola, GET real renderizado |
| Ejercicio 02 (AsyncNotifier con Dio real) | 35 | Los 3 pasos descomentados, `.when()` maneja loading/error/data con datos reales de la API |
| Ejercicio 03 (Repository pattern y pull-to-refresh) | 35 | Los 3 pasos descomentados, `RefreshIndicator` recarga la lista vía `ref.invalidate()` |

## 📦 Producto (30%)

Proyecto **Consumo de API REST con Dio + Riverpod**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `ItemsRepository` (interfaz + implementación con Dio) reemplaza la lista simulada de semana 5 | 25 |
| `ItemsNotifier` consume el repository y maneja loading/error/data en `HomeScreen` | 20 |
| Errores de red muestran mensaje claro (no el `DioException` crudo) con botón de reintentar | 20 |
| Pull-to-refresh funcional con `ref.invalidate()` sobre `itemsProvider` | 15 |
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

- Repositorio del estudiante, carpeta `week-06/` con la misma estructura de `3-proyecto/starter/`
  (incluyendo los archivos `*.g.dart` generados)
- Commit final con mensaje `feat(week-06): complete dio networking project`
- Fecha límite: fin de la semana 6, antes de iniciar semana 7
