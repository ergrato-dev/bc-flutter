# Ejercicio 02 — Notificación Local en Foreground

> Muestra una notificación visible cuando llega un mensaje FCM con la app abierta — Android no
> lo hace automáticamente en ese estado.

## 🎯 Objetivos

- Crear un `NotificationChannel` de Android con `flutter_local_notifications`
- Escuchar `FirebaseMessaging.onMessage` para detectar mensajes en foreground
- Mostrar una notificación local con el título/cuerpo del mensaje recibido

## 📋 Requisitos

- Flutter SDK local configurado, emulador/simulador corriendo
- Teoría 03 de esta semana completada
- Tu propio proyecto de Firebase (repite el Paso 0-1 del ejercicio 01 con este starter si usas
  un proyecto nuevo)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutterfire configure   # si aún no generaste firebase_options.dart para este starter
flutter run
```

---

## Paso 1: inicializar Firebase

Igual que en el ejercicio 01: corre `flutterfire configure`, luego **abre
`starter/lib/main.dart`** y descomenta la sección `PASO 1`.

## Paso 2: crear el canal de notificaciones (Android)

Android 8+ requiere que toda notificación pertenezca a un `NotificationChannel` — se crea una
sola vez, antes de mostrar la primera notificación:

```dart
// Ejemplo explicativo (no el código del ejercicio):
const channel = AndroidNotificationChannel(
  'high_importance_channel',
  'Notificaciones importantes',
  importance: Importance.max,
);

final localNotifications = FlutterLocalNotificationsPlugin();
await localNotifications
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);
```

**Descomenta la sección `PASO 2`** en `starter/lib/main.dart`.

✅ **Verifica**: no debe haber errores al arrancar — el canal se crea silenciosamente, no hay
feedback visual todavía.

---

## Paso 3: escuchar `onMessage` y mostrar la notificación

```dart
// Ejemplo explicativo (no el código del ejercicio):
FirebaseMessaging.onMessage.listen((message) {
  final notification = message.notification;
  if (notification == null) return;
  localNotifications.show(
    id: notification.hashCode,
    title: notification.title,
    body: notification.body,
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails('high_importance_channel', 'Notificaciones importantes'),
    ),
  );
});
```

**Descomenta la sección `PASO 3`** en `starter/lib/main.dart`.

✅ **Verifica**: con la app **abierta** en primer plano, envía un mensaje de prueba desde
Firebase Console (Paso 3 del ejercicio 01) — debe aparecer una notificación en la barra de
estado, algo que Android **no** hace por sí solo en foreground.

## ✅ Resultado final

Con la app en foreground, cada mensaje FCM recibido dispara una notificación local visible en
la barra de estado del dispositivo.
