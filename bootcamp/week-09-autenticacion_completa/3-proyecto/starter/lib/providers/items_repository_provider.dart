import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/items_repository.dart';
import 'dio_provider.dart';
import 'items_cache_box_provider.dart';

part 'items_repository_provider.g.dart';

// ============================================
// PROVIDER: itemsRepository
// Expone ItemsRepository a los AsyncNotifier — envuelve DioItemsRepository
// con CachedItemsRepository (ver teoría 05). Ya está completo.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
@riverpod
ItemsRepository itemsRepository(Ref ref) {
  final remote = DioItemsRepository(ref.watch(dioProvider));
  final box = ref.watch(itemsCacheBoxProvider);
  return CachedItemsRepository(remote, box);
}
