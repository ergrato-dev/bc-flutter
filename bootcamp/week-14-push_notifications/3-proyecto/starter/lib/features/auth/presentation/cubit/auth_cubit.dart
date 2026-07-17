import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../notifications/domain/repositories/notification_repository.dart';
import '../../domain/usecases/get_auth_token.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import 'auth_state.dart';

// ============================================
// CUBIT: AuthCubit
// Mismo trabajo que AuthNotifier (semana 9) — el guard de rutas
// (app/app_router.dart) observa `state` vía GoRouterRefreshStream(stream),
// no ref.watch (Bloc no tiene ese mecanismo) — ver teoría 06 de semana 13.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. Actualizado esta
// semana solo para pedir el permiso de notificaciones justo después de un
// login exitoso (ver teoría 04) — tu trabajo esta semana está en
// features/notifications/data/repositories/notification_repository_impl.dart.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._getAuthToken, this._login, this._logout, this._notificationRepository)
      : super(const AuthUnknown()) {
    checkAuthStatus();
  }

  final GetAuthToken _getAuthToken;
  final Login _login;
  final Logout _logout;
  final NotificationRepository _notificationRepository;

  Future<void> checkAuthStatus() async {
    final token = await _getAuthToken();
    emit(token != null ? AuthAuthenticated(token) : const AuthUnauthenticated());
  }

  Future<void> login(String username, String password) async {
    emit(const AuthLoading());
    try {
      final token = await _login(username, password);
      emit(AuthAuthenticated(token));
      // Pedir el permiso justo después del login, no al abrir la app en
      // frío — el contexto ("vas a recibir notificaciones de tus pedidos")
      // aumenta la tasa de aceptación (ver teoría 04).
      await _notificationRepository.ensurePermission();
    } catch (e) {
      emit(AuthError('$e'));
    }
  }

  Future<void> logout() async {
    await _logout();
    emit(const AuthUnauthenticated());
  }
}
