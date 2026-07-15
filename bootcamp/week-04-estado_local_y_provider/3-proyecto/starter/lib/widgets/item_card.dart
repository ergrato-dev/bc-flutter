import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../providers/favorites_provider.dart';

// ============================================
// WIDGET: ItemCard
// Tarjeta reutilizable con botón de favorito conectado a FavoritesProvider.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este widget ya está completo — muestra cómo usar context.watch (para
// pintar el ícono correcto) y context.read (para el onPressed) en un
// mismo widget. Puedes usarlo tal cual.
class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, this.onTap});

  final Item item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesProvider>().isFavorite(item.id);

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
          onPressed: () => context.read<FavoritesProvider>().toggle(item.id),
        ),
      ),
    );
  }
}
