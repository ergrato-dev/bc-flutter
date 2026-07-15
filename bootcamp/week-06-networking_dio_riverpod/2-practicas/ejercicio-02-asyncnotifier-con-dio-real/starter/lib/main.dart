/// Ejercicio 02 — AsyncNotifier con Dio Real
/// Qué: combinar Dio (ejercicio 01) con AsyncNotifier (semana 5) para cargar
/// datos reales, y traducir DioException a un mensaje propio.
/// Para qué: es el mecanismo exacto que usarás en el proyecto de esta
/// semana, con un repository de por medio.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

// TODO temporal: descomenta esta línea como parte del PASO 1 — build_runner
// no genera main.g.dart mientras no exista ningún @riverpod en este archivo.
// part 'main.g.dart';

void main() {
  debugPrint('--- Ejercicio 02: AsyncNotifier con Dio Real ---');
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      // TODO temporal: en el PASO 2 reemplaza este Placeholder por
      // const _PostsList()
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: dioProvider
// ============================================
// Descomenta `part 'main.g.dart';` arriba (junto a los imports) Y las
// siguientes líneas, luego corre build_runner:
// @Riverpod(keepAlive: true)
// Dio dio(Ref ref) {
//   return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'))
//     ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
// }

// ============================================
// PASO 2: PostsNotifier con GET real
// ============================================
// Descomenta las siguientes líneas (y corre build_runner). En el PASO 3
// reemplazarás el cuerpo de `build()` por la versión con manejo de errores.
// @riverpod
// class PostsNotifier extends _$PostsNotifier {
//   @override
//   Future<List<String>> build() async {
//     final dio = ref.watch(dioProvider);
//     final response = await dio.get('/posts');
//     return (response.data as List)
//         .map((json) => json['title'] as String)
//         .toList();
//   }
// }
//
// class _PostsList extends ConsumerWidget {
//   const _PostsList();
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final postsAsync = ref.watch(postsProvider);
//     return postsAsync.when(
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stackTrace) => Center(child: Text('$error')),
//       data: (titles) => ListView.builder(
//         itemCount: titles.length,
//         itemBuilder: (context, index) => ListTile(title: Text(titles[index])),
//       ),
//     );
//   }
// }

// ============================================
// PASO 3: Traducir DioException
// ============================================
// Reemplaza el cuerpo de `build()` de PostsNotifier (PASO 2, arriba) por:
//
// Future<List<String>> build() async {
//   final dio = ref.watch(dioProvider);
//   try {
//     final response = await dio.get('/posts');
//     return (response.data as List)
//         .map((json) => json['title'] as String)
//         .toList();
//   } on DioException catch (e) {
//     if (e.type == DioExceptionType.connectionError) {
//       throw Exception('Sin conexión a internet');
//     }
//     throw Exception('No se pudo cargar la información');
//   }
// }
//
// Regenera con build_runner después de reemplazar.
