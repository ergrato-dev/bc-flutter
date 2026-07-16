import 'package:equatable/equatable.dart';

// ============================================
// STATE: AuthState
// `AuthAuthenticated`/`AuthUnauthenticated` son los dos que lee el guard de
// rutas (app/app_router.dart) — ver teoría 06.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthUnknown extends AuthState {
  const AuthUnknown();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.token);

  final String token;

  @override
  List<Object?> get props => [token];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
