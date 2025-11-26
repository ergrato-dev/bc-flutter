# 📖 Glosario - Semana 9: Arquitectura y Testing

## 📋 Términos de Arquitectura y Testing

Glosario completo de términos técnicos utilizados en esta semana.

---

## A

### AAA Pattern
**Arrange-Act-Assert.** Patrón para estructurar tests unitarios en tres fases claras.
```dart
test('example', () {
  // Arrange - preparar datos y dependencias
  final calculator = Calculator();
  
  // Act - ejecutar la acción a testear
  final result = calculator.add(2, 3);
  
  // Assert - verificar el resultado
  expect(result, equals(5));
});
```

### Abstract Class
Clase que no puede ser instanciada directamente, usada para definir interfaces.
```dart
abstract class Repository {
  Future<List<Entity>> getAll();
}
```

### Assertion
Verificación de que una condición es verdadera en un test.
```dart
expect(result, isNotNull);
expect(list, hasLength(3));
```

---

## B

### BLoC Test
Package para testear BLoCs de manera sencilla.
```dart
blocTest<CounterBloc, int>(
  'emits [1] when increment is added',
  build: () => CounterBloc(),
  act: (bloc) => bloc.add(Increment()),
  expect: () => [1],
);
```

### Boundary
Límite entre capas de la arquitectura donde se definen interfaces.

### Build Runner
Herramienta para generar código en Dart (mocks, JSON serialization, etc.).
```bash
flutter pub run build_runner build
```

---

## C

### Clean Architecture
Arquitectura de software que separa el código en capas con dependencias hacia el centro.

### Code Coverage
Porcentaje de código ejecutado durante los tests.
```bash
flutter test --coverage
```

### Contract
Interfaz que define el contrato entre capas.
```dart
abstract class UserRepository {
  Future<User> getUser(int id);
}
```

---

## D

### Data Layer
Capa responsable de obtener y persistir datos (APIs, bases de datos).

### Data Source
Origen de datos (remoto o local).
```dart
abstract class RemoteDataSource {
  Future<UserModel> fetchUser(int id);
}
```

### Dependency Injection (DI)
Patrón donde las dependencias se proveen externamente.
```dart
class GetUser {
  final UserRepository repository; // Inyectada
  GetUser(this.repository);
}
```

### Domain Layer
Capa central con la lógica de negocio, entidades y casos de uso.

---

## E

### Either
Tipo funcional que representa éxito (Right) o fallo (Left).
```dart
Future<Either<Failure, User>> getUser(int id);

// Uso
result.fold(
  (failure) => print('Error: $failure'),
  (user) => print('User: ${user.name}'),
);
```

### Entity
Objeto de negocio en la capa Domain, sin dependencias externas.
```dart
class User {
  final int id;
  final String name;
  User({required this.id, required this.name});
}
```

### Expect
Función para verificar condiciones en tests.
```dart
expect(actual, matcher);
expect(result, equals(expected));
```

---

## F

### Failure
Clase que representa un error de dominio.
```dart
abstract class Failure {}
class ServerFailure extends Failure {}
class CacheFailure extends Failure {}
```

### Fake
Implementación simplificada de una dependencia para tests.
```dart
class FakeUserRepository implements UserRepository {
  @override
  Future<User> getUser(int id) async => User(id: id, name: 'Fake');
}
```

### Finder
Función para encontrar widgets en tests.
```dart
find.text('Hello');
find.byType(ElevatedButton);
find.byKey(Key('myKey'));
```

### Fixture
Datos de prueba predefinidos.
```dart
final testUser = User(id: 1, name: 'Test User');
```

---

## G

### Get It
Service Locator para inyección de dependencias.
```dart
final sl = GetIt.instance;
sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
```

### Golden Test
Test que compara screenshots de widgets con imágenes de referencia.

### Group
Agrupación de tests relacionados.
```dart
group('Calculator', () {
  test('should add numbers', () { ... });
  test('should subtract numbers', () { ... });
});
```

---

## H

### Happy Path
Flujo de ejecución exitoso sin errores.

### Hook
Funciones que se ejecutan antes/después de tests.
```dart
setUp(() { /* antes de cada test */ });
tearDown(() { /* después de cada test */ });
setUpAll(() { /* antes de todos los tests */ });
```

---

## I

### Injectable
Package para generar código de inyección de dependencias.
```dart
@injectable
class UserRepository { ... }

@module
abstract class RegisterModule { ... }
```

### Integration Test
Test que verifica múltiples componentes trabajando juntos.
```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('complete user flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Test flow...
  });
}
```

