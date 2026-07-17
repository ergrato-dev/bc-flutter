/// Ejercicio 01 — permission_handler: Permiso de Cámara
/// Qué: practicar el ciclo completo de un permiso — verificar, solicitar,
/// y manejar la denegación permanente con openAppSettings().
/// Para qué: es el mismo patrón que usarás para pedir la foto de tu
/// dominio en el proyecto de esta semana.
library;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  debugPrint('--- Ejercicio 01: permission_handler Permiso de Cámara ---');
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
  PermissionStatus? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Estado: ${_status?.toString() ?? 'sin verificar'}'),
            const SizedBox(height: 24),
            // TODO temporal: en el PASO 1, conecta este botón a
            // `_checkStatus` — ver instrucciones abajo.
            ElevatedButton(
              onPressed: () => debugPrint('verificar estado'),
              child: const Text('Verificar estado'),
            ),
            const SizedBox(height: 12),
            // TODO temporal: en el PASO 3, reemplaza este botón fijo por
            // el resultado de `_buildActions()` — ver instrucciones abajo.
            ElevatedButton(
              onPressed: () => debugPrint('solicitar permiso'),
              child: const Text('Solicitar permiso'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: verificar el estado sin pedirlo
// ============================================
// Agrega este método a `_HomeScreenState` y conéctalo al botón
// "Verificar estado":
//
// Future<void> _checkStatus() async {
//   final status = await Permission.camera.status;
//   setState(() => _status = status);
// }

// ============================================
// PASO 2: solicitar el permiso
// ============================================
// Agrega este método y conéctalo al botón "Solicitar permiso":
//
// Future<void> _requestPermission() async {
//   final status = await Permission.camera.request();
//   setState(() => _status = status);
// }

// ============================================
// PASO 3: manejar permanentlyDenied con openAppSettings
// ============================================
// Agrega este método:
//
// Widget _buildActions() {
//   if (_status?.isPermanentlyDenied ?? false) {
//     return ElevatedButton(
//       onPressed: () => openAppSettings(),
//       child: const Text('Abrir Ajustes'),
//     );
//   }
//   return ElevatedButton(onPressed: _requestPermission, child: const Text('Solicitar permiso'));
// }
//
// Y reemplaza el segundo `ElevatedButton` fijo de `build()` por
// `_buildActions()`.
