# 🔔 Notificaciones en Flutter

## 🎯 Objetivos del Módulo

Al completar este módulo, serás capaz de:

- [ ] Implementar notificaciones locales
- [ ] Configurar push notifications con Firebase
- [ ] Crear canales de notificación (Android)
- [ ] Manejar acciones y deep linking
- [ ] Programar notificaciones para el futuro
- [ ] Personalizar el aspecto de las notificaciones

---

## 📦 Paquetes Principales

```yaml
dependencies:
  # Notificaciones locales
  flutter_local_notifications: ^16.1.0
  
  # Timezone para notificaciones programadas
  timezone: ^0.9.2
  
  # Push Notifications (Firebase)
  firebase_core: ^2.24.2
  firebase_messaging: ^14.7.4
  
  # Permisos
  permission_handler: ^11.1.0
```

---

## 1️⃣ Notificaciones Locales

### Configuración Inicial

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    
    <!-- Permisos para notificaciones -->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.VIBRATE"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    
    <!-- Para notificaciones programadas -->
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
    <uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
    
    <application>
        <!-- Receiver para notificaciones programadas -->
        <receiver
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
            android:exported="false"/>
        
        <receiver
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
            android:exported="false">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON"/>
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </receiver>
    </application>
</manifest>
```

#### iOS (`ios/Runner/AppDelegate.swift`)

```swift
import UIKit
import Flutter
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Configuración para iOS 10+
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

### Servicio de Notificaciones Locales

