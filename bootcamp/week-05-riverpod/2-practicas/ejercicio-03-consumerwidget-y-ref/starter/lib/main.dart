/// Ejercicio 03 — ConsumerWidget, ref y Composición de Providers
/// Qué: practicar un provider derivado de otro y ref.listen para efectos
/// secundarios.
/// Para qué: componer providers (sin ProxyProvider) es una de las
/// principales ventajas de Riverpod sobre Provider (semana 4).
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// TODO temporal: descomenta esta línea como parte del PASO 1 — build_runner
// no genera main.g.dart mientras no exista ningún @riverpod en este archivo.
// part 'main.g.dart';

void main() {
  debugPrint('--- Ejercicio 03: ConsumerWidget, ref y Composición ---');
  runApp(const ProviderScope(child: MyApp()));
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
// PASO 1: CartNotifier
// ============================================
// Descomenta `part 'main.g.dart';` arriba (junto a los imports) Y las
// siguientes líneas, luego corre build_runner:
// @riverpod
// class CartNotifier extends _$CartNotifier {
//   @override
//   List<String> build() => [];
//
//   void addItem(String item) => state = [...state, item];
// }

// ============================================
// PASO 2: Provider derivado (composición)
// ============================================
// Descomenta las siguientes líneas (y corre build_runner):
// @riverpod
// int cartItemCount(Ref ref) {
//   final items = ref.watch(cartProvider);
//   return items.length;
// }

// ============================================
// PASO 3: ConsumerWidget + ref.listen
// ============================================
// Descomenta las siguientes líneas (y corre build_runner):
// class HomeContent extends ConsumerWidget {
//   const HomeContent({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.listen(cartItemCountProvider, (previous, next) {
//       if (next == 3) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('¡Ya tienes 3 productos!')),
//         );
//       }
//     });
//
//     final count = ref.watch(cartItemCountProvider);
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text('$count productos en el carrito'),
//         ElevatedButton(
//           onPressed: () =>
//               ref.read(cartProvider.notifier).addItem('Producto $count'),
//           child: const Text('Agregar producto'),
//         ),
//       ],
//     );
//   }
// }
