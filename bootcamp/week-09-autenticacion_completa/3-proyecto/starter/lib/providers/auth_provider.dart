import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_repository_provider.dart';
import 'items_cache_box_provider.dart';
import 'secure_storage_provider.dart';
import 'shared_preferences_provider.dart';

part 'auth_provider.g.dart';

// ============================================
// PROVIDER: AuthNotifier
// Estado de sesión: `AsyncData(null)` = sin sesión, `AsyncData(token)` =
// autenticado. build() intenta un auto-login leyendo el token guardado.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Tu trabajo esta semana es completar los dos TODOs: persistir el token al
// hacer login, y limpiar todo lo persistido (token + cache de semana 8) al
// hacer logout — ver teoría 03 y 06.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<String?> build() async {
    final storage = ref.watch(secureStorageProvider);
    return storage.read(key: authTokenKey);
  }

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final token = await ref.read(authRepositoryProvider).login(username, password);
      // TODO: guarda el token en flutter_secure_storage antes de retornarlo:
      // await ref.read(secureStorageProvider).write(key: authTokenKey, value: token);
      return token;
    });
  }

  Future<void> logout() async {
    // TODO: borra el token de flutter_secure_storage, y limpia el cache de
    // semana 8 (favoritos + items) — un segundo usuario en el mismo
    // dispositivo no debe ver los datos de la sesión anterior:
    // await ref.read(secureStorageProvider).delete(key: authTokenKey);
    // await ref.read(sharedPreferencesProvider).clear();
    // await ref.read(itemsCacheBoxProvider).clear();
    state = const AsyncData(null);
  }
}
