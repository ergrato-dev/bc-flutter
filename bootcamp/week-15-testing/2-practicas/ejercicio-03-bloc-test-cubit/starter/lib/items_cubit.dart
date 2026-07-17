/// ItemsCubit de ejemplo — ya está completo, no lo modifiques. Tu trabajo
/// es en test/items_cubit_test.dart.
library;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain.dart';

sealed class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object?> get props => [];
}

class ItemsInitial extends ItemsState {
  const ItemsInitial();
}

class ItemsLoading extends ItemsState {
  const ItemsLoading();
}

class ItemsLoaded extends ItemsState {
  const ItemsLoaded(this.items);

  final List<Item> items;

  @override
  List<Object?> get props => [items];
}

class ItemsError extends ItemsState {
  const ItemsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

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
