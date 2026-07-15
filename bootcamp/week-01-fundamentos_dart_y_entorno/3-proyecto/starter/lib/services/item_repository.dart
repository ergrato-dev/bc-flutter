import '../models/item.dart';

// ============================================
// SERVICE: ItemRepository
// Simula una fuente de datos asíncrona (como sería una llamada a una API
// real desde semana 6 con Dio). Por ahora usa Future.delayed para simular
// la latencia de red sin depender de ningún servicio externo.
// ============================================
class ItemRepository {
  /// Obtiene la lista de elementos del dominio.
  ///
  /// TODO: Reemplaza los datos de ejemplo por elementos de TU dominio
  /// asignado. Mantén el `Future.delayed` — simula la latencia real que
  /// tendrás desde semana 6 al consumir una API de verdad.
  Future<List<Item>> fetchItems() {
    return Future.delayed(const Duration(milliseconds: 300), () {
      // TODO: Reemplaza esta lista de ejemplo por elementos de tu dominio.
      return <Item>[
        Item(id: 'item_001', name: 'Elemento de ejemplo 1', createdAt: DateTime.now()),
        Item(id: 'item_002', name: 'Elemento de ejemplo 2', createdAt: DateTime.now()),
      ];
    });
  }

  /// Busca un elemento por id. Retorna `null` si no existe — practica
  /// null safety consumiendo este método desde `main.dart`.
  ///
  /// TODO: Implementa la búsqueda sobre el resultado de fetchItems().
  Future<Item?> findById(String id) async {
    // TODO: usa fetchItems(), luego busca el elemento con ese id.
    // Pista: List.where + firstOrNull, o un for con early return.
    throw UnimplementedError('findById no implementado');
  }
}