```dart
/**
 * LocalNotificationService
 * 
 * ¿Qué hace?
 * Servicio singleton para gestionar notificaciones locales.
 * 
 * ¿Para qué?
 * Centralizar la lógica de notificaciones, configuración de canales,
 * y manejo de acciones en un solo lugar.
 * 
 * ¿Cómo funciona?
 * 1. Se inicializa al inicio de la app
 * 2. Configura canales para Android
 * 3. Solicita permisos al usuario
 * 4. Permite mostrar, programar y cancelar notificaciones
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

/// Callback para cuando se toca una notificación
typedef NotificationTapCallback = void Function(String? payload);

class LocalNotificationService {
  // Singleton
  static final LocalNotificationService _instance = LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();
  
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  
  // Callback cuando se toca una notificación
  NotificationTapCallback? _onNotificationTap;
  
  // Stream controller para notificaciones recibidas
  final StreamController<String?> _notificationStream = StreamController.broadcast();
  Stream<String?> get notificationStream => _notificationStream.stream;
  
  /// Inicializa el servicio de notificaciones
  /// 
  /// Debe llamarse al inicio de la app (en main.dart)
  Future<void> initialize({
    NotificationTapCallback? onNotificationTap,
  }) async {
    _onNotificationTap = onNotificationTap;
    
    // Inicializar timezone
    tz.initializeTimeZones();
    
    // Configuración para Android
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // Configuración para iOS
    final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    
    final settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationResponse,
    );
    
    // Crear canales de notificación para Android
    await _createNotificationChannels();
    
    // Verificar si la app se abrió desde una notificación
    await _checkLaunchNotification();
  }
  
  /// Crea los canales de notificación para Android
  Future<void> _createNotificationChannels() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidPlugin == null) return;
    
    // Canal general
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'general',
        'General',
        description: 'Notificaciones generales de la app',
        importance: Importance.defaultImportance,
      ),
    );
    
    // Canal de alta prioridad
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'high_priority',
        'Alta Prioridad',
        description: 'Notificaciones importantes',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ),
    );
    
    // Canal silencioso
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'silent',
        'Silencioso',
        description: 'Notificaciones sin sonido',
        importance: Importance.low,
        playSound: false,
        enableVibration: false,
      ),
    );
    
    // Canal de recordatorios
    await androidPlugin.createNotificationChannel(
      const AndroidNotificationChannel(
        'reminders',
        'Recordatorios',
        description: 'Recordatorios y tareas programadas',
        importance: Importance.high,
        playSound: true,
      ),
    );
  }
  
  /// Solicita permisos de notificación
  Future<bool> requestPermission() async {
    // Android 13+
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }
    
    // iOS
    final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    
    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    
    return true;
  }
  
  /// Muestra una notificación inmediata
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String channelId = 'general',
    NotificationImportance importance = NotificationImportance.normal,
    bool playSound = true,
    bool enableVibration = true,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelId,
      importance: _mapImportance(importance),
      priority: _mapPriority(importance),
      playSound: playSound,
      enableVibration: enableVibration,
      icon: '@mipmap/ic_launcher',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _plugin.show(id, title, body, details, payload: payload);
  }
  
  /// Muestra una notificación con estilo expandido (solo Android)
  Future<void> showBigTextNotification({
    required int id,
    required String title,
    required String body,
    required String bigText,
    String? payload,
    String channelId = 'general',
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelId,
      importance: Importance.defaultImportance,
      styleInformation: BigTextStyleInformation(
        bigText,
        contentTitle: title,
        summaryText: 'Más información',
      ),
    );
    
    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );
    
    await _plugin.show(id, title, body, details, payload: payload);
  }
  
  /// Muestra una notificación con imagen (solo Android)
  Future<void> showImageNotification({
    required int id,
    required String title,
    required String body,
    required String imageUrl,
    String? payload,
    String channelId = 'general',
  }) async {
    final bigPictureStyle = BigPictureStyleInformation(
      FilePathAndroidBitmap(imageUrl),
      contentTitle: title,
      summaryText: body,
    );
    
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelId,
      importance: Importance.defaultImportance,
      styleInformation: bigPictureStyle,
    );
    
    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );
    
    await _plugin.show(id, title, body, details, payload: payload);
  }
  
  /// Programa una notificación para una fecha/hora específica
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    String channelId = 'reminders',
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelId,
      importance: Importance.high,
      priority: Priority.high,
    );
    
    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );
    
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }
  
  /// Programa una notificación periódica
  Future<void> schedulePeriodicNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval interval,
    String? payload,
    String channelId = 'reminders',
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelId,
      importance: Importance.defaultImportance,
    );
    
    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );
    
    await _plugin.periodicallyShow(
      id,
      title,
      body,
      interval,
      details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
  
  /// Cancela una notificación específica
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }
  
  /// Cancela todas las notificaciones
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }
  
  /// Obtiene las notificaciones pendientes
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests();
  }
  
  /// Obtiene las notificaciones activas (en la bandeja)
  Future<List<ActiveNotification>> getActiveNotifications() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidPlugin != null) {
      return await androidPlugin.getActiveNotifications();
    }
    
    return [];
  }
  
  // =============== CALLBACKS PRIVADOS ===============
  
  /// Callback cuando se toca una notificación
  void _onNotificationResponse(NotificationResponse response) {
    _notificationStream.add(response.payload);
    _onNotificationTap?.call(response.payload);
  }
  
  /// Callback para notificaciones en background
  @pragma('vm:entry-point')
  static void _onBackgroundNotificationResponse(NotificationResponse response) {
    // Manejar en background si es necesario
    print('Notificación en background: ${response.payload}');
  }
  
  /// Callback para iOS < 10
  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    _notificationStream.add(payload);
  }
  
  /// Verifica si la app se abrió desde una notificación
  Future<void> _checkLaunchNotification() async {
    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      final payload = launchDetails!.notificationResponse?.payload;
      _onNotificationTap?.call(payload);
    }
  }
  
  // =============== HELPERS ===============
  
  Importance _mapImportance(NotificationImportance importance) {
    switch (importance) {
      case NotificationImportance.low:
        return Importance.low;
      case NotificationImportance.normal:
        return Importance.defaultImportance;
      case NotificationImportance.high:
        return Importance.high;
      case NotificationImportance.urgent:
        return Importance.max;
    }
  }
  
  Priority _mapPriority(NotificationImportance importance) {
    switch (importance) {
      case NotificationImportance.low:
        return Priority.low;
      case NotificationImportance.normal:
        return Priority.defaultPriority;
      case NotificationImportance.high:
        return Priority.high;
      case NotificationImportance.urgent:
        return Priority.max;
    }
  }
  
  void dispose() {
    _notificationStream.close();
  }
}

/// Niveles de importancia de notificación
enum NotificationImportance {
  low,
  normal,
  high,
  urgent,
}
```

