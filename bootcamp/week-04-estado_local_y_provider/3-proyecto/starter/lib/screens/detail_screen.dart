import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/sample_items.dart';
import '../models/item.dart';
import '../providers/favorites_provider.dart';

// ============================================
// SCREEN: DetailScreen
// Detalle de un elemento (semana 3) + botón de favorito (semana 4).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Completa los TODOs: resolver el elemento (patrón de semana 3) y agregar
// el botón de favorito usando FavoritesProvider (mismo patrón de ItemCard).
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.itemId, this.preloadedItem});

  final String itemId;
  final Item? preloadedItem;

  @override
  Widget build(BuildContext context) {
    // TODO: resuelve `resolvedItem` con `preloadedItem ?? findItemById(itemId)`.
    final Item? resolvedItem = null; // TODO: reemplaza esta línea

    if (resolvedItem == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: const Center(child: Text('Elemento no encontrado')),
      );
    }

    // TODO: lee `isFavorite` desde `context.watch<FavoritesProvider>()`
    // usando `resolvedItem.id`, y agrega un IconButton en `actions:` del
    // AppBar que llame `context.read<FavoritesProvider>().toggle(resolvedItem.id)`
    // (mismo patrón que ItemCard).

    return Scaffold(
      appBar: AppBar(title: Text(resolvedItem.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(resolvedItem.description),
      ),
    );
  }
}
