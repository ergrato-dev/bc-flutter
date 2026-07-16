/// Ejercicio 02 — Hero Entre Pantallas
/// Qué: practicar el emparejamiento de Hero por tag entre una pantalla de
/// lista y una de detalle.
/// Para qué: es el mismo mecanismo que conectará ItemCard con DetailScreen
/// en el proyecto de esta semana.
library;

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 02: Hero Entre Pantallas ---');
  runApp(const MyApp());
}

class ColorSquare {
  const ColorSquare({required this.index, required this.value, required this.label});

  final int index;
  final Color value;
  final String label;
}

const colors = [
  ColorSquare(index: 0, value: Colors.indigo, label: 'Índigo'),
  ColorSquare(index: 1, value: Colors.teal, label: 'Verde azulado'),
  ColorSquare(index: 2, value: Colors.deepOrange, label: 'Naranja'),
];

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: ListView(
        children: [
          for (final color in colors)
            ListTile(
              // TODO temporal: en el PASO 1, envuelve este Container en un
              // Hero con tag 'color-square-${color.index}'.
              leading: Container(
                width: 56,
                height: 56,
                color: color.value,
                margin: const EdgeInsets.all(12),
              ),
              title: Text(color.label),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DetailScreen(color: color)),
              ),
            ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.color});

  final ColorSquare color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(color.label)),
      body: Center(
        // TODO temporal: en el PASO 2, envuelve este Container en un Hero
        // con el MISMO tag que usaste en HomeScreen.
        child: Container(width: 200, height: 200, color: color.value),
      ),
    );
  }
}

// ============================================
// PASO 1: Hero en la tarjeta de la lista
// ============================================
// Reemplaza el `Container` dentro de `leading:` por:
//
// Hero(
//   tag: 'color-square-${color.index}',
//   child: Container(
//     width: 56,
//     height: 56,
//     color: color.value,
//     margin: const EdgeInsets.all(12),
//   ),
// )

// ============================================
// PASO 2: Hero (mismo tag) en el detalle
// ============================================
// Reemplaza el `Container` dentro del `Center` de DetailScreen por:
//
// Hero(
//   tag: 'color-square-${color.index}',
//   child: Container(width: 200, height: 200, color: color.value),
// )

// ============================================
// PASO 3: tag único por instancia, no un string fijo
// ============================================
// Cambia temporalmente ambos tag a 'color-square' (sin ${color.index}),
// corre la app, y luego revierte el cambio dejando ${color.index} en
// ambos — ver instrucciones en el README para el porqué.
