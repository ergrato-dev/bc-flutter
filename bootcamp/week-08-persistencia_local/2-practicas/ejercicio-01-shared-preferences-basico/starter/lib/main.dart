/// Ejercicio 01 — SharedPreferences Básico
/// Qué: practicar el ciclo completo de SharedPreferences — cargarlo antes de
/// runApp(), leer un valor al iniciar, escribirlo en cada cambio.
/// Para qué: es el mismo mecanismo que usarás para persistir favoritos en
/// el proyecto de esta semana.
library;

import 'package:flutter/material.dart';
// ignore: unused_import — se usa al descomentar el PASO 1 (SharedPreferences).
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  debugPrint('--- Ejercicio 01: SharedPreferences Básico ---');
  // TODO temporal: reemplaza este main() como parte del PASO 1.
  runApp(const MyApp());
}

// TODO temporal: en el PASO 1, agrega `required this.prefs` al constructor
// y el campo `final SharedPreferences prefs;`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 01',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      // TODO temporal: en el PASO 1, pasa `prefs: prefs` aquí.
      home: const HomeScreen(),
    );
  }
}

// TODO temporal: en el PASO 1, agrega `required this.prefs` al constructor
// y el campo `final SharedPreferences prefs;`.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO temporal: en el PASO 2 reemplaza esta línea por la lectura de
  // SharedPreferences — ver instrucciones abajo.
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 01')),
      body: Center(
        child: Text('$_counter', style: Theme.of(context).textTheme.displayMedium),
      ),
      // TODO temporal: en el PASO 3 reemplaza `setState(() => _counter++)`
      // por una llamada a `_increment()` — ver instrucciones abajo.
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ============================================
// PASO 1: main() async + SharedPreferences.getInstance()
// ============================================
// Reemplaza el main() de arriba por:
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   runApp(MyApp(prefs: prefs));
// }
//
// Agrega `required this.prefs;` y `final SharedPreferences prefs;` a MyApp,
// y pasa `prefs: prefs` al construir HomeScreen dentro de MyApp.build().
// Agrega también `required this.prefs;` y `final SharedPreferences prefs;`
// a HomeScreen, y pasa `prefs: widget.prefs` — lo necesitarás en el PASO 2.

// ============================================
// PASO 2: leer el valor guardado al iniciar
// ============================================
// Reemplaza `int _counter = 0;` por:
//
// late int _counter = widget.prefs.getInt('counter') ?? 0;

// ============================================
// PASO 3: escribir el valor en cada cambio
// ============================================
// Agrega este método dentro de _HomeScreenState:
//
// void _increment() {
//   setState(() => _counter++);
//   widget.prefs.setInt('counter', _counter);
// }
//
// Reemplaza `onPressed: () => setState(() => _counter++)` por
// `onPressed: _increment`.
