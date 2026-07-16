import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/item.dart';
import '../cubit/favorites_cubit.dart';

// ============================================
// WIDGET: ItemCard
// Tarjeta reutilizable con botón de favorito conectado a FavoritesCubit —
// mismo patrón que semanas 4-9, ahora con context.watch/context.read en vez
// de ref.watch/ref.read.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, this.onTap});

  final Item item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesCubit>().isFavorite(item.id);

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
          onPressed: () => context.read<FavoritesCubit>().toggle(item.id),
        ),
      ),
    );
  }
}
