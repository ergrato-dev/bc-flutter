# Proyecto Semana 08 — Persistencia Local

## 🎯 Objetivo

Agregar persistencia local al proyecto de semana 7: favoritos guardados en `SharedPreferences` y
la lista de elementos de tu dominio cacheada en Hive, disponible sin conexión.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

Igual que semanas 6-7, el starter consume `https://jsonplaceholder.typicode.com`. Esta semana,
además, la lista queda guardada en un `Box` de Hive tras cada carga exitosa — pruébala en modo
avión después de haber cargado la lista al menos una vez.

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

> ⚠️ **Cada vez que modifiques un provider** (`@riverpod`), vuelve a correr
> `dart run build_runner build` antes de `flutter run`.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Qué debes completar

1. `lib/providers/favorites_provider.dart` — lee el estado inicial de favoritos desde
   `SharedPreferences` en `build()`, y persiste cada cambio en `toggle()` (ver teoría 02).
2. `lib/repositories/items_repository.dart` — implementa
   `CachedItemsRepository.fetchItems()`: red primero, y si falla, cae al `Box` de Hive como
   respaldo (ver teoría 05 y ejercicio 03).

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Favoritos y lista de elementos persistidos, verificables con un hot restart
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../rubrica-evaluacion.md)
