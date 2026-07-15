/// Ejercicio 03 — MultiProvider
/// Qué: combinar dos ChangeNotifier independientes con MultiProvider.
/// Para qué: el proyecto de esta semana y la mayoría de apps reales
/// necesitan más de un notifier expuesto al mismo tiempo.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  debugPrint('--- Ejercicio 03: MultiProvider ---');
  // TODO temporal: en el PASO 3 reemplaza esta línea por runApp() con
  // MultiProvider envolviendo MyApp.
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 03')),
      // TODO temporal: en el PASO 3 reemplaza este Placeholder por
      // const Center(child: HomeContent())
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: ThemeNotifier
// ============================================
// Descomenta las siguientes líneas:
// class ThemeNotifier extends ChangeNotifier {
//   bool _isDark = false;
//   bool get isDark => _isDark;
//
//   void toggle() {
//     _isDark = !_isDark;
//     notifyListeners();
//   }
// }

// ============================================
// PASO 2: CounterNotifier
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
// PASO 3: MultiProvider + consumo de ambos
// ============================================
// Descomenta las siguientes líneas:
// class HomeContent extends StatelessWidget {
//   const HomeContent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = context.watch<ThemeNotifier>();
//     final counter = context.watch<CounterNotifier>();
//     return Container(
//       color: theme.isDark ? Colors.black87 : Colors.white,
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Contador: ${counter.count}',
//             style: TextStyle(color: theme.isDark ? Colors.white : Colors.black),
//           ),
//           ElevatedButton(
//             onPressed: () => context.read<CounterNotifier>().increment(),
//             child: const Text('Sumar'),
//           ),
//           ElevatedButton(
//             onPressed: () => context.read<ThemeNotifier>().toggle(),
//             child: const Text('Cambiar tema'),
//           ),
//         ],
//       ),
//     );
//   }
// }
