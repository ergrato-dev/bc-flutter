# Rúbrica de Evaluación — Semana 08

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
| Criterio de decisión entre `shared_preferences`, Hive/`hive_ce` y `sqflite` | 20 |
| API de `SharedPreferences` — async solo al abrir la instancia, síncrona al leer/escribir | 15 |
| `Box` de Hive — abrir, guardar/leer `Map`/`List`, `box.listenable()` | 20 |
| Patrón `overrideWithValue()` para inyectar instancias cargadas antes de `runApp()` | 20 |
| Estrategia network-first con fallback y por qué `CachedItemsRepository` es un Decorator | 25 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (SharedPreferences básico) | 25 | Los 3 pasos descomentados, el contador sobrevive a un hot restart |
| Ejercicio 02 (Hive/hive_ce CRUD local) | 35 | Los 3 pasos descomentados, notas agregadas/eliminadas persisten y la lista se actualiza sola con `box.listenable()` |
| Ejercicio 03 (repository con cache offline) | 40 | Los 3 pasos descomentados, la lista sigue disponible en modo avión tras un hot restart |

## 📦 Producto (30%)

Proyecto **Persistencia Local**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `FavoritesNotifier` lee y persiste favoritos en `SharedPreferences` | 25 |
| `CachedItemsRepository.fetchItems()` implementado — red primero, cache como respaldo | 30 |
| Favoritos y lista de elementos sobreviven a un hot restart | 20 |
| App usable sin conexión tras haber cargado la lista al menos una vez | 15 |
| `flutter analyze` sin errores y `flutter test` pasando | 10 |

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

- Repositorio del estudiante, carpeta `week-08/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-08): complete local persistence project`
- Fecha límite: fin de la semana 8, antes de iniciar semana 9
