/// Ejercicio 02 — Layout con Row, Column y Expanded
/// Qué: practicar composición de Row/Column/Expanded/Spacer sobre un
/// Container decorado.
/// Para qué: es el layout base de cualquier tarjeta de lista — lo usarás en
/// el proyecto de esta semana y en casi todas las semanas siguientes.
library;

import 'package:flutter/material.dart';

void main() {
  debugPrint('--- Ejercicio 02: Layout con Row, Column y Expanded ---');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio 02',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0175C2), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Ejercicio 02')),
        body: const Center(child: Placeholder()), // se reemplaza en el PASO 1
      ),
    );
  }
}

// ============================================
// PASO 1: Container como base de la tarjeta
// ============================================
// Descomenta las siguientes líneas y reemplaza el `body:` de arriba por
// `body: buildCard(const Text('Tarjeta base'))`:
//
// Widget buildCard(Widget child) {
//   return Container(
//     padding: const EdgeInsets.all(16),
//     margin: const EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
//     ),
//     child: child,
//   );
// }

// ============================================
// PASO 2: Row + Column + Expanded dentro de la tarjeta
// ============================================
// Descomenta las siguientes líneas y pásale este widget a buildCard(...) en
// vez del Text('Tarjeta base'):
//
// const Row(
//   children: [
//     Icon(Icons.inventory_2, size: 40),
//     SizedBox(width: 12),
//     Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Nombre del elemento', style: TextStyle(fontWeight: FontWeight.bold)),
//           Text(
//             'Descripción larga que no debería desbordar la pantalla al mostrarse',
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     ),
//   ],
// )

// ============================================
// PASO 3: Spacer para alinear un precio a la derecha
// ============================================
// Descomenta las siguientes líneas y agrégalas como un children más dentro
// de la Column del PASO 2 (después del Text de descripción):
//
// Row(
//   children: [
//     const Text('Nombre'),
//     const Spacer(),
//     const Text('\$45.000', style: TextStyle(fontWeight: FontWeight.bold)),
//   ],
// ),
