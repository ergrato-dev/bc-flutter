# Rúbrica de Evaluación — Semana 10

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
| Regla de dependencia y las tres capas de Clean Architecture | 20 |
| Diferencia entre entidad (domain) y modelo/DTO (data) | 15 |
| Cubit — `emit()`, `BlocBuilder`, `BlocListener` | 20 |
| Diferencia entre Cubit y Bloc, y cuándo preferir cada uno | 15 |
| Orden de registro de dependencias con `get_it` | 15 |
| Por qué el guard de rutas usa `refreshListenable` en vez de reconstruir el router | 15 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (Cubit básico) | 25 | Los 3 pasos descomentados, contador funcional con `BlocBuilder` y `BlocListener` |
| Ejercicio 02 (Bloc con eventos) | 30 | Los 3 pasos descomentados, mismo contador reescrito con eventos y `on<Event>()` |
| Ejercicio 03 (Clean Architecture mini) | 45 | Los 3 pasos descomentados, las tres capas conectadas con `get_it`, la frase se carga y refresca |

## 📦 Producto (30%)

Proyecto **Clean Architecture y Bloc**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| Estructura `features/<feature>/{domain,data,presentation}` respetada en items y auth | 20 |
| `ItemsCubit.fetchItems()` y `CreateItemCubit.submit()` implementados con `emit()` | 25 |
| `AuthCubit.login()`/`logout()` implementados con `emit()` | 20 |
| Ningún widget importa un repository/datasource directo (solo Cubits) | 15 |
| `flutter analyze` sin errores y `flutter test` pasando | 20 |

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

- Repositorio del estudiante, carpeta `week-10/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-10): complete clean architecture and bloc project`
- Fecha límite: fin de la semana 10, antes de iniciar semana 11
