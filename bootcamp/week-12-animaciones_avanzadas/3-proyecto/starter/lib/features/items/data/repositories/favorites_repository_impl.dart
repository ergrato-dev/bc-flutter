import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/favorites_repository.dart';

// ============================================
// REPOSITORY IMPL: FavoritesRepositoryImpl
// Mismo patrón de FavoritesNotifier de semana 8-9, migrado a esta capa.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _prefsKey = 'favorite_ids';

  @override
  Future<Set<String>> getFavoriteIds() async {
    return (_prefs.getStringList(_prefsKey) ?? const []).toSet();
  }

  @override
  Future<void> saveFavoriteIds(Set<String> ids) async {
    await _prefs.setStringList(_prefsKey, ids.toList());
  }
}
