# Proyecto Semana 15 — Testing

## 🎯 Objetivo

Agregar una suite de tests (unit, widget y de Cubit) al proyecto Clean Architecture de semanas
10-14 — sin romper la arquitectura, las animaciones, la foto ni las notificaciones ya existentes.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

Igual que semanas 6-14: `jsonplaceholder.typicode.com` para tus datos de dominio,
`dummyjson.com` para login (`emilys`/`emilyspass`). Ningún test de esta semana debe golpear
estas APIs reales — todo repository queda simulado con `mocktail`.

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ El starter parte de semanas 10-14 ya completas (Clean Architecture, animaciones, foto,
> push notifications) — esta semana no las toca, solo agrega tests nuevos en `test/`.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Qué debes completar

Tres archivos con TODOs esta semana, cada uno en `test/`, mismo path relativo que el archivo que
prueban en `lib/`:

1. **`test/features/items/domain/usecases/get_items_test.dart`** — unit test de `GetItems` con
   `MockItemsRepository` (`mocktail`), ver teoría 01 y 02.
2. **`test/features/items/presentation/cubit/items_cubit_test.dart`** — `blocTest` de
   `ItemsCubit` cubriendo éxito y error, ver teoría 04.
3. **`test/features/items/presentation/widgets/item_card_test.dart`** — widget test de
   `ItemCard`: renderizado y toggle de favorito, ver teoría 03.

`test/widget_test.dart` ya existe desde semana 10 (smoke test de arranque) — no lo modifiques,
solo agrega los tres archivos nuevos.

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Los tres archivos de test completados, `flutter test` en verde (toda la suite, no solo los
   nuevos)
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../rubrica-evaluacion.md)
