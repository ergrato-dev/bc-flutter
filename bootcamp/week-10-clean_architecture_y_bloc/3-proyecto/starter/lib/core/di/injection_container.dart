import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_auth_token.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/items/data/datasources/items_local_data_source.dart';
import '../../features/items/data/datasources/items_remote_data_source.dart';
import '../../features/items/data/repositories/favorites_repository_impl.dart';
import '../../features/items/data/repositories/items_repository_impl.dart';
import '../../features/items/domain/repositories/favorites_repository.dart';
import '../../features/items/domain/repositories/items_repository.dart';
import '../../features/items/domain/usecases/create_item.dart';
import '../../features/items/domain/usecases/get_favorite_ids.dart';
import '../../features/items/domain/usecases/get_items.dart';
import '../../features/items/domain/usecases/toggle_favorite.dart';
import '../../features/items/presentation/cubit/create_item_cubit.dart';
import '../../features/items/presentation/cubit/favorites_cubit.dart';
import '../../features/items/presentation/cubit/items_cubit.dart';

const _itemsDioInstance = 'itemsDio';
const _authDioInstance = 'authDio';

final getIt = GetIt.instance;

// ============================================
// DI: injection_container
// Registra cada dependencia una sola vez, en orden (de afuera hacia
// adentro: externos → datasources → repositories → use cases → cubits).
// get_it reemplaza el rol de los providers de Riverpod para exponer
// instancias — sin Riverpod, no hay `ref.watch`/`overrideWithValue()`.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. Ver teoría 05.
Future<void> initDependencies({
  required Box<dynamic> itemsBox,
  required SharedPreferences prefs,
}) async {
  // Externos — instancias que main() ya cargó antes de runApp().
  getIt.registerSingleton<Box<dynamic>>(itemsBox);
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  getIt.registerLazySingleton<Dio>(
    () {
      final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
      if (kDebugMode) dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      return dio;
    },
    instanceName: _itemsDioInstance,
  );
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: 'https://dummyjson.com')),
    instanceName: _authDioInstance,
  );

  // Feature: items
  getIt.registerLazySingleton<ItemsRemoteDataSource>(
    () => ItemsRemoteDataSourceImpl(getIt(instanceName: _itemsDioInstance)),
  );
  getIt.registerLazySingleton<ItemsLocalDataSource>(
    () => ItemsLocalDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetItems(getIt()));
  getIt.registerLazySingleton(() => CreateItem(getIt()));
  getIt.registerLazySingleton(() => GetFavoriteIds(getIt()));
  getIt.registerLazySingleton(() => ToggleFavorite(getIt()));
  getIt.registerLazySingleton(() => ItemsCubit(getIt()));
  getIt.registerLazySingleton(() => CreateItemCubit(getIt()));
  getIt.registerLazySingleton(() => FavoritesCubit(getIt(), getIt()));

  // Feature: auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt(instanceName: _authDioInstance)),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetAuthToken(getIt()));
  getIt.registerLazySingleton(() => Login(getIt()));
  getIt.registerLazySingleton(() => Logout(getIt()));
  getIt.registerLazySingleton(() => AuthCubit(getIt(), getIt(), getIt()));
}
