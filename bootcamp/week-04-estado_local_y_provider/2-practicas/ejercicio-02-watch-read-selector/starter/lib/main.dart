/// Ejercicio 02 — context.watch, context.read y Selector
/// Qué: comparar watch/read y observar en consola cómo Selector evita
/// rebuilds innecesarios.
/// Para qué: evitar rebuilds de más es la primera optimización de
/// performance real que verás en el bootcamp (antes de semana 16).
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  debugPrint('--- Ejercicio 02: watch, read y Selector ---');
  // TODO temporal: en el PASO 1 reemplaza esta línea por
  // runApp(ChangeNotifierProvider(create: (context) => CartNotifier(), child: const MyApp()));
  runApp(const MyApp());
}

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
      // TODO temporal: en los PASO 2 y PASO 3 reemplaza este Placeholder
      // por una Column con CartFullView() y CartCountBadge().
      body: const Center(child: Placeholder()),
    );
  }
}

// ============================================
// PASO 1: CartNotifier con dos campos independientes
// ============================================
// Descomenta las siguientes líneas Y actualiza main() (ver el TODO de
// arriba) para envolver MyApp con ChangeNotifierProvider:
// class CartNotifier extends ChangeNotifier {
//   final List<String> _items = [];
//   String storeName = 'Tienda';
//
//   List<String> get items => List.unmodifiable(_items);
//
//   void addItem(String item) {
//     _items.add(item);
//     notifyListeners();
//   }
//
//   void renameStore(String newName) {
//     storeName = newName;
//     notifyListeners();
//   }
// }

// ============================================
// PASO 2: context.watch (mostrar) y context.read (botón)
// ============================================
// Descomenta las siguientes líneas:
// class CartFullView extends StatelessWidget {
//   const CartFullView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('CartFullView rebuild');
//     final cart = context.watch<CartNotifier>();
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(cart.storeName),
//         Text('${cart.items.length} productos (vista completa)'),
//         ElevatedButton(
//           onPressed: () =>
//               context.read<CartNotifier>().addItem('Producto ${cart.items.length + 1}'),
//           child: const Text('Agregar producto'),
//         ),
//         ElevatedButton(
//           onPressed: () => context.read<CartNotifier>().renameStore('Tienda renombrada'),
//           child: const Text('Cambiar nombre de tienda'),
//         ),
//       ],
//     );
//   }
// }

// ============================================
// PASO 3: Selector — reconstruir solo si cambia la cantidad
// ============================================
// Descomenta las siguientes líneas:
// class CartCountBadge extends StatelessWidget {
//   const CartCountBadge({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Selector<CartNotifier, int>(
//       selector: (context, cart) => cart.items.length,
//       builder: (context, itemCount, child) {
//         debugPrint('CartCountBadge rebuild (Selector)');
//         return Text('$itemCount productos (Selector)');
//       },
//     );
//   }
// }
