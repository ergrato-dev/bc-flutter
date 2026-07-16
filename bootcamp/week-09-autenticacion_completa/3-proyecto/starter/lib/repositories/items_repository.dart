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
// Este archivo ya está completo (semanas 6-8) — no necesitas modificarlo. Tu
// trabajo esta semana está en lib/providers/auth_provider.dart y
// lib/providers/dio_provider.dart.
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
    try {
      final items = await _remote.fetchItems();
      await _box.put(_cacheKey, items.map(_toCacheMap).toList());
      return items;
    } catch (_) {
      final cached = _box.get(_cacheKey) as List?;
      if (cached != null) return cached.map(_fromCacheMap).toList();
      rethrow;
    }
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
