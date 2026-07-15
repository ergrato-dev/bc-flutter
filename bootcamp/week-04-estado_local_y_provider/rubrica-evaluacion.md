# Rúbrica de Evaluación — Semana 04

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
| Por qué setState no basta, prop drilling | 15 |
| InheritedWidget: rol conceptual (Theme.of/MediaQuery.of) | 10 |
| ChangeNotifier + notifyListeners(): ciclo completo | 25 |
| context.watch() vs context.read(): cuándo usar cada uno | 25 |
| MultiProvider y límites de Provider frente a Riverpod | 25 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (ChangeNotifier básico) | 30 | Los 3 pasos descomentados, el contador funciona en pantalla |
| Ejercicio 02 (watch/read/Selector) | 35 | Los 3 pasos descomentados, la consola confirma que Selector evita el rebuild innecesario |
| Ejercicio 03 (MultiProvider) | 35 | Los 3 pasos descomentados, ambos notifiers funcionan de forma independiente |

## 📦 Producto (30%)

Proyecto **Favoritos del Dominio con Provider**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `Item`/`sampleItems` extendidos con datos del dominio (≥4 elementos) | 15 |
| Lista con buscador + navegación al detalle funcionando (semanas 2-3) | 20 |
| Botón de favorito funcional en `DetailScreen` (usa FavoritesProvider) | 25 |
| Contador del `AppBar` se actualiza correctamente desde lista y detalle | 20 |
| `flutter analyze` sin errores y `flutter test` pasando (incluye el test de `FavoritesProvider`) | 20 |

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

- Repositorio del estudiante, carpeta `week-04/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-04): complete domain favorites project`
- Fecha límite: fin de la semana 4, antes de iniciar semana 5
