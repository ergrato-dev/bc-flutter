import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/items_cache_box_provider.dart';
import 'providers/shared_preferences_provider.dart';
import 'router/app_router.dart';

// ============================================
// Autenticación Completa — Proyecto Semana 9
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. main() sigue igual que semana 8 —
// secureStorageProvider (nuevo esta semana) no necesita override aquí, es
// síncrono (ver teoría 03). MyApp ahora es ConsumerWidget: observa
// appRouterProvider, que se reconstruye completo en cada login/logout (ver
// teoría 05). Tu trabajo esta semana es completar los TODOs de
// lib/providers/auth_provider.dart (persistir el token, limpiar al cerrar
// sesión) y lib/providers/dio_provider.dart (interceptor de autenticación).
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final itemsBox = await Hive.openBox('items_cache');
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        itemsCacheBoxProvider.overrideWithValue(itemsBox),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Domain Auth App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
