import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/item.dart';
import 'items_repository_provider.dart';

part 'create_item_provider.g.dart';

// ============================================
// PROVIDER: CreateItemNotifier
// Modela el envío del formulario como una acción (no como una carga
// automática): build() arranca "idle", y create() dispara el POST.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — mismo patrón de la teoría 05 y del
// ejercicio 03. No necesitas modificarlo.
@riverpod
class CreateItemNotifier extends _$CreateItemNotifier {
  @override
  Future<void> build() async {
    // idle — no hace nada hasta que se llama create()
  }

  Future<void> create(Item item) async {
    state = const AsyncLoading();
    final repository = ref.read(itemsRepositoryProvider);
    state = await AsyncValue.guard(() => repository.createItem(item));
  }
}
