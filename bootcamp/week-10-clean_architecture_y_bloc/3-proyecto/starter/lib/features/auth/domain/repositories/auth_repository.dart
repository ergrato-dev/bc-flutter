// ============================================
// CONTRATO: AuthRepository
// Mismo contrato de semana 9, ahora en la capa domain — agrega getToken()
// para el auto-login (antes vivía directo en AuthNotifier.build()).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
abstract class AuthRepository {
  Future<String?> getToken();
  Future<String> login(String username, String password);
  Future<void> logout();
}
