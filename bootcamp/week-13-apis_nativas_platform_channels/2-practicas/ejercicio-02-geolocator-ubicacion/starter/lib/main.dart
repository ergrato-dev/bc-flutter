/// Ejercicio 02 — geolocator: Ubicación Actual
/// Qué: practicar el patrón check → request → actuar con la API propia de
/// permisos de geolocator (LocationPermission, distinta a PermissionStatus
/// de permission_handler), y obtener la posición actual del dispositivo.
/// Para qué: el mismo patrón general del ejercicio 01, aplicado a un
/// plugin distinto.
library;

import 'package:flutter/material.dart';
// ignore: unused_import — se usa al descomentar los PASOS 1-3 (Geolocator, LocationPermission).
import 'package:geolocator/geolocator.dart';

void main() {
  debugPrint('--- Ejercicio 02: geolocator Ubicación Actual ---');
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
  String _status = 'sin consultar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_status),
            const SizedBox(height: 24),
            // TODO temporal: en el PASO 3, conecta este botón a
            // `_getLocation` — ver instrucciones abajo.
            ElevatedButton(
              onPressed: () => debugPrint('obtener ubicación'),
              child: const Text('Obtener ubicación'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: permiso de ubicación (API propia de geolocator)
// ============================================
// Agrega este método a `_HomeScreenState`:
//
// Future<bool> _ensurePermission() async {
//   var permission = await Geolocator.checkPermission();
//
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     return false;
//   }
//
//   return permission == LocationPermission.always ||
//       permission == LocationPermission.whileInUse;
// }

// ============================================
// PASO 2: verificar que el servicio de ubicación esté activo
// ============================================
// Agrega este método:
//
// Future<bool> _ensureServiceEnabled() async {
//   final enabled = await Geolocator.isLocationServiceEnabled();
//   if (!enabled) {
//     setState(() => _status = 'Activa la ubicación del dispositivo');
//   }
//   return enabled;
// }

// ============================================
// PASO 3: obtener la posición actual
// ============================================
// Agrega este método y conéctalo al botón "Obtener ubicación":
//
// Future<void> _getLocation() async {
//   if (!await _ensurePermission()) {
//     setState(() => _status = 'Permiso de ubicación denegado');
//     return;
//   }
//   if (!await _ensureServiceEnabled()) return;
//
//   final position = await Geolocator.getCurrentPosition(
//     locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
//   );
//   setState(() => _status = 'lat: ${position.latitude}, lng: ${position.longitude}');
// }
