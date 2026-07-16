import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'shared_preferences_provider.dart';

part 'favorites_provider.g.dart';

// ============================================
// PROVIDER: FavoritesNotifier
// Migración del FavoritesProvider (ChangeNotifier) de semana 4 — ahora
// persistido en SharedPreferences (ver teoría 02 de esta semana).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Tu trabajo esta semana es completar los dos TODOs: leer el estado inicial
// desde SharedPreferences en build(), y persistirlo en cada toggle().
@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  static const _prefsKey = 'favorite_ids';

  @override
  Set<String> build() {
    // TODO: lee `ref.watch(sharedPreferencesProvider)` y retorna
    // `(prefs.getStringList(_prefsKey) ?? const []).toSet()` en vez de `{}`.
    return {};
  }

  bool isFavorite(String id) => state.contains(id);

  void toggle(String id) {
    state = state.contains(id) ? ({...state}..remove(id)) : {...state, id};
    // TODO: persiste el nuevo estado (no necesitas `await` — no bloquees el
    // toggle esperando que el disco termine de escribir):
    // ref.read(sharedPreferencesProvider).setStringList(_prefsKey, state.toList());
  }
}
