// ============================================
// CONTRATO: FavoritesRepository
// Favoritos vive dentro de la feature items (no es una feature propia) —
// solo tiene sentido en relación a un Item, así que separarlo en su propio
// features/favorites/ obligaría a items a depender de esa feature de todos
// modos. Ver teoría 02.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
abstract class FavoritesRepository {
  Future<Set<String>> getFavoriteIds();
  Future<void> saveFavoriteIds(Set<String> ids);
}
