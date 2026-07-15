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

| Fase | Paquete | Rol |
|---|---|---|
| Navegación | `go_router` | Navegación declarativa |
| Estado (S4) | `provider` | Gestión de estado local |
| Estado (S5+) | `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` | Estándar del curso |
| Estado (S10+) | `flutter_bloc` | Alternativa orientada a eventos |
| Networking | `dio` | Cliente HTTP |
| Formularios | `flutter_form_builder`, `form_builder_validators` | Formularios y validación |
| Persistencia | `shared_preferences`, `hive`/`isar`, `sqflite` | Almacenamiento local |
| Seguridad | `flutter_secure_storage` | Tokens y credenciales |
| Auth | `firebase_auth` | Autenticación |
| Push | `firebase_messaging` | Notificaciones push |
| Testing | `flutter_test` (SDK), `mocktail`, `integration_test` (SDK) | Unit/widget/E2E |
| Lint | `flutter_lints` | Reglas de análisis estático |

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
