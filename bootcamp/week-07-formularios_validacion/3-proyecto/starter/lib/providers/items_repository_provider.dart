import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/items_repository.dart';
import 'dio_provider.dart';

part 'items_repository_provider.g.dart';

// ============================================
// PROVIDER: itemsRepository
// Expone ItemsRepository a los AsyncNotifier — ya está completo.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
@riverpod
ItemsRepository itemsRepository(Ref ref) {
  return DioItemsRepository(ref.watch(dioProvider));
}
