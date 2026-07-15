import 'package:flutter/material.dart';

import '../data/sample_items.dart';
import '../models/item.dart';

// ============================================
// SCREEN: DetailScreen
// Detalle de un elemento, alcanzable vía /items/:id (fuera del ShellRoute,
// por eso NO tiene la bottom nav bar — se apiló con context.push).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Completa el TODO usando el patrón "id como fuente de verdad, extra como
// caché" del ejercicio 02.
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

    return Scaffold(
      appBar: AppBar(title: Text(resolvedItem.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(resolvedItem.description),
      ),
    );
  }
}
