import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

// ============================================
// Migración a Riverpod + AsyncNotifier — Proyecto Semana 5
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. Tu trabajo esta semana es completar los
// TODOs de lib/screens/home_screen.dart y lib/screens/detail_screen.dart,
// y adaptar lib/models/item.dart y lib/providers/items_provider.dart a tu
// dominio.
void main() {
  // A diferencia de ChangeNotifierProvider en semana 4, ProviderScope SÍ
  // puede quedarse en runApp() — es la convención oficial de Riverpod. La
  // diferencia: en los tests, en vez de pumpWidget(const MyApp()), se
  // envuelve explícitamente con ProviderScope (ver test/widget_test.dart).
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Domain Riverpod App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
