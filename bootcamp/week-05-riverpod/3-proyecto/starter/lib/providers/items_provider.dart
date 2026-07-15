import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/item.dart';

part 'items_provider.g.dart';

// ============================================
// PROVIDER: ItemsNotifier
// Simula una fuente de datos asíncrona (como sería una llamada a una API
// real desde semana 6 con Dio). El AsyncNotifierProvider generado expone
// AsyncValue<List<Item>> — maneja loading/error/data automáticamente.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — es el mismo patrón del ejercicio 02.
// Reemplaza los elementos de ejemplo por al menos 4 elementos de tu
// dominio asignado.
@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  @override
  Future<List<Item>> build() async {
    await Future.delayed(const Duration(milliseconds: 600));
    // TODO: Reemplaza esta lista de ejemplo por elementos de tu dominio.
    return const [
      Item(id: '1', name: 'Elemento de ejemplo 1', description: 'Descripción breve del elemento 1'),
      Item(id: '2', name: 'Elemento de ejemplo 2', description: 'Descripción breve del elemento 2'),
      Item(id: '3', name: 'Elemento de ejemplo 3', description: 'Descripción breve del elemento 3'),
      Item(id: '4', name: 'Elemento de ejemplo 4', description: 'Descripción breve del elemento 4'),
    ];
  }
}

/// Busca un elemento por id dentro de una lista ya cargada. Retorna `null`
/// si no existe. Ya implementado — úsalo desde DetailScreen.
Item? findItemById(List<Item> items, String id) {
  for (final item in items) {
    if (item.id == id) return item;
  }
  return null;
}
