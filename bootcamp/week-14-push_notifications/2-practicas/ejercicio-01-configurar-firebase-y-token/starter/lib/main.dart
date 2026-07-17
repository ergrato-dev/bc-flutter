/// Ejercicio 01 — Configurar Firebase y Obtener el Token
/// Qué: inicializar Firebase Cloud Messaging en un proyecto propio y obtener
/// el FCM token del dispositivo.
/// Para qué: es el primer paso de cualquier feature de push notifications —
/// sin este token, un backend no tiene a quién enviarle un mensaje.
library;

import 'package:flutter/material.dart';
// Descomenta estos imports en el PASO 1, después de correr `flutterfire
// configure` (ver README) — firebase_options.dart no existe hasta entonces.
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  // TODO temporal: en el PASO 1, agrega WidgetsFlutterBinding.ensureInitialized()
  // y Firebase.initializeApp(...) — ver instrucciones al final del archivo.
  debugPrint('--- Ejercicio 01: Configurar Firebase y Obtener el Token ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 01',
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
  // ignore: prefer_final_fields — se reasigna con setState al completar el PASO 2.
  String _token = 'sin consultar';

  // TODO temporal: en el PASO 2, agrega el método `_getToken` — ver
  // instrucciones al final del archivo.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(_token, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              // TODO temporal: en el PASO 2, reemplaza este onPressed por
              // `_getToken` — ver instrucciones abajo.
              ElevatedButton(
                onPressed: () => debugPrint('obtener token'),
                child: const Text('Obtener token'),
              ),
            ],
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
// PASO 2: obtener el FCM token
// ============================================
// Agrega este método a `_HomeScreenState` y conéctalo al botón:
//
// Future<void> _getToken() async {
//   final token = await FirebaseMessaging.instance.getToken();
//   setState(() => _token = token ?? 'sin token (¿permiso concedido en iOS?)');
// }
//
// onPressed: _getToken,
//
// ✅ Verifica en un dispositivo/emulador real: el token (una cadena larga)
// debe aparecer en pantalla. Cópialo para el Paso 3 del README (mensaje de
// prueba desde Firebase Console).
