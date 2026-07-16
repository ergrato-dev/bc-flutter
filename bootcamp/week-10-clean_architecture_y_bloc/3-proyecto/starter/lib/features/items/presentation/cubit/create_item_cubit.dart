import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/item.dart';
import '../../domain/usecases/create_item.dart';
import 'create_item_state.dart';

// ============================================
// CUBIT: CreateItemCubit
// Mismo trabajo que CreateItemNotifier (AsyncNotifier<void> de acción,
// semana 7-9) — ver teoría 03.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Tu trabajo esta semana es completar el TODO de submit().
class CreateItemCubit extends Cubit<CreateItemState> {
  CreateItemCubit(this._createItem) : super(const CreateItemIdle());

  final CreateItem _createItem;

  Future<void> submit(Item item) async {
    // TODO: implementa el envío (mismo patrón que
    // CreateItemNotifier.create(), ahora con emit() en vez de state =):
    // 1. `emit(const CreateItemSubmitting());`
    // 2. Dentro de un try, ejecuta `await _createItem(item);` y
    //    `emit(const CreateItemSuccess());`.
    // 3. En el catch, `emit(CreateItemFailure('$e'));`.
  }
}
