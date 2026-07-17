# 📦 Versiones del Stack — Bootcamp Flutter

Versiones de referencia para la primera cohorte. Se fijan al iniciar cada cohorte y no se
actualizan a mitad de curso (evita romper ejemplos ya publicados).

## Core

| Tecnología | Versión | Notas |
|---|---|---|
| Dart | canal stable vigente | `dart --version` |
| Flutter | canal stable vigente | `flutter --version`, `flutter doctor` sin errores |
| Docker | 27+ | Container runtime |
| Docker Compose | 2.31+ | Orquestación |

> ⚠️ A diferencia de `bc-fastapi`/`bc-reactnative`, aquí **no fijamos un número de versión
> exacto por adelantado**: el canal `stable` de Flutter cambia con frecuencia y una versión
> hardcodeada hoy puede no existir ya al iniciar la cohorte. El instructor debe correr
> `flutter --version` el primer día de clase y documentar el resultado exacto aquí antes de
> generar el contenido de la semana 1.

## Paquetes por fase

| Fase | Paquete | Versión pineada | Rol |
|---|---|---|---|
| Navegación (S3) | `go_router` | **17.3.0** ✅ confirmada en pub.dev | Navegación declarativa |
| Estado (S4) | `provider` | **6.1.5+1** ✅ confirmada en pub.dev | Gestión de estado local |
| Estado (S5+) | `flutter_riverpod` 3.3.2, `riverpod_annotation` 4.0.3, `riverpod_generator` 4.0.4 | ✅ confirmadas en pub.dev | Estándar del curso |
| Estado (S5+, dev) | `build_runner` | **2.15.1** ✅ — NO 2.15.2: incompatible con `riverpod_generator` 4.0.4 (conflicto de rango de `analyzer`, detectado al resolver dependencias) | Generación de código |
| Estado (S10+) | `flutter_bloc` 9.1.1, `equatable` 2.1.0, `get_it` 9.2.1 (DI, reemplaza a Riverpod) | ✅ confirmadas en pub.dev | Cierre de la progresión — Cubit en el proyecto, Bloc solo en teoría; ver semana 10 |
| Networking (S6) | `dio` | **5.10.0** ✅ confirmada en pub.dev | Cliente HTTP |
| Formularios (S7) | `flutter_form_builder` 10.3.0+2, `form_builder_validators` 11.3.0 | ✅ confirmadas en pub.dev | Formularios y validación |
| Persistencia (S8) | `shared_preferences` 2.5.5, `hive_ce_flutter` 2.3.4, `hive_ce_generator` 1.11.2, `sqflite` (solo teoría, sin código) | ✅ confirmadas en pub.dev | Almacenamiento local — `hive_ce` en vez de `hive` (sin release estable en años) o `isar` (última estable de hace 3 años); ver teoría 01 de semana 8 |
| Seguridad (S9) | `flutter_secure_storage` 10.3.1 | ✅ confirmada en pub.dev | Tokens y credenciales |
| Auth (S9) | JWT propio (Dio, API `dummyjson.com`) — `firebase_auth` cubierto solo en teoría como alternativa | ✅ confirmado | Autenticación — ver teoría 01 y 06 de semana 9 |
| Push (S14) | `firebase_core` 4.12.1, `firebase_messaging` 16.4.3, `flutter_local_notifications` 22.0.1 | ✅ confirmadas en pub.dev | Notificaciones push — `flutter_local_notifications` muestra el mensaje en foreground (FCM no lo hace solo en Android) |
| Testing (S15) | `flutter_test`/`integration_test` (SDK, versión ligada al SDK de Flutter), `mocktail` 1.0.5, `bloc_test` 10.0.0 | ✅ confirmadas en pub.dev | Unit/widget/E2E — `bloc_test` requiere `bloc` ^9.0.0, compatible con `flutter_bloc` 9.1.1 ya pineado en S10 |
| Lint | `flutter_lints` | 5.0.0 (rango de compatibilidad estándar, no pineo estricto) | Reglas de análisis estático |

## Política de pineo

- Paquetes **core del curso** (los usados en teoría/prácticas/proyectos): versión exacta en el
  `pubspec.yaml` de referencia del instructor (sin `^`), para reproducibilidad entre cohortes.
- Paquetes de **desarrollo/tooling** (`flutter_lints`, etc.): pueden usar rango de compatibilidad
  estándar de `pub`.
- Actualizar esta tabla cada vez que se fije una versión — no dejarla en "canal stable vigente"
  una vez arrancada la cohorte.

## Calendario de auditoría

- Auditoría de dependencias (`flutter pub outdated`, avisos de `pub.dev`) al inicio de cada
  cohorte, antes de generar contenido nuevo.
- Revisión de CVEs conocidos en paquetes core (Dio, Firebase SDKs) — documentar hallazgos aquí
  si aplica, siguiendo el mismo formato que `bc-fastapi/docs/dependency-security-policy.md`.
