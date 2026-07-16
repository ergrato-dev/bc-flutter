import '../entities/item.dart';
import '../repositories/items_repository.dart';

// ============================================
// USE CASE: CreateItem
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class CreateItem {
  CreateItem(this._repository);

  final ItemsRepository _repository;

  Future<void> call(Item item) => _repository.createItem(item);
}
