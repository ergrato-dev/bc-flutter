# 🚀 Proyecto Final: LifeTracker Pro

## 📋 Información General

| Campo           | Detalle                                            |
| --------------- | -------------------------------------------------- |
| **Nombre**      | LifeTracker Pro                                    |
| **Descripción** | App integral de productividad y bienestar personal |
| **Duración**    | 8-10 horas (proyecto final del bootcamp)           |
| **Dificultad**  | ⭐⭐⭐⭐ Avanzado                                  |
| **Stack**       | Flutter + Firebase + Clean Architecture            |

---

## 🎯 Objetivos del Proyecto

Este proyecto final integra **todos los conocimientos** del bootcamp:

| Semana | Conocimiento           | Aplicación en el Proyecto  |
| ------ | ---------------------- | -------------------------- |
| 1-2    | Dart y Flutter básico  | Estructura del código      |
| 3      | Widgets y Layouts      | UI completa y responsiva   |
| 4      | Navegación             | Flujo de pantallas         |
| 5      | Gestión de Estado      | BLoC pattern               |
| 6      | APIs y HTTP            | Sincronización de datos    |
| 7      | Persistencia           | SQLite + SharedPreferences |
| 8      | Features Nativas       | Notificaciones, cámara     |
| 9      | Arquitectura y Testing | Clean Architecture + Tests |
| 10     | Deployment             | CI/CD + Publicación        |

---

## 📱 Características de la Aplicación

### Core Features

#### 1. Gestión de Hábitos

- ✅ Crear hábitos personalizados
- ✅ Tracking diario con streaks
- ✅ Recordatorios con notificaciones
- ✅ Estadísticas y gráficos de progreso

#### 2. Lista de Tareas

- ✅ CRUD completo de tareas
- ✅ Categorías y prioridades
- ✅ Fechas de vencimiento
- ✅ Filtros y búsqueda

#### 3. Diario Personal

- ✅ Entradas diarias con mood
- ✅ Adjuntar fotos (cámara/galería)
- ✅ Búsqueda por fecha y contenido
- ✅ Exportar en PDF

#### 4. Dashboard

- ✅ Resumen del día
- ✅ Progreso de hábitos
- ✅ Tareas pendientes
- ✅ Mood tracker semanal

### Features Técnicas

- 🏗️ **Clean Architecture** con 3 capas
- 📦 **BLoC** para gestión de estado
- 💾 **SQLite** para persistencia local
- 🔔 **Notificaciones** locales programadas
- 📸 **Cámara** y galería
- 📊 **Analytics** con Firebase
- 🔥 **Crashlytics** para monitoreo
- 🚀 **CI/CD** con GitHub Actions
- 🌍 **Multi-entorno** (dev/staging/prod)

---

## 🏗️ Arquitectura del Proyecto

### Estructura de Carpetas

```
lib/
├── main.dart                    # Entry point por defecto
├── main_dev.dart               # Entry point desarrollo
├── main_staging.dart           # Entry point staging
├── main_prod.dart              # Entry point producción
├── app.dart                    # MaterialApp configuration
│
├── core/
│   ├── config/
│   │   ├── env.dart           # Variables de entorno
│   │   ├── flavors.dart       # Configuración de flavors
│   │   └── app_config.dart    # Configuración centralizada
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_routes.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── text_styles.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── validators.dart
│   │   └── extensions.dart
│   ├── errors/
│   │   ├── failures.dart
│   │   └── exceptions.dart
│   └── services/
│       ├── analytics_service.dart
│       ├── crash_service.dart
│       └── notification_service.dart
│
├── data/
│   ├── models/
│   │   ├── habit_model.dart
│   │   ├── task_model.dart
│   │   ├── journal_model.dart
│   │   └── user_model.dart
│   ├── datasources/
│   │   ├── local/
│   │   │   ├── database_helper.dart
│   │   │   ├── habit_local_datasource.dart
│   │   │   ├── task_local_datasource.dart
│   │   │   └── journal_local_datasource.dart
│   │   └── remote/
│   │       └── sync_remote_datasource.dart
│   └── repositories/
│       ├── habit_repository_impl.dart
│       ├── task_repository_impl.dart
│       └── journal_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── habit.dart
│   │   ├── task.dart
│   │   ├── journal_entry.dart
│   │   └── user.dart
│   ├── repositories/
│   │   ├── habit_repository.dart
│   │   ├── task_repository.dart
│   │   └── journal_repository.dart
│   └── usecases/
│       ├── habits/
│       │   ├── get_habits.dart
│       │   ├── create_habit.dart
│       │   ├── complete_habit.dart
│       │   └── delete_habit.dart
│       ├── tasks/
│       │   ├── get_tasks.dart
│       │   ├── create_task.dart
│       │   ├── update_task.dart
│       │   └── delete_task.dart
│       └── journal/
│           ├── get_entries.dart
│           ├── create_entry.dart
│           └── search_entries.dart
│
├── presentation/
│   ├── bloc/
│   │   ├── habits/
│   │   │   ├── habit_bloc.dart
│   │   │   ├── habit_event.dart
│   │   │   └── habit_state.dart
│   │   ├── tasks/
│   │   │   ├── task_bloc.dart
│   │   │   ├── task_event.dart
│   │   │   └── task_state.dart
│   │   ├── journal/
│   │   │   ├── journal_bloc.dart
│   │   │   ├── journal_event.dart
│   │   │   └── journal_state.dart
│   │   └── dashboard/
│   │       └── dashboard_bloc.dart
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── onboarding/
│   │   │   └── onboarding_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── dashboard/
│   │   │   └── dashboard_screen.dart
│   │   ├── habits/
│   │   │   ├── habits_screen.dart
│   │   │   ├── habit_detail_screen.dart
│   │   │   └── create_habit_screen.dart
│   │   ├── tasks/
│   │   │   ├── tasks_screen.dart
│   │   │   ├── task_detail_screen.dart
│   │   │   └── create_task_screen.dart
│   │   ├── journal/
│   │   │   ├── journal_screen.dart
│   │   │   ├── entry_detail_screen.dart
│   │   │   └── create_entry_screen.dart
│   │   └── settings/
│   │       └── settings_screen.dart
│   └── widgets/
│       ├── common/
│       │   ├── app_button.dart
│       │   ├── app_text_field.dart
│       │   ├── app_card.dart
│       │   └── loading_indicator.dart
│       ├── habits/
│       │   ├── habit_card.dart
│       │   ├── habit_streak.dart
│       │   └── habit_progress.dart
│       ├── tasks/
│       │   ├── task_tile.dart
│       │   └── task_filter.dart
│       └── journal/
│           ├── mood_selector.dart
│           └── entry_card.dart
│
└── di/
    └── injection.dart          # Dependency injection setup
```

