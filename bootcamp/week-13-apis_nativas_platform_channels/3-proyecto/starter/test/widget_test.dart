// ponytail: dos smoke tests — confirman que la app arranca autenticada
// mostrando el badge de favoritos en 0 (construyendo el árbol de cubits y
// el router a mano, sin get_it: un test nunca debe golpear Dio, Hive ni
// flutter_secure_storage reales), y que FavoritesCubit.toggle() funciona en
// aislamiento sobre un FavoritesRepository falso en memoria. No verifican
// PhotoPickerField (cámara/permiso reales) ni las animaciones de semanas
// 11-12 — eso se comprueba visualmente en el emulador/simulador. Ver
// teoría 06 sobre cómo un PhotoRepository envuelto haría esto testeable.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:domain_native_apis_app/app/app_router.dart';
import 'package:domain_native_apis_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:domain_native_apis_app/features/auth/domain/usecases/get_auth_token.dart';
import 'package:domain_native_apis_app/features/auth/domain/usecases/login.dart';
import 'package:domain_native_apis_app/features/auth/domain/usecases/logout.dart';
import 'package:domain_native_apis_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:domain_native_apis_app/features/items/domain/entities/item.dart';
import 'package:domain_native_apis_app/features/items/domain/repositories/favorites_repository.dart';
import 'package:domain_native_apis_app/features/items/domain/repositories/items_repository.dart';
import 'package:domain_native_apis_app/features/items/domain/usecases/create_item.dart';
import 'package:domain_native_apis_app/features/items/domain/usecases/get_favorite_ids.dart';
import 'package:domain_native_apis_app/features/items/domain/usecases/get_items.dart';
import 'package:domain_native_apis_app/features/items/domain/usecases/toggle_favorite.dart';
import 'package:domain_native_apis_app/features/items/presentation/cubit/create_item_cubit.dart';
import 'package:domain_native_apis_app/features/items/presentation/cubit/favorites_cubit.dart';
import 'package:domain_native_apis_app/features/items/presentation/cubit/items_cubit.dart';

class FakeItemsRepository implements ItemsRepository {
  @override
  Future<List<Item>> getItems() async => const [
        Item(id: '1', name: 'Elemento de prueba', description: 'Descripción de prueba'),
      ];

  @override
  Future<void> createItem(Item item) async {}
}

class FakeFavoritesRepository implements FavoritesRepository {
  Set<String> _ids = {};

  @override
  Future<Set<String>> getFavoriteIds() async => _ids;

  @override
  Future<void> saveFavoriteIds(Set<String> ids) async => _ids = ids;
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<String?> getToken() async => 'fake-token';

  @override
  Future<String> login(String username, String password) async => 'fake-token';

  @override
  Future<void> logout() async {}
}

void main() {
  testWidgets('La app arranca autenticada con el badge de favoritos en 0', (tester) async {
    final authRepository = FakeAuthRepository();
    final authCubit = AuthCubit(
      GetAuthToken(authRepository),
      Login(authRepository),
      Logout(authRepository),
    );
    final itemsCubit = ItemsCubit(GetItems(FakeItemsRepository()));
    final createItemCubit = CreateItemCubit(CreateItem(FakeItemsRepository()));
    final favoritesRepository = FakeFavoritesRepository();
    final favoritesCubit = FavoritesCubit(
      GetFavoriteIds(favoritesRepository),
      ToggleFavorite(favoritesRepository),
    );
    addTearDown(() {
      authCubit.close();
      itemsCubit.close();
      createItemCubit.close();
      favoritesCubit.close();
    });

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authCubit),
          BlocProvider.value(value: itemsCubit),
          BlocProvider.value(value: createItemCubit),
          BlocProvider.value(value: favoritesCubit),
        ],
        child: MaterialApp.router(routerConfig: buildAppRouter(authCubit)),
      ),
    );
    // No pumpAndSettle: mientras el estado es ItemsLoading, el
    // CircularProgressIndicator indeterminado anima indefinidamente —
    // pumpAndSettle nunca terminaría de esperar. Dos pumps alcanzan para
    // que fetchItems() (ya implementado) resuelva y HomeScreen reconstruya
    // con ItemsLoaded.
    await tester.pump();
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
  });

  test('FavoritesCubit.toggle agrega, persiste y quita un id', () async {
    final repository = FakeFavoritesRepository();
    final cubit = FavoritesCubit(GetFavoriteIds(repository), ToggleFavorite(repository));
    addTearDown(cubit.close);

    expect(cubit.state, isEmpty);

    await cubit.toggle('1');
    expect(cubit.state, {'1'});

    await cubit.toggle('1');
    expect(cubit.state, isEmpty);
  });
}
