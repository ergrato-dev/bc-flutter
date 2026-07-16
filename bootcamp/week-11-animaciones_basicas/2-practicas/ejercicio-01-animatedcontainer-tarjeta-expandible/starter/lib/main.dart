/// Ejercicio 01 — AnimatedContainer: Tarjeta Expandible
/// Qué: practicar `AnimatedContainer` animando height, color y padding a la
/// vez, y `AnimatedDefaultTextStyle` para el texto interno.
/// Para qué: es el mismo patrón que usarás en el `ItemCard` del proyecto de
/// esta semana.
library;

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 01: AnimatedContainer Tarjeta Expandible ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 01',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          // TODO temporal: en el PASO 2, reemplaza este Container estático
          // por el AnimatedContainer de las instrucciones.
          child: Container(
            width: 220,
            height: _expanded ? 220 : 96,
            padding: EdgeInsets.all(_expanded ? 24 : 12),
            decoration: BoxDecoration(
              color: _expanded ? Colors.indigo : Colors.indigo.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            // TODO temporal: en el PASO 3, reemplaza este Text fijo por el
            // AnimatedDefaultTextStyle de las instrucciones.
            child: const Text(
              'Toca para expandir',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: constantes de motion
// ============================================
// Agrega esta clase antes de MyApp:
//
// abstract final class AppMotion {
//   static const Duration medium = Duration(milliseconds: 250);
//   static const Curve standard = Curves.easeInOut;
// }

// ============================================
// PASO 2: AnimatedContainer con height, color y padding
// ============================================
// Reemplaza el `Container` de arriba (manteniendo `width: 220`) por:
//
// AnimatedContainer(
//   duration: AppMotion.medium,
//   curve: AppMotion.standard,
//   width: 220,
//   height: _expanded ? 220 : 96,
//   padding: EdgeInsets.all(_expanded ? 24 : 12),
//   decoration: BoxDecoration(
//     color: _expanded ? Colors.indigo : Colors.indigo.shade200,
//     borderRadius: BorderRadius.circular(12),
//   ),
//   child: const Text(
//     'Toca para expandir',
//     style: TextStyle(color: Colors.white),
//   ),
// )

// ============================================
// PASO 3: texto que también anima su tamaño
// ============================================
// Reemplaza el `Text` fijo (child del AnimatedContainer del PASO 2) por:
//
// AnimatedDefaultTextStyle(
//   duration: AppMotion.medium,
//   style: TextStyle(
//     color: Colors.white,
//     fontSize: _expanded ? 22 : 14,
//     fontWeight: _expanded ? FontWeight.bold : FontWeight.normal,
//   ),
//   child: const Text('Toca para expandir'),
// )
