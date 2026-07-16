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
// Este archivo ya está completo — no necesitas modificarlo.
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
          child: BlocBuilder<ItemsCubit, ItemsState>(
            builder: (context, state) {
              return switch (state) {
                ItemsInitial() || ItemsLoading() =>
                  const Center(child: CircularProgressIndicator()),
                ItemsError(:final message) => ErrorRetryView(
                    message: message,
                    onRetry: () => context.read<ItemsCubit>().fetchItems(),
                  ),
                ItemsLoaded(:final items) => _ItemsList(items: items, query: _query),
              };
            },
          ),
        ),
      ],
    );
  }
}

class _ItemsList extends StatelessWidget {
  const _ItemsList({required this.items, required this.query});

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
