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
| Estado (S10+) | `flutter_bloc` | por confirmar en semana 10 | Alternativa orientada a eventos |
| Networking (S6) | `dio` | por confirmar en semana 6 | Cliente HTTP |
| Formularios (S7) | `flutter_form_builder`, `form_builder_validators` | por confirmar en semana 7 | Formularios y validación |
| Persistencia (S8) | `shared_preferences`, `hive`/`isar`, `sqflite` | por confirmar en semana 8 | Almacenamiento local |
| Seguridad (S9) | `flutter_secure_storage` | por confirmar en semana 9 | Tokens y credenciales |
| Auth (S9) | `firebase_auth` | por confirmar en semana 9 | Autenticación |
| Push (S14) | `firebase_messaging` | por confirmar en semana 14 | Notificaciones push |
| Testing (S15) | `flutter_test` (SDK), `mocktail`, `integration_test` (SDK) | por confirmar en semana 15 | Unit/widget/E2E |
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
