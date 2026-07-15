/// Ejercicio 02 — Parámetros de Ruta y extra
/// Qué: practicar path parameters (:id) y el patrón id+extra de go_router.
/// Para qué: es exactamente el mecanismo de navegación lista→detalle que
/// usarás en el proyecto de esta semana, y en cualquier pantalla de
/// detalle del resto del bootcamp.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SampleItem {
  final String id;
  final String name;
  const SampleItem({required this.id, required this.name});
}

const _items = [
  SampleItem(id: '1', name: 'Elemento Alfa'),
  SampleItem(id: '2', name: 'Elemento Beta'),
  SampleItem(id: '3', name: 'Elemento Gamma'),
];

/// Busca un elemento por id, o `null` si no existe. Ya implementado — lo
/// usarás en el PASO 3.
SampleItem? findById(String id) {
  for (final item in _items) {
    if (item.id == id) return item;
  }
  return null;
}

void main() {
  debugPrint('--- Ejercicio 02: Parámetros de Ruta y extra ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    // PASO 1: descomenta la ruta de detalle con path parameter
    // GoRoute(
    //   path: '/items/:id',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     final preloadedItem = state.extra as SampleItem?;
    //     return DetailScreen(itemId: id, preloadedItem: preloadedItem);
    //   },
    // ),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Elementos')),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            title: Text(item.name),
            // TODO temporal: en el PASO 2 reemplaza `() {}` por
            // `() => context.push('/items/${item.id}', extra: item)`
            onTap: () {},
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.itemId, this.preloadedItem});

  final String itemId;
  final SampleItem? preloadedItem;

  @override
  Widget build(BuildContext context) {
    // PASO 3: descomenta la línea de abajo y borra la línea siguiente
    // (la que dice "TODO temporal, ver PASO 3")
    // final resolvedItem = preloadedItem ?? findById(itemId);
    final SampleItem? resolvedItem = preloadedItem; // TODO temporal, ver PASO 3

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: Center(child: Text(resolvedItem?.name ?? 'Elemento no encontrado')),
    );
  }
}
