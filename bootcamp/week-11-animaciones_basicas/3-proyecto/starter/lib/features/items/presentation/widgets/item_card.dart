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
// Tu trabajo esta semana es agregar dos animaciones (TODOs abajo):
// 1. Envolver el leading en un Hero — debe emparejar con el de DetailScreen.
// 2. Animar el fondo del ícono de favorito con AnimatedContainer.
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
        // TODO temporal: en el PASO 1, envuelve este CircleAvatar en un
        // Hero con tag 'item-icon-${item.id}' — ver instrucciones abajo.
        leading: const CircleAvatar(child: Icon(Icons.inventory_2)),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        // TODO temporal: en el PASO 2, envuelve este IconButton en un
        // AnimatedContainer que anime el color de fondo — ver instrucciones
        // abajo.
        trailing: IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: isFavorite ? Colors.red : null,
          onPressed: () => context.read<FavoritesCubit>().toggle(item.id),
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: Hero en el leading (emparejado con DetailScreen)
// ============================================
// Reemplaza `leading: const CircleAvatar(child: Icon(Icons.inventory_2))`
// por:
//
// leading: Hero(
//   tag: 'item-icon-${item.id}',
//   child: const CircleAvatar(child: Icon(Icons.inventory_2)),
// ),
//
// El tag debe coincidir EXACTAMENTE con el de DetailScreen (ver PASO 1 en
// detail_screen.dart) — ver teoría 04 sobre por qué el tag debe incluir el
// id, no un string fijo.

// ============================================
// PASO 2: AnimatedContainer en el fondo del favorito
// ============================================
// Reemplaza el `IconButton` de `trailing:` por:
//
// trailing: AnimatedContainer(
//   duration: const Duration(milliseconds: 250),
//   curve: Curves.easeOut,
//   decoration: BoxDecoration(
//     color: isFavorite ? Colors.red.withValues(alpha: 0.12) : Colors.transparent,
//     shape: BoxShape.circle,
//   ),
//   child: IconButton(
//     icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
//     color: isFavorite ? Colors.red : null,
//     onPressed: () => context.read<FavoritesCubit>().toggle(item.id),
//   ),
// ),
//
// Cada toggle anima el fondo circular (transparente → rojo tenue) en vez de
// cambiar de golpe — el mismo patrón de la teoría 02, aplicado a un `color`
// en vez de a `height`.
