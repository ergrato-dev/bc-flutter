/// Punto de entrada de la aplicación de recetas
///
/// Este es el archivo principal que inicializa la app
/// y configura el tema de Material Design.

import 'package:flutter/material.dart';

// En un proyecto real, importarías:
// import 'screens/home_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas Deliciosas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const HomeScreen(), // Definido en home_screen.dart
    );
  }
}

/// Placeholder para HomeScreen
/// En tu proyecto, usa el archivo home_screen.dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🍳 Recetas Deliciosas')),
      body: const Center(
        child: Text('Ver home_screen.dart para implementación completa'),
      ),
    );
  }
}
