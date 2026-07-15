# Semana 06 — Networking con Dio y Riverpod

> **Fase 2 — Estado y Datos** | Semana 6 de 19 | ⏱️ 16 horas

Esta semana conecta tu app a una API REST real usando **Dio**, y reemplaza el `Future.delayed`
simulado de semana 5 por una llamada HTTP real dentro de un `AsyncNotifier` de Riverpod.

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Explicar por qué Dio se prefiere sobre el paquete `http` para apps de producción
- [ ] Configurar una instancia de Dio con `BaseOptions` (baseUrl, timeouts) e interceptors
- [ ] Ejecutar peticiones GET y parsear la respuesta a modelos propios (`fromJson`)
- [ ] Capturar y clasificar `DioException` por su `DioExceptionType`
- [ ] Separar las llamadas HTTP de los providers usando el patrón Repository
- [ ] Consumir un repository desde un `AsyncNotifier` de Riverpod, con estados loading/error/data
- [ ] Implementar reintento y pull-to-refresh con `ref.invalidate()` / `ref.refresh()`

## 📚 Requisitos previos

- Semana 5 (Riverpod) completada — `AsyncNotifier`, `AsyncValue`, `.when()`
- Flutter SDK local configurado (`flutter doctor` sin errores) + emulador/simulador corriendo
- Docker (para `flutter analyze`/`flutter test` reproducibles)
- Conexión a internet (las prácticas y el proyecto consumen una API REST pública real)

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Introducción a Dio y APIs REST](1-teoria/01-introduccion-a-dio-y-apis-rest.md)
2. [Interceptors y Configuración Avanzada](1-teoria/02-interceptors-y-configuracion-avanzada.md)
3. [Manejo de Errores con DioException](1-teoria/03-manejo-de-errores-dioexception.md)
4. [Repository Pattern con Dio](1-teoria/04-repository-pattern-con-dio.md)
5. [Riverpod Async para Networking](1-teoria/05-riverpod-async-para-networking.md)
6. [Serialización JSON y Buenas Prácticas](1-teoria/06-serializacion-json-y-buenas-practicas.md)

### Prácticas

1. [Ejercicio 01 — Dio Básico e Interceptors](2-practicas/ejercicio-01-dio-basico-e-interceptors/README.md)
2. [Ejercicio 02 — AsyncNotifier con Dio Real](2-practicas/ejercicio-02-asyncnotifier-con-dio-real/README.md)
3. [Ejercicio 03 — Repository Pattern y Pull-to-Refresh](2-practicas/ejercicio-03-repository-pattern-y-refresh/README.md)

### Proyecto

[Consumo de API REST con Dio + Riverpod](3-proyecto/README.md) — el `ItemsNotifier` de semana 5
deja de simular datos y pasa a consumir una API REST real a través de un repository, con manejo
de errores y pull-to-refresh, sobre tu dominio único asignado.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas, código regenerado con `build_runner`)
- [ ] Proyecto adaptado al dominio asignado, consumiendo la API REST vía repository
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 05 — Riverpod](../week-05-riverpod/README.md) | [Semana 07 — Formularios y Validación →](../week-07-formularios_validacion/README.md)
