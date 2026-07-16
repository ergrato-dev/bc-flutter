import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_items.dart';
import 'items_state.dart';

// ============================================
// CUBIT: ItemsCubit
// Mismo trabajo que ItemsNotifier (AsyncNotifier, semanas 5-9), expresado
// con emit() en vez de retornar un Future desde build() — ver teoría 03.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Tu trabajo esta semana es completar el TODO de fetchItems().
class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit(this._getItems) : super(const ItemsInitial());

  final GetItems _getItems;

  Future<void> fetchItems() async {
    // TODO: implementa la carga (mismo patrón que ItemsNotifier.build(),
    // ahora con emit() en vez de return):
    // 1. `emit(const ItemsLoading());`
    // 2. Dentro de un try, ejecuta `final items = await _getItems();` y
    //    `emit(ItemsLoaded(items));`.
    // 3. En el catch, `emit(ItemsError('$e'));`.
  }
}
