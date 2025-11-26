# Práctica 03: Optimización con `Selector` y `select`

## Descripción

Partiendo del ejercicio del carrito, analizar y optimizar puntos donde ocurren rebuilds innecesarios:

- Identificar widgets que se reconstruyen cuando no deberían.
- Reemplazar `Consumer` o `context.watch()` por `Selector` o `context.select()` cuando aplique.

## Requisitos mínimos

- Demostrar al menos 2 optimizaciones usando `Selector` o `select`.
- Medir impacto (profiler o logs simples).

## Criterios de evaluación

- Optimización efectiva (3 pts)
- Justificación y medición (1.5 pts)
- Código limpio (0.5 pts)
