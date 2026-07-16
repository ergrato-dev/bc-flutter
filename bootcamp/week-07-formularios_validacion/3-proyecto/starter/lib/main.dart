import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

// ============================================
// Formulario de Creación con Validación — Proyecto Semana 7
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. Tu trabajo esta semana es completar los
// TODOs de lib/repositories/items_repository.dart (método createItem) y
// lib/screens/create_item_screen.dart (campos del formulario y feedback
// de envío).
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Domain Forms App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
