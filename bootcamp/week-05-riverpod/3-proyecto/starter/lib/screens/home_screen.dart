import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/items_provider.dart';
import '../widgets/item_card.dart';

// ============================================
// SCREEN: HomeScreen (tab "Lista")
// Lista de elementos cargada de forma asíncrona (ItemsNotifier) + buscador
// + botón de favorito en cada tarjeta (ya funciona, ver ItemCard).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// El manejo de AsyncValue con .when() ya está armado (loading/error). Tu
// trabajo es completar el TODO dentro de `data:` — filtrar y renderizar
// la lista.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(itemsProvider);

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
        Expanded(
          child: itemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
            data: (items) {
              // TODO: filtra `items` según `_query` (case-insensitive, por
              // `item.name`) en una variable `filteredItems`.
              // TODO: si `filteredItems` está vacío, muestra un mensaje en
              // vez del ListView.
              // TODO: si no, retorna un ListView.builder con
              //   ItemCard(
              //     item: filteredItems[index],
              //     onTap: () => context.push('/items/${filteredItems[index].id}', extra: filteredItems[index]),
              //   )
              return const Center(child: Placeholder());
            },
          ),
        ),
      ],
    );
  }
}
