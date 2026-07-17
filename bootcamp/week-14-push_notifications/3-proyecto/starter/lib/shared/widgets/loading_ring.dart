import 'dart:math';

import 'package:flutter/material.dart';

// ============================================
// WIDGET: LoadingRing
// Indicador de carga custom que reemplaza al CircularProgressIndicator de
// HomeScreen — AnimationController.repeat() + CustomPainter con repaint.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class LoadingRing extends StatefulWidget {
  const LoadingRing({super.key, this.size = 48});

  final double size;

  @override
  State<LoadingRing> createState() => _LoadingRingState();
}

class _LoadingRingState extends State<LoadingRing> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(widget.size),
      painter: _RingPainter(animation: _controller, color: Theme.of(context).colorScheme.primary),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.animation, required this.color}) : super(repaint: animation);

  final Animation<double> animation;
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
    final startAngle = 2 * pi * animation.value;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => true;
}
