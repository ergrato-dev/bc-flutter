/// Ejercicio 01 — Dio Básico e Interceptors
/// Qué: practicar la configuración de Dio (BaseOptions, interceptors) y un
/// GET real, sin Riverpod de por medio todavía.
/// Para qué: separar el concepto de Dio del concepto de AsyncNotifier antes
/// de combinarlos en el ejercicio 02.
library;

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  debugPrint('--- Ejercicio 01: Dio Básico e Interceptors ---');
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
      // TODO temporal: en el PASO 3 reemplaza este Placeholder por
      // const _PostTitle()
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: Instancia de Dio con BaseOptions
// ============================================
// Descomenta las siguientes líneas:
// final dio = Dio(
//   BaseOptions(
//     baseUrl: 'https://jsonplaceholder.typicode.com',
//     connectTimeout: const Duration(seconds: 10),
//     receiveTimeout: const Duration(seconds: 10),
//   ),
// );

// ============================================
// PASO 2: LogInterceptor
// ============================================
// Agrega esta línea justo después de crear `dio` en el PASO 1:
// dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

// ============================================
// PASO 3: GET real con FutureBuilder
// ============================================
// Descomenta las siguientes líneas (y corre `flutter pub get` si no lo
// hiciste aún):
// class _PostTitle extends StatelessWidget {
//   const _PostTitle();
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Response>(
//       future: dio.get('/posts/1'),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         final data = snapshot.data!.data as Map<String, dynamic>;
//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Text(data['title'] as String),
//         );
//       },
//     );
//   }
// }
