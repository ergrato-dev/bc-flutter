import 'package:flutter/foundation.dart';

// ============================================
// PROVIDER: FavoritesProvider
// ChangeNotifier que mantiene el conjunto de ids marcados como favoritos.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — es el mismo patrón que practicaste en
// los ejercicios 01-03. No necesitas modificarlo, solo consumirlo desde
// las pantallas (context.watch/context.read).
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  int get count => _favoriteIds.length;

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggle(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }
}
