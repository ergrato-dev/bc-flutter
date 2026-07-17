# Buenas Prácticas: Testing y Seguridad

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué envolver `FirebaseMessaging` en un repository lo hace testeable
- Cómo simular mensajes entrantes en un test con `mocktail`
- Por qué el envío de notificaciones nunca debe iniciarse desde el cliente
- Otras buenas prácticas de UX y batería

## 📋 Conceptos Clave

### 1. `FirebaseMessaging.instance` no se puede instanciar en tests

Igual que con `geolocator` o `image_picker` (semana 13), `FirebaseMessaging` depende de
plugins nativos — no está disponible en el entorno de test de `flutter_test`. La solución es la
misma: una interfaz de repository que el resto de la app consume, y una implementación real que
envuelve el SDK.

```dart
// domain/repositories/notification_repository.dart
abstract class NotificationRepository {
  Future<String?> getToken();
  Stream<RemoteMessage> get onForegroundMessage;
  Future<RemoteMessage?> getInitialMessage();
}
```

```dart
// data/repositories/notification_repository_impl.dart
class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<String?> getToken() => FirebaseMessaging.instance.getToken();

  @override
  Stream<RemoteMessage> get onForegroundMessage => FirebaseMessaging.onMessage;

  @override
  Future<RemoteMessage?> getInitialMessage() =>
      FirebaseMessaging.instance.getInitialMessage();
}
```

### 2. Testear con `mocktail`

Con la interfaz, el resto de la app (cubits, widgets) depende de `NotificationRepository`, no
de Firebase — se puede simular sin tocar ningún plugin nativo:

```dart
class MockNotificationRepository extends Mock implements NotificationRepository {}

void main() {
  test('emite un evento cuando llega un mensaje en foreground', () {
    final repository = MockNotificationRepository();
    final controller = StreamController<RemoteMessage>();
    when(() => repository.onForegroundMessage).thenAnswer((_) => controller.stream);

    // ...suscribir el cubit bajo prueba y verificar su reacción...

    controller.close();
  });
}
```

### 3. El server key nunca viaja al cliente

FCM permite enviar mensajes vía HTTP con una **credencial de servidor** (Server Key / cuenta de
servicio). Esa credencial da control total para enviar notificaciones a cualquier dispositivo
del proyecto — si se incluye en el código de la app (o en un repositorio público), cualquiera
puede extraerla y enviar spam a todos tus usuarios.

> ⚠️ El envío de notificaciones **siempre** ocurre desde un backend propio o desde Cloud
> Functions — nunca desde la app Flutter. La app solo **recibe** mensajes, nunca los envía.

### 4. UX: no abusar de las notificaciones

- Pedir el permiso con contexto (ver teoría 04), no en el primer frame
- Agrupar notificaciones relacionadas en un mismo `NotificationChannel` (Android) para que el
  usuario pueda silenciarlas selectivamente sin perder las demás
- Dar siempre una opción dentro de la app para desactivar categorías específicas
  (`unsubscribeFromTopic`), no solo a nivel de sistema operativo

### 5. Batería y `onBackgroundMessage`

El background handler (teoría 03) corre en un isolate que el sistema operativo puede matar en
cualquier momento tras completarlo — no uses esa función para trabajo largo (llamadas de red
lentas, escritura pesada a disco). Mantenla corta y enfocada en actualizar estado local o
loguear.

## ⚠️ Errores Comunes

- **Escribir tests que inicializan Firebase de verdad**: fallan en CI porque no hay
  `google-services.json` real — siempre mockear detrás de la interfaz del repository.
- **Incluir una API key de servidor en el repositorio**, aunque sea "solo para pruebas" — los
  repositorios públicos son rastreados por bots que buscan credenciales filtradas.
- **Suscribir a demasiados topics por defecto**: aumenta el ruido y la tasa de desinstalación —
  el usuario debe optar explícitamente por cada categoría.

## 📚 Recursos Adicionales

- [FCM — Guía de arquitectura de servidor](https://firebase.google.com/docs/cloud-messaging/server)
- [mocktail — pub.dev](https://pub.dev/packages/mocktail)
- [OWASP — Mobile Top 10, M10: seguridad de credenciales](https://owasp.org/www-project-mobile-top-10/)

## ✅ Checklist de Verificación

Antes de pasar a las prácticas, verifica que entiendes:

- [ ] Por qué `NotificationRepository` hace testeable el código que usa FCM
- [ ] Por qué el server key nunca debe estar en el cliente
- [ ] Qué limitaciones tiene el background handler en cuanto a batería y tiempo
