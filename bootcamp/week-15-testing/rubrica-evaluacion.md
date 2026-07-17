# Rúbrica de Evaluación — Semana 15

## Distribución de Puntaje

| Tipo de Evidencia    | Peso | Instrumento             |
| --------------------- | ---- | ------------------------ |
| Conocimiento 🧠      | 30%  | Cuestionario teórico     |
| Desempeño 💪         | 40%  | Ejercicios en clase      |
| Producto 📦          | 30%  | Proyecto entregable      |

**Mínimo aprobatorio**: 70% en cada tipo de evidencia.

## 🧠 Conocimiento (30%)

| Criterio | Puntos |
|---|---|
| `group`/`test`/`expect` — estructura de un unit test con `flutter_test` | 15 |
| `mocktail`: `Mock`, `when().thenAnswer()`, `verify()`, por qué hace falta `registerFallbackValue()` | 20 |
| Ciclo de un widget test: `pumpWidget` → `find` → acción (`tap`/`enterText`) → `pump`/`pumpAndSettle` → `expect` | 20 |
| `blocTest`: `build`, `act`, `expect` — qué reemplaza frente a probar un Cubit a mano | 20 |
| Qué detecta un golden test que un widget test normal no detecta | 10 |
| La pirámide de testing — por qué hay muchos unit tests y pocos E2E | 15 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (unit test con mocktail) | 30 | Los pasos descomentados, `MockItemsRepository` verificado con `when`/`verify`, test en verde |
| Ejercicio 02 (widget test de formulario) | 35 | Los pasos descomentados, el test llena el formulario, lo envía y verifica el resultado esperado |
| Ejercicio 03 (bloc_test de un Cubit) | 35 | Los pasos descomentados, `blocTest` cubre el estado de éxito y el de error del Cubit |

## 📦 Producto (30%)

Proyecto **Testing**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| Unit test de un use case con `mocktail` (repository mockeado, sin red real) | 25 |
| `blocTest` de un Cubit cubriendo al menos éxito y error | 25 |
| Widget test de una pantalla o widget clave del dominio | 25 |
| Arquitectura, animaciones, foto y notificaciones de semanas 10-14 sin romper | 10 |
| `flutter analyze` sin errores y `flutter test` pasando (toda la suite, no solo los tests nuevos) | 15 |

### Criterios transversales

- ✅ Implementación coherente con el dominio asignado
- ✅ Sin copia de implementaciones de otros aprendices
- ✅ App funcional en emulador/simulador iOS y/o Android
- ✅ `flutter analyze` sin errores
- ✅ `flutter test` pasando (verificable con Docker:
  `docker compose run --rm flutter flutter test`)
- ✅ Ningún test golpea red, Firebase, Hive o `flutter_secure_storage` reales — todo mockeado

## Escala de Calificación

| Rango | Nivel |
|---|---|
| 90-100% | Sobresaliente |
| 80-89% | Notable |
| 70-79% | Aprobado |
| < 70% | No aprobado (requiere recuperación) |

## Formato de Entrega

- Repositorio del estudiante, carpeta `week-15/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-15): complete testing project`
- Fecha límite: fin de la semana 15, antes de iniciar semana 16
