import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/favorites_provider.dart';
import 'router/app_router.dart';

// ============================================
// Favoritos del Dominio con Provider — Proyecto Semana 4
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. Tu trabajo esta semana es completar los
// TODOs de lib/screens/home_screen.dart y lib/screens/detail_screen.dart,
// y adaptar lib/models/item.dart y lib/data/sample_items.dart a tu dominio.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // El ChangeNotifierProvider vive DENTRO de MyApp (no en runApp()) para
    // que `pumpWidget(const MyApp())` en los tests también lo incluya —
    // si quedara solo en runApp(), un test que monte MyApp directamente
    // lanzaría ProviderNotFoundException al llegar a cualquier
    // Consumer/context.watch<FavoritesProvider>().
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MaterialApp.router(
        title: 'Domain Favorites App',
        theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
        routerConfig: appRouter,
      ),
    );
  }
}
