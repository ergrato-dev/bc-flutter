# Semana 10 — Clean Architecture y Bloc

> **Fase 2 — Estado y Datos** | Semana 10 de 19 | ⏱️ 16 horas

Esta semana reorganiza el proyecto de semana 9 en Clean Architecture (capas domain/data/
presentation, por feature) y migra la gestión de estado de Riverpod a Bloc/Cubit — el cierre de
la progresión de estado del bootcamp (Provider → Riverpod → Bloc/Cubit).

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Explicar la regla de dependencia de Clean Architecture y las tres capas (domain, data,
      presentation)
- [ ] Separar una entidad de dominio de su modelo de datos (DTO)
- [ ] Escribir un `Cubit` con `emit()` y consumirlo con `BlocBuilder`/`BlocListener`
- [ ] Explicar la diferencia entre `Cubit` y `Bloc` (orientado a eventos) y cuándo preferir cada uno
- [ ] Registrar un árbol de dependencias con `get_it`, en el orden correcto
- [ ] Conectar un guard de rutas de `go_router` a un Cubit con `refreshListenable`

## 📚 Requisitos previos

- Semana 9 (Autenticación Completa) completada — JWT, `flutter_secure_storage`, guard de rutas
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

1. [Introducción a Clean Architecture](1-teoria/01-introduccion-a-clean-architecture.md)
2. [Estructura de Capas: Domain, Data, Presentation](1-teoria/02-estructura-de-capas-domain-data-presentation.md)
3. [Cubit — Estado Simple con emit()](1-teoria/03-cubit-estado-simple-con-emit.md)
4. [Bloc — Eventos y Estados](1-teoria/04-bloc-eventos-y-estados.md)
5. [Inyección de Dependencias con get_it](1-teoria/05-inyeccion-de-dependencias-con-get-it.md)
6. [GoRouterRefreshStream y Buenas Prácticas de Arquitectura](1-teoria/06-gorouterrefreshstream-y-buenas-practicas.md)

### Prácticas

1. [Ejercicio 01 — Cubit Básico](2-practicas/ejercicio-01-cubit-basico/README.md)
2. [Ejercicio 02 — Bloc con Eventos](2-practicas/ejercicio-02-bloc-con-eventos/README.md)
3. [Ejercicio 03 — Clean Architecture Mini](2-practicas/ejercicio-03-clean-architecture-mini/README.md)

### Proyecto

[Clean Architecture y Bloc](3-proyecto/README.md) — migra las features de tu dominio (items,
favoritos, auth) del proyecto de semana 9 a Clean Architecture, con Cubit en vez de Riverpod.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto migrado a Clean Architecture con Cubit, adaptado al dominio asignado
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 09 — Autenticación Completa](../week-09-autenticacion_completa/README.md) | [Semana 11 — Animaciones Básicas →](../week-11-animaciones_basicas/README.md)
