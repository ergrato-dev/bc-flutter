# Permisos de Notificaciones

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué iOS requiere permiso explícito para mostrar notificaciones y Android tradicionalmente no
- Qué cambió en Android 13 con `POST_NOTIFICATIONS`
- Cómo solicitar el permiso con `firebase_messaging` de forma que cubra ambas plataformas
- Los valores de `AuthorizationStatus` y qué significa cada uno

## 📋 Conceptos Clave

### 1. iOS — permiso obligatorio desde siempre

En iOS, ninguna app puede mostrar notificaciones sin que el usuario lo autorice explícitamente
mediante un diálogo del sistema. `firebase_messaging` expone este permiso con
`requestPermission()`:

```dart
Future<AuthorizationStatus> requestNotificationPermission() async {
  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  return settings.authorizationStatus;
}
```

### 2. `AuthorizationStatus` — los cuatro estados

| Valor | Significado |
|---|---|
| `authorized` | Usuario concedió el permiso |
| `denied` | Usuario lo rechazó — en iOS no se puede volver a preguntar, solo desde Ajustes |
| `notDetermined` | Aún no se ha preguntado |
| `provisional` | iOS: notificaciones silenciosas, sin diálogo (solo aparecen en el centro de notificaciones) |

> 💡 **Diferencia con `permission_handler`** (semana 13): `PermissionStatus` es el enum genérico
> de `permission_handler` para cámara, ubicación, etc. `AuthorizationStatus` es específico de
> `firebase_messaging` — nombres distintos para el mismo concepto de "estado de un permiso".

### 3. Android — el cambio en Android 13

Hasta Android 12, las apps podían mostrar notificaciones sin pedir permiso. Desde **Android 13**
(API 33), `POST_NOTIFICATIONS` es un permiso runtime como cámara o ubicación — hay que
declararlo y solicitarlo:

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

```dart
import 'package:permission_handler/permission_handler.dart';

Future<bool> ensureNotificationPermission() async {
  // permission_handler ya cubre POST_NOTIFICATIONS — mismo patrón check →
  // request de la semana 13, sin necesitar código específico de Android 13.
  var status = await Permission.notification.status;
  if (status.isDenied) {
    status = await Permission.notification.request();
  }
  return status.isGranted;
}
```

En Android 12 o anterior, `Permission.notification.status` devuelve `granted` automáticamente
(no hay diálogo que mostrar), así que este código es seguro en todas las versiones.

### 4. Un flujo que cubre ambas plataformas

```dart
Future<bool> ensurePushPermission() async {
  final settings = await FirebaseMessaging.instance.requestPermission();
  final iosOk = settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional;

  // En Android, requestPermission() de firebase_messaging ya delega a
  // POST_NOTIFICATIONS internamente desde firebase_messaging 14+ — pero
  // usar permission_handler explícito es más claro para auditar el estado.
  final androidOk = await ensureNotificationPermission();

  return Platform.isIOS ? iosOk : androidOk;
}
```

### 5. Casos de Uso Móvil

Uber pide el permiso de notificaciones justo después del primer viaje solicitado, no al abrir la
app por primera vez — el contexto ("vas a necesitar saber cuándo llega tu conductor") aumenta la
tasa de aceptación frente a pedirlo en frío al arrancar.

## ⚠️ Errores Comunes

- **Pedir el permiso apenas abre la app**: sin contexto, los usuarios tienden a rechazarlo — y
  en iOS, si lo rechazan, solo pueden revertirlo manualmente desde Ajustes.
- **Olvidar declarar `POST_NOTIFICATIONS` en el manifest de Android**: sin la declaración, la
  solicitud de permiso falla silenciosamente en Android 13+.
- **Asumir que `getToken()` funciona sin permiso en iOS**: devuelve `null` hasta que el usuario
  autoriza — verifica siempre antes de enviarlo al backend.

## 📚 Recursos Adicionales

- [FCM — Permisos en Flutter](https://firebase.google.com/docs/cloud-messaging/flutter/receive#request_permissions)
- [Android — permiso POST_NOTIFICATIONS](https://developer.android.com/develop/ui/views/notifications/notification-permission)
- [permission_handler — pub.dev](https://pub.dev/packages/permission_handler)

## ✅ Checklist de Verificación

Antes de continuar, verifica que entiendes:

- [ ] Los cuatro valores de `AuthorizationStatus`
- [ ] Qué cambió en Android 13 respecto a versiones anteriores
- [ ] Por qué el momento en que se pide el permiso importa
