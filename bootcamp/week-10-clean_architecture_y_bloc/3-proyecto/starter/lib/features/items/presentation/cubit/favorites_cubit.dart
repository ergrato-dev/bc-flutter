import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_favorite_ids.dart';
import '../../domain/usecases/toggle_favorite.dart';

// ============================================
// CUBIT: FavoritesCubit
// Mismo trabajo que FavoritesNotifier (semanas 4-9) — el estado es
// directamente Set<String>, sin necesitar una clase de estado propia (no
// hay loading/error: leer/escribir SharedPreferences no fluctúa entre
// estados visibles para el usuario).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class FavoritesCubit extends Cubit<Set<String>> {
  FavoritesCubit(this._getFavoriteIds, this._toggleFavorite) : super({}) {
    _load();
  }

  final GetFavoriteIds _getFavoriteIds;
  final ToggleFavorite _toggleFavorite;

  Future<void> _load() async {
    emit(await _getFavoriteIds());
  }

  bool isFavorite(String id) => state.contains(id);

  Future<void> toggle(String id) async {
    emit(await _toggleFavorite(state, id));
  }
}
