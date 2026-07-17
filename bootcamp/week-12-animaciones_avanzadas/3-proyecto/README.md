# Proyecto Semana 12 — Animaciones Avanzadas

## 🎯 Objetivo

Agregar animaciones explícitas (`AnimationController`, `CustomPainter`) al proyecto Clean
Architecture de semanas 10-11 — sin romper las animaciones implícitas ya existentes ni la
arquitectura.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

Igual que semanas 6-11: `jsonplaceholder.typicode.com` para tus datos de dominio,
`dummyjson.com` para login (`emilys`/`emilyspass`).

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ El starter parte de las animaciones implícitas de semana 11 ya completas (Hero,
> AnimatedContainer, AnimatedSwitcher) — esta semana no las toca, solo agrega animaciones
> explícitas nuevas.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Qué debes completar

1. `lib/shared/widgets/loading_ring.dart` — `AnimationController` en modo `repeat()` (PASO 1),
   `CustomPainter` conectado vía `repaint` (PASO 2), y el `CustomPaint` final (PASO 3).
2. `lib/features/items/presentation/widgets/item_card.dart` (`_FavoriteButton`) — controller y
   `dispose()` (PASO 1), `TweenSequence` de "pop" (PASO 2), y `ScaleTransition` disparado al
   tocar (PASO 3).

Los dos siguen el patrón de las teorías 01, 02, 04 y 05: `vsync: this`, `dispose()` sin
excepción, `Tween`/`TweenSequence` derivado del mismo controller.

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. `LoadingRing` girando en el estado de carga, `_FavoriteButton` con "pop" al tocar
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../rubrica-evaluacion.md)
