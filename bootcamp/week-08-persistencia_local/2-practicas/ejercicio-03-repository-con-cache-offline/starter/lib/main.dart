/// Ejercicio 03 — Repository con Cache Offline
/// Qué: combinar Dio y Hive en un AsyncNotifier — red primero, cache local
/// como respaldo si la red falla.
/// Para qué: es el patrón exacto de CachedItemsRepository que completarás
/// en el proyecto de esta semana.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

// TODO temporal: descomenta esta línea como parte del PASO 1 — build_runner
// no genera main.g.dart mientras no exista ningún @riverpod en este archivo.
// part 'main.g.dart';

void main() {
  debugPrint('--- Ejercicio 03: Repository con Cache Offline ---');
  // TODO temporal: reemplaza este main() como parte del PASO 1.
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

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO temporal: en el PASO 3 agrega aquí:
    // final quotesAsync = ref.watch(quotesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 03')),
      // TODO temporal: en el PASO 3 reemplaza este Placeholder por
      // quotesAsync.when(...) — ver instrucciones abajo.
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: dioProvider + itemsBoxProvider
// ============================================
// Descomenta `part 'main.g.dart';` arriba (junto a los imports) Y las
// siguientes líneas. Luego reemplaza el main() de arriba por:
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   final box = await Hive.openBox('quotes_cache');
//   runApp(
//     ProviderScope(
//       overrides: [itemsBoxProvider.overrideWithValue(box)],
//       child: const MyApp(),
//     ),
//   );
// }
//
// @Riverpod(keepAlive: true)
// Dio dio(Ref ref) {
//   return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
// }
//
// @riverpod
// Box<dynamic> itemsBox(Ref ref) {
//   throw UnimplementedError('Debe sobreescribirse en main() — ver overrides de ProviderScope.');
// }
//
// Regenera con build_runner después de agregar estos providers.

// ============================================
// PASO 2: QuotesNotifier — red primero, cache como respaldo
// ============================================
// Agrega esta clase junto a los providers del PASO 1:
//
// @riverpod
// class QuotesNotifier extends _$QuotesNotifier {
//   static const _cacheKey = 'titles';
//
//   @override
//   Future<List<String>> build() async {
//     final box = ref.watch(itemsBoxProvider);
//     try {
//       final response = await ref.read(dioProvider).get('/posts');
//       final titles = (response.data as List)
//           .map((json) => json['title'] as String)
//           .toList();
//       await box.put(_cacheKey, titles);
//       return titles;
//     } catch (_) {
//       final cached = box.get(_cacheKey) as List?;
//       if (cached != null) return cached.cast<String>();
//       rethrow;
//     }
//   }
// }
//
// Regenera con build_runner después de agregar la clase.

// ============================================
// PASO 3: UI reactiva con reintento
// ============================================
// Sigue las instrucciones de los comentarios TODO temporal dentro de
// HomeScreen.build() — descomenta `final quotesAsync = ...` y reemplaza el
// Placeholder por:
//
// quotesAsync.when(
//   loading: () => const Center(child: CircularProgressIndicator()),
//   error: (error, stackTrace) => Center(
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text('$error'),
//         ElevatedButton(
//           onPressed: () => ref.invalidate(quotesProvider),
//           child: const Text('Reintentar'),
//         ),
//       ],
//     ),
//   ),
//   data: (titles) => ListView.builder(
//     itemCount: titles.length,
//     itemBuilder: (context, index) => ListTile(title: Text(titles[index])),
//   ),
// ),
