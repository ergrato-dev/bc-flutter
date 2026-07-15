# Proyecto Semana 03 — Navegación del Dominio

> Extiende la pantalla de semana 2 con navegación real: dos tabs persistentes (Lista / Acerca
> de) vía `ShellRoute`, y una pantalla de detalle alcanzable por `id` vía `/items/:id`.

## 🎯 Objetivo

Integrar `MaterialApp.router`, `ShellRoute` con bottom nav, y navegación lista→detalle con
path parameters + `extra`.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## ✅ Requisitos Funcionales (Adaptables a tu dominio)

1. Extender `Item` en `lib/models/item.dart` con al menos 2 propiedades propias del dominio.
2. Reemplazar `lib/data/sample_items.dart` con al menos 4 elementos reales de tu dominio.
3. Completar `lib/screens/home_screen.dart`: filtrar por `_query`, renderizar con
   `ListView.builder` + `ItemCard`, y navegar al detalle con `context.push()`.
4. Completar `lib/screens/detail_screen.dart`: resolver el elemento con
   `preloadedItem ?? findItemById(itemId)`.
5. Personalizar `lib/screens/about_screen.dart` con una descripción de tu dominio.

`lib/router/app_router.dart` ya está completo — no necesitas modificarlo, solo entender cómo
conecta las pantallas (mismo patrón de los ejercicios 01-03).

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

1. App funcional en emulador/simulador iOS y/o Android: tabs Lista/Acerca de + detalle por id
2. Código adaptado a tu dominio (modelo, datos, pantallas)
3. `flutter analyze` sin errores y `flutter test` pasando
4. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../rubrica-evaluacion.md](../rubrica-evaluacion.md)
