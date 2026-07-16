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
// Este archivo ya está completo — mismo patrón de semana 6, sin cambios.
// El formulario de esta semana no toca esta pantalla (el botón para crear
// un elemento vive en el router, ver lib/router/app_router.dart);
// no necesitas modificarla.
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
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$error'),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(itemsProvider),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
            data: (items) {
              final filteredItems = items
                  .where((item) => item.name.toLowerCase().contains(_query.toLowerCase()))
                  .toList();

              if (filteredItems.isEmpty) {
                return const Center(child: Text('No se encontraron elementos'));
              }

              return RefreshIndicator(
                onRefresh: () => ref.refresh(itemsProvider.future),
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) => ItemCard(
                    item: filteredItems[index],
                    onTap: () => context.push(
                      '/items/${filteredItems[index].id}',
                      extra: filteredItems[index],
                    ),
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
