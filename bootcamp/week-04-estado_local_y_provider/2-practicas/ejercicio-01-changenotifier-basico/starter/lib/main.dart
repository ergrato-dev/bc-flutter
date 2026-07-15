/// Ejercicio 01 — ChangeNotifier Básico
/// Qué: practicar ChangeNotifier, ChangeNotifierProvider y Consumer.
/// Para qué: es la unidad mínima de estado compartido que usarás en el
/// proyecto de esta semana y en el resto del bootcamp (Riverpod y Bloc
/// reutilizan el mismo modelo mental).
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  debugPrint('--- Ejercicio 01: ChangeNotifier Básico ---');
  // TODO temporal: en el PASO 2 envuelve MyApp con ChangeNotifierProvider
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      // TODO temporal: en el PASO 3 reemplaza este Placeholder por el Consumer
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: El ChangeNotifier
// ============================================
// Descomenta las siguientes líneas:
// class CounterNotifier extends ChangeNotifier {
//   int _count = 0;
//   int get count => _count;
//
//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }

// ============================================
// PASO 2: ChangeNotifierProvider en la raíz
// ============================================
// Descomenta las siguientes líneas y reemplaza `runApp(const MyApp());` en
// main() por `runApp(ChangeNotifierProvider(create: (context) => CounterNotifier(), child: const MyApp()));`
//
// (no hay código adicional que descomentar aquí — el cambio es en main())

// ============================================
// PASO 3: Consumer para mostrar y modificar el contador
// ============================================
// Descomenta las siguientes líneas y reemplaza el `body:` de HomeScreen por
// `body: const Center(child: CounterView())`:
//
// class CounterView extends StatelessWidget {
//   const CounterView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CounterNotifier>(
//       builder: (context, notifier, child) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('${notifier.count}', style: const TextStyle(fontSize: 32)),
//             ElevatedButton(onPressed: notifier.increment, child: const Text('Sumar')),
//           ],
//         );
//       },
//     );
//   }
// }
