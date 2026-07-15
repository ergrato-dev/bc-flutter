// ponytail: dos smoke tests — confirman que la app arranca con el badge de
// favoritos en 0 (envolviendo MyApp con ProviderScope explícitamente,
// como main.dart señala), y que FavoritesNotifier funciona de forma
// aislada con ProviderContainer, sin montar ningún widget. Súbelos de
// nivel cuando implementes tus TODOs.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:domain_riverpod_app/main.dart';
import 'package:domain_riverpod_app/providers/favorites_provider.dart';

void main() {
  testWidgets('La app arranca con el badge de favoritos en 0', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
  });

  test('FavoritesNotifier.toggle agrega y quita un id', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(favoritesProvider), isEmpty);

    container.read(favoritesProvider.notifier).toggle('1');
    expect(container.read(favoritesProvider), {'1'});

    container.read(favoritesProvider.notifier).toggle('1');
    expect(container.read(favoritesProvider), isEmpty);
  });
}
