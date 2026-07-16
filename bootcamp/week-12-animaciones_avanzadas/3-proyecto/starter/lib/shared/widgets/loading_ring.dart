import 'dart:math';

import 'package:flutter/material.dart';

// ============================================
// WIDGET: LoadingRing
// Indicador de carga custom que reemplaza al CircularProgressIndicator de
// HomeScreen — mismo patrón del ejercicio 03 (AnimationController.repeat()
// + CustomPainter con repaint).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Tu trabajo esta semana es completar los TODOs de abajo: el controller en
// modo repeat, y el CustomPainter que dibuja el anillo usando su valor.
class LoadingRing extends StatefulWidget {
  const LoadingRing({super.key, this.size = 48});

  final double size;

  @override
  State<LoadingRing> createState() => _LoadingRingState();
}

// TODO temporal: en el PASO 1, agrega `with SingleTickerProviderStateMixin`
// a esta clase.
class _LoadingRingState extends State<LoadingRing> {
  @override
  Widget build(BuildContext context) {
    // TODO temporal: en el PASO 3, reemplaza este CustomPaint (con
    // _StaticRingPainter) por el que usa _RingPainter con el controller —
    // ver instrucciones al final del archivo.
    return CustomPaint(
      size: Size.square(widget.size),
      painter: _StaticRingPainter(color: Theme.of(context).colorScheme.primary),
    );
  }
}

// Painter de referencia (progreso fijo, sin animar) — lo reemplazarás en
// el PASO 2 por _RingPainter, que recibe la animación en vez de dibujar un
// arco fijo.
class _StaticRingPainter extends CustomPainter {
  _StaticRingPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 4;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant _StaticRingPainter oldDelegate) => oldDelegate.color != color;
}

// ============================================
// PASO 1: el controller en modo repeat
// ============================================
// Agrega `with SingleTickerProviderStateMixin` a `_LoadingRingState`, y
// dentro de la clase:
//
// late final AnimationController _controller = AnimationController(
//   duration: const Duration(seconds: 1),
//   vsync: this,
// )..repeat();
//
// @override
// void dispose() {
//   _controller.dispose();
//   super.dispose();
// }

// ============================================
// PASO 2: el painter recibe la animación, no un color fijo
// ============================================
// Agrega esta clase (puedes dejar _StaticRingPainter arriba, sin usarla):
//
// class _RingPainter extends CustomPainter {
//   _RingPainter({required this.animation, required this.color}) : super(repaint: animation);
//
//   final Animation<double> animation;
//   final Color color;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = size.center(Offset.zero);
//     final radius = size.shortestSide / 2 - 4;
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4
//       ..strokeCap = StrokeCap.round;
//     final startAngle = 2 * pi * animation.value; // gira con cada tick
//     canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, pi, false, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant _RingPainter oldDelegate) => true;
// }

// ============================================
// PASO 3: conectar el CustomPaint al controller
// ============================================
// Reemplaza el `CustomPaint` de `build()` por:
//
// CustomPaint(
//   size: Size.square(widget.size),
//   painter: _RingPainter(animation: _controller, color: Theme.of(context).colorScheme.primary),
// )
