// ignore: unused_import — se usa al descomentar el PASO 1 (MaterialApp, find, tap...).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: unused_import — se usa al descomentar el PASO 1 (BlocProvider).
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: unused_import — se usa al descomentar el PASO 1 (Item).
import 'package:domain_testing_app/features/items/domain/entities/item.dart';
import 'package:domain_testing_app/features/items/domain/repositories/favorites_repository.dart';
// ignore: unused_import — se usa al descomentar el PASO 1 (GetFavoriteIds).
import 'package:domain_testing_app/features/items/domain/usecases/get_favorite_ids.dart';
// ignore: unused_import — se usa al descomentar el PASO 1 (ToggleFavorite).
import 'package:domain_testing_app/features/items/domain/usecases/toggle_favorite.dart';
// ignore: unused_import — se usa al descomentar el PASO 1 (FavoritesCubit).
import 'package:domain_testing_app/features/items/presentation/cubit/favorites_cubit.dart';
// ignore: unused_import — se usa al descomentar el PASO 1 (ItemCard).
import 'package:domain_testing_app/features/items/presentation/widgets/item_card.dart';

/// Repository en memoria — evita golpear SharedPreferences real en el test
/// (mismo patrón de FakeFavoritesRepository en test/widget_test.dart).
class FakeFavoritesRepository implements FavoritesRepository {
  Set<String> _ids = {};

  @override
  Future<Set<String>> getFavoriteIds() async => _ids;

  @override
  Future<void> saveFavoriteIds(Set<String> ids) async => _ids = ids;
}

void main() {
  group('ItemCard', () {
    // TODO temporal: en el PASO 1, agrega los tests — ver instrucciones al
    // final del archivo.
  });
}

// ============================================
// PASO 1: renderizado y toggle de favorito
// ============================================
// Agrega esto dentro de group('ItemCard', () { ... }):
//
// const item = Item(id: '1', name: 'Laptop', description: 'Portátil 14"');
//
// Widget buildCard(FavoritesCubit cubit) {
//   return MaterialApp(
//     home: Scaffold(
//       body: BlocProvider.value(
//         value: cubit,
//         child: const ItemCard(item: item),
//       ),
//     ),
//   );
// }
//
// testWidgets('muestra el nombre y la descripción del elemento', (tester) async {
//   final repository = FakeFavoritesRepository();
//   final cubit = FavoritesCubit(GetFavoriteIds(repository), ToggleFavorite(repository));
//   addTearDown(cubit.close);
//
//   await tester.pumpWidget(buildCard(cubit));
//   await tester.pump(); // deja que _load() de FavoritesCubit resuelva
//
//   expect(find.text('Laptop'), findsOneWidget);
//   expect(find.text('Portátil 14"'), findsOneWidget);
//   expect(find.byIcon(Icons.favorite_border), findsOneWidget);
// });
//
// testWidgets('tocar el ícono marca el elemento como favorito', (tester) async {
//   final repository = FakeFavoritesRepository();
//   final cubit = FavoritesCubit(GetFavoriteIds(repository), ToggleFavorite(repository));
//   addTearDown(cubit.close);
//
//   await tester.pumpWidget(buildCard(cubit));
//   await tester.pump();
//
//   await tester.tap(find.byIcon(Icons.favorite_border));
//   await tester.pump(); // setState() del toggle
//   await tester.pump(const Duration(milliseconds: 300)); // termina el "pop"
//
//   expect(find.byIcon(Icons.favorite), findsOneWidget);
// });
//
// ✅ Verifica: `flutter test` debe mostrar "All tests passed!" con ambos
// tests en verde.
