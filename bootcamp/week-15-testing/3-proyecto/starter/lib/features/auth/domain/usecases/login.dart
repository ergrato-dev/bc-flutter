import '../repositories/auth_repository.dart';

// ============================================
// USE CASE: Login
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class Login {
  Login(this._repository);

  final AuthRepository _repository;

  Future<String> call(String username, String password) =>
      _repository.login(username, password);
}
