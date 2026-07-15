/// Ejercicio 01 — Provider Funcional y Notifier
/// Qué: practicar un provider funcional de solo lectura y un Notifier con
/// estado mutable, ambos con generación de código.
/// Para qué: es la unidad mínima de Riverpod que usarás el resto del
/// bootcamp — Provider (semana 4) no vuelve a aparecer como tema nuevo.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// TODO temporal: descomenta esta línea como parte del PASO 1 — build_runner
// no genera main.g.dart mientras no exista ningún @riverpod en este archivo.
// part 'main.g.dart';

void main() {
  debugPrint('--- Ejercicio 01: Provider Funcional y Notifier ---');
  runApp(const ProviderScope(child: MyApp()));
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
      // TODO temporal: en el PASO 3 reemplaza este Placeholder por
      // const Center(child: HomeContent())
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: Provider funcional
// ============================================
// Descomenta `part 'main.g.dart';` arriba (junto a los imports) Y las
// siguientes líneas, luego corre build_runner:
// @riverpod
// String greeting(Ref ref) {
//   return 'Hola, Riverpod';
// }

// ============================================
// PASO 2: Notifier con estado mutable
// ============================================
// Descomenta las siguientes líneas (y corre build_runner):
// @riverpod
// class Counter extends _$Counter {
//   @override
//   int build() => 0;
//
//   void increment() => state++;
// }

// ============================================
// PASO 3: ConsumerWidget consumiendo ambos
// ============================================
// Descomenta las siguientes líneas (y corre build_runner):
// class HomeContent extends ConsumerWidget {
//   const HomeContent({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final message = ref.watch(greetingProvider);
//     final count = ref.watch(counterProvider);
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(message),
//         Text('$count'),
//         ElevatedButton(
//           onPressed: () => ref.read(counterProvider.notifier).increment(),
//           child: const Text('Sumar'),
//         ),
//       ],
//     );
//   }
// }
