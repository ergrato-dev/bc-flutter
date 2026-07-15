# Glosario — Semana 03: Navegación con go_router

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## C

**context.go()**: navega reemplazando la ubicación actual — no se puede volver con el botón atrás.

**context.pop()**: vuelve a la pantalla anterior en la pila de navegación.

**context.push()**: navega apilando una nueva pantalla sobre la actual — sí se puede volver.

## D

**Deep link**: URL que, al abrirse, navega directamente a una pantalla específica de la app.

## E

**extra**: mecanismo de `go_router` para pasar un objeto completo en la navegación, como
optimización — no sobrevive deep links ni refresh en Flutter Web.

## G

**GoRoute**: declara una ruta individual (`path` + `builder`) dentro de un `GoRouter`.

**GoRouter**: configuración central de rutas de la app, usada con `MaterialApp.router`.

## N

**Navigator 1.0**: sistema de navegación imperativo (`Navigator.push`/`Navigator.pop`).

**Navigator 2.0**: sistema de navegación declarativo, basado en describir la navegación como
estado (la URL actual).

## P

**Path parameter**: segmento variable de una ruta, declarado con `:nombre` (ej. `/items/:id`).

## Q

**Query parameter**: parámetro adicional en la URL tras `?` (ej. `?q=flutter`), leído con
`state.uri.queryParameters`.

## R

**redirect**: función de `go_router` (a nivel de `GoRouter` o `GoRoute`) que puede forzar una
navegación distinta antes de construir la pantalla — base de la protección de rutas.

## S

**ShellRoute**: ruta contenedora cuyo `builder` envuelve a rutas hijas, manteniendo UI
persistente (como una bottom nav bar) sin reconstruirse al navegar entre ellas.

---

> 📚 Plan de estudios completo del bootcamp: [docs/plan-estudios.md](../../../docs/plan-estudios.md)
