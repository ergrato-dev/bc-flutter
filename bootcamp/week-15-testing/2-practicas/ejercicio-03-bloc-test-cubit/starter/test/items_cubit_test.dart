// ignore: unused_import — se usa al descomentar los PASOS 1 y 2 (blocTest).
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ejercicio_03_bloc_test_cubit/domain.dart';
// ignore: unused_import — se usa al descomentar los PASOS 1 y 2 (ItemsCubit, ItemsState...).
import 'package:ejercicio_03_bloc_test_cubit/items_cubit.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  group('ItemsCubit', () {
    // ignore: unused_local_variable — se usa al descomentar los PASOS 1 y 2.
    late MockItemsRepository repository;

    setUp(() => repository = MockItemsRepository());

    // TODO temporal: en el PASO 1, agrega el blocTest del caso de éxito —
    // ver instrucciones al final del archivo.

    // TODO temporal: en el PASO 2, agrega el blocTest del caso de error —
    // ver instrucciones al final del archivo.
  });
}

// ============================================
// PASO 1: caso de éxito
// ============================================
// Agrega esto dentro de group('ItemsCubit', () { ... }), después de setUp:
//
// blocTest<ItemsCubit, ItemsState>(
//   'emite [ItemsLoading, ItemsLoaded] cuando el repository responde',
//   build: () {
//     when(() => repository.getItems()).thenAnswer(
//       (_) async => const [Item(id: '1', name: 'Laptop', description: 'Portátil')],
//     );
//     return ItemsCubit(GetItems(repository));
//   },
//   act: (cubit) => cubit.fetchItems(),
//   expect: () => [
//     isA<ItemsLoading>(),
//     isA<ItemsLoaded>().having((s) => s.items, 'items', hasLength(1)),
//   ],
// );

// ============================================
// PASO 2: caso de error
// ============================================
// Agrega esto también dentro del group:
//
// blocTest<ItemsCubit, ItemsState>(
//   'emite [ItemsLoading, ItemsError] cuando el repository lanza',
//   build: () {
//     when(() => repository.getItems()).thenThrow(Exception('sin conexión'));
//     return ItemsCubit(GetItems(repository));
//   },
//   act: (cubit) => cubit.fetchItems(),
//   expect: () => [isA<ItemsLoading>(), isA<ItemsError>()],
// );
//
// ✅ Verifica: `flutter test` debe mostrar "All tests passed!" con ambos
// blocTest en verde.
