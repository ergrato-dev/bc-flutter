# 🚀 Proyecto Integrador: TaskManager con Clean Architecture

## 📋 Información del Proyecto

| Campo | Detalle |
|-------|---------|
| **Nombre** | TaskManager Pro |
| **Duración** | 3-4 horas |
| **Nivel** | Avanzado |
| **Evaluación** | 50% de la semana |

---

## 🎯 Objetivo

Desarrollar una aplicación completa de gestión de tareas aplicando **Clean Architecture**, **Testing** y las mejores prácticas aprendidas durante la semana. El proyecto integra todos los conceptos de arquitectura, testing unitario, widget testing y BLoC.

---

## 📱 Descripción de la App

**TaskManager Pro** es una aplicación de productividad que permite:

- ✅ Crear, editar y eliminar tareas
- ✅ Organizar tareas por prioridad y categoría
- ✅ Marcar tareas como completadas
- ✅ Filtrar y buscar tareas
- ✅ Persistencia local de datos
- ✅ Diseño Material Design 3

---

## 🏗️ Arquitectura

### Estructura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada
├── app.dart                       # MaterialApp configuration
├── injection_container.dart       # Dependency Injection setup
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Colores de la app
│   │   └── app_strings.dart       # Strings/textos
│   ├── error/
│   │   ├── exceptions.dart        # Excepciones custom
│   │   └── failures.dart          # Failures para Either
│   ├── theme/
│   │   └── app_theme.dart         # Tema Material Design 3
│   ├── usecases/
│   │   └── usecase.dart           # Base UseCase
│   └── utils/
│       ├── date_formatter.dart    # Formateo de fechas
│       └── validators.dart        # Validadores
│
└── features/
    └── task/
        ├── domain/
        │   ├── entities/
        │   │   ├── task.dart
        │   │   └── category.dart
        │   ├── repositories/
        │   │   └── task_repository.dart
        │   └── usecases/
        │       ├── create_task.dart
        │       ├── delete_task.dart
        │       ├── get_tasks.dart
        │       ├── update_task.dart
        │       └── toggle_task.dart
        │
        ├── data/
        │   ├── datasources/
        │   │   ├── task_local_datasource.dart
        │   │   └── task_local_datasource_impl.dart
        │   ├── models/
        │   │   ├── task_model.dart
        │   │   └── category_model.dart
        │   └── repositories/
        │       └── task_repository_impl.dart
        │
        └── presentation/
            ├── bloc/
            │   ├── task_bloc.dart
            │   ├── task_event.dart
            │   └── task_state.dart
            ├── pages/
            │   ├── home_page.dart
            │   ├── task_form_page.dart
            │   └── task_detail_page.dart
            └── widgets/
                ├── task_item.dart
                ├── task_list.dart
                ├── task_form.dart
                ├── priority_selector.dart
                ├── category_chip.dart
                └── empty_state.dart
