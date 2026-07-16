import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item.dart';
import '../providers/favorites_provider.dart';

// ============================================
// WIDGET: ItemCard
// Tarjeta reutilizable con botón de favorito conectado a FavoritesNotifier.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este widget ya está completo — mismo patrón que semana 4, ahora con
// ref.watch/ref.read en vez de context.watch/context.read.
class ItemCard extends ConsumerWidget {
  const ItemCard({super.key, required this.item, this.onTap});

  final Item item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(item.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(child: Icon(Icons.inventory_2)),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: isFavorite ? Colors.red : null,
          onPressed: () => ref.read(favoritesProvider.notifier).toggle(item.id),
        ),
      ),
    );
  }
}
