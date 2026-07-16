import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

// ============================================
// PROVIDER: sharedPreferences
// Expone la instancia de SharedPreferences ya cargada — ver teoría 02.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. El cuerpo real
// nunca se ejecuta: main.dart sobreescribe este provider con
// overrideWithValue() antes de runApp(), usando la instancia que cargó con
// SharedPreferences.getInstance().
@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('Debe sobreescribirse en main() — ver overrides de ProviderScope.');
}
