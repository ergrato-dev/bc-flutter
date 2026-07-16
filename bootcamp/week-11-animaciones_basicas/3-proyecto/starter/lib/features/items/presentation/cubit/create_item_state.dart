import 'package:equatable/equatable.dart';

// ============================================
// STATE: CreateItemState
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo.
sealed class CreateItemState extends Equatable {
  const CreateItemState();

  @override
  List<Object?> get props => [];
}

class CreateItemIdle extends CreateItemState {
  const CreateItemIdle();
}

class CreateItemSubmitting extends CreateItemState {
  const CreateItemSubmitting();
}

class CreateItemSuccess extends CreateItemState {
  const CreateItemSuccess();
}

class CreateItemFailure extends CreateItemState {
  const CreateItemFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
