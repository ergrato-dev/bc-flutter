# 🧪 Testing de Llamadas API

## 🎯 Niveles de Testing

| Nivel       | Qué Testea        | Velocidad | Aislamiento |
| ----------- | ----------------- | --------- | ----------- |
| Unit        | Servicios, Parseo | ⚡ Rápido | Alto        |
| Widget      | UI + Estado       | 🚀 Medio  | Medio       |
| Integration | Flujo completo    | 🐢 Lento  | Bajo        |

---

## 🔧 Setup

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.8
  http_mock_adapter: ^0.6.1 # Para Dio
```

---

## 📝 Unit Tests

### Testing de Modelos

```dart
void main() {
  group('User Model', () {
    test('fromJson creates valid User', () {
      final json = {
        'id': 1,
        'name': 'John Doe',
        'email': 'john@example.com',
      };

      final user = User.fromJson(json);

      expect(user.id, 1);
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
    });

    test('fromJson handles null values', () {
      final json = {
        'id': 1,
        'name': 'John',
        'email': null,
      };

      final user = User.fromJson(json);

      expect(user.email, isNull);
    });

    test('toJson returns correct map', () {
      final user = User(id: 1, name: 'John', email: 'john@example.com');

      final json = user.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'John');
    });
  });
}
```

### Testing de Services con Mock

```dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late UserService userService;

  setUp(() {
    mockClient = MockClient();
    userService = UserService(client: mockClient);
  });

  group('UserService', () {
    test('fetchUsers returns list on success', () async {
      // Arrange
      when(mockClient.get(any)).thenAnswer((_) async => http.Response(
        jsonEncode([
          {'id': 1, 'name': 'John'},
          {'id': 2, 'name': 'Jane'},
        ]),
        200,
      ));

      // Act
      final users = await userService.fetchUsers();

      // Assert
      expect(users.length, 2);
      expect(users[0].name, 'John');
      verify(mockClient.get(any)).called(1);
    });

    test('fetchUsers throws on 404', () async {
      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      expect(
        () => userService.fetchUsers(),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('fetchUsers throws on network error', () async {
      when(mockClient.get(any)).thenThrow(SocketException('No connection'));

      expect(
        () => userService.fetchUsers(),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
```

### Testing con Dio Mock Adapter

```dart
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late UserService userService;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    userService = UserService(dio: dio);
  });

  test('getUser returns user on success', () async {
    dioAdapter.onGet(
      '/users/1',
      (server) => server.reply(200, {
        'id': 1,
        'name': 'John',
        'email': 'john@example.com',
      }),
    );

    final user = await userService.getUser(1);

    expect(user.id, 1);
    expect(user.name, 'John');
  });

  test('createUser sends correct data', () async {
    dioAdapter.onPost(
      '/users',
      data: {'name': 'John', 'email': 'john@example.com'},
      (server) => server.reply(201, {'id': 1, 'name': 'John'}),
    );

    final user = await userService.createUser(
      name: 'John',
      email: 'john@example.com',
    );

    expect(user.id, 1);
  });

  test('handles timeout', () async {
    dioAdapter.onGet(
      '/users',
      (server) => server.throws(
        408,
        DioException(
          requestOptions: RequestOptions(path: '/users'),
          type: DioExceptionType.connectionTimeout,
        ),
      ),
    );

    expect(
      () => userService.getUsers(),
      throwsA(isA<NetworkException>()),
    );
  });
}
```

---

## 🎨 Widget Tests

```dart
void main() {
  late MockUserService mockService;

  setUp(() {
    mockService = MockUserService();
  });

  testWidgets('shows loading indicator initially', (tester) async {
    when(mockService.getUsers()).thenAnswer(
      (_) => Future.delayed(const Duration(seconds: 2), () => []),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<UserService>.value(
          value: mockService,
          child: const UsersScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows users when loaded', (tester) async {
    when(mockService.getUsers()).thenAnswer(
      (_) async => [
        User(id: 1, name: 'John'),
        User(id: 2, name: 'Jane'),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<UserService>.value(
          value: mockService,
          child: const UsersScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('John'), findsOneWidget);
    expect(find.text('Jane'), findsOneWidget);
  });

  testWidgets('shows error and retry button on failure', (tester) async {
    when(mockService.getUsers()).thenThrow(NetworkException());

    await tester.pumpWidget(...);
    await tester.pumpAndSettle();

    expect(find.text('Error de conexión'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);

    // Test retry
    when(mockService.getUsers()).thenAnswer((_) async => [
      User(id: 1, name: 'John'),
    ]);

    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();

    expect(find.text('John'), findsOneWidget);
  });

  testWidgets('pull to refresh works', (tester) async {
    when(mockService.getUsers()).thenAnswer(
      (_) async => [User(id: 1, name: 'John')],
    );

    await tester.pumpWidget(...);
    await tester.pumpAndSettle();

    // Pull to refresh
    await tester.drag(find.byType(ListView), const Offset(0, 300));
    await tester.pumpAndSettle();

    verify(mockService.getUsers()).called(2);
  });
}
```

---

## 🔄 Integration Tests

```dart
// test/integration/user_flow_test.dart
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('User Flow', () {
    testWidgets('complete user creation flow', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to create user
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Fill form
      await tester.enterText(
        find.byKey(const Key('nameField')),
        'John Doe',
      );
      await tester.enterText(
        find.byKey(const Key('emailField')),
        'john@example.com',
      );

      // Submit
      await tester.tap(find.text('Crear'));
      await tester.pumpAndSettle();

      // Verify navigation back and user in list
      expect(find.text('John Doe'), findsOneWidget);
    });
  });
}
```

---

## 📊 Test Data Factories

```dart
class TestData {
  static User createUser({
    int id = 1,
    String name = 'Test User',
    String email = 'test@example.com',
  }) {
    return User(id: id, name: name, email: email);
  }

  static List<User> createUsers(int count) {
    return List.generate(
      count,
      (i) => createUser(id: i + 1, name: 'User ${i + 1}'),
    );
  }

  static Map<String, dynamic> createUserJson({
    int id = 1,
    String name = 'Test User',
  }) {
    return {
      'id': id,
      'name': name,
      'email': 'test@example.com',
    };
  }
}

// Uso en tests
test('parses list correctly', () {
  final json = List.generate(5, (i) => TestData.createUserJson(id: i));
  final users = json.map((j) => User.fromJson(j)).toList();
  expect(users.length, 5);
});
```

---

## ✅ Checklist de Testing

```
□ Modelos: fromJson / toJson
□ Services: happy path
□ Services: error handling (404, 500, timeout)
□ Services: edge cases (empty list, null values)
□ Widgets: loading state
□ Widgets: success state
□ Widgets: error state con retry
□ Widgets: pull to refresh
□ Integration: flujo completo
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
