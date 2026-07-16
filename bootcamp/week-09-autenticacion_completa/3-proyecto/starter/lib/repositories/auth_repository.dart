import 'package:dio/dio.dart';

// ============================================
// REPOSITORY: AuthRepository
// Contrato + implementación con Dio — mismo patrón que ItemsRepository
// (semana 6). Ver teoría 02.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
abstract class AuthRepository {
  Future<String> login(String username, String password);
}

class DioAuthRepository implements AuthRepository {
  DioAuthRepository(this._dio);

  final Dio _dio;

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      return response.data['accessToken'] as String;
    } on DioException catch (e) {
      throw Exception(_messageFor(e));
    }
  }

  String _messageFor(DioException e) {
    if (e.response?.statusCode == 400) return 'Usuario o contraseña incorrectos';
    if (e.type == DioExceptionType.connectionError) return 'Sin conexión a internet';
    return 'No se pudo iniciar sesión';
  }
}
