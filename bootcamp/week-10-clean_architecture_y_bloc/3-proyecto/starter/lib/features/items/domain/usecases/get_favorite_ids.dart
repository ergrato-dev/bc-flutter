import '../repositories/favorites_repository.dart';

// ============================================
// USE CASE: GetFavoriteIds
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class GetFavoriteIds {
  GetFavoriteIds(this._repository);

  final FavoritesRepository _repository;

  Future<Set<String>> call() => _repository.getFavoriteIds();
}
