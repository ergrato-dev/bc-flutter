# Ejercicio 03 — CustomPainter Animado

> Convertirás un anillo de progreso estático (dibujado con `CustomPainter`) en un spinner que gira
> indefinidamente, conectando un `AnimationController` en modo `repeat()` directamente al
> `painter`, descomentando código paso a paso.

## 🎯 Objetivos

- Conectar un `AnimationController` a un `CustomPainter` con el parámetro `repaint`
- Usar `.repeat()` para un loop indefinido (a diferencia de `.forward()`/`.reverse()`)
- Reconocer por qué `shouldRepaint` puede retornar `true` sin costo cuando ya usas `repaint:`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: el controller en modo repeat

```dart
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — nota el `..repeat()`
encadenado justo después de crear el controller: arranca el loop apenas se construye, sin
necesitar un botón.

---

## Paso 2: el painter recibe la animación, no un valor fijo

```dart
class ProgressRingPainter extends CustomPainter {
  ProgressRingPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

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
      2 * pi * animation.value,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressRingPainter oldDelegate) => true;
}
```

**Descomenta la sección `PASO 2`** — reemplaza el `StaticRingPainter` (que dibuja un progreso fijo
de 0.3) por este `ProgressRingPainter`. `super(repaint: animation)` es lo que dispara `paint()`
en cada tick — no necesitas `AnimatedBuilder` ni `setState`.

---

## Paso 3: conectar el CustomPaint al controller

```dart
CustomPaint(
  size: const Size(80, 80),
  painter: ProgressRingPainter(animation: _controller),
)
```

**Descomenta la sección `PASO 3`** — reemplaza el `CustomPaint` con `StaticRingPainter` por este.

✅ **Verifica**: el anillo gira indefinidamente sin que hayas llamado `setState` ni una sola vez —
`repaint: animation` es todo lo que conecta el reloj del controller al repintado del `Canvas`.

---

## ✅ Resultado final

Un anillo de progreso animado con `CustomPainter` + `AnimationController.repeat()` — la base del
indicador de carga custom que reemplazará al `CircularProgressIndicator` del `HomeScreen` en el
proyecto de esta semana.
