# Proyecto Semana 06 — Networking con Dio y Riverpod

## 🎯 Objetivo

Reemplazar la lista simulada de semana 5 (`Future.delayed`) por datos reales, consumidos con
Dio a través de un repository, y agregar manejo de errores con reintento y pull-to-refresh —
todo aplicado a tu dominio asignado.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

El starter consume `https://jsonplaceholder.typicode.com/posts` (API pública, gratuita, sin
autenticación) como fuente de datos genérica — mapea sus campos `id`/`title`/`body` a tu modelo
`Item` en `lib/models/item.dart`. Si encuentras una API pública real y gratuita que encaje mejor
con tu dominio, puedes reemplazarla (ajusta `baseUrl` en `lib/providers/dio_provider.dart` y el
`fromJson` de `Item`).

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

1. `lib/models/item.dart` — agrega las propiedades específicas de tu dominio.
2. `lib/repositories/items_repository.dart` — implementa `fetchItems()`: GET real con Dio,
   parseo a `List<Item>`, y traducción de `DioException` a un mensaje entendible.
3. `lib/screens/home_screen.dart` — completa el pull-to-refresh (`RefreshIndicator` +
   `ref.refresh()`) y el estado de error con botón de reintentar (`ref.invalidate()`).
4. `lib/screens/about_screen.dart` — reemplaza el texto de ejemplo por la descripción de tu
   dominio.

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Código adaptado a tu dominio, consumiendo datos reales vía Dio + repository
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../rubrica-evaluacion.md)
