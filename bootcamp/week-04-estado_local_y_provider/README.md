# Semana 04 — Estado Local y Provider

> **Fase 2 — Estado y Datos** | Semana 4 de 19 | ⏱️ 16 horas

Abre la fase de Estado y Datos, y con ella la progresión de gestión de estado del bootcamp:
**Provider (esta semana) → Riverpod (semana 5, estándar del curso) → Bloc/Cubit (semana 10)**.

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Explicar por qué `setState` no basta para estado compartido entre widgets lejanos
- [ ] Explicar qué hace Provider por debajo (InheritedWidget) a nivel conceptual
- [ ] Declarar un `ChangeNotifier` con estado privado y `notifyListeners()`
- [ ] Exponerlo con `ChangeNotifierProvider` y consumirlo con `Consumer`/`context.watch`
- [ ] Elegir correctamente entre `context.watch()` y `context.read()`
- [ ] Optimizar rebuilds innecesarios con `Selector`
- [ ] Combinar varios notifiers con `MultiProvider`
- [ ] Nombrar al menos 2 limitaciones de Provider que motivan usar Riverpod

## 📚 Requisitos previos

- Semana 3 (Navegación con go_router) completada
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

1. [El Problema del Estado Compartido](1-teoria/01-el-problema-del-estado-compartido.md)
2. [InheritedWidget: la base de Provider](1-teoria/02-inheritedwidget.md)
3. [ChangeNotifier y ChangeNotifierProvider](1-teoria/03-changenotifier-y-changenotifierprovider.md)
4. [context.watch, context.read y Selector](1-teoria/04-watch-read-y-selector.md)
5. [MultiProvider y Organización de Providers](1-teoria/05-multiprovider.md)
6. [Buenas Prácticas y Límites de Provider](1-teoria/06-buenas-practicas-y-limites-de-provider.md)

### Prácticas

1. [Ejercicio 01 — ChangeNotifier Básico](2-practicas/ejercicio-01-changenotifier-basico/README.md)
2. [Ejercicio 02 — context.watch, context.read y Selector](2-practicas/ejercicio-02-watch-read-selector/README.md)
3. [Ejercicio 03 — MultiProvider](2-practicas/ejercicio-03-multiprovider/README.md)

### Proyecto

[Favoritos del Dominio con Provider](3-proyecto/README.md) — marca/desmarca favoritos desde la
lista o el detalle, con contador en el `AppBar`, sobre el dominio único asignado.

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

[← Semana 03 — Navegación con go_router](../week-03-navegacion_go_router/README.md) | [Semana 05 — Riverpod →](../week-05-riverpod/README.md)
