import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'shared_preferences_provider.dart';

part 'favorites_provider.g.dart';

// ============================================
// PROVIDER: FavoritesNotifier
// Migración del FavoritesProvider (ChangeNotifier) de semana 4 — persistido
// en SharedPreferences desde semana 8.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo (semana 8) — no necesitas modificarlo. Tu
// trabajo esta semana está en lib/providers/auth_provider.dart y
// lib/providers/dio_provider.dart.
@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  static const _prefsKey = 'favorite_ids';

  @override
  Set<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return (prefs.getStringList(_prefsKey) ?? const []).toSet();
  }

  bool isFavorite(String id) => state.contains(id);

  void toggle(String id) {
    state = state.contains(id) ? ({...state}..remove(id)) : {...state, id};
    ref.read(sharedPreferencesProvider).setStringList(_prefsKey, state.toList());
  }
}