```

---

## 📋 Requisitos Funcionales

### RF01: Gestión de Tareas

| ID | Descripción | Prioridad |
|----|-------------|-----------|
| RF01.1 | Crear tarea con título, descripción, prioridad y fecha límite | Alta |
| RF01.2 | Editar todos los campos de una tarea | Alta |
| RF01.3 | Eliminar tarea con confirmación | Alta |
| RF01.4 | Marcar/desmarcar tarea como completada | Alta |

### RF02: Visualización

| ID | Descripción | Prioridad |
|----|-------------|-----------|
| RF02.1 | Listar todas las tareas | Alta |
| RF02.2 | Filtrar por estado (pendientes/completadas/todas) | Media |
| RF02.3 | Ordenar por fecha de creación o prioridad | Media |
| RF02.4 | Mostrar contador de tareas pendientes | Baja |

### RF03: Persistencia

| ID | Descripción | Prioridad |
|----|-------------|-----------|
| RF03.1 | Guardar tareas localmente | Alta |
| RF03.2 | Cargar tareas al iniciar la app | Alta |
| RF03.3 | Sincronizar cambios automáticamente | Media |

---

## 📋 Requisitos No Funcionales

### RNF01: Arquitectura

- Implementar Clean Architecture con 3 capas
- Usar BLoC para gestión de estado
- Aplicar principios SOLID
- Inyección de dependencias con GetIt

### RNF02: Testing

- Cobertura mínima de 70%
- Tests unitarios para todos los casos de uso
- Tests de widget para componentes principales
- Al menos 3 tests de integración

### RNF03: Calidad de Código

- Documentación con Dartdoc
- Nombres en inglés, comentarios en español
- Sin warnings del analyzer
- Código formateado con `dart format`

---

## 🎨 Diseño de Pantallas

### Pantalla Principal (HomePage)

```
┌─────────────────────────────────────┐
│  ☰  TaskManager Pro        🔍  ⚙️  │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ☐ Comprar víveres       🔴  │   │
│  │   Ir al supermercado        │   │
│  │   📅 Hoy                    │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ☑ Reunión con equipo    🟡  │   │
│  │   Discutir roadmap Q2       │   │
│  │   📅 Completada             │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ ☐ Ejercicio             🟢  │   │
│  │   30 min de cardio          │   │
│  │   📅 Mañana                 │   │
│  └─────────────────────────────┘   │
│                                     │
│                            ┌───┐   │
│                            │ + │   │
│                            └───┘   │
├─────────────────────────────────────┤
│  Todas  │  Pendientes  │ Completadas│
└─────────────────────────────────────┘
```

### Pantalla de Formulario (TaskFormPage)

```
┌─────────────────────────────────────┐
│  ←  Nueva Tarea                     │
├─────────────────────────────────────┤
│                                     │
│  Título *                           │
│  ┌─────────────────────────────┐   │
│  │ Escribir título...          │   │
│  └─────────────────────────────┘   │
│                                     │
│  Descripción                        │
│  ┌─────────────────────────────┐   │
│  │ Agregar descripción...      │   │
│  │                             │   │
│  │                             │   │
│  └─────────────────────────────┘   │
│                                     │
│  Prioridad                          │
│  ┌──────┐ ┌────────┐ ┌──────┐     │
│  │ Baja │ │ Media  │ │ Alta │     │
│  └──────┘ └────────┘ └──────┘     │
│                                     │
│  Fecha límite                       │
│  ┌─────────────────────────────┐   │
│  │ 📅 Seleccionar fecha        │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │         GUARDAR             │   │
│  └─────────────────────────────┘   │
│                                     │
└─────────────────────────────────────┘
```

---

## 🔧 Implementación Guiada

### Paso 1: Configurar Dependencias

```yaml
# pubspec.yaml
name: task_manager
description: TaskManager Pro - Clean Architecture

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  dartz: ^0.10.1
  get_it: ^7.6.4
  sqflite: ^2.3.0
  path: ^1.8.3
  intl: ^0.18.1
  uuid: ^4.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  bloc_test: ^9.1.5
  mockito: ^5.4.4
  build_runner: ^2.4.7
```

### Paso 2: Implementar Capa de Dominio

Ver ejemplos en prácticas 01 y 02.

### Paso 3: Implementar Capa de Datos

```dart
// lib/features/task/data/models/task_model.dart

import '../../domain/entities/task.dart';

/// Modelo de datos que extiende la entidad Task.
/// 
/// Agrega funcionalidad de serialización para persistencia.
class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    super.description,
    super.isCompleted,
    required super.createdAt,
    super.dueDate,
    super.priority,
  });

  /// Crea TaskModel desde JSON (base de datos).
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isCompleted: json['is_completed'] == 1,
      createdAt: DateTime.parse(json['created_at'] as String),
      dueDate: json['due_date'] != null 
          ? DateTime.parse(json['due_date'] as String)
          : null,
      priority: TaskPriority.values[json['priority'] as int],
    );
  }

  /// Convierte a JSON para persistencia.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'priority': priority.index,
    };
  }

  /// Crea TaskModel desde entidad Task.
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      dueDate: task.dueDate,
      priority: task.priority,
    );
  }
}
```

### Paso 4: Configurar Inyección de Dependencias

```dart
// lib/injection_container.dart

