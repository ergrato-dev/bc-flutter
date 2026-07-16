import 'package:dio/dio.dart';

import '../models/item.dart';

// ============================================
// REPOSITORY: ItemsRepository
// Contrato + implementación con Dio — el AsyncNotifier de lectura
// (items_provider.dart) y el de escritura (create_item_provider.dart)
// solo conocen esta interfaz, nunca Dio directamente.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// `fetchItems()` ya está completo (semana 6). Tu trabajo esta semana es
// completar el TODO de `createItem()` — mismo patrón, ahora con POST.
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
    // TODO: dentro de un try/catch on DioException:
    // 1. Ejecuta `await _dio.post('/posts', data: item.toJson())`.
    // 2. En el catch, traduce el error con `_messageFor(e)` (ya implementado
    //    abajo) — no dejes escapar la DioException cruda.
    throw UnimplementedError();
  }

  String _messageFor(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return 'Sin conexión a internet';
    }
    return 'No se pudo completar la operación';
  }
}
