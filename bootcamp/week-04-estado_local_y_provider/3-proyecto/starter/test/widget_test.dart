// ponytail: dos smoke tests — confirman que la app arranca con el badge de
// favoritos en 0, y que FavoritesProvider funciona de forma aislada (sin
// montar ningún widget). Súbelos de nivel cuando implementes tus TODOs.
import 'package:flutter_test/flutter_test.dart';

import 'package:domain_favorites_app/main.dart';
import 'package:domain_favorites_app/providers/favorites_provider.dart';

void main() {
  testWidgets('La app arranca con el badge de favoritos en 0', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
  });

  test('FavoritesProvider.toggle agrega y quita un id', () {
    final provider = FavoritesProvider();
    expect(provider.isFavorite('1'), isFalse);

    provider.toggle('1');
    expect(provider.isFavorite('1'), isTrue);
    expect(provider.count, 1);

    provider.toggle('1');
    expect(provider.isFavorite('1'), isFalse);
    expect(provider.count, 0);
  });
}
