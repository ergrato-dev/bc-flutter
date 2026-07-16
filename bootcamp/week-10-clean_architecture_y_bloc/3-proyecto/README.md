# Proyecto Semana 10 — Clean Architecture y Bloc

## 🎯 Objetivo

Migrar el proyecto de semana 9 a Clean Architecture (features/domain/data/presentation) y de
Riverpod a Bloc/Cubit — sin cambiar el comportamiento visible de la app.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

Igual que semanas 6-9: `jsonplaceholder.typicode.com` para tus datos de dominio,
`dummyjson.com` para login (`emilys`/`emilyspass`).

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ Esta semana **no usa** `build_runner` — no hay generación de código (ni `@riverpod`, ni
> `TypeAdapter` de Hive). Todo el árbol de dependencias se registra a mano en
> `lib/core/di/injection_container.dart` con `get_it`.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Qué debes completar

1. `lib/features/items/presentation/cubit/items_cubit.dart` — `fetchItems()`.
2. `lib/features/items/presentation/cubit/create_item_cubit.dart` — `submit()`.
3. `lib/features/auth/presentation/cubit/auth_cubit.dart` — `login()` y `logout()`.

Los tres siguen el mismo patrón: `emit()` del estado de carga, `try`/`catch` alrededor del use
case, `emit()` del estado final — ver teoría 03.

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Estructura `features/<feature>/{domain,data,presentation}` respetada
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../../rubrica-evaluacion.md)
