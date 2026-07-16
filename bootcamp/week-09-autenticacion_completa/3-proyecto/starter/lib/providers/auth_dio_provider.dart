import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_dio_provider.g.dart';

// ============================================
// PROVIDER: authDio
// Instancia de Dio dedicada al servicio de autenticación — baseUrl distinto
// al de tus datos de dominio (dioProvider). Ver teoría 02.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
@Riverpod(keepAlive: true)
Dio authDio(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
}
