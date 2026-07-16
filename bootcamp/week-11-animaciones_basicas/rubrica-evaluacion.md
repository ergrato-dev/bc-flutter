# Rúbrica de Evaluación — Semana 11

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
| Diferencia entre animación implícita y explícita | 15 |
| `AnimatedContainer` y qué propiedades puede interpolar | 15 |
| `Curves` y `Duration` — cuándo elegir cada curva y rango razonable de tiempo | 15 |
| Emparejamiento de `Hero` por `tag` y errores comunes que rompen el vuelo | 20 |
| `AnimatedSwitcher` — por qué requiere `key` única por variante | 15 |
| `AnimatedList` — sincronización entre datos reales e `insertItem`/`removeItem` | 20 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (AnimatedContainer) | 30 | Los pasos descomentados, tarjeta expandible con `height`/`color`/`padding` animados y curva/duración correctas |
| Ejercicio 02 (Hero entre pantallas) | 35 | Los pasos descomentados, vuelo Hero funcional entre lista y detalle con `tag` único por ítem |
| Ejercicio 03 (AnimatedSwitcher + AnimatedList) | 35 | Los pasos descomentados, transición de estados con `AnimatedSwitcher` y alta/baja animada con `AnimatedList` |

## 📦 Producto (30%)

Proyecto **Animaciones Básicas**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `Hero` funcional entre `ItemCard` (lista) y `DetailScreen`, con `tag` único por ítem | 25 |
| `AnimatedContainer` en la tarjeta o el detalle con curva/duración de `AppMotion` | 20 |
| `AnimatedSwitcher` reemplazando el `switch` plano de loading/error/loaded en la pantalla de items | 20 |
| Arquitectura Clean Architecture del proyecto sin romper (animaciones solo tocan `presentation/`) | 20 |
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

- Repositorio del estudiante, carpeta `week-11/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-11): complete basic animations project`
- Fecha límite: fin de la semana 11, antes de iniciar semana 12
