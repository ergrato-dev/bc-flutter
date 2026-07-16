import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../models/item_model.dart';

// ============================================
// DATA SOURCE: ItemsLocalDataSource
// Única clase del proyecto que sabe que existe Hive — la misma
// responsabilidad del Box directo en CachedItemsRepository de semana 8,
// ahora aislada como "fuente de datos local".
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
abstract class ItemsLocalDataSource {
  Future<List<ItemModel>?> getCachedItems();
  Future<void> cacheItems(List<ItemModel> items);
}

class ItemsLocalDataSourceImpl implements ItemsLocalDataSource {
  ItemsLocalDataSourceImpl(this._box);

  final Box<dynamic> _box;

  static const _cacheKey = 'items';

  @override
  Future<List<ItemModel>?> getCachedItems() async {
    final cached = _box.get(_cacheKey) as List?;
    if (cached == null) return null;
    return cached.map(ItemModel.fromCacheMap).toList();
  }

  @override
  Future<void> cacheItems(List<ItemModel> items) async {
    await _box.put(_cacheKey, items.map((item) => item.toCacheMap()).toList());
  }
}
