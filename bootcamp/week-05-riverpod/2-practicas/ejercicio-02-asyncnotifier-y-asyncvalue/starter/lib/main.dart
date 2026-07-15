/// Ejercicio 02 — AsyncNotifier y AsyncValue
/// Qué: practicar un provider async y el manejo de AsyncValue con .when().
/// Para qué: es el mecanismo exacto que usarás en semana 6 para consumir
/// APIs REST reales con Dio.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// TODO temporal: descomenta esta línea como parte del PASO 1 — build_runner
// no genera main.g.dart mientras no exista ningún @riverpod en este archivo.
// part 'main.g.dart';

void main() {
  debugPrint('--- Ejercicio 02: AsyncNotifier y AsyncValue ---');
  runApp(const ProviderScope(child: MyApp()));
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

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 02'),
        // TODO temporal: en el PASO 3 agrega un botón en `actions:` que
        // llame ref.read(itemsProvider.notifier).addItem('Nuevo elemento')
      ),
      // TODO temporal: en el PASO 1 y PASO 2 reemplaza este Placeholder.
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: Provider asíncrono
// ============================================
// Descomenta `part 'main.g.dart';` arriba (junto a los imports) Y las
// siguientes líneas, luego corre build_runner:
// @riverpod
// class ItemsNotifier extends _$ItemsNotifier {
//   @override
//   Future<List<String>> build() async {
//     await Future.delayed(const Duration(milliseconds: 800));
//     return ['Elemento 1', 'Elemento 2', 'Elemento 3'];
//   }
//
//   // PASO 3: descomenta este método junto con el resto del PASO 3 abajo
//   // Future<void> addItem(String name) async {
//   //   final current = await future;
//   //   state = AsyncData([...current, name]);
//   // }
// }

// ============================================
// PASO 2: Manejar AsyncValue con .when()
// ============================================
// Descomenta las siguientes líneas y reemplaza el `body:` de HomeScreen por
// `body: const _ItemsList()`:
//
// class _ItemsList extends ConsumerWidget {
//   const _ItemsList();
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final itemsAsync = ref.watch(itemsProvider);
//     return itemsAsync.when(
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stackTrace) => Center(child: Text('Error: $error')),
//       data: (items) => ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) => ListTile(title: Text(items[index])),
//       ),
//     );
//   }
// }

// ============================================
// PASO 3: Mutar estado async — agregar un elemento
// ============================================
// 1. Descomenta el método `addItem` dentro de ItemsNotifier (arriba, PASO 1)
// 2. Descomenta el botón de abajo y agrégalo a `actions:` del AppBar en HomeScreen:
//
// IconButton(
//   icon: const Icon(Icons.add),
//   onPressed: () => ref.read(itemsProvider.notifier).addItem('Nuevo elemento'),
// ),
