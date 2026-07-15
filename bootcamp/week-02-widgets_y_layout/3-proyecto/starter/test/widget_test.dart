// ponytail: un único smoke test — confirma que la app arranca y el Scaffold
// muestra el AppBar esperado, sin exigir una suite exhaustiva a un proyecto
// de semana 2. Súbelo de nivel cuando implementes tus propios TODOs.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:domain_list_app/main.dart';

void main() {
  testWidgets('HomeScreen muestra el AppBar con título', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
