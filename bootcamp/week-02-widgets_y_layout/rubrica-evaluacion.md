# Rúbrica de Evaluación — Semana 02

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
| StatelessWidget vs StatefulWidget: diferencia y cuándo usar cada uno | 20 |
| MaterialApp/Scaffold/AppBar: rol de cada uno | 15 |
| MainAxisAlignment/CrossAxisAlignment, Expanded vs Flexible | 25 |
| ListView vs ListView.builder: por qué `.builder` para datos dinámicos | 20 |
| TextEditingController y por qué debe hacerse dispose() | 20 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (widget tree y Scaffold) | 30 | Los 3 pasos descomentados, la app corre en emulador/simulador sin errores |
| Ejercicio 02 (layout Row/Column) | 35 | Los 3 pasos descomentados, sin `RenderFlex overflowed`, precio alineado a la derecha |
| Ejercicio 03 (ListView + inputs) | 35 | Los 3 pasos descomentados, filtrado en tiempo real funcionando |

## 📦 Producto (30%)

Proyecto **Pantalla de Lista del Dominio**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `Item` extendido con ≥2 propiedades propias del dominio | 15 |
| `sampleItems` con ≥4 elementos coherentes con el dominio | 15 |
| Buscador (`TextField` + filtrado) funcionando en tiempo real | 25 |
| Lista renderizada con `ListView.builder` + `ItemCard`, sin overflow | 25 |
| Manejo del caso de lista vacía (sin resultados de búsqueda) | 10 |
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

- Repositorio del estudiante, carpeta `week-02/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-02): complete domain list screen project`
- Fecha límite: fin de la semana 2, antes de iniciar semana 3