---

### Ejemplo de Uso

```dart
/**
 * Ejemplo de uso del servicio de notificaciones locales
 */

import 'package:flutter/material.dart';

class NotificationDemoScreen extends StatefulWidget {
  const NotificationDemoScreen({Key? key}) : super(key: key);
  
  @override
  State<NotificationDemoScreen> createState() => _NotificationDemoScreenState();
}

class _NotificationDemoScreenState extends State<NotificationDemoScreen> {
  final _notificationService = LocalNotificationService();
  int _notificationId = 0;
  
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }
  
  Future<void> _initializeNotifications() async {
    await _notificationService.initialize(
      onNotificationTap: (payload) {
        // Manejar tap en notificación
        if (payload != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payload: $payload')),
          );
        }
      },
    );
    
    // Solicitar permisos
    await _notificationService.requestPermission();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Notificación simple
          _buildButton(
            'Notificación Simple',
            Icons.notifications,
            () async {
              await _notificationService.showNotification(
                id: _notificationId++,
                title: 'Hola Flutter!',
                body: 'Esta es una notificación simple',
                payload: 'simple_notification',
              );
            },
          ),
          
          // Notificación de alta prioridad
          _buildButton(
            'Alta Prioridad',
            Icons.priority_high,
            () async {
              await _notificationService.showNotification(
                id: _notificationId++,
                title: '¡Urgente!',
                body: 'Esta notificación es importante',
                channelId: 'high_priority',
                importance: NotificationImportance.high,
              );
            },
          ),
          
          // Notificación expandida
          _buildButton(
            'Texto Expandido',
            Icons.expand,
            () async {
              await _notificationService.showBigTextNotification(
                id: _notificationId++,
                title: 'Artículo Nuevo',
                body: 'Toca para leer más...',
                bigText: 'Este es un texto mucho más largo que se expande '
                    'cuando el usuario desliza la notificación hacia abajo. '
                    'Puedes incluir mucha más información aquí para dar '
                    'contexto adicional al usuario sobre el contenido.',
              );
            },
          ),
          
          // Notificación programada
          _buildButton(
            'Programar (10 seg)',
            Icons.schedule,
            () async {
              final scheduledDate = DateTime.now().add(
                const Duration(seconds: 10),
              );
              
              await _notificationService.scheduleNotification(
                id: _notificationId++,
                title: 'Notificación Programada',
                body: 'Han pasado 10 segundos!',
                scheduledDate: scheduledDate,
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notificación programada para 10 segundos'),
                ),
              );
            },
          ),
          
          // Cancelar todas
          _buildButton(
            'Cancelar Todas',
            Icons.clear_all,
            () async {
              await _notificationService.cancelAllNotifications();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificaciones canceladas')),
              );
            },
          ),
          
          // Ver pendientes
          _buildButton(
            'Ver Pendientes',
            Icons.list,
            () async {
              final pending = await _notificationService.getPendingNotifications();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Notificaciones Pendientes'),
                  content: Text('Total: ${pending.length}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildButton(String label, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
```

---

## 2️⃣ Push Notifications con Firebase

### Configuración de Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Crea un proyecto o selecciona uno existente
3. Agrega tu app Android/iOS
4. Descarga los archivos de configuración:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`

### Android (`android/app/build.gradle`)

```gradle
plugins {
    id 'com.android.application'
    id 'kotlin-android'
    id 'com.google.gms.google-services' // Agregar
}

dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
}
```

### Android (`android/build.gradle`)

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

---

### Servicio de Push Notifications

```dart
/**
 * PushNotificationService
 * 
 * Servicio para manejar push notifications con Firebase Cloud Messaging.
 * 
 * Tipos de mensajes FCM:
 * 1. Notification message: Mostrado automáticamente por el sistema
 * 2. Data message: Manejado por la app (más control)
 * 3. Híbrido: Ambos tipos combinados
 */

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Handler para mensajes en background (debe ser top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message: ${message.messageId}');
  
  // Mostrar notificación local si es data message
  if (message.notification == null) {
    // Es un data message, mostramos manualmente
    await PushNotificationService._showNotificationFromData(message.data);
  }
}

class PushNotificationService {
  // Singleton
  static final PushNotificationService _instance = PushNotificationService._internal();
  factory PushNotificationService() => _instance;
  PushNotificationService._internal();
  
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();
  
  // Stream para mensajes recibidos
  final StreamController<RemoteMessage> _messageStream = 
      StreamController.broadcast();
  Stream<RemoteMessage> get messageStream => _messageStream.stream;
  
  // Token del dispositivo
  String? _token;
  String? get token => _token;
  
  /// Inicializa el servicio de push notifications
  Future<void> initialize() async {
    // Configurar handler para background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Solicitar permisos
    await _requestPermission();
    
    // Obtener y guardar token
    await _getToken();
    
    // Configurar notificaciones locales
    await _setupLocalNotifications();
    
    // Escuchar mensajes en foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Escuchar cuando se abre la app desde una notificación
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    
    // Verificar si la app se abrió desde una notificación
    await _checkInitialMessage();
    
    // Escuchar cambios de token
    _messaging.onTokenRefresh.listen(_onTokenRefresh);
  }
  
  /// Solicita permisos de notificación
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    
    print('Permission status: ${settings.authorizationStatus}');
  }
  
  /// Obtiene el token del dispositivo
  Future<void> _getToken() async {
    _token = await _messaging.getToken();
    print('FCM Token: $_token');
    
    // TODO: Enviar token a tu backend para asociarlo con el usuario
    // await _sendTokenToServer(_token);
  }
  
  /// Callback cuando el token se actualiza
  void _onTokenRefresh(String newToken) {
    _token = newToken;
    print('New FCM Token: $newToken');
    
    // TODO: Actualizar token en el backend
    // await _sendTokenToServer(newToken);
  }
  
  /// Configura las notificaciones locales para mostrar push en foreground
  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _localNotifications.initialize(settings);
    
    // Crear canal para push notifications
    final androidPlugin = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'push_notifications',
        'Push Notifications',
        description: 'Notificaciones push de la app',
        importance: Importance.high,
      ),
    );
  }
  
  /// Maneja mensajes en foreground
  void _handleForegroundMessage(RemoteMessage message) {
    print('Foreground message: ${message.messageId}');
    _messageStream.add(message);
    
    // Si tiene notification, mostrarla localmente
    final notification = message.notification;
    if (notification != null) {
      _showLocalNotification(
        title: notification.title ?? '',
        body: notification.body ?? '',
        payload: message.data.toString(),
      );
    }
  }
  
  /// Maneja cuando se abre la app desde una notificación
  void _handleMessageOpenedApp(RemoteMessage message) {
    print('Message opened app: ${message.messageId}');
    _messageStream.add(message);
    
    // TODO: Navegar a la pantalla correspondiente según message.data
    // _handleNavigation(message.data);
  }
  
  /// Verifica si la app se abrió desde una notificación
  Future<void> _checkInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    
    if (message != null) {
      print('Initial message: ${message.messageId}');
      _messageStream.add(message);
      
      // TODO: Navegar a la pantalla correspondiente
    }
  }
  
  /// Muestra una notificación local
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'push_notifications',
      'Push Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }
  
  /// Muestra notificación desde data message (static para background)
  static Future<void> _showNotificationFromData(Map<String, dynamic> data) async {
    final title = data['title'] ?? 'Notificación';
    final body = data['body'] ?? '';
    
    final plugin = FlutterLocalNotificationsPlugin();
    
    const androidDetails = AndroidNotificationDetails(
      'push_notifications',
      'Push Notifications',
      importance: Importance.high,
    );
    
    const details = NotificationDetails(android: androidDetails);
    
    await plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }
  
  /// Suscribe a un topic
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }
  
  /// Desuscribe de un topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }
  
  /// Elimina el token (logout)
  Future<void> deleteToken() async {
    await _messaging.deleteToken();
    _token = null;
  }
  
  void dispose() {
    _messageStream.close();
  }
}
```

---

### Integración en main.dart

```dart
/**
 * main.dart - Configuración de Firebase y notificaciones
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase
  await Firebase.initializeApp();
  
  // Inicializar servicios de notificaciones
  await LocalNotificationService().initialize(
    onNotificationTap: (payload) {
      // Manejar navegación según payload
      print('Local notification tapped: $payload');
    },
  );
  
  await PushNotificationService().initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    
    // Escuchar push notifications
    PushNotificationService().messageStream.listen((message) {
      // Manejar mensaje recibido
      print('Message received: ${message.notification?.title}');
      
      // Puedes mostrar un diálogo, snackbar, o navegar
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications Demo',
      home: const HomeScreen(),
    );
  }
}
```

---

## 3️⃣ Acciones en Notificaciones

```dart
/**
 * Notificaciones con acciones (botones)
 */

