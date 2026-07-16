import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/error_retry_view.dart';
import '../../domain/entities/item.dart';
import '../cubit/items_cubit.dart';
import '../cubit/items_state.dart';
import '../widgets/item_card.dart';

// ============================================
// SCREEN: HomeScreen (tab "Lista")
// Lista de elementos — mismo patrón de semanas 6-9 (buscador, pull-to-
// refresh, reintento en error), ahora con BlocBuilder en vez de
// itemsAsync.when().
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Tu trabajo esta semana es completar el TODO del body — envolver el
// switch en un AnimatedSwitcher (ver PASO 1 al final del archivo).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    context.read<ItemsCubit>().fetchItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(labelText: 'Buscar', prefixIcon: Icon(Icons.search)),
            onChanged: (value) => setState(() => _query = value),
          ),
        ),
        Expanded(
          // TODO temporal: en el PASO 1, envuelve el `switch` de abajo (el
          // valor retornado por `builder`) en un AnimatedSwitcher — ver
          // instrucciones al final del archivo.
          child: BlocBuilder<ItemsCubit, ItemsState>(
            builder: (context, state) {
              return switch (state) {
                ItemsInitial() || ItemsLoading() => const Center(
                    key: ValueKey('loading'),
                    child: CircularProgressIndicator(),
                  ),
                ItemsError(:final message) => ErrorRetryView(
                    key: const ValueKey('error'),
                    message: message,
                    onRetry: () => context.read<ItemsCubit>().fetchItems(),
                  ),
                ItemsLoaded(:final items) =>
                  _ItemsList(key: const ValueKey('loaded'), items: items, query: _query),
              };
            },
          ),
        ),
      ],
    );
  }
}

// ============================================
// PASO 1: AnimatedSwitcher envolviendo el switch de estados
// ============================================
// Reemplaza `builder: (context, state) { return switch (state) { ... }; }`
// por:
//
// builder: (context, state) {
//   return AnimatedSwitcher(
//     duration: const Duration(milliseconds: 300),
//     child: switch (state) {
//       ItemsInitial() || ItemsLoading() => const Center(
//           key: ValueKey('loading'),
//           child: CircularProgressIndicator(),
//         ),
//       ItemsError(:final message) => ErrorRetryView(
//           key: const ValueKey('error'),
//           message: message,
//           onRetry: () => context.read<ItemsCubit>().fetchItems(),
//         ),
//       ItemsLoaded(:final items) =>
//         _ItemsList(key: const ValueKey('loaded'), items: items, query: _query),
//     },
//   );
// },
//
// Cada rama ya tiene su `ValueKey` única (`'loading'`, `'error'`, `'loaded'`)
// — sin ellas, `AnimatedSwitcher` no detectaría el cambio de widget (ver
// teoría 05). `_ItemsList` sigue reconstruyéndose en cada tecleo de
// búsqueda con la MISMA key `'loaded'`, así que no vuelve a animar el fundido
// en cada letra — solo cuando cambia de rama (loading/error/loaded).

class _ItemsList extends StatelessWidget {
  const _ItemsList({super.key, required this.items, required this.query});

  final List<Item> items;
  final String query;

  @override
  Widget build(BuildContext context) {
    final filteredItems = items
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredItems.isEmpty) {
      return const Center(child: Text('No se encontraron elementos'));
    }

    return RefreshIndicator(
      onRefresh: () => context.read<ItemsCubit>().fetchItems(),
      child: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) => ItemCard(
          item: filteredItems[index],
          onTap: () => context.push('/items/${filteredItems[index].id}', extra: filteredItems[index]),
        ),
      ),
    );
  }
}
