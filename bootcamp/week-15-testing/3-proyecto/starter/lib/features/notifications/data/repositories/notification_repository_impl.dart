import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/repositories/notification_repository.dart';

// ============================================
// REPOSITORY: NotificationRepositoryImpl
// Implementación real que envuelve FirebaseMessaging y
// flutter_local_notifications — mismo patrón de PhotoPickerField (semana
// 13): la app solo conoce la interfaz, esta clase es la única que importa
// los paquetes nativos.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo (semana 14) — no necesitas modificarlo. Tu
// trabajo esta semana es escribir tests que lo simulen detrás de la
// interfaz `NotificationRepository` (ver teoría 02 sobre mocktail).
class NotificationRepositoryImpl implements NotificationRepository {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final _routeController = StreamController<String>.broadcast();

  static const _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Notificaciones importantes',
    importance: Importance.max,
  );

  @override
  Stream<String> get onNotificationRoute => _routeController.stream;

  /// Lee `data['itemId']` cuando `data['type'] == 'item_detail'` — misma
  /// convención de payload usada en el ejercicio 03 de semana 14.
  String? _routeFromMessage(RemoteMessage? message) {
    if (message == null) return null;
    final itemId = message.data['itemId'];
    if (message.data['type'] == 'item_detail' && itemId != null) {
      return '/items/$itemId';
    }
    return null;
  }

  @override
  Future<bool> ensurePermission() async {
    final settings = await _messaging.requestPermission();
    final iosOk = settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    if (!Platform.isAndroid) return iosOk;

    var status = await Permission.notification.status;
    if (status.isDenied) {
      status = await Permission.notification.request();
    }
    return status.isGranted;
  }

  @override
  Future<void> initialize() async {
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(_channel.id, _channel.name),
        ),
      );
    });

    // Background → foreground: el usuario tocó la notificación con la app
    // ya viva en memoria.
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final route = _routeFromMessage(message);
      if (route != null) _routeController.add(route);
    });

    // Terminated → foreground: se consulta UNA VEZ, la app se abrió por
    // este mensaje.
    final initialMessage = await _messaging.getInitialMessage();
    final initialRoute = _routeFromMessage(initialMessage);
    if (initialRoute != null) _routeController.add(initialRoute);
  }
}
