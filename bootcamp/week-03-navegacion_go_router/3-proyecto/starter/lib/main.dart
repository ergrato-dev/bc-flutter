import 'package:flutter/material.dart';

import 'router/app_router.dart';

// ============================================
// Navegación del Dominio — Proyecto Semana 3
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. Tu trabajo esta semana es completar los
// TODOs de lib/screens/home_screen.dart, lib/screens/detail_screen.dart y
// lib/screens/about_screen.dart, y adaptar lib/models/item.dart y
// lib/data/sample_items.dart a tu dominio.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Domain Navigation App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
