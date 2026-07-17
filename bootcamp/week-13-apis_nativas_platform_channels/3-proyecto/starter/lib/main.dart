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
// APIs Nativas y Platform Channels sobre Clean Architecture — Semana 13
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. Las animaciones
// de semanas 11-12 ya están completas; tu trabajo esta semana está en
// features/items/presentation/widgets/photo_picker_field.dart — ver
// teorías 01 y 02.
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
        title: 'Domain Native APIs App',
        theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
        routerConfig: router,
      ),
    );
  }
}
