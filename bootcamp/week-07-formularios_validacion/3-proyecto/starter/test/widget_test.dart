// ponytail: dos smoke tests — confirman que la app arranca con el badge de
// favoritos en 0 (envolviendo MyApp con ProviderScope explícitamente, como
// main.dart señala), y que FavoritesNotifier funciona de forma aislada con
// ProviderContainer, sin montar ningún widget. Súbelos de nivel cuando
// implementes tus TODOs.
//
// itemsRepositoryProvider se sobreescribe con un FakeItemsRepository (mismo
// motivo que semana 6): un widget test nunca debe golpear la red real.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:domain_forms_app/main.dart';
import 'package:domain_forms_app/models/item.dart';
import 'package:domain_forms_app/providers/favorites_provider.dart';
import 'package:domain_forms_app/providers/items_repository_provider.dart';
import 'package:domain_forms_app/repositories/items_repository.dart';

class FakeItemsRepository implements ItemsRepository {
  @override
  Future<List<Item>> fetchItems() async => const [
        Item(id: '1', name: 'Elemento de prueba', description: 'Descripción de prueba'),
      ];

  @override
  Future<void> createItem(Item item) async {}
}

void main() {
  testWidgets('La app arranca con el badge de favoritos en 0', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [itemsRepositoryProvider.overrideWithValue(FakeItemsRepository())],
        child: const MyApp(),
      ),
    );
    await tester.pump();

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
