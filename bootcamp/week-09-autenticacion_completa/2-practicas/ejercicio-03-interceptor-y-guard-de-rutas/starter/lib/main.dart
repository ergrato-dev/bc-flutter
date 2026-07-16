/// Ejercicio 03 — Interceptor y Guard de Rutas
/// Qué: un interceptor de Dio que agrega un header a cada request, y un
/// GoRouter reconstruido como provider que redirige según el estado de auth.
/// Para qué: es el mecanismo exacto que conectarás con login real y
/// flutter_secure_storage en el proyecto de esta semana.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

// TODO temporal: descomenta esta línea como parte del PASO 1 — build_runner
// no genera main.g.dart mientras no exista ningún @riverpod en este archivo.
// part 'main.g.dart';

void main() {
  debugPrint('--- Ejercicio 03: Interceptor y Guard de Rutas ---');
  runApp(const ProviderScope(child: MyApp()));
}

// TODO temporal: en el PASO 3 cambia esta clase de StatelessWidget a
// ConsumerWidget (build recibe también WidgetRef ref), y usa
// MaterialApp.router(routerConfig: ref.watch(appRouterProvider)) en vez de
// MaterialApp(home: ...).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 03',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          // TODO temporal: en el PASO 1 reemplaza este onPressed por
          // `() => ref.read(authProvider.notifier).login()`.
          onPressed: () {},
          child: const Text('Iniciar sesión'),
        ),
      ),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _headersResult = '';

  Future<void> _checkHeaders() async {
    // TODO temporal: en el PASO 2 reemplaza este cuerpo por:
    // final response = await ref.read(dioProvider).get('/headers');
    // setState(() => _headersResult = '${response.data['headers']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            // TODO temporal: en el PASO 1 reemplaza este onPressed por
            // `() => ref.read(authProvider.notifier).logout()`.
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _checkHeaders,
              child: const Text('Ver headers enviados'),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(_headersResult, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: AuthNotifier + pantallas + dioProvider base
// ============================================
// Descomenta `part 'main.g.dart';` arriba (junto a los imports) Y las
// siguientes líneas:
//
// @riverpod
// class AuthNotifier extends _$AuthNotifier {
//   @override
//   bool build() => false;
//
//   void login() => state = true;
//   void logout() => state = false;
// }
//
// @Riverpod(keepAlive: true)
// Dio dio(Ref ref) {
//   return Dio(BaseOptions(baseUrl: 'https://httpbin.org'));
// }
//
// Reemplaza el `onPressed: () {}` de LoginScreen por
// `() => ref.read(authProvider.notifier).login()`, y el de HomeScreen
// (el ícono de logout) por `() => ref.read(authProvider.notifier).logout()`.
// Regenera con build_runner después de agregar estos providers.

// ============================================
// PASO 2: interceptor que agrega el header
// ============================================
// Reemplaza el `dioProvider` del PASO 1 por:
//
// @Riverpod(keepAlive: true)
// Dio dio(Ref ref) {
//   final dio = Dio(BaseOptions(baseUrl: 'https://httpbin.org'));
//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) {
//         if (ref.read(authProvider)) {
//           options.headers['Authorization'] = 'Bearer demo-token';
//         }
//         handler.next(options);
//       },
//     ),
//   );
//   return dio;
// }
//
// Reemplaza el cuerpo de `_checkHeaders()` (después de "TODO temporal") por:
//
// final response = await ref.read(dioProvider).get('/headers');
// setState(() => _headersResult = '${response.data['headers']}');
//
// Regenera con build_runner después de agregar el interceptor.

// ============================================
// PASO 3: appRouterProvider con redirect
// ============================================
// Agrega este provider junto a los del PASO 1-2:
//
// @riverpod
// GoRouter appRouter(Ref ref) {
//   final isLoggedIn = ref.watch(authProvider);
//   return GoRouter(
//     initialLocation: isLoggedIn ? '/' : '/login',
//     redirect: (context, state) {
//       final loggingIn = state.uri.toString() == '/login';
//       if (!isLoggedIn && !loggingIn) return '/login';
//       if (isLoggedIn && loggingIn) return '/';
//       return null;
//     },
//     routes: [
//       GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
//       GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
//     ],
//   );
// }
//
// Sigue las instrucciones del comentario TODO temporal dentro de MyApp —
// cambia a ConsumerWidget y usa MaterialApp.router(routerConfig:
// ref.watch(appRouterProvider)). Regenera con build_runner.
