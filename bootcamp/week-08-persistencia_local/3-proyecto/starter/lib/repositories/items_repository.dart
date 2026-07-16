import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../models/item.dart';

// ============================================
// REPOSITORY: ItemsRepository
// Contrato + dos implementaciones: DioItemsRepository (red, semana 6-7) y
// CachedItemsRepository (decorator con cache local, semana 8). El
// AsyncNotifier de lectura (items_provider.dart) y el de escritura
// (create_item_provider.dart) solo conocen esta interfaz.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// DioItemsRepository ya está completo (semanas 6-7). Tu trabajo esta semana
// es completar el TODO de CachedItemsRepository.fetchItems() — ver teoría 05.
abstract class ItemsRepository {
  Future<List<Item>> fetchItems();
  Future<void> createItem(Item item);
}

class DioItemsRepository implements ItemsRepository {
  DioItemsRepository(this._dio);

  final Dio _dio;

  @override
  Future<List<Item>> fetchItems() async {
    try {
      final response = await _dio.get('/posts');
      return (response.data as List)
          .map((json) => Item.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(_messageFor(e));
    }
  }

  @override
  Future<void> createItem(Item item) async {
    try {
      await _dio.post('/posts', data: item.toJson());
    } on DioException catch (e) {
      throw Exception(_messageFor(e));
    }
  }

  String _messageFor(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return 'Sin conexión a internet';
    }
    return 'No se pudo completar la operación';
  }
}

// ============================================
// REPOSITORY: CachedItemsRepository
// Decorator sobre ItemsRepository — agrega cache local en Hive sin que
// DioItemsRepository ni ItemsNotifier necesiten saber que existe.
// ============================================
class CachedItemsRepository implements ItemsRepository {
  CachedItemsRepository(this._remote, this._box);

  final ItemsRepository _remote;
  final Box<dynamic> _box;

  static const _cacheKey = 'items';

  @override
  Future<List<Item>> fetchItems() async {
    // TODO: implementa la estrategia network-first con fallback (ver
    // teoría 05):
    // 1. Dentro de un try, ejecuta `await _remote.fetchItems()`.
    // 2. Si tiene éxito, guarda el resultado en cache antes de retornarlo:
    //    `await _box.put(_cacheKey, items.map(_toCacheMap).toList());`
    //    y retorna `items`.
    // 3. En el catch (genérico — sin conexión, timeout, lo que sea), lee
    //    `_box.get(_cacheKey) as List?`.
    // 4. Si no es null, mapea de vuelta con `_fromCacheMap` y retórnalo.
    // 5. Si es null (nunca hubo cache), relanza el error original con
    //    `rethrow`.
    throw UnimplementedError();
  }

  @override
  Future<void> createItem(Item item) => _remote.createItem(item);

  Map<String, dynamic> _toCacheMap(Item item) => {
        'id': item.id,
        'name': item.name,
        'description': item.description,
      };

  Item _fromCacheMap(dynamic map) {
    final m = map as Map;
    return Item(
      id: m['id'] as String,
      name: m['name'] as String,
      description: m['description'] as String,
    );
  }
}
