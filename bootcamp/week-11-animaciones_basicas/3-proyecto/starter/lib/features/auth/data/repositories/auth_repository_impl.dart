import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

// ============================================
// REPOSITORY IMPL: AuthRepositoryImpl
// Mismo patrón de AuthNotifier de semana 9 (persistir/borrar el token),
// migrado a esta capa.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. Tu trabajo esta
// semana está en AuthCubit (presentation/cubit/) — ver teoría 03.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._storage);

  final AuthRemoteDataSource _remote;
  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';

  @override
  Future<String?> getToken() => _storage.read(key: _tokenKey);

  @override
  Future<String> login(String username, String password) async {
    final token = await _remote.login(username, password);
    await _storage.write(key: _tokenKey, value: token);
    return token;
  }

  @override
  Future<void> logout() => _storage.delete(key: _tokenKey);
}
