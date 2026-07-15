# Proyecto Semana 02 — Pantalla de Lista del Dominio

> Tu primera app Flutter real: una pantalla con buscador que lista los elementos de tu dominio
> asignado, usando los patrones de layout y listas vistos esta semana.

## 🎯 Objetivo

Integrar `MaterialApp`/`Scaffold`, `Row`/`Column`/`Expanded`, `ListView.builder` y `TextField`
en una sola pantalla funcional.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## ✅ Requisitos Funcionales (Adaptables a tu dominio)

1. Extender `Item` en `lib/models/item.dart` con al menos 2 propiedades propias del dominio.
2. Reemplazar `lib/data/sample_items.dart` con al menos 4 elementos reales de tu dominio.
3. Completar `lib/screens/home_screen.dart`: filtrar por `_query`, mostrar la lista con
   `ItemCard` dentro de un `ListView.builder`, y manejar el caso de lista vacía.
4. Cambiar el título del `AppBar` por el nombre de tu dominio.

## 💡 Ejemplos de Adaptación por Dominio

| Dominio        | Entidad principal | Atributos ejemplo (además de id/name/description) |
| -------------- | ------------------ | ----------------------------------------------------- |
| 📖 Biblioteca  | Libro                | author, isbn                                            |
| 💊 Farmacia    | Medicamento           | price, stock                                             |
| 🏋️ Gimnasio    | Miembro                | plan, active                                              |
| 🍽️ Restaurante | Platillo                | price, category                                            |

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

1. App funcional en emulador/simulador iOS y/o Android, mostrando tu lista con buscador
2. Código adaptado a tu dominio (modelo, datos, pantalla)
3. `flutter analyze` sin errores y `flutter test` pasando
4. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../rubrica-evaluacion.md](../rubrica-evaluacion.md)
