import 'dart:io';

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
// Este archivo ya está completo — no necesitas modificarlo. El Hero,
// AnimatedContainer y el "pop" de _FavoriteButton (semanas 11-12) siguen
// igual, igual que mostrar `item.photoPath` (semana 13). Tu trabajo esta
// semana está en
// features/notifications/data/repositories/notification_repository_impl.dart.
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
          child: CircleAvatar(
            backgroundImage: item.photoPath != null ? FileImage(File(item.photoPath!)) : null,
            child: item.photoPath == null ? const Icon(Icons.inventory_2) : null,
          ),
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
// AnimatedContainer (semana 11) + "pop" de escala con AnimationController
// (semana 12) — ambos ya completos.
// ============================================
class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton({required this.itemId, required this.isFavorite});

  final String itemId;
  final bool isFavorite;

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _bounce = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
    TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
  ]).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: widget.isFavorite ? Colors.red.withValues(alpha: 0.12) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: ScaleTransition(
        scale: _bounce,
        child: IconButton(
          icon: Icon(widget.isFavorite ? Icons.favorite : Icons.favorite_border),
          color: widget.isFavorite ? Colors.red : null,
          onPressed: () {
            _controller.forward(from: 0);
            context.read<FavoritesCubit>().toggle(widget.itemId);
          },
        ),
      ),
    );
  }
}
