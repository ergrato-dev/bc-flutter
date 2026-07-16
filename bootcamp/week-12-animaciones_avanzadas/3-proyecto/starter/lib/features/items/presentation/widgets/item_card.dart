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
// El Hero y el AnimatedContainer de semana 11 ya están completos — esta
// semana no toca ItemCard directamente. Tu trabajo está en
// _FavoriteButton (al final de este archivo): un "pop" de escala con
// AnimationController al tocar el ícono.
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
        leading: Hero(
          tag: 'item-icon-${item.id}',
          child: const CircleAvatar(child: Icon(Icons.inventory_2)),
        ),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: _FavoriteButton(itemId: item.id, isFavorite: isFavorite),
      ),
    );
  }
}

// ============================================
// WIDGET: _FavoriteButton
// AnimatedContainer (semana 11, ya completo) + "pop" de escala con
// AnimationController (semana 12, tu trabajo — ver TODOs abajo).
// ============================================
class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton({required this.itemId, required this.isFavorite});

  final String itemId;
  final bool isFavorite;

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

// TODO temporal: en el PASO 1, agrega `with SingleTickerProviderStateMixin`
// a esta clase.
class _FavoriteButtonState extends State<_FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: widget.isFavorite ? Colors.red.withValues(alpha: 0.12) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      // TODO temporal: en el PASO 3, envuelve este IconButton en un
      // ScaleTransition que use el bounce del PASO 2, y dispara
      // `_controller.forward(from: 0)` en el onPressed — ver instrucciones
      // abajo.
      child: IconButton(
        icon: Icon(widget.isFavorite ? Icons.favorite : Icons.favorite_border),
        color: widget.isFavorite ? Colors.red : null,
        onPressed: () => context.read<FavoritesCubit>().toggle(widget.itemId),
      ),
    );
  }
}

// ============================================
// PASO 1: el controller y su dispose
// ============================================
// Agrega `with SingleTickerProviderStateMixin` a `_FavoriteButtonState`, y
// dentro de la clase:
//
// late final AnimationController _controller = AnimationController(
//   duration: const Duration(milliseconds: 300),
//   vsync: this,
// );
//
// @override
// void dispose() {
//   _controller.dispose();
//   super.dispose();
// }

// ============================================
// PASO 2: TweenSequence de "pop" (crece y vuelve)
// ============================================
// Agrega este campo debajo de `_controller` (ver teoría 04 — TweenSequence):
//
// late final Animation<double> _bounce = TweenSequence<double>([
//   TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
//   TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
// ]).animate(_controller);

// ============================================
// PASO 3: ScaleTransition + disparar el bounce al tocar
// ============================================
// Reemplaza el `IconButton` de arriba por:
//
// ScaleTransition(
//   scale: _bounce,
//   child: IconButton(
//     icon: Icon(widget.isFavorite ? Icons.favorite : Icons.favorite_border),
//     color: widget.isFavorite ? Colors.red : null,
//     onPressed: () {
//       _controller.forward(from: 0);
//       context.read<FavoritesCubit>().toggle(widget.itemId);
//     },
//   ),
// ),
//
// El bounce corre en CADA toque (agregar o quitar de favoritos) — un solo
// `forward(from: 0)` sin necesitar `reverse()` manual, porque el
// TweenSequence ya vuelve a 1.0 en su segunda mitad.
