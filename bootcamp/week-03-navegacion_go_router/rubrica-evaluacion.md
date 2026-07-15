# Rúbrica de Evaluación — Semana 03

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
| Navegación imperativa vs declarativa, por qué go_router | 15 |
| `go()` vs `push()` vs `pop()`: cuándo usar cada uno | 20 |
| Path parameters, query parameters y `extra` (y por qué extra no basta solo) | 25 |
| ShellRoute: qué problema resuelve y cómo se diferencia de rutas anidadas | 20 |
| redirect y deep links: propósito general | 20 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (rutas básicas) | 30 | Los 3 pasos descomentados, navegación push/pop funcionando |
| Ejercicio 02 (parámetros de ruta) | 35 | Los 3 pasos descomentados, fallback por id funcionando sin extra |
| Ejercicio 03 (ShellRoute y tabs) | 35 | Los 2 pasos descomentados, bottom nav persistente sin reconstruirse al cambiar de tab |

## 📦 Producto (30%)

Proyecto **Navegación del Dominio**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `Item`/`sampleItems` extendidos con datos del dominio (≥4 elementos) | 15 |
| Tab "Lista" con buscador + navegación al detalle vía `context.push` | 25 |
| Tab "Acerca de" personalizada | 10 |
| `DetailScreen` resuelve el elemento con el patrón id+extra correctamente | 25 |
| Bottom nav bar persistente (no se reconstruye al cambiar de tab) | 15 |
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

- Repositorio del estudiante, carpeta `week-03/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-03): complete domain navigation project`
- Fecha límite: fin de la semana 3, antes de iniciar semana 4
