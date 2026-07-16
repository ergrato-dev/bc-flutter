import '../repositories/auth_repository.dart';

// ============================================
// USE CASE: GetAuthToken
// Usado por AuthCubit al arrancar la app, para el auto-login.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class GetAuthToken {
  GetAuthToken(this._repository);

  final AuthRepository _repository;

  Future<String?> call() => _repository.getToken();
}
