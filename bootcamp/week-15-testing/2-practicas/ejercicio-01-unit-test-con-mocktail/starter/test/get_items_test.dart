import 'package:flutter_test/flutter_test.dart';
// ignore: unused_import — se usa al descomentar el PASO 2 (when, verify).
import 'package:mocktail/mocktail.dart';

// ignore: unused_import — se usa al descomentar los PASOS 1 y 2.
import 'package:ejercicio_01_unit_test_con_mocktail/domain.dart';

// TODO temporal: en el PASO 1, declara aquí (fuera de cualquier función) la
// clase MockItemsRepository — ver instrucciones al final del archivo.

void main() {
  group('GetItems', () {
    // TODO temporal: en el PASO 2, agrega el test — ver instrucciones al
    // final del archivo.
  });
}

// ============================================
// PASO 1: declarar el mock
// ============================================
// Agrega esto arriba de main() (fuera de cualquier función):
//
// class MockItemsRepository extends Mock implements ItemsRepository {}

// ============================================
// PASO 2: programar el mock y escribir el test
// ============================================
// Agrega esto dentro de group('GetItems', () { ... }):
//
// test('retorna la lista de elementos del repository', () async {
//   final repository = MockItemsRepository();
//   when(() => repository.getItems()).thenAnswer(
//     (_) async => const [Item(id: '1', name: 'Laptop', description: 'Portátil')],
//   );
//
//   final result = await GetItems(repository)();
//
//   expect(result, hasLength(1));
//   expect(result.first.name, 'Laptop');
//   verify(() => repository.getItems()).called(1);
// });
//
// ✅ Verifica: `flutter test` debe mostrar "All tests passed!".
