/// Ejercicio 03 — CustomPainter Animado
/// Qué: practicar la conexión de un AnimationController (en modo repeat)
/// directamente a un CustomPainter vía el parámetro `repaint`.
/// Para qué: es el mismo patrón del indicador de carga custom que
/// reemplazará al CircularProgressIndicator en el proyecto de esta semana.
library;

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 03: CustomPainter Animado ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 03',
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
      appBar: AppBar(title: const Text('Ejercicio 03')),
      body: Center(
        // TODO temporal: en el PASO 3, reemplaza este CustomPaint por el
        // que usa ProgressRingPainter con el controller — ver
        // instrucciones abajo.
        child: CustomPaint(
          size: const Size(80, 80),
          painter: StaticRingPainter(progress: 0.3),
        ),
      ),
    );
  }
}

// Painter de referencia (progreso fijo, sin animar) — lo reemplazarás en
// el PASO 2 por ProgressRingPainter, que recibe la animación en vez de un
// valor fijo.
class StaticRingPainter extends CustomPainter {
  StaticRingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 8;

    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, radius, trackPaint);

    final progressPaint = Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant StaticRingPainter oldDelegate) => oldDelegate.progress != progress;
}

// ============================================
// PASO 1: el controller en modo repeat
// ============================================
// Agrega `with SingleTickerProviderStateMixin` a `_HomeScreenState`, y
// dentro de la clase:
//
// late final AnimationController _controller = AnimationController(
//   duration: const Duration(seconds: 2),
//   vsync: this,
// )..repeat();
//
// @override
// void dispose() {
//   _controller.dispose();
//   super.dispose();
// }

// ============================================
// PASO 2: el painter recibe la animación, no un valor fijo
// ============================================
// Agrega esta clase (puedes dejar StaticRingPainter arriba, sin usarla):
//
// class ProgressRingPainter extends CustomPainter {
//   ProgressRingPainter({required this.animation}) : super(repaint: animation);
//
//   final Animation<double> animation;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = size.center(Offset.zero);
//     final radius = size.shortestSide / 2 - 8;
//
//     final trackPaint = Paint()
//       ..color = Colors.grey.shade300
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 8;
//     canvas.drawCircle(center, radius, trackPaint);
//
//     final progressPaint = Paint()
//       ..color = Colors.indigo
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 8
//       ..strokeCap = StrokeCap.round;
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -pi / 2,
//       2 * pi * animation.value,
//       false,
//       progressPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant ProgressRingPainter oldDelegate) => true;
// }

// ============================================
// PASO 3: conectar el CustomPaint al controller
// ============================================
// Reemplaza el `CustomPaint` de arriba (con StaticRingPainter) por:
//
// CustomPaint(
//   size: const Size(80, 80),
//   painter: ProgressRingPainter(animation: _controller),
// )
