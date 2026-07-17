/// Dominio de ejemplo para el ejercicio 01 — ya está completo, no lo
/// modifiques. Tu trabajo es en test/get_items_test.dart.
library;

class Item {
  const Item({required this.id, required this.name, required this.description});

  final String id;
  final String name;
  final String description;
}

abstract class ItemsRepository {
  Future<List<Item>> getItems();
}

class GetItems {
  const GetItems(this._repository);

  final ItemsRepository _repository;

  Future<List<Item>> call() => _repository.getItems();
}
