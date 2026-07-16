import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/item.dart';
import 'items_repository_provider.dart';

part 'items_provider.g.dart';

// ============================================
// PROVIDER: ItemsNotifier
// Carga los elementos de tu dominio a través de ItemsRepository — a
// diferencia de semana 5, ya no simula datos con Future.delayed.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — mismo mecanismo de AsyncNotifier de
// semana 5, ahora delegando en el repository que completaste en
// items_repository.dart. No necesitas modificarlo.
@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  @override
  Future<List<Item>> build() async {
    final repository = ref.watch(itemsRepositoryProvider);
    return repository.fetchItems();
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
