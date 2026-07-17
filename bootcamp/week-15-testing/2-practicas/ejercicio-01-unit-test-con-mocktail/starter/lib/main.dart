/// Ejercicio 01 — Unit Test con mocktail
/// Qué: escribir un unit test para GetItems, simulando ItemsRepository con
/// mocktail.
/// Para qué: es la unidad más rápida y barata de probar — sin red, sin
/// Flutter, en milisegundos.
/// Tu trabajo esta semana está en test/get_items_test.dart, no aquí.
library;

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Ejercicio 01 — ver test/get_items_test.dart'),
        ),
      ),
    );
  }
}
