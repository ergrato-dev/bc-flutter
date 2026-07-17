import 'package:dio/dio.dart';

import '../models/item_model.dart';

// ============================================
// DATA SOURCE: ItemsRemoteDataSource
// Única clase del proyecto que sabe que existe Dio y jsonplaceholder — la
// misma responsabilidad de DioItemsRepository en semanas 6-9, ahora aislada
// como "fuente de datos remota" en vez de "repository" completo.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
abstract class ItemsRemoteDataSource {
  Future<List<ItemModel>> fetchItems();
  Future<void> createItem(ItemModel item);
}

class ItemsRemoteDataSourceImpl implements ItemsRemoteDataSource {
  ItemsRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<ItemModel>> fetchItems() async {
    try {
      final response = await _dio.get('/posts');
      return (response.data as List)
          .map((json) => ItemModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(_messageFor(e));
    }
  }

  @override
  Future<void> createItem(ItemModel item) async {
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
