import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/sample_items.dart';
import '../widgets/item_card.dart';

// ============================================
// SCREEN: HomeScreen (tab "Lista")
// Lista de elementos con buscador (semanas 2-3) + botón de favorito
// (FavoritesProvider) en cada tarjeta.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Completa los TODOs para filtrar la lista y navegar al detalle. El botón
// de favorito de cada tarjeta ya funciona (ItemCard está completo).
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
    // `item.name`), igual que en semanas 2-3. Guarda el resultado en
    // `filteredItems`.

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(labelText: 'Buscar', prefixIcon: Icon(Icons.search)),
            onChanged: (value) => setState(() => _query = value),
          ),
        ),
        // TODO: reemplaza este Expanded por un ListView.builder sobre
        // `filteredItems`, usando:
        //   ItemCard(
        //     item: filteredItems[index],
        //     onTap: () => context.push('/items/${filteredItems[index].id}', extra: filteredItems[index]),
        //   )
        // Si `filteredItems` está vacío, muestra un mensaje en vez del ListView.
        const Expanded(child: Center(child: Placeholder())),
      ],
    );
  }
}
