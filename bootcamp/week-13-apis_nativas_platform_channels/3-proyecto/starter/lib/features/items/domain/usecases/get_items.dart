import '../entities/item.dart';
import '../repositories/items_repository.dart';

// ============================================
// USE CASE: GetItems
// Una clase por acción de negocio, con un único método `call()` — permite
// invocar la instancia como función: `getItems()`. Ver teoría 02.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class GetItems {
  GetItems(this._repository);

  final ItemsRepository _repository;

  Future<List<Item>> call() => _repository.getItems();
}
