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
// Este archivo ya está completo — no necesitas modificarlo. La migración de
// Clean Architecture de semana 10 ya terminó; esta semana solo agrega
// animaciones en la capa presentation (ver item_card.dart, detail_screen.dart
// y home_screen.dart).
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
    emit(const AuthLoading());
    try {
      final token = await _login(username, password);
      emit(AuthAuthenticated(token));
    } catch (e) {
      emit(AuthError('$e'));
    }
  }

  Future<void> logout() async {
    await _logout();
    emit(const AuthUnauthenticated());
  }
}
