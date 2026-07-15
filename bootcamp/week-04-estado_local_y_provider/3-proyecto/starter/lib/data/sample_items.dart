import '../models/item.dart';

// ============================================
// DATA: sampleItems + findItemById
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Reemplaza estos elementos de ejemplo por al menos 4 elementos reales de
// tu dominio asignado. `findItemById` ya está implementado.
const List<Item> sampleItems = [
  Item(id: '1', name: 'Elemento de ejemplo 1', description: 'Descripción breve del elemento 1'),
  Item(id: '2', name: 'Elemento de ejemplo 2', description: 'Descripción breve del elemento 2'),
  Item(id: '3', name: 'Elemento de ejemplo 3', description: 'Descripción breve del elemento 3'),
  Item(id: '4', name: 'Elemento de ejemplo 4', description: 'Descripción breve del elemento 4'),
];

/// Busca un elemento por id. Retorna `null` si no existe.
Item? findItemById(String id) {
  for (final item in sampleItems) {
    if (item.id == id) return item;
  }
  return null;
}