### Interface
Contrato que define métodos que una clase debe implementar.

---

## L

### Layered Architecture
Arquitectura organizada en capas con responsabilidades específicas.

### Left
En Either, representa el caso de fallo.
```dart
return Left(ServerFailure());
```

---

## M

### Matcher
Objeto que define cómo comparar valores en assertions.
```dart
expect(list, contains('item'));
expect(value, greaterThan(5));
expect(widget, findsOneWidget);
```

### Mock
Objeto que simula el comportamiento de una dependencia.
```dart
@GenerateMocks([UserRepository])
class MockUserRepository extends Mock implements UserRepository {}
```

### Mockito
Package para crear mocks en Dart.
```dart
when(mock.method()).thenReturn(value);
when(mock.method()).thenThrow(Exception());
verify(mock.method()).called(1);
```

### Model
Representación de datos con lógica de serialización.
```dart
class UserModel extends User {
  factory UserModel.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

---

## P

### Presentation Layer
Capa de UI con widgets, páginas y gestión de estado.

### Pump
Método para avanzar frames en widget tests.
```dart
await tester.pump(); // Un frame
await tester.pump(Duration(seconds: 1)); // Avanzar tiempo
await tester.pumpAndSettle(); // Hasta que no haya animaciones
```

---

## R

### Red-Green-Refactor
Ciclo de TDD: test falla (red), implementar (green), mejorar (refactor).

### Repository
Abstracción que oculta el origen de los datos.
```dart
abstract class UserRepository {
  Future<Either<Failure, User>> getUser(int id);
}

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remote;
  final LocalDataSource local;
  // ...
}
```

### Right
En Either, representa el caso de éxito.
```dart
return Right(user);
```

---

## S

### Service Locator
Patrón para obtener dependencias de un registro central.
```dart
final repository = GetIt.I<UserRepository>();
```

### setUp
Función que se ejecuta antes de cada test.
```dart
setUp(() {
  mockRepository = MockUserRepository();
  useCase = GetUser(mockRepository);
});
```

### SOLID
Principios de diseño orientado a objetos:
- **S**ingle Responsibility
- **O**pen/Closed
- **L**iskov Substitution
- **I**nterface Segregation
- **D**ependency Inversion

### Stub
Respuesta predefinida de un mock.
```dart
when(mock.getUser(1)).thenAnswer((_) async => testUser);
```

### SUT
**System Under Test.** El componente que se está testeando.

---

## T

### TDD
**Test-Driven Development.** Metodología donde se escriben tests antes del código.

### tearDown
Función que se ejecuta después de cada test.
```dart
tearDown(() {
  // Limpiar recursos
});
```

### Test
Verificación automatizada de comportamiento.
```dart
test('description', () {
  // Test code
});
```

### testWidgets
Función para tests de widgets.
```dart
testWidgets('renders correctly', (WidgetTester tester) async {
  await tester.pumpWidget(MyWidget());
  expect(find.text('Hello'), findsOneWidget);
});
```

---

## U

### Unit Test
Test de una unidad aislada de código.
```dart
test('Calculator.add returns correct sum', () {
  expect(Calculator().add(2, 3), equals(5));
});
```

### Use Case
Clase que encapsula una operación de negocio específica.
```dart
class GetUser implements UseCase<User, int> {
  final UserRepository repository;
  
  GetUser(this.repository);
  
  @override
  Future<Either<Failure, User>> call(int userId) {
    return repository.getUser(userId);
  }
}
```

---

## V

### Verify
Verificar que un método fue llamado en un mock.
```dart
verify(mockRepository.getUser(1)).called(1);
verifyNever(mockRepository.deleteUser(any));
```

---

## W

### When
Configurar comportamiento de un mock.
```dart
when(mock.method()).thenReturn(value);
when(mock.method()).thenAnswer((_) async => value);
when(mock.method()).thenThrow(Exception());
```

### Widget Test
Test de componentes de UI.
```dart
testWidgets('button triggers callback', (tester) async {
  var pressed = false;
  await tester.pumpWidget(
    MaterialApp(
      home: ElevatedButton(
        onPressed: () => pressed = true,
        child: Text('Press'),
      ),
    ),
  );
  
  await tester.tap(find.text('Press'));
  expect(pressed, isTrue);
});
```

### WidgetTester
Clase para interactuar con widgets en tests.
```dart
await tester.pumpWidget(widget);
await tester.tap(finder);
await tester.enterText(finder, 'text');
await tester.drag(finder, offset);
```

---

## 📚 Referencias

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Dart Test Package](https://pub.dev/packages/test)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

> **Total de términos:** 60+
