import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

// ============================================
// Pantalla de Lista del Dominio — Proyecto Semana 2
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — la app arranca en HomeScreen. Tu trabajo
// esta semana es completar los TODOs de lib/screens/home_screen.dart,
// lib/data/sample_items.dart y lib/models/item.dart.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domain List App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
