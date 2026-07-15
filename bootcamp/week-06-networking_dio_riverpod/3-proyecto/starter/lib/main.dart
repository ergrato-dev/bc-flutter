import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

// ============================================
// Consumo de API REST con Dio + Riverpod — Proyecto Semana 6
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. Tu trabajo esta semana es completar los
// TODOs de lib/repositories/items_repository.dart y
// lib/screens/home_screen.dart, y adaptar lib/models/item.dart al JSON de
// tu dominio.
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Domain Networking App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
