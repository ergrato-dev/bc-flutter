import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/item.dart';
import '../screens/about_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';

// ============================================
// ROUTER: appRouter
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — es la misma configuración que practicaste
// en los ejercicios 01, 02 y 03. No necesitas modificarlo, solo entender
// cómo conecta HomeScreen/AboutScreen (dentro del ShellRoute, con bottom
// nav) con DetailScreen (fuera del ShellRoute, apilada con push).
int _indexForLocation(String location) => location.startsWith('/about') ? 1 : 0;

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _indexForLocation(state.uri.toString()),
            onDestinationSelected: (index) => context.go(index == 0 ? '/' : '/about'),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.list), label: 'Lista'),
              NavigationDestination(icon: Icon(Icons.info), label: 'Acerca de'),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Mi Dominio')),
            body: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Acerca de')),
            body: const AboutScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/items/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final preloadedItem = state.extra as Item?;
        return DetailScreen(itemId: id, preloadedItem: preloadedItem);
      },
    ),
  ],
);
