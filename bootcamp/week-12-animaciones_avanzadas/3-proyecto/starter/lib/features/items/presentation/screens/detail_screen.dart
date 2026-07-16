import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/item.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/items_cubit.dart';
import '../cubit/items_state.dart';

// ============================================
// SCREEN: DetailScreen
// Detalle de un elemento — resuelve por `extra` (semana 3) o, si no vino,
// busca en el ItemsCubit ya cargado. Mismo patrón de semana 5-9.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. El Hero de
// semana 11 sigue emparejado con ItemCard; esta semana no toca esta
// pantalla (ver home_screen.dart e item_card.dart).
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.itemId, this.preloadedItem});

  final String itemId;
  final Item? preloadedItem;

  @override
  Widget build(BuildContext context) {
    if (preloadedItem != null) {
      return _DetailContent(item: preloadedItem!);
    }

    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        return switch (state) {
          ItemsInitial() || ItemsLoading() => Scaffold(
              appBar: AppBar(title: const Text('Detalle')),
              body: const Center(child: CircularProgressIndicator()),
            ),
          ItemsError(:final message) => Scaffold(
              appBar: AppBar(title: const Text('Detalle')),
              body: Center(child: Text(message)),
            ),
          ItemsLoaded(:final items) => _findAndShow(items),
        };
      },
    );
  }

  Widget _findAndShow(List<Item> items) {
    for (final item in items) {
      if (item.id == itemId) return _DetailContent(item: item);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: const Center(child: Text('Elemento no encontrado')),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesCubit>().isFavorite(item.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? Colors.red : null,
            onPressed: () => context.read<FavoritesCubit>().toggle(item.id),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'item-icon-${item.id}',
              child: const CircleAvatar(radius: 32, child: Icon(Icons.inventory_2, size: 32)),
            ),
            const SizedBox(height: 16),
            Text(item.description),
          ],
        ),
      ),
    );
  }
}
