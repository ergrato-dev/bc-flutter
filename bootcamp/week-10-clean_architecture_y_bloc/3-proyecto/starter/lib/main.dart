import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_router.dart';
import 'core/di/injection_container.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/items/presentation/cubit/create_item_cubit.dart';
import 'features/items/presentation/cubit/favorites_cubit.dart';
import 'features/items/presentation/cubit/items_cubit.dart';

// ============================================
// Clean Architecture y Bloc — Proyecto Semana 10
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. main() carga Hive/SharedPreferences igual
// que semana 8-9, pero en vez de ProviderScope(overrides: [...]) usa
// initDependencies() (get_it) para registrar todo el árbol de
// dependencias, y MultiBlocProvider en vez de ProviderScope para exponer
// los cubits a toda la app — ver teoría 05. Tu trabajo esta semana está en
// los cubits (features/*/presentation/cubit/) y en
// features/items/data/repositories/items_repository_impl.dart.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final itemsBox = await Hive.openBox('items_cache');
  final prefs = await SharedPreferences.getInstance();

  await initDependencies(itemsBox: itemsBox, prefs: prefs);

  final router = buildAppRouter(getIt<AuthCubit>());

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthCubit>()),
        BlocProvider.value(value: getIt<ItemsCubit>()),
        BlocProvider.value(value: getIt<CreateItemCubit>()),
        BlocProvider.value(value: getIt<FavoritesCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Domain Clean App',
        theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
        routerConfig: router,
      ),
    );
  }
}
