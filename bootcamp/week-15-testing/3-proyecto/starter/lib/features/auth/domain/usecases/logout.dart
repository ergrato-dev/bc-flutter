import '../repositories/auth_repository.dart';

// ============================================
// USE CASE: Logout
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class Logout {
  Logout(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
