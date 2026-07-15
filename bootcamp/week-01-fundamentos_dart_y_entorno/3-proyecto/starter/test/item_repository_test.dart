// ponytail: un único smoke test — confirma que fetchItems() resuelve y que
// el repositorio no explota, sin exigir una suite exhaustiva a un proyecto
// de semana 1. Súbelo de nivel cuando implementes tus propios TODOs.
import 'package:test/test.dart';

import 'package:domain_modeler_console/services/item_repository.dart';

void main() {
  group('ItemRepository', () {
    test('fetchItems resuelve con al menos un elemento', () async {
      final repository = ItemRepository();

      final items = await repository.fetchItems();

      expect(items, isNotEmpty);
    });
  });
}
