# Proyecto Semana 07 — Formulario de Creación con Validación

## 🎯 Objetivo

Agregar una pantalla de creación al proyecto de semana 6: un formulario con `FormBuilder`,
validado en el cliente, que envía un nuevo elemento vía POST real con Dio a través del
repository.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

Igual que semana 6, el starter consume `https://jsonplaceholder.typicode.com` — el `POST` a
`/posts` es simulado por la API (responde `201` con un `id` falso, no persiste realmente). Es
suficiente para practicar el flujo completo de envío/validación/feedback.

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

1. `lib/repositories/items_repository.dart` — implementa `createItem()`: POST real con Dio y
   traducción de `DioException` (mismo patrón de `fetchItems()`, ya completo).
2. `lib/screens/create_item_screen.dart` — agrega al menos 3 campos de tu dominio con
   validadores coherentes, y conecta el feedback reactivo del envío (loading/éxito/error) con
   `CreateItemNotifier` (ver teoría 05 y ejercicio 03).

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Formulario de creación adaptado a tu dominio, validando y enviando correctamente
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../../rubrica-evaluacion.md)
