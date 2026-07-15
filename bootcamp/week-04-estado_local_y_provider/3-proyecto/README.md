# Proyecto Semana 04 — Favoritos del Dominio con Provider

> Extiende la navegación de semana 3 con estado compartido real: marca/desmarca elementos como
> favoritos desde la lista o el detalle, y ve el contador actualizarse en el `AppBar`.

## 🎯 Objetivo

Integrar `ChangeNotifier` + `ChangeNotifierProvider` + `context.watch`/`context.read` en una
app con navegación, demostrando estado compartido entre pantallas no relacionadas
jerárquicamente (lista, detalle y el badge del `AppBar`).

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## ✅ Requisitos Funcionales (Adaptables a tu dominio)

1. Extender `Item` en `lib/models/item.dart` con al menos 2 propiedades propias del dominio.
2. Reemplazar `lib/data/sample_items.dart` con al menos 4 elementos reales de tu dominio.
3. Completar `lib/screens/home_screen.dart`: filtrar por `_query`, renderizar con
   `ListView.builder` + `ItemCard`, y navegar al detalle con `context.push()`.
4. Completar `lib/screens/detail_screen.dart`: resolver el elemento (patrón de semana 3) y
   agregar un botón de favorito en el `AppBar` usando `FavoritesProvider`.
5. Personalizar `lib/screens/about_screen.dart` con una descripción de tu dominio.

`lib/providers/favorites_provider.dart`, `lib/widgets/item_card.dart` y
`lib/router/app_router.dart` ya están completos — el botón de favorito de cada tarjeta y el
badge del `AppBar` ya funcionan sin que los toques.

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
flutter run
```

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android: marcar/desmarcar favoritos desde lista
   y detalle, contador del `AppBar` actualizado en ambos casos
2. Código adaptado a tu dominio (modelo, datos, pantallas)
3. `flutter analyze` sin errores y `flutter test` pasando
4. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../rubrica-evaluacion.md](../rubrica-evaluacion.md)
