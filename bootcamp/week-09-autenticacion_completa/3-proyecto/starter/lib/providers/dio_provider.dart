import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secure_storage_provider.dart';

part 'dio_provider.g.dart';

// ============================================
// PROVIDER: dio
// Instancia única de Dio para toda la app — keepAlive evita que Riverpod la
// destruya cuando ninguna pantalla la está observando.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// El Dio y el LogInterceptor ya están completos (semana 6). Tu trabajo esta
// semana es completar el TODO del interceptor de autenticación — ver
// teoría 04.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // TODO: lee el token con
        // `await ref.read(secureStorageProvider).read(key: authTokenKey)`
        // y, si no es null, agrégalo como header antes de continuar:
        // `options.headers['Authorization'] = 'Bearer $token';`
        handler.next(options);
      },
    ),
  );
  return dio;
}
