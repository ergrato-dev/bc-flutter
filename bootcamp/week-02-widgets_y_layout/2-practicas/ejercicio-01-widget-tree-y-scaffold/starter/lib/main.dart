/// Ejercicio 01 — Widget Tree, MaterialApp y Scaffold
/// Qué: practicar MaterialApp/Scaffold, StatelessWidget y StatefulWidget.
/// Para qué: es la estructura mínima de cualquier pantalla Flutter que
/// construirás el resto del bootcamp.
/// Impacto: sin esto, ninguna pantalla de las semanas siguientes tiene base.
library;

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 01: Widget Tree y Scaffold ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 01',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: const Placeholder(), // reemplázalo por HomeScreen() en el PASO 1
    );
  }
}

// ============================================
// PASO 1: MaterialApp + Scaffold
// ============================================
// Descomenta las siguientes líneas y reemplaza el `home:` de arriba por
// `const HomeScreen()`:
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Ejercicio 01')),
//       body: const Center(child: Text('Hola, Flutter')),
//     );
//   }
// }

// ============================================
// PASO 2: Un StatelessWidget propio
// ============================================
// Descomenta las siguientes líneas, y dentro de HomeScreen cambia el `body:`
// por `body: const Center(child: Greeting(name: 'Ada'))`:
//
// class Greeting extends StatelessWidget {
//   const Greeting({super.key, required this.name});
//   final String name;
//
//   @override
//   Widget build(BuildContext context) => Text('Bienvenido, $name');
// }

// ============================================
// PASO 3: Un StatefulWidget con contador
// ============================================
// Descomenta las siguientes líneas, y dentro de HomeScreen cambia el `body:`
// por `body: const Center(child: TapCounter())`:
//
// class TapCounter extends StatefulWidget {
//   const TapCounter({super.key});
//   @override
//   State<TapCounter> createState() => _TapCounterState();
// }
//
// class _TapCounterState extends State<TapCounter> {
//   int _taps = 0;
//
//   void _increment() => setState(() => _taps++);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text('Toques: $_taps'),
//         ElevatedButton(onPressed: _increment, child: const Text('Tocar')),
//       ],
//     );
//   }
// }
