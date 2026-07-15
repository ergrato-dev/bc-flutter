/// Ejercicio 01 — Rutas Básicas con GoRouter
/// Qué: practicar MaterialApp.router, GoRoute, context.push() y context.pop().
/// Para qué: es la configuración mínima de navegación que usarás en el
/// proyecto de esta semana y en el resto del bootcamp.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  debugPrint('--- Ejercicio 01: Rutas Básicas con GoRouter ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO temporal: en el PASO 1 reemplaza este `return` completo por
    // `return MaterialApp.router(routerConfig: _router);`
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Completa el PASO 1 para activar go_router')),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Center(
        child: ElevatedButton(
          // TODO temporal: en el PASO 2 reemplaza `() {}` por
          // `() => context.push('/detail')`
          onPressed: () {},
          child: const Text('Ir al detalle'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Pantalla de detalle'),
            const SizedBox(height: 12),
            // PASO 3: descomenta el botón de abajo para volver con context.pop()
            // ElevatedButton(
            //   onPressed: () => context.pop(),
            //   child: const Text('Volver'),
            // ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: GoRouter con una sola ruta
// ============================================
// Descomenta las siguientes líneas:
// final _router = GoRouter(
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
//   ],
// );

// ============================================
// PASO 2: Segunda ruta — agrégala a `routes:` del _router de arriba
// ============================================
// Descomenta y agrega esta línea dentro de `routes: [ ... ]` del PASO 1:
// GoRoute(path: '/detail', builder: (context, state) => const DetailScreen()),
