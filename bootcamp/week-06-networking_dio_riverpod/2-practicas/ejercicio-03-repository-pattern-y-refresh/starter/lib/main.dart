/// Ejercicio 03 — Repository Pattern y Pull-to-Refresh
/// Qué: separar Dio del AsyncNotifier detrás de un repository, y agregar
/// pull-to-refresh con ref.refresh().
/// Para qué: es la arquitectura exacta del proyecto de esta semana — el
/// AsyncNotifier nunca conoce Dio directamente.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

// TODO temporal: descomenta esta línea como parte del PASO 1 — build_runner
// no genera main.g.dart mientras no exista ningún @riverpod en este archivo.
// part 'main.g.dart';

void main() {
  debugPrint('--- Ejercicio 03: Repository Pattern y Pull-to-Refresh ---');
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
      // const _PostsList()
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: PostsRepository
// ============================================
// Descomenta `part 'main.g.dart';` arriba (junto a los imports) Y las
// siguientes líneas, luego corre build_runner:
// abstract class PostsRepository {
//   Future<List<String>> fetchTitles();
// }
//
// class DioPostsRepository implements PostsRepository {
//   DioPostsRepository(this._dio);
//
//   final Dio _dio;
//
//   @override
//   Future<List<String>> fetchTitles() async {
//     try {
//       final response = await _dio.get('/posts');
//       return (response.data as List)
//           .map((json) => json['title'] as String)
//           .toList();
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionError) {
//         throw Exception('Sin conexión a internet');
//       }
//       throw Exception('No se pudo cargar la información');
//     }
//   }
// }

// ============================================
// PASO 2: postsRepositoryProvider + PostsNotifier
// ============================================
// Descomenta las siguientes líneas (y corre build_runner):
// @Riverpod(keepAlive: true)
// Dio dio(Ref ref) {
//   return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
// }
//
// @riverpod
// PostsRepository postsRepository(Ref ref) {
//   return DioPostsRepository(ref.watch(dioProvider));
// }
//
// @riverpod
// class PostsNotifier extends _$PostsNotifier {
//   @override
//   Future<List<String>> build() async {
//     final repository = ref.watch(postsRepositoryProvider);
//     return repository.fetchTitles();
//   }
// }

// ============================================
// PASO 3: Pull-to-refresh
// ============================================
// Descomenta las siguientes líneas (y corre build_runner):
// class _PostsList extends ConsumerWidget {
//   const _PostsList();
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final postsAsync = ref.watch(postsProvider);
//     return postsAsync.when(
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stackTrace) => Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('$error'),
//             ElevatedButton(
//               onPressed: () => ref.invalidate(postsProvider),
//               child: const Text('Reintentar'),
//             ),
//           ],
//         ),
//       ),
//       data: (titles) => RefreshIndicator(
//         onRefresh: () => ref.refresh(postsProvider.future),
//         child: ListView.builder(
//           itemCount: titles.length,
//           itemBuilder: (context, index) => ListTile(title: Text(titles[index])),
//         ),
//       ),
//     );
//   }
// }
