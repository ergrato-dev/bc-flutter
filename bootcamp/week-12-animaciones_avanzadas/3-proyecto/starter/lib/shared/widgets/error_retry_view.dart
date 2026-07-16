import 'package:flutter/material.dart';

// ============================================
// WIDGET: ErrorRetryView
// Mensaje de error + botón "Reintentar" — reutilizado por HomeScreen
// (ItemsCubit) y LoginScreen (AuthCubit), las dos pantallas con el mismo
// patrón de error/reintento. Vive en shared/ porque no pertenece a ninguna
// feature específica.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class ErrorRetryView extends StatelessWidget {
  const ErrorRetryView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: const Text('Reintentar')),
        ],
      ),
    );
  }
}
