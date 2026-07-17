# Fundamentos de FCM: Tokens y Topics

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es el FCM token y cómo obtenerlo
- Cuándo se renueva y cómo reaccionar con `onTokenRefresh`
- Qué es un topic y cuándo conviene usarlo en vez de un token individual
- Cómo enviar un mensaje de prueba desde la consola de Firebase

## 📋 Conceptos Clave

### 1. El FCM token — identidad de esta instalación

Cada instalación de la app en un dispositivo recibe un **token** único que la identifica ante
FCM. Un backend que quiera notificar a un usuario específico necesita guardar su token.

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getDeviceToken() async {
  // En iOS, getToken() devuelve null hasta que el usuario concede el permiso
  // de notificaciones (ver teoría 04) — en Android no requiere permiso previo.
  final token = await FirebaseMessaging.instance.getToken();
  return token;
}
```

> 💡 **Diferencia con otros frameworks**: no hay equivalente directo en apps web tradicionales —
> es conceptualmente parecido a una suscripción de Web Push, pero gestionado enteramente por el
> SDK nativo de Firebase, sin que el desarrollador maneje claves VAPID manualmente.

### 2. El token cambia — `onTokenRefresh`

El token no es permanente: cambia si el usuario reinstala la app, limpia los datos, o restaura
un backup en otro dispositivo. Por eso el backend debe escuchar su renovación, no guardarlo una
sola vez:

```dart
FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
  // Enviar newToken a tu backend para reemplazar el token anterior
  // guardado para este usuario.
  debugPrint('Token renovado: $newToken');
});
```

### 3. Topics — enviar a muchos sin conocer sus tokens

Un **topic** es un canal de suscripción. Cualquier dispositivo puede suscribirse, y un mensaje
enviado al topic llega a todos los suscritos — sin que el backend necesite conocer sus tokens
individuales:

```dart
Future<void> subscribeToPromotions() async {
  await FirebaseMessaging.instance.subscribeToTopic('promotions');
}

Future<void> unsubscribeFromPromotions() async {
  await FirebaseMessaging.instance.unsubscribeFromTopic('promotions');
}
```

### 4. Token vs. Topic — cuándo usar cada uno

| Necesitas notificar... | Usa |
|---|---|
| A un usuario específico ("tu pedido #123 fue enviado") | **Token** guardado en tu backend |
| A todos los usuarios de una categoría ("nueva promoción de electrónica") | **Topic** |
| A todos los usuarios de la app | Topic general (ej. `all-users`) |

### 5. Enviar un mensaje de prueba

Sin backend propio, puedes probar FCM directamente desde Firebase Console → **Messaging** →
"Crear tu primera campaña" → pegar el token del dispositivo (o el nombre del topic) como
destino. Es la forma más rápida de verificar que la app recibe mensajes antes de escribir
código de servidor.

### 6. Casos de Uso Móvil

Spotify usa topics para "nuevo episodio de tus podcasts seguidos" (un topic por podcast) y
tokens individuales para "tu descarga offline terminó" (específico del dispositivo que la
inició).

## ⚠️ Errores Comunes

- **Guardar el token una sola vez** sin escuchar `onTokenRefresh`: el backend termina enviando
  mensajes a un token que ya no existe.
- **Confundir topic con "canal de notificación" de Android**: son conceptos distintos — el
  topic es del lado de FCM (servidor), el `NotificationChannel` es una categoría local en el
  dispositivo Android (ver teoría 03).
- **Pedir el token antes de tener permiso en iOS**: devuelve `null` silenciosamente, no lanza
  una excepción — verifica siempre el resultado.

## 📚 Recursos Adicionales

- [FCM — Tokens de registro](https://firebase.google.com/docs/cloud-messaging/manage-tokens)
- [FCM — Topics](https://firebase.google.com/docs/cloud-messaging/flutter/topic-messaging)
- [firebase_messaging — pub.dev](https://pub.dev/packages/firebase_messaging)

## ✅ Checklist de Verificación

Antes de continuar, verifica que entiendes:

- [ ] Qué identifica el FCM token y por qué puede cambiar
- [ ] Cuándo usar un topic en vez de un token
- [ ] Cómo enviar un mensaje de prueba desde Firebase Console
