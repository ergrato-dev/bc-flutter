import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item.dart';
import '../providers/favorites_provider.dart';
import '../providers/items_provider.dart';

// ============================================
// SCREEN: DetailScreen
// Detalle de un elemento — resuelve por `extra` (semana 3) o, si no vino,
// busca en ItemsNotifier ya cargado. Botón de favorito con FavoritesNotifier.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — mismo patrón de semana 5, sin cambios.
// El networking de esta semana no toca esta pantalla; no necesitas
// modificarla.
class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.itemId, this.preloadedItem});

  final String itemId;
  final Item? preloadedItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (preloadedItem != null) {
      return _DetailContent(item: preloadedItem!);
    }

    final itemsAsync = ref.watch(itemsProvider);
    return itemsAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: Center(child: Text('$error')),
      ),
      data: (items) {
        final item = findItemById(items, itemId);
        if (item == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Detalle')),
            body: const Center(child: Text('Elemento no encontrado')),
          );
        }
        return _DetailContent(item: item);
      },
    );
  }
}

class _DetailContent extends ConsumerWidget {
  const _DetailContent({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(item.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? Colors.red : null,
            onPressed: () => ref.read(favoritesProvider.notifier).toggle(item.id),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(item.description),
      ),
    );
  }
}
