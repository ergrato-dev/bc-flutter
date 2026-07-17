import '../../domain/entities/item.dart';
import '../../domain/repositories/items_repository.dart';
import '../datasources/items_local_data_source.dart';
import '../datasources/items_remote_data_source.dart';
import '../models/item_model.dart';

// ============================================
// REPOSITORY IMPL: ItemsRepositoryImpl
// Implementa el contrato del dominio orquestando las dos fuentes de datos
// — red primero, cache como respaldo (mismo patrón que CachedItemsRepository
// de semana 8, ahora con datasources en vez de un Box directo).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — mismo patrón de CachedItemsRepository de
// semana 8, migrado a esta capa. Tu trabajo esta semana está en los cubits
// (presentation/cubit/) — ver teoría 03.
class ItemsRepositoryImpl implements ItemsRepository {
  ItemsRepositoryImpl(this._remote, this._local);

  final ItemsRemoteDataSource _remote;
  final ItemsLocalDataSource _local;

  @override
  Future<List<Item>> getItems() async {
    try {
      final items = await _remote.fetchItems();
      await _local.cacheItems(items);
      return items;
    } catch (_) {
      final cached = await _local.getCachedItems();
      if (cached != null) return cached;
      rethrow;
    }
  }

  @override
  Future<void> createItem(Item item) {
    final model = ItemModel(
      id: item.id,
      name: item.name,
      description: item.description,
      photoPath: item.photoPath,
    );
    return _remote.createItem(model);
  }
}
