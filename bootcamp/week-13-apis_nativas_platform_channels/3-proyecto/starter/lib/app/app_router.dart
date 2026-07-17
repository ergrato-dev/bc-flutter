import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/di/injection_container.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/cubit/auth_state.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/items/domain/entities/item.dart';
import '../features/items/presentation/cubit/favorites_cubit.dart';
import '../features/items/presentation/screens/create_item_screen.dart';
import '../features/items/presentation/screens/detail_screen.dart';
import '../features/items/presentation/screens/home_screen.dart';
import 'about_screen.dart';

// ============================================
// ROUTER: appRouter
// A diferencia de semana 9 (appRouter como provider de Riverpod, que se
// reconstruía completo al cambiar authProvider), Bloc no tiene un mecanismo
// equivalente a `ref.watch` fuera del árbol de widgets — por eso este
// router se construye una sola vez y usa `refreshListenable` para
// reevaluar `redirect` en cada cambio de AuthCubit. Ver teoría 06.
//
// Los cuatro cubits (AuthCubit, ItemsCubit, CreateItemCubit, FavoritesCubit)
// se proveen una sola vez, arriba de este router, en main.dart — igual que
// ProviderScope envolvía toda la app en semanas 5-9, aquí MultiBlocProvider
// hace lo mismo. Ninguna ruta necesita su propio BlocProvider.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

int _indexForLocation(String location) => location.startsWith('/about') ? 1 : 0;

GoRouter buildAppRouter(AuthCubit authCubit) {
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      final isLoggedIn = authCubit.state is AuthAuthenticated;
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
                  Builder(
                    builder: (context) {
                      final count = context.watch<FavoritesCubit>().state.length;
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
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => getIt<AuthCubit>().logout(),
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
