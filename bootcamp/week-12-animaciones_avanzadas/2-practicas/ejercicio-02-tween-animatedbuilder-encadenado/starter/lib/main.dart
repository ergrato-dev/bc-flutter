/// Ejercicio 02 — Tween y AnimatedBuilder Encadenado
/// Qué: practicar Interval para repartir dos animaciones en tramos
/// distintos de un mismo controller, combinadas en un solo AnimatedBuilder.
/// Para qué: es el mismo patrón que usarás en cualquier animación con más
/// de una propiedad secuenciada (ver teoría 04).
library;

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 02: Tween y AnimatedBuilder Encadenado ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 02',
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
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: Center(
        // TODO temporal: en el PASO 3, reemplaza este Container por el
        // AnimatedBuilder de las instrucciones.
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.indigo.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint('anima'),
        child: const Icon(Icons.play_arrow),
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
//   duration: const Duration(milliseconds: 800),
//   vsync: this,
// );
//
// @override
// void dispose() {
//   _controller.dispose();
//   super.dispose();
// }

// ============================================
// PASO 2: dos Tween en tramos distintos con Interval
// ============================================
// Agrega estos campos debajo de `_controller`:
//
// late final Animation<double> _scale = Tween<double>(begin: 1.0, end: 1.5).animate(
//   CurvedAnimation(
//     parent: _controller,
//     curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
//   ),
// );
//
// late final Animation<Color?> _color = ColorTween(
//   begin: Colors.indigo.shade200,
//   end: Colors.red,
// ).animate(
//   CurvedAnimation(
//     parent: _controller,
//     curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
//   ),
// );

// ============================================
// PASO 3: un solo AnimatedBuilder combinando ambas
// ============================================
// Reemplaza el `Container` de arriba por:
//
// AnimatedBuilder(
//   animation: _controller,
//   builder: (context, child) {
//     return Transform.scale(
//       scale: _scale.value,
//       child: DecoratedBox(
//         decoration: BoxDecoration(color: _color.value, borderRadius: BorderRadius.circular(12)),
//         child: child,
//       ),
//     );
//   },
//   child: const SizedBox(width: 80, height: 80),
// )
//
// Y cambia el `onPressed` del FloatingActionButton por:
// `() => _controller.forward(from: 0)`.
