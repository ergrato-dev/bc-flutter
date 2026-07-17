/// Ejercicio 03 — bloc_test de un Cubit
/// Qué: probar ItemsCubit con blocTest, combinado con mocktail.
/// Para qué: expresar build/act/expect de forma declarativa, sin acumular
/// estados manualmente en cada test.
/// Tu trabajo esta semana está en test/items_cubit_test.dart, no aquí.
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
          child: Text('Ejercicio 03 — ver test/items_cubit_test.dart'),
        ),
      ),
    );
  }
}
