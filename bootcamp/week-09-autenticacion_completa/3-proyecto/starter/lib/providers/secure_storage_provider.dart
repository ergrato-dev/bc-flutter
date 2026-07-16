import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

// ============================================
// PROVIDER: secureStorage
// Expone la instancia de FlutterSecureStorage — ver teoría 03.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. A diferencia de
// sharedPreferencesProvider e itemsCacheBoxProvider (semana 8), este
// provider no necesita override en main(): FlutterSecureStorage() es un
// constructor síncrono, no carga nada por adelantado.
const authTokenKey = 'auth_token';

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}
