# Proyecto Semana 11 — Animaciones Básicas

## 🎯 Objetivo

Agregar `Hero`, `AnimatedContainer` y `AnimatedSwitcher` al proyecto Clean Architecture de
semana 10 — sin romper la arquitectura ni cambiar de gestor de estado (sigue siendo Bloc/Cubit;
el estado "vigente" del temario vuelve a Riverpod para material *nuevo*, no implica migrar de
nuevo un proyecto que ya usa Cubit).

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

Igual que semanas 6-10: `jsonplaceholder.typicode.com` para tus datos de dominio,
`dummyjson.com` para login (`emilys`/`emilyspass`).

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ El starter parte de la migración de semana 10 ya terminada (`ItemsCubit`, `CreateItemCubit`
> y `AuthCubit` completos) — esta semana **no** toca `domain/` ni `data/`, solo
> `presentation/`.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Qué debes completar

1. `lib/features/items/presentation/widgets/item_card.dart` — Hero en el `leading` (PASO 1) y
   `AnimatedContainer` en el fondo del botón de favorito (PASO 2).
2. `lib/features/items/presentation/screens/detail_screen.dart` — Hero con el mismo `tag` que
   `item_card.dart` (PASO 1).
3. `lib/features/items/presentation/screens/home_screen.dart` — `AnimatedSwitcher` envolviendo
   el `switch` de loading/error/loaded (PASO 1).

Los tres siguen el patrón de las teorías 02, 04 y 05: mismo `tag` en ambos `Hero`, `ValueKey`
única por rama del `AnimatedSwitcher`, `duration`/`curve` consistentes en el `AnimatedContainer`.

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. `Hero` funcional entre la lista y el detalle, sin romper la navegación de `go_router`
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../../rubrica-evaluacion.md)
