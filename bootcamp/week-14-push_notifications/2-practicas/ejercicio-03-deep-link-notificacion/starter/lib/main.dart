/// Ejercicio 03 — Deep Link al Tocar la Notificación
/// Qué: navegar a una pantalla específica leyendo el `data` payload de un
/// mensaje FCM, cubriendo background (onMessageOpenedApp) y terminated
/// (getInitialMessage).
/// Para qué: el deep linking real siempre lee `data`, nunca el texto visible
/// de la notificación — ver teoría 05.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Descomenta estos imports en el PASO 1, después de correr `flutterfire
// configure` (ver README) — firebase_options.dart no existe hasta entonces.
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'firebase_options.dart';

// TODO temporal: en el PASO 2, agrega aquí (fuera de cualquier clase) la
// función `routeFromMessage` que lee el data payload — ver instrucciones al
// final del archivo.

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/items/:id',
      builder: (context, state) => DetailScreen(itemId: state.pathParameters['id']!),
    ),
  ],
);

Future<void> main() async {
  // TODO temporal: en el PASO 1, agrega WidgetsFlutterBinding.ensureInitialized()
  // y Firebase.initializeApp(...) — ver instrucciones al final del archivo.
  debugPrint('--- Ejercicio 03: Deep Link al Tocar la Notificación ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ejercicio 03',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      routerConfig: router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 03')),
      body: Center(
        child: ElevatedButton(
          // TODO temporal: en el PASO 2, reemplaza este onPressed para
          // construir un RemoteMessage de prueba y navegar con
          // routeFromMessage — ver instrucciones al final del archivo.
          onPressed: () => debugPrint('simular notificación'),
          child: const Text('Simular notificación'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: Center(child: Text('Elemento #$itemId')),
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
// PASO 2: leer el data payload
// ============================================
// Agrega esta función arriba de `router` (fuera de cualquier clase):
//
// String? routeFromMessage(RemoteMessage? message) {
//   if (message == null) return null;
//   final itemId = message.data['itemId'];
//   if (message.data['type'] == 'item_detail' && itemId != null) {
//     return '/items/$itemId';
//   }
//   return null;
// }
//
// Y reemplaza el onPressed del botón "Simular notificación" en HomeScreen:
//
// onPressed: () {
//   final route = routeFromMessage(
//     RemoteMessage(data: {'type': 'item_detail', 'itemId': '42'}),
//   );
//   if (route != null) router.push(route);
// },

// ============================================
// PASO 3: conectar onMessageOpenedApp y getInitialMessage
// ============================================
// Reemplaza `main()` completo por esto (mantiene el PASO 1 ya hecho):
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//   // Terminated → foreground: se resuelve UNA VEZ, antes de montar el router.
//   final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//   final initialRoute = routeFromMessage(initialMessage);
//   if (initialRoute != null) {
//     router.go(initialRoute);
//   }
//
//   // Background → foreground: el usuario ya está viendo la app, el router
//   // ya existe, basta con push().
//   FirebaseMessaging.onMessageOpenedApp.listen((message) {
//     final route = routeFromMessage(message);
//     if (route != null) router.push(route);
//   });
//
//   runApp(const MyApp());
// }
//
// ✅ Verifica: el botón "Simular notificación" navega a `/items/42` mostrando
// "Elemento #42" — el mismo camino que seguiría un toque real, sin necesitar
// backend para probarlo.
