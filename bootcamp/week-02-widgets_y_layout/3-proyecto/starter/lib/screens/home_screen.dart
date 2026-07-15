import 'package:flutter/material.dart';

import '../data/sample_items.dart';
import '../widgets/item_card.dart';

// ============================================
// SCREEN: HomeScreen
// Lista de elementos de tu dominio, con buscador.
// Reutiliza los patrones de los ejercicios 02 (layout) y 03 (lista + input).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// El AppBar ya está listo. Completa los TODOs para mostrar la lista de
// sampleItems y conectar el buscador.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: filtra `sampleItems` según `_query` (case-insensitive, por
    // `item.name`), igual que en el ejercicio 03. Guarda el resultado en
    // una variable `filteredItems`.

    return Scaffold(
      // NOTA PARA EL APRENDIZ: cambia este título por el nombre de tu dominio.
      appBar: AppBar(title: const Text('Mi Dominio')),
      // TODO: reemplaza este Placeholder por una Column con:
      //   1. Un Padding + TextField (controller: _searchController) que
      //      actualice `_query` con setState en su onChanged.
      //   2. Un Expanded con un ListView.builder sobre `filteredItems`,
      //      usando ItemCard(item: filteredItems[index]) por cada fila.
      //   3. Si `filteredItems` está vacío, muestra un mensaje en vez del
      //      ListView (usa null safety / .isEmpty, no asumas que siempre
      //      hay resultados).
      body: const Placeholder(),
    );
  }
}
