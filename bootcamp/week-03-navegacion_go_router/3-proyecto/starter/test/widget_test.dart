// ponytail: un único smoke test — confirma que el router arranca en "/" y
// muestra la bottom nav bar del ShellRoute, sin exigir una suite exhaustiva
// a un proyecto de semana 3. Súbelo de nivel cuando implementes tus TODOs.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:domain_navigation_app/main.dart';

void main() {
  testWidgets('La app arranca en la ruta / con NavigationBar visible', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Mi Dominio'), findsOneWidget);
  });
}
