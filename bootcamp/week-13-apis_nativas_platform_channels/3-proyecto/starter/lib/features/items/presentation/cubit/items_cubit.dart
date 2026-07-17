import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_items.dart';
import 'items_state.dart';

// ============================================
// CUBIT: ItemsCubit
// Mismo trabajo que ItemsNotifier (AsyncNotifier, semanas 5-9), expresado
// con emit() en vez de retornar un Future desde build() — ver teoría 03
// de semana 10. Migración de Clean Architecture ya completa — esta semana
// no toca este archivo, solo la presentación (ver home_screen.dart).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit(this._getItems) : super(const ItemsInitial());

  final GetItems _getItems;

  Future<void> fetchItems() async {
    emit(const ItemsLoading());
    try {
      final items = await _getItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemsError('$e'));
    }
  }
}
