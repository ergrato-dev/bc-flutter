/// Ejercicio 02 — Notificación Local en Foreground
/// Qué: mostrar una notificación local cuando llega un mensaje FCM con la
/// app abierta.
/// Para qué: FCM no muestra nada por sí solo en foreground — a diferencia
/// de background/terminated, donde el sistema operativo sí lo hace.
library;

import 'package:flutter/material.dart';
// Descomenta estos imports en el PASO 1, después de correr `flutterfire
// configure` (ver README) — firebase_options.dart no existe hasta entonces.
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'firebase_options.dart';

// TODO temporal: en el PASO 2, declara aquí (fuera de cualquier clase) la
// instancia `FlutterLocalNotificationsPlugin` — ver instrucciones al final
// del archivo.

Future<void> main() async {
  // TODO temporal: en el PASO 1, agrega WidgetsFlutterBinding.ensureInitialized()
  // y Firebase.initializeApp(...) — ver instrucciones al final del archivo.
  debugPrint('--- Ejercicio 02: Notificación Local en Foreground ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 02',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // TODO temporal: en el PASO 3, agrega aquí la suscripción a
    // `FirebaseMessaging.onMessage` — ver instrucciones al final del archivo.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'App en foreground.\nEnvía un mensaje de prueba desde\nFirebase Console para verla aquí.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: inicializar Firebase
// ============================================
// Después de correr `flutterfire configure` (ver README), reemplaza main()
// por esto (y descomenta los imports de arriba):
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

// ============================================
// PASO 2: crear el canal de notificaciones (Android)
// ============================================
// Agrega esto arriba de `main()` (fuera de cualquier clase):
//
// final _localNotifications = FlutterLocalNotificationsPlugin();
//
// const _channel = AndroidNotificationChannel(
//   'high_importance_channel',
//   'Notificaciones importantes',
//   importance: Importance.max,
// );
//
// Future<void> _createNotificationChannel() async {
//   await _localNotifications
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(_channel);
// }
//
// Y agrega `await _createNotificationChannel();` dentro de `main()`, después
// de `Firebase.initializeApp(...)`.

// ============================================
// PASO 3: escuchar onMessage y mostrar la notificación
// ============================================
// Agrega esto dentro de `initState()` de `_HomeScreenState`:
//
// FirebaseMessaging.onMessage.listen((message) {
//   final notification = message.notification;
//   if (notification == null) return;
//
//   _localNotifications.show(
//     notification.hashCode,
//     notification.title,
//     notification.body,
//     const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'high_importance_channel',
//         'Notificaciones importantes',
//       ),
//     ),
//   );
// });
//
// ✅ Verifica en un dispositivo/emulador real: con la app abierta, envía un
// mensaje de prueba desde Firebase Console — debe aparecer en la barra de
// estado, aunque la app siga en foreground.
