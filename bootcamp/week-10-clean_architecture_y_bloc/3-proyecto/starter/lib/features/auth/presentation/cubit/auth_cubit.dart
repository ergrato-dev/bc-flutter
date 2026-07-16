import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_auth_token.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import 'auth_state.dart';

// ============================================
// CUBIT: AuthCubit
// Mismo trabajo que AuthNotifier (semana 9) — el guard de rutas
// (app/app_router.dart) observa `state` vía GoRouterRefreshStream(stream),
// no ref.watch (Bloc no tiene ese mecanismo) — ver teoría 06.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// checkAuthStatus() ya está completo (se llama una vez al construir el
// cubit, mismo rol que build() leyendo el token guardado en semana 9). Tu
// trabajo esta semana es completar los TODOs de login() y logout().
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._getAuthToken, this._login, this._logout) : super(const AuthUnknown()) {
    checkAuthStatus();
  }

  final GetAuthToken _getAuthToken;
  final Login _login;
  final Logout _logout;

  Future<void> checkAuthStatus() async {
    final token = await _getAuthToken();
    emit(token != null ? AuthAuthenticated(token) : const AuthUnauthenticated());
  }

  Future<void> login(String username, String password) async {
    // TODO: implementa el login (mismo patrón que AuthNotifier.login() de
    // semana 9, ahora con emit() en vez de state =):
    // 1. `emit(const AuthLoading());`
    // 2. Dentro de un try, ejecuta `final token = await _login(username, password);`
    //    y `emit(AuthAuthenticated(token));`.
    // 3. En el catch, `emit(AuthError('$e'));`.
  }

  Future<void> logout() async {
    // TODO: implementa el logout:
    // 1. `await _logout();`
    // 2. `emit(const AuthUnauthenticated());`
  }
}
