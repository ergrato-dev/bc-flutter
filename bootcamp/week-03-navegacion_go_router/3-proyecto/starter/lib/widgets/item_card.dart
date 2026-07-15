import 'package:flutter/material.dart';

import '../models/item.dart';

// ============================================
// WIDGET: ItemCard
// Tarjeta reutilizable para mostrar un Item en la lista (de semana 2).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este widget ya está completo. `onTap` lo conecta HomeScreen con la
// navegación al detalle — no necesitas modificarlo.
class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, this.onTap});

  final Item item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(child: Icon(Icons.inventory_2)),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.description, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
