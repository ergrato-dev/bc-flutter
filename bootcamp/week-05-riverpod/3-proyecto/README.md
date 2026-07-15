# Proyecto Semana 05 — Migración a Riverpod + AsyncNotifier

> Migra los favoritos de semana 4 (Provider) a Riverpod, y reemplaza la lista estática de
> elementos por un `AsyncNotifier` que simula una carga de red.

## 🎯 Objetivo

Integrar `ProviderScope`, `Notifier`, `AsyncNotifier`/`AsyncValue` y `ConsumerWidget`/
`ConsumerStatefulWidget` en una app con navegación — el mismo dominio de semanas 2-4, ahora con
el estándar de estado del resto del bootcamp.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## ✅ Requisitos Funcionales (Adaptables a tu dominio)

1. Extender `Item` en `lib/models/item.dart` con al menos 2 propiedades propias del dominio.
2. Reemplazar los elementos de ejemplo en `lib/providers/items_provider.dart` (dentro de
   `ItemsNotifier.build()`) con al menos 4 elementos reales de tu dominio.
3. Completar `lib/screens/home_screen.dart`: dentro del `data:` de `.when()`, filtrar por
   `_query`, manejar lista vacía, y renderizar con `ListView.builder` + `ItemCard`.
4. Completar `lib/screens/detail_screen.dart`: resolver el elemento con `findItemById` cuando
   no llega por `extra`, y agregar el botón de favorito en `_DetailContent`.
5. Personalizar `lib/screens/about_screen.dart` con una descripción de tu dominio.

`lib/providers/favorites_provider.dart`, `lib/widgets/item_card.dart` y
`lib/router/app_router.dart` ya están completos.

## 💡 Ejemplos de Adaptación por Dominio

| Dominio        | Entidad principal | Atributos ejemplo (además de id/name/description) |
| -------------- | ------------------ | ----------------------------------------------------- |
| 📖 Biblioteca  | Libro                | author, isbn                                            |
| 💊 Farmacia    | Medicamento           | price, stock                                             |
| 🏋️ Gimnasio    | Miembro                | plan, active                                              |

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

> ⚠️ **Cada vez que modifiques un provider** (`items_provider.dart`, `favorites_provider.dart`),
> vuelve a correr `dart run build_runner build`.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter dart run build_runner build
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android: lista con spinner de carga inicial,
   buscador, favoritos y detalle, todo sobre tu dominio
2. Código adaptado a tu dominio (modelo, provider de datos, pantallas)
3. `flutter analyze` sin errores y `flutter test` pasando
4. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../rubrica-evaluacion.md](../rubrica-evaluacion.md)
