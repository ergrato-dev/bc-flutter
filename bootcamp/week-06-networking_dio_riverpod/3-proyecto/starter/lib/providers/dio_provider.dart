import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

// ============================================
// PROVIDER: dio
// Instancia única de Dio para toda la app — keepAlive evita que Riverpod la
// destruya cuando ninguna pantalla la está observando.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. Si tu dominio
// usa otra API, cambia `baseUrl` aquí (único lugar de la app donde vive).
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
  return dio;
}
