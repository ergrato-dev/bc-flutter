/// Ejercicio 01 — AnimationController Básico
/// Qué: practicar el ciclo completo de un AnimationController — mixin,
/// dispose, Tween con curva, y alternar forward/reverse según isCompleted.
/// Para qué: es el mismo patrón que usarás para el "pop" de favorito en el
/// ItemCard del proyecto de esta semana.
library;

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 01: AnimationController Básico ---');
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

// TODO temporal: en el PASO 1, agrega `with SingleTickerProviderStateMixin`
// a esta clase.
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      body: Center(
        // TODO temporal: en el PASO 3, reemplaza este GestureDetector por
        // el que envuelve un ScaleTransition — ver instrucciones abajo.
        child: GestureDetector(
          onTap: () => debugPrint('toca el logo'),
          child: const FlutterLogo(size: 120),
        ),
      ),
    );
  }
}

// ============================================
// PASO 1: el controller y su dispose
// ============================================
// Agrega `with SingleTickerProviderStateMixin` a `_HomeScreenState`, y
// dentro de la clase:
//
// late final AnimationController _controller = AnimationController(
//   duration: const Duration(milliseconds: 300),
//   vsync: this,
// );
//
// @override
// void dispose() {
//   _controller.dispose();
//   super.dispose();
// }

// ============================================
// PASO 2: Tween con curva
// ============================================
// Agrega este campo debajo de `_controller`:
//
// late final Animation<double> _scale = Tween<double>(begin: 1.0, end: 1.4).animate(
//   CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
// );

// ============================================
// PASO 3: ScaleTransition + toggle forward/reverse
// ============================================
// Reemplaza el `GestureDetector` de arriba por:
//
// GestureDetector(
//   onTap: () {
//     if (_controller.isCompleted) {
//       _controller.reverse();
//     } else {
//       _controller.forward();
//     }
//   },
//   child: ScaleTransition(scale: _scale, child: const FlutterLogo(size: 120)),
// )
