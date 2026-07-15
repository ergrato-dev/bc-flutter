/// Ejercicio 03 — ShellRoute y Navegación por Tabs
/// Qué: practicar ShellRoute con una NavigationBar persistente entre 2 tabs.
/// Para qué: es el mismo patrón que usarás en el proyecto de esta semana
/// para separar "Lista" de "Acerca de" sin reconstruir la barra inferior.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  debugPrint('--- Ejercicio 03: ShellRoute y Navegación por Tabs ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}

int _indexForLocation(String location) => location.startsWith('/about') ? 1 : 0;

final _router = GoRouter(
  routes: [
    // PASO 1: descomenta el ShellRoute completo (reemplaza este comentario)
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return Scaffold(
    //       body: child,
    //       bottomNavigationBar: NavigationBar(
    //         selectedIndex: _indexForLocation(state.uri.toString()),
    //         onDestinationSelected: (index) => context.go(index == 0 ? '/' : '/about'),
    //         destinations: const [
    //           NavigationDestination(icon: Icon(Icons.list), label: 'Inicio'),
    //           NavigationDestination(icon: Icon(Icons.info), label: 'Acerca de'),
    //         ],
    //       ),
    //     );
    //   },
    //   routes: [
    //     // PASO 2: descomenta estas dos rutas hijas
    //     // GoRoute(path: '/', builder: (context, state) => const HomeTab()),
    //     // GoRoute(path: '/about', builder: (context, state) => const AboutTab()),
    //   ],
    // ),
  ],
);

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Pestaña Inicio'));
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Pestaña Acerca de'));
  }
}
