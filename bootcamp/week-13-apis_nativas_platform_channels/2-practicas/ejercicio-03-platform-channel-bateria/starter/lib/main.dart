/// Ejercicio 03 — Platform Channel: Nivel de Batería
/// Qué: practicar el lado Dart de un platform channel — invokeMethod y el
/// manejo de PlatformException/MissingPluginException.
/// Para qué: el lado nativo (android/.../MainActivity.kt) ya está completo
/// y es la referencia exacta del patrón de la teoría 04 — este ejercicio
/// solo requiere código Dart, no Kotlin.
library;

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 03: Platform Channel Nivel de Batería ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 03',
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
  String _status = 'sin consultar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 03')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_status, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            // TODO temporal: en el PASO 2, conecta este botón a
            // `_getBatteryLevel` — ver instrucciones abajo.
            ElevatedButton(
              onPressed: () => debugPrint('obtener nivel de batería'),
              child: const Text('Obtener nivel de batería'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: declarar el MethodChannel
// ============================================
// Agrega esta constante arriba de `class MyApp` (fuera de cualquier clase):
//
// const _batteryChannel = MethodChannel('com.bcflutter.week13/battery');
//
// `MethodChannel`, `PlatformException` y `MissingPluginException` vienen de
// `package:flutter/services.dart` — no necesitas importarlo aparte, porque
// `package:flutter/material.dart` (ya importado arriba) lo re-exporta
// completo.
//
// El nombre debe coincidir EXACTAMENTE con el de MainActivity.kt
// (android/app/src/main/kotlin/.../MainActivity.kt) — ya está completo del
// lado nativo, ver teoría 04.

// ============================================
// PASO 2: invocar el método nativo
// ============================================
// Agrega este método a `_HomeScreenState` y conéctalo al botón:
//
// Future<void> _getBatteryLevel() async {
//   try {
//     final level = await _batteryChannel.invokeMethod<int>('getBatteryLevel');
//     setState(() => _status = 'Batería: $level%');
//   } on PlatformException catch (e) {
//     setState(() => _status = 'Error nativo: ${e.code}');
//   } on MissingPluginException {
//     setState(() => _status = 'Canal sin handler — revisa el nombre del canal');
//   }
// }
//
// ✅ Verifica en un dispositivo/emulador Android real (no en Chrome/desktop
// — este platform channel solo tiene implementación nativa Android en este
// ejercicio, ver teoría 04 sobre por qué iOS queda como referencia).
