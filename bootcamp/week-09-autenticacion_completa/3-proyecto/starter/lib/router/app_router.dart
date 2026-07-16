import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/item.dart';
import '../providers/auth_provider.dart';
import '../providers/favorites_provider.dart';
import '../screens/about_screen.dart';
import '../screens/create_item_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

part 'app_router.g.dart';

// ============================================
// ROUTER: appRouter
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. Desde esta
// semana, appRouter es un provider (no una constante): ref.watch(authProvider)
// hace que se reconstruya completo en cada login/logout, con el redirect ya
// actualizado (ver teoría 05).
int _indexForLocation(String location) => location.startsWith('/about') ? 1 : 0;

@riverpod
GoRouter appRouter(Ref ref) {
  final isLoggedIn = ref.watch(authProvider).value != null;

  return GoRouter(
    initialLocation: isLoggedIn ? '/' : '/login',
    redirect: (context, state) {
      final isLoggingIn = state.uri.toString() == '/login';
      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
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
                  Consumer(
                    builder: (context, ref, child) {
                      final count = ref.watch(favoritesProvider).length;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Center(
                          child: Chip(
                            avatar: const Icon(Icons.favorite, size: 18, color: Colors.red),
                            label: Text('$count'),
                          ),
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) => IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => ref.read(authProvider.notifier).logout(),
                    ),
                  ),
                ],
              ),
              body: const HomeScreen(),
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.push('/items/new'),
                child: const Icon(Icons.add),
              ),
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
        path: '/items/new',
        builder: (context, state) => const CreateItemScreen(),
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
}
