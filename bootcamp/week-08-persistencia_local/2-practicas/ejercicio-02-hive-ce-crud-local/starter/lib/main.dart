/// Ejercicio 02 — Hive/hive_ce CRUD Local
/// Qué: abrir un Box, agregar/eliminar valores, y reconstruir la UI
/// automáticamente con box.listenable() — sin setState manual por cambio.
/// Para qué: el Box de este ejercicio es el mismo mecanismo que usarás para
/// cachear la lista de elementos del proyecto de esta semana.
library;

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() {
  debugPrint('--- Ejercicio 02: Hive/hive_ce CRUD Local ---');
  // TODO temporal: reemplaza este main() como parte del PASO 1.
  runApp(const MyApp());
}

// TODO temporal: en el PASO 1, agrega `required this.notesBox` al
// constructor y el campo `final Box<String> notesBox;`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 02',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      // TODO temporal: en el PASO 1, pasa `notesBox: notesBox` aquí.
      home: const HomeScreen(),
    );
  }
}

// TODO temporal: en el PASO 1, agrega `required this.notesBox` al
// constructor y el campo `final Box<String> notesBox;`.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 02')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Nueva nota'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  // TODO temporal: en el PASO 2 reemplaza este onPressed
                  // por `() => _addNote(_controller.text)`.
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // TODO temporal: en el PASO 3 reemplaza este Placeholder por el
          // Expanded(child: ValueListenableBuilder(...)) — ver instrucciones
          // abajo.
          const Expanded(child: Center(child: Placeholder())),
        ],
      ),
    );
  }
}

// ============================================
// PASO 1: Hive.initFlutter() + Hive.openBox()
// ============================================
// Reemplaza el main() de arriba por:
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   final notesBox = await Hive.openBox<String>('notes');
//   runApp(MyApp(notesBox: notesBox));
// }
//
// Agrega `required this.notesBox;` y `final Box<String> notesBox;` a MyApp,
// y pasa `notesBox: notesBox` al construir HomeScreen dentro de
// MyApp.build(). Agrega también `required this.notesBox;` y
// `final Box<String> notesBox;` a HomeScreen — lo necesitarás en el PASO 2.

// ============================================
// PASO 2: agregar una nota con box.add()
// ============================================
// Agrega este método dentro de _HomeScreenState:
//
// void _addNote(String text) {
//   if (text.trim().isEmpty) return;
//   widget.notesBox.add(text.trim());
//   _controller.clear();
// }
//
// Reemplaza el `onPressed: () {}` del IconButton por
// `() => _addNote(_controller.text)`.

// ============================================
// PASO 3: lista reactiva con box.listenable() + eliminar
// ============================================
// Reemplaza `const Expanded(child: Center(child: Placeholder()))` por:
//
// Expanded(
//   child: ValueListenableBuilder(
//     valueListenable: widget.notesBox.listenable(),
//     builder: (context, Box<String> box, _) {
//       return ListView.builder(
//         itemCount: box.length,
//         itemBuilder: (context, index) => ListTile(
//           title: Text(box.getAt(index) ?? ''),
//           trailing: IconButton(
//             icon: const Icon(Icons.delete_outline),
//             onPressed: () => box.deleteAt(index),
//           ),
//         ),
//       );
//     },
//   ),
// ),
