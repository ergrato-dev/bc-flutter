/// Ejercicio 02 — Bloc con Eventos
/// Qué: el mismo contador del ejercicio 01, ahora con Bloc<Event, State> en
/// vez de Cubit<int> — eventos, on<Event>(), bloc.add().
/// Para qué: comparar Cubit vs Bloc con el mismo ejemplo, para decidir con
/// criterio propio cuándo usar cada uno (ver teoría 04).
library;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  debugPrint('--- Ejercicio 02: Bloc con Eventos ---');
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO temporal: en el PASO 3 reemplaza este Scaffold por el árbol
    // BlocProvider(...) — ver instrucciones abajo.
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: eventos
// ============================================
// Agrega estas clases a nivel de archivo:
//
// sealed class CounterEvent extends Equatable {
//   const CounterEvent();
//   @override
//   List<Object?> get props => [];
// }
//
// class CounterIncremented extends CounterEvent {
//   const CounterIncremented();
// }
//
// class CounterDecremented extends CounterEvent {
//   const CounterDecremented();
// }

// ============================================
// PASO 2: CounterBloc con on<Event>()
// ============================================
// Agrega esta clase a nivel de archivo:
//
// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterIncremented>((event, emit) => emit(state + 1));
//     on<CounterDecremented>((event, emit) => emit(state - 1));
//   }
// }

// ============================================
// PASO 3: BlocProvider + disparar eventos con .add()
// ============================================
// Reemplaza el `Scaffold` de HomeScreen.build() por:
//
// return BlocProvider(
//   create: (context) => CounterBloc(),
//   child: Scaffold(
//     appBar: AppBar(title: const Text('Ejercicio 02')),
//     body: Center(
//       child: BlocBuilder<CounterBloc, int>(
//         builder: (context, count) => Text('$count', style: Theme.of(context).textTheme.displayMedium),
//       ),
//     ),
//     floatingActionButton: Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         FloatingActionButton(
//           heroTag: 'decrement',
//           onPressed: () => context.read<CounterBloc>().add(const CounterDecremented()),
//           child: const Icon(Icons.remove),
//         ),
//         const SizedBox(width: 12),
//         FloatingActionButton(
//           heroTag: 'increment',
//           onPressed: () => context.read<CounterBloc>().add(const CounterIncremented()),
//           child: const Icon(Icons.add),
//         ),
//       ],
//     ),
//   ),
// );