---

## 📦 Dependencias

```yaml
# pubspec.yaml
name: life_tracker_pro
description: App integral de productividad y bienestar personal
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5

  # Dependency Injection
  get_it: ^7.6.4
  injectable: ^2.3.2

  # Database
  sqflite: ^2.3.0
  path: ^1.8.3
  shared_preferences: ^2.2.2

  # Firebase
  firebase_core: ^2.24.0
  firebase_analytics: ^10.7.0
  firebase_crashlytics: ^3.4.7

  # Notifications
  flutter_local_notifications: ^16.2.0
  timezone: ^0.9.2

  # Camera & Image
  image_picker: ^1.0.5
  path_provider: ^2.1.1

  # Functional Programming
  dartz: ^0.10.1

  # UI
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.0
  fl_chart: ^0.65.0
  intl: ^0.18.1

  # Utils
  uuid: ^4.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  # Testing
  mockito: ^5.4.4
  bloc_test: ^9.1.5

  # Code Generation
  build_runner: ^2.4.7
  injectable_generator: ^2.4.1

  # Assets
  flutter_launcher_icons: ^0.13.1
  flutter_native_splash: ^2.3.5

  # Linting
  flutter_lints: ^3.0.1
```

---

## 🧪 Requisitos de Testing

### Mínimos Obligatorios

| Tipo         | Cantidad Mínima | Enfoque                             |
| ------------ | --------------- | ----------------------------------- |
| Unit Tests   | 10              | Use cases, repositories, BLoCs      |
| Widget Tests | 5               | Screens principales, widgets custom |
| Integration  | 2               | Flujos completos                    |

### Cobertura Esperada

- **Domain Layer**: > 80%
- **Data Layer**: > 60%
- **Presentation**: > 40%
- **Total**: > 50%

---

## ✅ Checklist de Entrega

### Arquitectura y Código

- [ ] Clean Architecture implementada (3 capas)
- [ ] BLoC pattern para estado
- [ ] Dependency Injection con get_it
- [ ] Manejo de errores con Either<Failure, T>
- [ ] Código documentado (dartdoc)
- [ ] Nomenclatura en inglés

### Funcionalidades

- [ ] CRUD de hábitos funcionando
- [ ] CRUD de tareas funcionando
- [ ] Diario con fotos funcionando
- [ ] Dashboard con estadísticas
- [ ] Notificaciones locales
- [ ] Persistencia con SQLite

### Calidad

- [ ] Mínimo 17 tests pasando
- [ ] flutter analyze sin errores
- [ ] dart format aplicado
- [ ] README del proyecto

### Deployment

- [ ] Configuración multi-entorno
- [ ] App icons generados
- [ ] Splash screen configurado
- [ ] Build de release firmado
- [ ] CI/CD configurado
- [ ] Analytics implementado

---

## 📊 Criterios de Evaluación

| Componente                    | Peso | Puntos  |
| ----------------------------- | ---- | ------- |
| Arquitectura Clean            | 20%  | 20      |
| Funcionalidades completas     | 25%  | 25      |
| Testing (17+ tests)           | 20%  | 20      |
| UI/UX y Diseño                | 10%  | 10      |
| Deployment y CI/CD            | 15%  | 15      |
| Documentación y código limpio | 10%  | 10      |
| **TOTAL**                     | 100% | **100** |

---

## 📅 Plan de Desarrollo Sugerido

### Día 1-2: Arquitectura Base (3h)

- [ ] Setup proyecto y dependencias
- [ ] Estructura de carpetas
- [ ] Configuración de entornos
- [ ] DI con get_it

### Día 3-4: Core Features (3h)

- [ ] Implementar módulo de Hábitos
- [ ] Implementar módulo de Tareas
- [ ] Base de datos SQLite

### Día 5: Features Adicionales (2h)

- [ ] Módulo de Diario
- [ ] Dashboard
- [ ] Notificaciones

### Día 6: Testing y Polish (2h)

- [ ] Escribir tests
- [ ] Pulir UI
- [ ] Corregir bugs

### Día 7: Deployment (2h)

- [ ] Assets finales
- [ ] CI/CD
- [ ] Build de release
- [ ] Documentación

---

## 📖 Recursos Adicionales

- [GUIA-DISENO.md](./GUIA-DISENO.md) - Sistema de diseño completo
- [EJEMPLOS-DATOS.md](./EJEMPLOS-DATOS.md) - Modelos y datos de ejemplo

---

## 🔗 Navegación

| ⬅️ Anterior                           | 🏠 Índice                 | Siguiente ➡️                    |
| ------------------------------------- | ------------------------- | ------------------------------- |
| [Prácticas](../2-practicas/README.md) | [Semana 10](../README.md) | [Guía Diseño](./GUIA-DISENO.md) |
