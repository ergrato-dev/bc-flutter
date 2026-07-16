/// Ejercicio 03 — AnimatedSwitcher y AnimatedList
/// Qué: practicar la transición animada entre estados distintos y la
/// inserción/eliminación animada de elementos de una lista.
/// Para qué: es el mismo patrón que usarás en la pantalla de items y en la
/// lista de favoritos del proyecto de esta semana.
library;

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 03: AnimatedSwitcher y AnimatedList ---');
  runApp(const MyApp());
}

enum ViewState { loading, error, loaded }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 03',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ViewState _state = ViewState.loading;
  final List<String> _favorites = ['Elemento A', 'Elemento B'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 03')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _state = ViewState.loading),
                  child: const Text('Cargando'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _state = ViewState.error),
                  child: const Text('Error'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _state = ViewState.loaded),
                  child: const Text('Listo'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 64,
            // TODO temporal: en el PASO 1, reemplaza este switch plano por
            // el AnimatedSwitcher de las instrucciones.
            child: Center(
              child: switch (_state) {
                ViewState.loading => const CircularProgressIndicator(),
                ViewState.error => const Text('Error al cargar'),
                ViewState.loaded => const Icon(Icons.check_circle, size: 48),
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () =>
                  setState(() => _favorites.add('Elemento ${_favorites.length + 1}')),
              child: const Text('Agregar favorito'),
            ),
          ),
          Expanded(
            // TODO temporal: en el PASO 2, reemplaza este ListView estático
            // por el AnimatedList de las instrucciones (agrega también el
            // GlobalKey<AnimatedListState> _listKey como campo del State).
            child: ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_favorites[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  // TODO temporal: en el PASO 3, reemplaza este setState por
                  // una llamada a `_removeFavorite(index)`.
                  onPressed: () => setState(() => _favorites.removeAt(index)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// PASO 1: AnimatedSwitcher con key por estado
// ============================================
// Reemplaza el `switch` dentro del `Center` (dentro del SizedBox de
// height: 64) por:
//
// AnimatedSwitcher(
//   duration: const Duration(milliseconds: 300),
//   child: switch (_state) {
//     ViewState.loading => const CircularProgressIndicator(key: ValueKey('loading')),
//     ViewState.error => const Text('Error al cargar', key: ValueKey('error')),
//     ViewState.loaded => const Icon(Icons.check_circle, size: 48, key: ValueKey('loaded')),
//   },
// )

// ============================================
// PASO 2: lista de favoritos con AnimatedList
// ============================================
// Agrega este campo a _HomeScreenState:
//
// final _listKey = GlobalKey<AnimatedListState>();
//
// Reemplaza el `ListView.builder` de favoritos por:
//
// AnimatedList(
//   key: _listKey,
//   initialItemCount: _favorites.length,
//   itemBuilder: (context, index, animation) => SizeTransition(
//     sizeFactor: animation,
//     child: ListTile(
//       title: Text(_favorites[index]),
//       trailing: IconButton(
//         icon: const Icon(Icons.remove_circle_outline),
//         onPressed: () => _removeFavorite(index),
//       ),
//     ),
//   ),
// )

// ============================================
// PASO 3: insertar y eliminar con animación
// ============================================
// Agrega estos métodos a _HomeScreenState, y usa `_addFavorite` en el botón
// "Agregar favorito" en vez del `setState` directo:
//
// void _addFavorite(String name) {
//   setState(() => _favorites.add(name));
//   _listKey.currentState?.insertItem(_favorites.length - 1);
// }
//
// void _removeFavorite(int index) {
//   final removed = _favorites[index];
//   setState(() => _favorites.removeAt(index));
//   _listKey.currentState?.removeItem(
//     index,
//     (context, animation) => SizeTransition(
//       sizeFactor: animation,
//       child: ListTile(title: Text(removed)),
//     ),
//   );
// }
