/// Ejercicio 01 — Cubit Básico
/// Qué: un contador con Cubit<int> — emit(), BlocProvider, BlocBuilder y
/// BlocListener.
/// Para qué: es el mismo ciclo que usarás con ItemsCubit, AuthCubit y
/// CreateItemCubit en el proyecto de esta semana.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  debugPrint('--- Ejercicio 01: Cubit Básico ---');
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
    // TODO temporal: en el PASO 2 reemplaza este Scaffold por el árbol
    // BlocProvider(...) — ver instrucciones abajo. En el PASO 3, envuelve
    // ese árbol con BlocListener(...).
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: CounterCubit
// ============================================
// Agrega esta clase a nivel de archivo (fuera de cualquier widget):
//
// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);
//
//   void increment() => emit(state + 1);
//   void decrement() => emit(state - 1);
// }

// ============================================
// PASO 2: BlocProvider + BlocBuilder
// ============================================
// Reemplaza el `Scaffold` de HomeScreen.build() por:
//
// return BlocProvider(
//   create: (context) => CounterCubit(),
//   child: Scaffold(
//     appBar: AppBar(title: const Text('Ejercicio 01')),
//     body: Center(
//       child: BlocBuilder<CounterCubit, int>(
//         builder: (context, count) => Text('$count', style: Theme.of(context).textTheme.displayMedium),
//       ),
//     ),
//     floatingActionButton: Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         FloatingActionButton(
//           heroTag: 'decrement',
//           onPressed: () => context.read<CounterCubit>().decrement(),
//           child: const Icon(Icons.remove),
//         ),
//         const SizedBox(width: 12),
//         FloatingActionButton(
//           heroTag: 'increment',
//           onPressed: () => context.read<CounterCubit>().increment(),
//           child: const Icon(Icons.add),
//         ),
//       ],
//     ),
//   ),
// );

// ============================================
// PASO 3: BlocListener — efecto secundario sin reconstruir
// ============================================
// Envuelve el `child: Scaffold(...)` del BlocProvider del PASO 2 con:
//
// BlocListener<CounterCubit, int>(
//   listener: (context, count) {
//     if (count == 5) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('¡Llegaste a 5!')),
//       );
//     }
//   },
//   child: Scaffold(/* el mismo Scaffold del PASO 2 */),
// ),
