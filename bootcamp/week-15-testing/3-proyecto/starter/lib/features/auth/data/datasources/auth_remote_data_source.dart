import 'package:dio/dio.dart';

// ============================================
// DATA SOURCE: AuthRemoteDataSource
// Única clase del proyecto que sabe que existe Dio y dummyjson.com — misma
// responsabilidad de DioAuthRepository en semana 9.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
abstract class AuthRemoteDataSource {
  Future<String> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._dio);

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
