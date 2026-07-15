# Semana 03 — Navegación con go_router

> **Fase 1 — Fundamentos Flutter** | Semana 3 de 19 | ⏱️ 16 horas

Cierra la fase de fundamentos: le das navegación real a la app de semana 2, con tabs
persistentes y una pantalla de detalle alcanzable por id.

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Explicar la diferencia entre navegación imperativa (Navigator 1.0) y declarativa (2.0)
- [ ] Configurar `MaterialApp.router` con un `GoRouter` y declarar rutas con `GoRoute`
- [ ] Elegir correctamente entre `context.go()`, `context.push()` y `context.pop()`
- [ ] Leer path parameters, query parameters, y usar `extra` como optimización (no como única
      fuente del dato)
- [ ] Construir una navegación con `ShellRoute` y bottom nav bar persistente
- [ ] Proteger una ruta con `redirect`
- [ ] Explicar qué es un deep link y cómo probarlo localmente

## 📚 Requisitos previos

- Semana 2 (Widgets y Layout) completada
- Flutter SDK local configurado (`flutter doctor` sin errores) + emulador/simulador corriendo
- Docker (para `flutter analyze`/`flutter test` reproducibles)

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Introducción a la Navegación y go_router](1-teoria/01-introduccion-a-la-navegacion-y-go_router.md)
2. [Rutas Básicas y Configuración de GoRouter](1-teoria/02-rutas-basicas-y-gorouter-config.md)
3. [Parámetros y Rutas Dinámicas](1-teoria/03-parametros-y-rutas-dinamicas.md)
4. [Rutas Anidadas y ShellRoute](1-teoria/04-rutas-anidadas-y-shellroute.md)
5. [Redirecciones con GoRouter](1-teoria/05-redirecciones.md)
6. [Deep Links](1-teoria/06-deep-links.md)

### Prácticas

1. [Ejercicio 01 — Rutas Básicas con GoRouter](2-practicas/ejercicio-01-rutas-basicas/README.md)
2. [Ejercicio 02 — Parámetros de Ruta y extra](2-practicas/ejercicio-02-parametros-de-ruta/README.md)
3. [Ejercicio 03 — ShellRoute y Navegación por Tabs](2-practicas/ejercicio-03-shellroute-y-tabs/README.md)

### Proyecto

[Navegación del Dominio](3-proyecto/README.md) — tabs Lista/Acerca de con `ShellRoute` +
detalle por id sobre el dominio único asignado.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 02 — Widgets y Layout](../week-02-widgets_y_layout/README.md) | [Semana 04 — Estado Local y Provider →](../week-04-estado_local_y_provider/README.md)