import 'package:get_it/get_it.dart';
import 'features/task/data/datasources/task_local_datasource.dart';
import 'features/task/data/datasources/task_local_datasource_impl.dart';
import 'features/task/data/repositories/task_repository_impl.dart';
import 'features/task/domain/repositories/task_repository.dart';
import 'features/task/domain/usecases/create_task.dart';
import 'features/task/domain/usecases/delete_task.dart';
import 'features/task/domain/usecases/get_tasks.dart';
import 'features/task/domain/usecases/update_task.dart';
import 'features/task/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => TaskBloc(
      getTasks: sl(),
      createTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));

  // Repository
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );
}
```

### Paso 5: Implementar Tests

Ver prácticas 02, 03 y 04 para ejemplos detallados.

---

## ✅ Checklist de Entrega

### Arquitectura
- [ ] Estructura de carpetas Clean Architecture
- [ ] Entidades del dominio (Task, Category)
- [ ] Interfaces de repositorio
- [ ] Casos de uso implementados
- [ ] Modelos de datos con serialización
- [ ] Repositorio implementado
- [ ] Data source local (SQLite)

### Presentación
- [ ] BLoC con eventos y estados
- [ ] HomePage con lista de tareas
- [ ] TaskFormPage para crear/editar
- [ ] TaskDetailPage (opcional)
- [ ] Widgets reutilizables
- [ ] Filtrado y ordenamiento

### Testing
- [ ] Tests unitarios de casos de uso (≥5)
- [ ] Tests unitarios de entidades (≥3)
- [ ] Tests del BLoC (≥5)
- [ ] Tests de widgets (≥5)
- [ ] Tests de integración (≥3)
- [ ] Cobertura ≥70%

### Calidad
- [ ] Documentación Dartdoc
- [ ] Sin warnings del analyzer
- [ ] Código formateado
- [ ] README del proyecto

---

## 🎓 Criterios de Evaluación

| Criterio | Peso | Puntos |
|----------|------|--------|
| Clean Architecture | 25% | 25 |
| Funcionalidad completa | 20% | 20 |
| Testing (cobertura y calidad) | 25% | 25 |
| Calidad de código | 15% | 15 |
| UI/UX | 10% | 10 |
| Documentación | 5% | 5 |
| **TOTAL** | **100%** | **100** |

### Rúbrica Detallada

#### Clean Architecture (25 pts)
- **Excelente (23-25)**: Separación perfecta de capas, DI correcta, SOLID aplicado
- **Bueno (18-22)**: Capas bien separadas, algunas dependencias cruzadas menores
- **Regular (12-17)**: Estructura presente pero con violaciones de arquitectura
- **Insuficiente (0-11)**: No sigue Clean Architecture

#### Testing (25 pts)
- **Excelente (23-25)**: >80% cobertura, tests bien estructurados, casos edge
- **Bueno (18-22)**: 70-80% cobertura, tests funcionales
- **Regular (12-17)**: 50-70% cobertura, tests básicos
- **Insuficiente (0-11)**: <50% cobertura o tests no funcionan

---

## 📚 Recursos

- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC](https://bloclibrary.dev/)
- [GetIt Package](https://pub.dev/packages/get_it)
- [sqflite Package](https://pub.dev/packages/sqflite)

---

## 🚀 Extensiones Opcionales

Para quienes terminen antes o quieran ir más allá:

1. **Categorías**: Agregar sistema de categorías/etiquetas
2. **Subtareas**: Permitir crear subtareas dentro de una tarea
3. **Notificaciones**: Recordatorios para tareas con fecha límite
4. **Temas**: Implementar tema claro/oscuro
5. **Búsqueda**: Agregar búsqueda de tareas
6. **Estadísticas**: Mostrar gráficos de productividad
7. **Export/Import**: Exportar tareas a JSON/CSV
8. **Cloud Sync**: Sincronización con Firebase

---

> **Nota**: Este proyecto integra todos los conocimientos de la Semana 09. Toma tu tiempo para implementar correctamente la arquitectura antes de avanzar con las funcionalidades.
