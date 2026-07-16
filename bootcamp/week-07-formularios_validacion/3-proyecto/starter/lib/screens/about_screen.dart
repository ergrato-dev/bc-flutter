import 'package:flutter/material.dart';

// ============================================
// SCREEN: AboutScreen (tab "Acerca de")
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Reemplaza el texto de ejemplo por una breve descripción de tu dominio
// asignado (2-3 líneas basta).
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        // TODO: reemplaza este texto por la descripción de tu dominio.
        child: Text(
          'Acerca de mi dominio — reemplaza este texto por una descripción '
          'breve de tu dominio asignado.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
