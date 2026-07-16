import '../repositories/favorites_repository.dart';

// ============================================
// USE CASE: ToggleFavorite
// Recibe el conjunto actual de favoritos (lo mantiene el Cubit, no este use
// case) y retorna el nuevo conjunto ya persistido.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class ToggleFavorite {
  ToggleFavorite(this._repository);

  final FavoritesRepository _repository;

  Future<Set<String>> call(Set<String> currentIds, String id) async {
    final newIds =
        currentIds.contains(id) ? ({...currentIds}..remove(id)) : {...currentIds, id};
    await _repository.saveFavoriteIds(newIds);
    return newIds;
  }
}
