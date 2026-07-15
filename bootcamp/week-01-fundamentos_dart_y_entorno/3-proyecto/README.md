# Proyecto Semana 01 — Modelador de Dominio en Consola

> Un programa de línea de comandos, en Dart puro (sin Flutter todavía), que modela y lista los
> elementos de tu dominio asignado, simulando una carga asíncrona.

## 🎯 Objetivo

Integrar todo lo aprendido esta semana — null safety, colecciones, funciones, POO con mixins y
`Future`/`async`/`await` — en un programa ejecutable de principio a fin.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## ✅ Requisitos Funcionales (Adaptables a tu dominio)

1. Modelar tu entidad principal en `lib/models/item.dart` con al menos 2 propiedades propias
   del dominio (además de `id`, `name`, `createdAt` que ya trae la clase `Item`).
2. Completar `ItemRepository.fetchItems()` en `lib/services/item_repository.dart` con al menos
   4 elementos de ejemplo de tu dominio.
3. Implementar `ItemRepository.findById()` usando null safety (debe retornar `null`, no lanzar
   excepción, cuando el id no existe).
4. Completar `lib/main.dart`: cargar los elementos, manejar el caso de lista vacía, imprimirlos,
   y probar `findById` con un id existente y uno inexistente.

## 💡 Ejemplos de Adaptación por Dominio

| Dominio        | Entidad principal | Atributos ejemplo (además de id/name/createdAt) |
| -------------- | ------------------ | -------------------------------------------------- |
| 📖 Biblioteca  | Libro                | author, isbn, available                            |
| 💊 Farmacia    | Medicamento           | price, stock, category                             |
| 🏋️ Gimnasio    | Miembro                | plan, startDate, active                            |
| 🍽️ Restaurante | Platillo                | price, category                                     |
| 🏥 Hospital     | Paciente                 | age, diagnosis                                       |

## 🚀 Cómo ejecutar

```bash
cd starter
dart pub get
dart run lib/main.dart
```

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter dart pub get
docker compose run --rm flutter dart analyze
docker compose run --rm flutter dart test
```

## 🛠️ Entregables

1. Código adaptado a tu dominio (modelo, repositorio, main)
2. `dart analyze` sin errores
3. `dart test` pasando (el test incluido en `test/` no requiere cambios)
4. README actualizado con una descripción breve de tu dominio elegido

## 📊 Criterios de Evaluación

Ver [../rubrica-evaluacion.md](../rubrica-evaluacion.md)
