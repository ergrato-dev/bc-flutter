# Proyecto Semana 14 — Push Notifications

## 🎯 Objetivo

Agregar notificaciones push (`firebase_messaging` + `flutter_local_notifications`) al proyecto
Clean Architecture de semanas 10-13 — sin romper la arquitectura, las animaciones ni la foto ya
existentes.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

Igual que semanas 6-13: `jsonplaceholder.typicode.com` para tus datos de dominio,
`dummyjson.com` para login (`emilys`/`emilyspass`). Las notificaciones son independientes de
esa API — vienen de tu propio proyecto de Firebase.

## 🔥 Configura tu proyecto de Firebase

Necesitas tu propio proyecto gratuito antes de correr esta semana:

```bash
dart pub global activate flutterfire_cli
cd starter
flutterfire configure
```

Esto genera `lib/firebase_options.dart` (y la configuración nativa de Android/iOS si ya tienes
`android/`/`ios/` en tu copia de trabajo desde semanas anteriores). Ver teoría 01.

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ El starter parte de la foto (semana 13) y las animaciones (semanas 11-12) ya completas —
> esta semana no las toca, solo agrega notificaciones push nuevas.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Qué debes completar

`lib/features/notifications/data/repositories/notification_repository_impl.dart` — el único
archivo con TODOs esta semana:

1. **PASO 1** — `ensurePermission()`: `requestPermission()` de FCM en iOS,
   `Permission.notification` de `permission_handler` en Android 13+ (mismo patrón check →
   request de la semana 13 — ver teoría 04).
2. **PASO 2** — `initialize()`: crea el `AndroidNotificationChannel` y escucha
   `FirebaseMessaging.onMessage` para mostrar la notificación en foreground con
   `flutter_local_notifications` — ver teoría 03.
3. **PASO 3** — amplía `initialize()`: conecta `onMessageOpenedApp` y `getInitialMessage()` para
   emitir la ruta del elemento tocado por `onNotificationRoute` — ver teoría 05.

`main.dart` (PASO 1 de inicialización de Firebase), `AuthCubit` (pide el permiso tras el login)
e `injection_container.dart` (registra `NotificationRepository`) ya están completos — no
necesitas modificarlos.

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android, con tu propio proyecto de Firebase
2. Notificación visible en foreground; tocar una notificación navega al elemento correcto
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../../rubrica-evaluacion.md)
