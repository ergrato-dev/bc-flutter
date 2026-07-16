import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/auth_repository.dart';
import 'auth_dio_provider.dart';

part 'auth_repository_provider.g.dart';

// ============================================
// PROVIDER: authRepository
// Expone AuthRepository al AuthNotifier — ya está completo.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
@riverpod
AuthRepository authRepository(Ref ref) {
  return DioAuthRepository(ref.watch(authDioProvider));
}
