import 'package:dio/dio.dart';

import '../models/item.dart';

// ============================================
// REPOSITORY: ItemsRepository
// Contrato + implementación con Dio — el AsyncNotifier (items_provider.dart)
// solo conoce esta interfaz, nunca Dio directamente.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Completa el TODO de `fetchItems()` — mismo patrón de los ejercicios 02 y
// 03: GET a `/posts`, parsear cada elemento con `Item.fromJson`, y traducir
// `DioException` a un mensaje entendible.
abstract class ItemsRepository {
  Future<List<Item>> fetchItems();
}

class DioItemsRepository implements ItemsRepository {
  DioItemsRepository(this._dio);

  final Dio _dio;

  @override
  Future<List<Item>> fetchItems() async {
    // TODO: dentro de un try/catch on DioException:
    // 1. Ejecuta `await _dio.get('/posts')`.
    // 2. Mapea `response.data` (List) a `List<Item>` con `Item.fromJson`.
    // 3. En el catch, traduce `e.type` a un mensaje propio (ver archivo de
    //    teoría 03 y 06) — por ejemplo:
    //    if (e.type == DioExceptionType.connectionError) {
    //      throw Exception('Sin conexión a internet');
    //    }
    //    throw Exception('No se pudo cargar la información');
    throw UnimplementedError();
  }
}
