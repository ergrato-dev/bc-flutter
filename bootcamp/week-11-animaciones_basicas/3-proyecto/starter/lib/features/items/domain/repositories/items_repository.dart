import '../entities/item.dart';

// ============================================
// CONTRATO: ItemsRepository
// El dominio define QUÉ necesita (obtener/crear elementos), nunca CÓMO se
// obtienen — esa implementación vive en data/repositories/items_repository_impl.dart.
// Mismo contrato de semanas 6-9, ahora en la capa domain. Ver teoría 02.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
abstract class ItemsRepository {
  Future<List<Item>> getItems();
  Future<void> createItem(Item item);
}
