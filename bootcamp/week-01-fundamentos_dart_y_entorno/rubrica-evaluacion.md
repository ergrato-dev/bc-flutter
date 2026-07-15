# Rúbrica de Evaluación — Semana 01

## Distribución de Puntaje

| Tipo de Evidencia    | Peso | Instrumento             |
| -------------------- | ---- | ------------------------ |
| Conocimiento 🧠      | 30%  | Cuestionario teórico     |
| Desempeño 💪         | 40%  | Ejercicios en clase      |
| Producto 📦          | 30%  | Proyecto entregable      |

**Mínimo aprobatorio**: 70% en cada tipo de evidencia.

## 🧠 Conocimiento (30%)

Cuestionario teórico sobre los 6 temas de `1-teoria/`:

| Criterio | Puntos |
|---|---|
| Diferencia `var`/`final`/`const` y cuándo usar cada uno | 15 |
| Null safety: `?`, `?.`, `??`, `??=`, `!`, `late` — uso correcto y riesgos de `!` | 25 |
| Parámetros nombrados vs posicionales, `switch` como expresión | 15 |
| List/Set/Map: cuándo usar cada uno, operadores de colección | 15 |
| Herencia vs mixins: cuándo usar cada uno | 15 |
| `Future` vs `Stream`: cuándo usar cada uno | 15 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (null safety) | 30 | Los 4 pasos descomentados, `dart run` sin errores ni excepciones no manejadas |
| Ejercicio 02 (colecciones y funciones) | 35 | Los 4 pasos descomentados, salida de consola coincide con lo esperado en el README |
| Ejercicio 03 (POO y async) | 35 | Los 4 pasos descomentados, pausa async visible (~1s), error del paso 4 capturado por `catch` |

## 📦 Producto (30%)

Proyecto **Modelador de Dominio en Consola**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `Item` extendido con ≥2 propiedades propias del dominio | 20 |
| `fetchItems()` con ≥4 elementos de ejemplo, coherentes con el dominio | 20 |
| `findById()` implementado con null safety (retorna `null`, no lanza excepción) | 25 |
| `main.dart` completo: carga, maneja lista vacía, imprime, prueba `findById` en ambos casos | 25 |
| `dart analyze` sin errores y `dart test` pasando | 10 |

### Criterios transversales

- ✅ Implementación coherente con el dominio asignado
- ✅ Sin copia de implementaciones de otros aprendices
- ✅ `dart analyze` sin errores
- ✅ `dart test` pasando (verificable con Docker: `docker compose run --rm flutter dart test`)

## Escala de Calificación

| Rango | Nivel |
|---|---|
| 90-100% | Sobresaliente |
| 80-89% | Notable |
| 70-79% | Aprobado |
| < 70% | No aprobado (requiere recuperación) |

## Formato de Entrega

- Repositorio del estudiante, carpeta `week-01/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-01): complete domain modeler console project`
- Fecha límite: fin de la semana 1, antes de iniciar semana 2
