import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/items_cache_box_provider.dart';
import 'providers/shared_preferences_provider.dart';
import 'router/app_router.dart';

// ============================================
// Persistencia Local — Proyecto Semana 8
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. main() ahora es async: carga
// SharedPreferences y abre el Box de Hive *antes* de runApp(), y los
// inyecta en el árbol de providers vía overrides — así ningún provider que
// los consume necesita ser async solo por esperar I/O de disco (ver
// teoría 02). Tu trabajo esta semana es completar los TODOs de
// lib/providers/favorites_provider.dart (persistir favoritos) y
// lib/repositories/items_repository.dart (CachedItemsRepository.fetchItems).
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Domain Persistence App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
