# 🗓️ Plan de Estudios — Bootcamp Flutter Zero to Hero

19 semanas · 304 horas · 16h/semana (2 sesiones de 8h) · Evaluación 30/40/30 por semana (mínimo 70% c/u)

## Tabla de fases

| Fase | Semanas | Horas | Temas principales |
|---|---|---|---|
| 0. Lenguaje | 1 | 16h | Dart moderno (null safety, async, OOP, mixins) |
| 1. Fundamentos Flutter | 2-3 | 32h | Widgets, layout, Material/Cupertino, navegación (go_router) |
| 2. Estado y Datos | 4-10 | 112h | Provider → Riverpod, networking, forms, persistencia, auth, Clean Architecture + Bloc |
| 3. Avanzado | 11-16 | 96h | Animaciones, platform channels, push notifications, testing, performance |
| 4. Producción | 17-19 | 48h | Build/release, publicación en tiendas, CI/CD, proyecto final |
| **Total** | **19** | **304h** | |

## Temario semana a semana

| # | Carpeta | Tema | Gestor de estado vigente |
|---|---|---|---|
| 01 | `week-01-fundamentos_dart_y_entorno` | Dart moderno: variables, null safety, funciones, colecciones, POO, async/await, Futures/Streams, mixins, extension methods | — |
| 02 | `week-02-widgets_y_layout` | Widget tree, StatelessWidget/StatefulWidget, Row/Column/Flex, Material/Cupertino | `setState` |
| 03 | `week-03-navegacion_go_router` | Navigator 2.0, go_router, rutas anidadas, deep links | `setState` |
| 04 | `week-04-estado_local_y_provider` | setState, InheritedWidget, ChangeNotifier + Provider | **Provider** |
| 05 | `week-05-riverpod` | Riverpod: providers, AsyncNotifier, code generation | **Riverpod** (estándar desde aquí) |
| 06 | `week-06-networking_dio_riverpod` | Dio/http, consumo de APIs REST, manejo de errores, Riverpod async | Riverpod |
| 07 | `week-07-formularios_validacion` | Form widgets, validators, flutter_form_builder | Riverpod |
| 08 | `week-08-persistencia_local` | SharedPreferences, Hive/Isar, sqflite | Riverpod |
| 09 | `week-09-autenticacion_completa` | Firebase Auth / JWT, flutter_secure_storage | Riverpod |
| 10 | `week-10-clean_architecture_y_bloc` | Clean Architecture en Flutter, Bloc/Cubit | **Bloc/Cubit** (introducido) |
| 11 | `week-11-animaciones_basicas` | Implicit animations, AnimatedContainer, Hero | Riverpod |
| 12 | `week-12-animaciones_avanzadas` | Explicit animations, AnimationController, CustomPainter | Riverpod |
| 13 | `week-13-apis_nativas_platform_channels` | Cámara, ubicación, permisos, platform channels | Riverpod |
| 14 | `week-14-push_notifications` | Firebase Cloud Messaging, notificaciones locales | Riverpod |
| 15 | `week-15-testing` | Unit/widget tests, integration_test, golden tests, mocktail | Riverpod |
| 16 | `week-16-performance_devtools` | Flutter DevTools, rebuilds, const, profiling | Riverpod |
| 17 | `week-17-build_release_publicacion` | APK/AAB/IPA, firma, flavors, Play Store + App Store | Riverpod |
| 18 | `week-18-cicd` | GitHub Actions/Codemagic, Fastlane, OTA con Shorebird | Riverpod |
| 19 | `week-19-proyecto_final` | Consolidación del proyecto de dominio único (sin `1-teoria/2-practicas`) | A elección del estudiante |

> A partir de semana 5, todo ejemplo nuevo usa **Riverpod** salvo que la semana lo indique
> explícitamente distinto (semana 10 introduce Bloc como alternativa dentro de Clean
> Architecture, no como reemplazo).

## Progresión arquitectónica de estado

```
Semana 4          Semana 5 ────────────────► Semana 10
Provider           Riverpod (estándar)        + Bloc/Cubit (alternativa,
setState/                                       dentro de Clean Architecture)
ChangeNotifier
```

Igual que la progresión monolito → hexagonal de otros bootcamps del catálogo, esta secuencia
es deliberada: cada gestor resuelve el problema del anterior, no son temas sueltos.

## Origen del temario

Adaptado del temario de `bc-reactnative` (18 semanas, 144h, framework móvil multiplataforma más
cercano en este catálogo), con dos ajustes:

1. Se añadió la **semana 1 de Dart**, siguiendo el patrón de `bc-react` (1 semana de TypeScript
   antes de arrancar React), ya que Flutter requiere un lenguaje que los estudiantes no conocen.
2. Se añadió la **semana 10 (Clean Architecture + Bloc)**, inspirada en la progresión
   arquitectónica deliberada de `bc-fastapi` (monolito → hexagonal), aprovechando que 16h/semana
   duplican la profundidad disponible por tema frente a las 8h/semana de `bc-reactnative`.
