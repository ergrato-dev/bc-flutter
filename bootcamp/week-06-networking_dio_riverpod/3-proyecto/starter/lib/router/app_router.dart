import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/item.dart';
import '../providers/favorites_provider.dart';
import '../screens/about_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';

// ============================================
// ROUTER: appRouter
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — misma configuración de semanas 3-4, con
// el badge de favoritos ahora leído de FavoritesNotifier (Riverpod) en vez
// de FavoritesProvider (Provider). No necesitas modificarlo.
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
            appBar: AppBar(
              title: const Text('Mi Dominio'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Center(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final count = ref.watch(favoritesProvider).length;
                        return Chip(
                          avatar: const Icon(Icons.favorite, size: 18, color: Colors.red),
                          label: Text('$count'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