/// Muestra una notificación con acciones
Future<void> showNotificationWithActions({
  required int id,
  required String title,
  required String body,
}) async {
  final plugin = FlutterLocalNotificationsPlugin();
  
  // Definir acciones
  const action1 = AndroidNotificationAction(
    'action_reply',
    'Responder',
    icon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    showsUserInterface: true,
  );
  
  const action2 = AndroidNotificationAction(
    'action_archive',
    'Archivar',
    icon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
  );
  
  const action3 = AndroidNotificationAction(
    'action_delete',
    'Eliminar',
    cancelNotification: true, // Cierra la notificación al tocar
  );
  
  final androidDetails = AndroidNotificationDetails(
    'general',
    'General',
    importance: Importance.high,
    actions: [action1, action2, action3],
  );
  
  final details = NotificationDetails(android: androidDetails);
  
  await plugin.show(id, title, body, details);
}

/// Maneja las acciones de notificación
void handleNotificationAction(NotificationResponse response) {
  switch (response.actionId) {
    case 'action_reply':
      // Abrir pantalla de respuesta
      print('Usuario quiere responder');
      break;
    case 'action_archive':
      // Archivar el elemento
      print('Usuario archivó');
      break;
    case 'action_delete':
      // Eliminar el elemento
      print('Usuario eliminó');
      break;
    default:
      // Tap en la notificación (no en acción)
      print('Notification tapped');
  }
}
```

---

## 📝 Resumen

| Tipo | Uso | Paquete |
|------|-----|---------|
| **Local** | Recordatorios, tareas, sin servidor | flutter_local_notifications |
| **Push** | Mensajes del servidor, marketing | firebase_messaging |
| **Programadas** | Alarmas, eventos futuros | flutter_local_notifications + timezone |
| **Con acciones** | Respuestas rápidas | flutter_local_notifications |

### Checklist de Implementación

- [ ] Configurar permisos en AndroidManifest.xml
- [ ] Configurar Info.plist para iOS
- [ ] Crear canales de notificación (Android)
- [ ] Solicitar permisos al usuario
- [ ] Manejar tap en notificaciones
- [ ] Configurar Firebase para push
- [ ] Manejar mensajes en foreground y background
- [ ] Implementar navegación desde notificaciones

---

## 🔗 Navegación

| Anterior | Índice | Siguiente |
|----------|--------|-----------|
| [Geolocalización](./02-geolocalizacion-mapas.md) | [Semana 8](../README.md) | [Prácticas](../2-practicas/) |
