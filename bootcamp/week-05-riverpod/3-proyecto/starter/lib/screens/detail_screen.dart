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
// Completa los TODOs: resolver el elemento cuando no vino por `extra`, y
// agregar el botón de favorito (mismo patrón de ItemCard).
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
        body: Center(child: Text('Error: $error')),
      ),
      data: (items) {
        // TODO: usa `findItemById(items, itemId)` (ya implementado en
        // items_provider.dart) para resolver el elemento. Si es `null`,
        // retorna un Scaffold con "Elemento no encontrado" (mismo patrón
        // de semana 3). Si no, retorna `_DetailContent(item: item)`.
        return const Scaffold(body: Center(child: Placeholder()));
      },
    );
  }
}

class _DetailContent extends ConsumerWidget {
  const _DetailContent({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: lee `isFavorite` desde `ref.watch(favoritesProvider)`
    // usando `item.id`, y agrega un IconButton en `actions:` del AppBar
    // que llame `ref.read(favoritesProvider.notifier).toggle(item.id)`
    // (mismo patrón que ItemCard).

    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(item.description),
      ),
    );
  }
}
