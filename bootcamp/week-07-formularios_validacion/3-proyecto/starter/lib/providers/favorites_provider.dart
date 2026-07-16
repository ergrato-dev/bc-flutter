import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_provider.g.dart';

// ============================================
// PROVIDER: FavoritesNotifier
// Migración directa del FavoritesProvider (ChangeNotifier) de semana 4.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — es el mismo patrón del ejercicio 01,
// aplicado a Set<String> en vez de int. No necesitas modificarlo.
@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  Set<String> build() => {};

  bool isFavorite(String id) => state.contains(id);

  void toggle(String id) {
    state = state.contains(id) ? ({...state}..remove(id)) : {...state, id};
  }
}
