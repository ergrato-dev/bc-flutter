import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/item.dart';
import '../../domain/usecases/create_item.dart';
import 'create_item_state.dart';

// ============================================
// CUBIT: CreateItemCubit
// Mismo trabajo que CreateItemNotifier (AsyncNotifier<void> de acción,
// semana 7-9) — ver teoría 03 de semana 10. Migración de Clean Architecture
// ya completa — esta semana no toca este archivo.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class CreateItemCubit extends Cubit<CreateItemState> {
  CreateItemCubit(this._createItem) : super(const CreateItemIdle());

  final CreateItem _createItem;

  Future<void> submit(Item item) async {
    emit(const CreateItemSubmitting());
    try {
      await _createItem(item);
      emit(const CreateItemSuccess());
    } catch (e) {
      emit(CreateItemFailure('$e'));
    }
  }
}
