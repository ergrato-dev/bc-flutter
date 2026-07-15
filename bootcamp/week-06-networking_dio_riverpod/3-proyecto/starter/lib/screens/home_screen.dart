import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/items_provider.dart';
import '../widgets/item_card.dart';

// ============================================
// SCREEN: HomeScreen (tab "Lista")
// Lista de elementos cargada desde una API REST real (ItemsNotifier) +
// buscador + pull-to-refresh + reintento en caso de error.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// El filtrado y el ListView ya están completos (mismo patrón de semana 5).
// Tu trabajo esta semana es completar los TODOs de las ramas `data:` y
// `error:` de `.when()` — pull-to-refresh y reintento.
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
            error: (error, stackTrace) {
              // TODO: reemplaza este Placeholder por un Center con el
              // mensaje de `error` y un ElevatedButton que llame
              // `ref.invalidate(itemsProvider)` para reintentar (ver
              // ejercicio 03, PASO 3).
              return const Center(child: Placeholder());
            },
            data: (items) {
              final filteredItems = items
                  .where((item) => item.name.toLowerCase().contains(_query.toLowerCase()))
                  .toList();

              if (filteredItems.isEmpty) {
                return const Center(child: Text('No se encontraron elementos'));
              }

              // TODO: envuelve el ListView.builder de abajo en un
              // RefreshIndicator cuyo `onRefresh` llame
              // `ref.refresh(itemsProvider.future)` (ver ejercicio 03,
              // PASO 3) — actualmente falta el pull-to-refresh.
              return ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) => ItemCard(
                  item: filteredItems[index],
                  onTap: () => context.push(
                    '/items/${filteredItems[index].id}',
                    extra: filteredItems[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
