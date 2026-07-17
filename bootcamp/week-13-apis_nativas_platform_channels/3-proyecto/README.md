# Proyecto Semana 13 — APIs Nativas y Platform Channels

## 🎯 Objetivo

Agregar captura/selección de foto (`permission_handler` + `image_picker`) al proyecto Clean
Architecture de semanas 10-12 — sin romper la arquitectura ni las animaciones ya existentes.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

Igual que semanas 6-12: `jsonplaceholder.typicode.com` para tus datos de dominio,
`dummyjson.com` para login (`emilys`/`emilyspass`). `photoPath` es local y nunca viaja al API
fake (`jsonplaceholder` no tiene ese campo).

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ El starter parte de las animaciones de semanas 11-12 ya completas (Hero,
> AnimatedContainer, AnimatedSwitcher, `_FavoriteButton` con "pop") — esta semana no las toca,
> solo agrega el campo de foto en `CreateItemScreen`.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Qué debes completar

`lib/features/items/presentation/widgets/photo_picker_field.dart` — el único archivo con TODOs
esta semana:

1. **PASO 1** — `_ensureCameraPermission()`: check → request → `openAppSettings()` si quedó
   `permanentlyDenied` (mismo patrón de teoría 01).
2. **PASO 2** — `_pick(ImageSource source)`: solo pide el permiso cuando `source ==
   ImageSource.camera` (la galería no lo necesita, ver teoría 02); si el usuario cancela,
   `photo` es `null` y no es un error.
3. **PASO 3** — conecta los dos botones (`camera_alt`, `photo_library`) a `_pick(...)`.

`ItemCard`, `DetailScreen` e `ItemModel` ya están completos: muestran `item.photoPath` con
`FileImage` cuando existe (fallback a ícono si es `null`) y lo cachean localmente sin enviarlo
al API fake.

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. `PhotoPickerField` funcionando: permiso de cámara verificado, foto visible en `ItemCard` y
   `DetailScreen`
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../rubrica-evaluacion.md)
