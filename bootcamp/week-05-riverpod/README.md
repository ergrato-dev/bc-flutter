# Semana 05 — Riverpod

> **Fase 2 — Estado y Datos** | Semana 5 de 19 | ⏱️ 16 horas

Riverpod se convierte en el **estándar de gestión de estado del resto del bootcamp** — desde
aquí hasta semana 19 (con Bloc/Cubit sumándose, no reemplazando, en semana 10).

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Explicar por qué Riverpod no depende de `BuildContext` (a diferencia de Provider)
- [ ] Instalar y configurar Riverpod con generación de código (`build_runner`)
- [ ] Declarar providers funcionales y componerlos entre sí (`ref.watch` de un provider en otro)
- [ ] Declarar un `Notifier` con estado mutable, reasignando `state` de forma inmutable
- [ ] Declarar un provider async y manejar `AsyncValue` con `.when()`
- [ ] Elegir correctamente entre `ref.watch()`, `ref.read()` y `ref.listen()`
- [ ] Migrar un `ChangeNotifier` de Provider (semana 4) a un `Notifier` de Riverpod
- [ ] Testear un Notifier con `ProviderContainer`, sin montar ningún widget

## 📚 Requisitos previos

- Semana 4 (Estado Local y Provider) completada
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

1. [Introducción a Riverpod](1-teoria/01-introduccion-a-riverpod.md)
2. [Providers Funcionales con Code Generation](1-teoria/02-providers-funcionales-con-codegen.md)
3. [Notifier y Estado Mutable](1-teoria/03-notifier-y-estado-mutable.md)
4. [AsyncNotifier y AsyncValue](1-teoria/04-asyncnotifier-y-asyncvalue.md)
5. [ConsumerWidget, Consumer y ref](1-teoria/05-consumerwidget-y-ref.md)
6. [Migración desde Provider y Buenas Prácticas](1-teoria/06-migracion-desde-provider-y-buenas-practicas.md)

### Prácticas

1. [Ejercicio 01 — Provider Funcional y Notifier](2-practicas/ejercicio-01-provider-funcional-y-notifier/README.md)
2. [Ejercicio 02 — AsyncNotifier y AsyncValue](2-practicas/ejercicio-02-asyncnotifier-y-asyncvalue/README.md)
3. [Ejercicio 03 — ConsumerWidget, ref y Composición de Providers](2-practicas/ejercicio-03-consumerwidget-y-ref/README.md)

### Proyecto

[Migración a Riverpod + AsyncNotifier](3-proyecto/README.md) — favoritos migrados de Provider a
Riverpod, y lista de elementos cargada con `AsyncNotifier` sobre el dominio único asignado.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas, código regenerado con `build_runner`)
- [ ] Proyecto adaptado al dominio asignado
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 04 — Estado Local y Provider](../week-04-estado_local_y_provider/README.md) | [Semana 06 — Networking con Dio y Riverpod →](../week-06-networking_dio_riverpod/README.md)
