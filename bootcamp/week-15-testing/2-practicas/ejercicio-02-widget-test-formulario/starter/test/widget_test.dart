// ignore: unused_import — se usa al descomentar el PASO 1 (MaterialApp, Key).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: unused_import — se usa al descomentar el PASO 1 (FormScreen).
import 'package:ejercicio_02_widget_test_formulario/main.dart';

void main() {
  group('FormScreen', () {
    // TODO temporal: en los PASOS 1, 2 y 3, agrega los tests — ver
    // instrucciones al final del archivo.
  });
}

// ============================================
// PASO 1: estado inicial
// ============================================
// Agrega esto dentro de group('FormScreen', () { ... }):
//
// testWidgets('muestra el formulario vacío al inicio', (tester) async {
//   await tester.pumpWidget(const MaterialApp(home: FormScreen()));
//
//   expect(find.byKey(const Key('name-field')), findsOneWidget);
//   expect(find.textContaining('¡Hola'), findsNothing);
// });

// ============================================
// PASO 2: envío válido
// ============================================
// Agrega esto también dentro del group:
//
// testWidgets('muestra el saludo al enviar con nombre', (tester) async {
//   await tester.pumpWidget(const MaterialApp(home: FormScreen()));
//
//   await tester.enterText(find.byKey(const Key('name-field')), 'Ana');
//   await tester.tap(find.byKey(const Key('submit-button')));
//   await tester.pump();
//
//   expect(find.text('¡Hola, Ana!'), findsOneWidget);
// });

// ============================================
// PASO 3: validación de campo vacío
// ============================================
// Agrega esto también dentro del group:
//
// testWidgets('muestra el error si el nombre está vacío', (tester) async {
//   await tester.pumpWidget(const MaterialApp(home: FormScreen()));
//
//   await tester.tap(find.byKey(const Key('submit-button')));
//   await tester.pump();
//
//   expect(find.text('El nombre es obligatorio'), findsOneWidget);
// });
//
// ✅ Verifica: `flutter test` debe mostrar "All tests passed!" con los tres
// tests en verde.
