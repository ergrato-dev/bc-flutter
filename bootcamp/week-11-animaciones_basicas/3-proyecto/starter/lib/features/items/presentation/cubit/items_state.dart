import 'package:equatable/equatable.dart';

import '../../domain/entities/item.dart';

// ============================================
// STATE: ItemsState
// Un estado por cada momento posible de la carga — el mismo abanico
// loading/data/error que AsyncValue<List<Item>> cubría con una sola clase
// en semanas 5-9 (ver teoría 03: por qué Cubit usa clases separadas).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
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
