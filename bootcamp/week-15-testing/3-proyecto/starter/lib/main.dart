import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Descomenta estos imports en el PASO 1, después de correr `flutterfire
// configure` (ver README) — firebase_options.dart no existe hasta entonces.
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'app/app_router.dart';
import 'core/di/injection_container.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/items/presentation/cubit/create_item_cubit.dart';
import 'features/items/presentation/cubit/favorites_cubit.dart';
import 'features/items/presentation/cubit/items_cubit.dart';
import 'features/notifications/domain/repositories/notification_repository.dart';

// ============================================
// Testing sobre Clean Architecture — Semana 15
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo salvo el PASO 1 (inicializar Firebase, que
// depende de TU propio proyecto de Firebase — ver README). Tu trabajo
// principal esta semana está en test/ — ver 3-proyecto/README.md.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO temporal: en el PASO 1, agrega await Firebase.initializeApp(...)
  // aquí — ver instrucciones al final del archivo. Sin esto, el resto de la
  // app corre, pero NotificationRepository.initialize() falla al llegar a
  // cualquier llamada de FirebaseMessaging.

  await Hive.initFlutter();
  final itemsBox = await Hive.openBox('items_cache');
  final prefs = await SharedPreferences.getInstance();

  await initDependencies(itemsBox: itemsBox, prefs: prefs);
  await getIt<NotificationRepository>().initialize();

  final router = buildAppRouter(getIt<AuthCubit>());

  // Deep link: cada ruta emitida por un toque de notificación (background o
  // terminated) se navega aquí — router.push() funciona igual sin importar
  // en qué pantalla esté el usuario en ese momento.
  getIt<NotificationRepository>().onNotificationRoute.listen(router.push);

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
        title: 'Domain Testing App',
        theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
        routerConfig: router,
      ),
    );
  }
}

// ============================================
// PASO 1: inicializar Firebase
// ============================================
// Después de correr `flutterfire configure` (ver README), descomenta los
// imports de arriba y agrega esta línea al inicio de `main()`, justo
// después de `WidgetsFlutterBinding.ensureInitialized()`:
//
// await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
