// ponytail: dos smoke tests — confirman que la app arranca autenticada
// mostrando el badge de favoritos en 0 (envolviendo MyApp con ProviderScope
// explícitamente, como main.dart señala), y que FavoritesNotifier persiste
// en SharedPreferences de forma aislada con ProviderContainer, sin montar
// ningún widget. Súbelos de nivel cuando implementes tus TODOs.
//
// itemsRepositoryProvider se sobreescribe con un FakeItemsRepository (mismo
// motivo que semana 6): un widget test nunca debe golpear la red real, y así
// tampoco necesita el Box de Hive (CachedItemsRepository nunca se construye).
// authProvider se sobreescribe con FakeAuthNotifier: un widget test tampoco
// debe golpear flutter_secure_storage (no hay platform channel en el
// harness de test) ni la API de login real — simula sesión ya iniciada,
// para poder llegar directo a HomeScreen y verificar el badge.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:domain_auth_app/main.dart';
import 'package:domain_auth_app/models/item.dart';
import 'package:domain_auth_app/providers/auth_provider.dart';
import 'package:domain_auth_app/providers/favorites_provider.dart';
import 'package:domain_auth_app/providers/items_repository_provider.dart';
import 'package:domain_auth_app/providers/shared_preferences_provider.dart';
import 'package:domain_auth_app/repositories/items_repository.dart';

class FakeItemsRepository implements ItemsRepository {
  @override
  Future<List<Item>> fetchItems() async => const [
        Item(id: '1', name: 'Elemento de prueba', description: 'Descripción de prueba'),
      ];

  @override
  Future<void> createItem(Item item) async {}
}

class FakeAuthNotifier extends AuthNotifier {
  @override
  Future<String?> build() async => 'fake-token';
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('La app arranca autenticada con el badge de favoritos en 0', (tester) async {
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(FakeAuthNotifier.new),
          itemsRepositoryProvider.overrideWithValue(FakeItemsRepository()),
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
  });

  test('FavoritesNotifier.toggle agrega, persiste y quita un id', () async {
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    expect(container.read(favoritesProvider), isEmpty);

    container.read(favoritesProvider.notifier).toggle('1');
    expect(container.read(favoritesProvider), {'1'});

    container.read(favoritesProvider.notifier).toggle('1');
    expect(container.read(favoritesProvider), isEmpty);
  });
}
