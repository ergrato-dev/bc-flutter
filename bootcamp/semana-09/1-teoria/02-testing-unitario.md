# 🧪 Módulo 2: Testing Unitario en Flutter

## 📋 Contenido

1. [Introducción al Testing](#-introducción-al-testing)
2. [Configuración](#-configuración)
3. [Estructura de Tests](#-estructura-de-tests)
4. [Patrón AAA](#-patrón-aaa)
5. [Matchers y Assertions](#-matchers-y-assertions)
6. [Mocking con Mockito](#-mocking-con-mockito)
7. [Testing de Use Cases](#-testing-de-use-cases)
8. [Test-Driven Development](#-test-driven-development)
9. [Code Coverage](#-code-coverage)

---

## 🎯 Objetivos

- Escribir tests unitarios efectivos
- Aplicar el patrón AAA (Arrange, Act, Assert)
- Usar Mockito para crear mocks
- Implementar TDD en proyectos Flutter
- Medir y mejorar la cobertura de código

---

## 📖 Introducción al Testing

### ¿Por qué testear?

| Beneficio         | Descripción                               |
| ----------------- | ----------------------------------------- |
| **Confianza**     | Cambios sin miedo a romper funcionalidad  |
| **Documentación** | Tests explican el comportamiento esperado |
| **Diseño**        | Tests fuerzan mejor arquitectura          |
| **Regresiones**   | Detectar bugs antes de producción         |
| **Refactoring**   | Mejorar código con seguridad              |

### Pirámide de Testing

```
        /\
       /  \        Integration Tests
      /    \       (Pocos, lentos, costosos)
     /──────\
    /        \     Widget Tests
   /          \    (Algunos, moderados)
  /────────────\
 /              \  Unit Tests
/________________\ (Muchos, rápidos, baratos)
```

### Tipos de Tests en Flutter

| Tipo            | Qué testea           | Velocidad | Ejemplo              |
| --------------- | -------------------- | --------- | -------------------- |
| **Unit**        | Funciones, clases    | Rápido    | Use cases, BLoCs     |
| **Widget**      | Widgets individuales | Medio     | Botones, formularios |
| **Integration** | Flujos completos     | Lento     | Login flow           |

---

## ⚙️ Configuración

### pubspec.yaml

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  test: ^1.24.9
  mockito: ^5.4.4
  build_runner: ^2.4.8
  bloc_test: ^9.1.5
```

### Estructura de Carpetas

```
test/
├── core/
│   └── utils/
│       └── input_converter_test.dart
├── features/
│   └── user/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── user_remote_datasource_test.dart
│       │   ├── models/
│       │   │   └── user_model_test.dart
│       │   └── repositories/
│       │       └── user_repository_impl_test.dart
│       ├── domain/
│       │   └── usecases/
│       │       ├── get_user_test.dart
│       │       └── get_users_test.dart
│       └── presentation/
│           └── bloc/
│               └── user_bloc_test.dart
├── fixtures/
│   └── user_fixture.json
└── helpers/
    └── test_helper.dart
```

---

## 📝 Estructura de Tests

### Anatomía de un Test

```dart
/// test/features/user/domain/usecases/get_user_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Importar las clases necesarias
import 'package:my_app/features/user/domain/usecases/get_user.dart';
import 'package:my_app/features/user/domain/repositories/user_repository.dart';

// Generar mocks
@GenerateMocks([UserRepository])
import 'get_user_test.mocks.dart';

void main() {
  // Declarar variables
  late GetUser usecase;
  late MockUserRepository mockRepository;

  // Configuración antes de cada test
  setUp(() {
    mockRepository = MockUserRepository();
    usecase = GetUser(mockRepository);
  });

  // Grupo de tests relacionados
  group('GetUser', () {
    // Datos de prueba
    const tUserId = 1;
    final tUser = User(
      id: tUserId,
      name: 'Test User',
      email: 'test@example.com',
      createdAt: DateTime(2024, 1, 1),
    );

    test('should get user from repository', () async {
      // Arrange
      when(mockRepository.getUser(tUserId))
          .thenAnswer((_) async => Right(tUser));

      // Act
      final result = await usecase(tUserId);

      // Assert
      expect(result, Right(tUser));
      verify(mockRepository.getUser(tUserId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      when(mockRepository.getUser(tUserId))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act
      final result = await usecase(tUserId);

      // Assert
      expect(result, Left(ServerFailure()));
      verify(mockRepository.getUser(tUserId)).called(1);
    });
  });
}
```

### Ejecutar Tests

```bash
# Todos los tests
flutter test

# Un archivo específico
flutter test test/features/user/domain/usecases/get_user_test.dart

# Tests que coinciden con un patrón
flutter test --name "should get user"

# Con reporter detallado
flutter test --reporter expanded
```

---

## 🎯 Patrón AAA

### Arrange, Act, Assert

```dart
test('should calculate total price with discount', () {
  // ═══════════════════════════════════════════════════
  // ARRANGE - Preparar datos y dependencias
  // ═══════════════════════════════════════════════════
  final cart = ShoppingCart();
  final product = Product(name: 'Laptop', price: 1000.0);
  final discount = Discount(percentage: 10);

  cart.addProduct(product);
  cart.applyDiscount(discount);

  // ═══════════════════════════════════════════════════
  // ACT - Ejecutar la acción a testear
  // ═══════════════════════════════════════════════════
  final totalPrice = cart.calculateTotal();

  // ═══════════════════════════════════════════════════
  // ASSERT - Verificar el resultado
  // ═══════════════════════════════════════════════════
  expect(totalPrice, equals(900.0)); // 1000 - 10%
});
```

### Ejemplos por Tipo

```dart
// Test de función pura
test('should add two numbers correctly', () {
  // Arrange
  final calculator = Calculator();

  // Act
  final result = calculator.add(2, 3);

  // Assert
  expect(result, equals(5));
});

// Test de excepción
test('should throw when dividing by zero', () {
  // Arrange
  final calculator = Calculator();

  // Act & Assert
  expect(
    () => calculator.divide(10, 0),
    throwsA(isA<DivisionByZeroException>()),
  );
});

// Test asíncrono
test('should fetch data from API', () async {
  // Arrange
  when(mockApi.fetchData()).thenAnswer((_) async => testData);

  // Act
  final result = await service.getData();

  // Assert
  expect(result, equals(testData));
});
```

---

## ✅ Matchers y Assertions

### Matchers Básicos

```dart
void main() {
  group('Basic Matchers', () {
    test('equality matchers', () {
      expect(1 + 1, equals(2));
      expect('hello', equals('hello'));
      expect([1, 2, 3], equals([1, 2, 3]));
    });

    test('type matchers', () {
      expect(42, isA<int>());
      expect('hello', isA<String>());
      expect(null, isNull);
      expect('hello', isNotNull);
    });

    test('boolean matchers', () {
      expect(true, isTrue);
      expect(false, isFalse);
    });

    test('comparison matchers', () {
      expect(10, greaterThan(5));
      expect(5, lessThan(10));
      expect(10, greaterThanOrEqualTo(10));
      expect(5, lessThanOrEqualTo(5));
      expect(7, inInclusiveRange(5, 10));
    });
  });
}
```

### Matchers de Colecciones

```dart
group('Collection Matchers', () {
  test('list matchers', () {
    final list = [1, 2, 3, 4, 5];

    expect(list, hasLength(5));
    expect(list, contains(3));
    expect(list, containsAll([1, 3, 5]));
    expect(list, isNotEmpty);
    expect([], isEmpty);
    expect(list, orderedEquals([1, 2, 3, 4, 5]));
    expect(list, unorderedEquals([5, 4, 3, 2, 1]));
  });

  test('map matchers', () {
    final map = {'name': 'John', 'age': 30};

    expect(map, containsKey('name'));
    expect(map, containsValue('John'));
    expect(map, containsPair('name', 'John'));
  });
});
```

### Matchers de Strings

```dart
group('String Matchers', () {
  test('string matchers', () {
    const text = 'Hello, World!';

    expect(text, startsWith('Hello'));
    expect(text, endsWith('!'));
    expect(text, contains('World'));
    expect(text, matches(RegExp(r'Hello.*')));
    expect(text, equalsIgnoringCase('HELLO, WORLD!'));
    expect('  hello  ', equalsIgnoringWhitespace('hello'));
  });
});
```

### Matchers de Excepciones

```dart
group('Exception Matchers', () {
  test('throws exception', () {
    expect(
      () => throw Exception('Error'),
      throwsException,
    );
  });

  test('throws specific exception type', () {
    expect(
      () => throw ArgumentError('Invalid argument'),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('throws with message', () {
    expect(
      () => throw Exception('Specific error message'),
      throwsA(
        predicate<Exception>(
          (e) => e.toString().contains('Specific error message'),
        ),
      ),
    );
  });

  test('throws StateError', () {
    expect(
      () => throw StateError('Bad state'),
      throwsStateError,
    );
  });
});
```

### Custom Matchers

```dart
/// Matcher personalizado para validar emails
class IsValidEmail extends Matcher {
  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! String) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(item);
  }

  @override
  Description describe(Description description) {
    return description.add('a valid email address');
  }
}

// Uso
Matcher isValidEmail = IsValidEmail();

test('should be valid email', () {
  expect('test@example.com', isValidEmail);
  expect('invalid-email', isNot(isValidEmail));
});
```

---

## 🎭 Mocking con Mockito

### Generación de Mocks

```dart
/// test/features/user/domain/usecases/get_user_test.dart

import 'package:mockito/annotations.dart';

// Anotar las clases a mockear
@GenerateMocks([
  UserRepository,
  NetworkInfo,
  UserRemoteDataSource,
  UserLocalDataSource,
])
void main() {
  // Tests...
}

// Ejecutar: flutter pub run build_runner build
```

### Configurar Comportamiento (Stubbing)

```dart
group('Stubbing', () {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  test('thenReturn - valor síncrono', () {
    // Configurar respuesta
    when(mockRepository.getUserSync(1)).thenReturn(testUser);

    // Usar
    final result = mockRepository.getUserSync(1);
    expect(result, equals(testUser));
  });

  test('thenAnswer - valor asíncrono', () async {
    // Configurar respuesta asíncrona
    when(mockRepository.getUser(1))
        .thenAnswer((_) async => Right(testUser));

    // Usar
    final result = await mockRepository.getUser(1);
    expect(result, Right(testUser));
  });

  test('thenThrow - lanzar excepción', () {
    // Configurar excepción
    when(mockRepository.getUser(any))
        .thenThrow(ServerException('Server error'));

    // Verificar
    expect(
      () => mockRepository.getUser(1),
      throwsA(isA<ServerException>()),
    );
  });

  test('respuestas múltiples', () async {
    // Primera llamada retorna usuario, segunda falla
    when(mockRepository.getUser(1))
        .thenAnswer((_) async => Right(testUser))
        .thenAnswer((_) async => Left(ServerFailure()));

    final first = await mockRepository.getUser(1);
    final second = await mockRepository.getUser(1);

    expect(first, Right(testUser));
    expect(second, Left(ServerFailure()));
  });
});
```

### Argument Matchers

```dart
group('Argument Matchers', () {
  test('any - cualquier valor', () {
    when(mockRepository.getUser(any))
        .thenAnswer((_) async => Right(testUser));

    // Funciona con cualquier ID
    mockRepository.getUser(1);
    mockRepository.getUser(999);
  });

  test('argThat - condición personalizada', () {
    when(mockRepository.getUser(argThat(greaterThan(0))))
        .thenAnswer((_) async => Right(testUser));

    when(mockRepository.getUser(argThat(lessThanOrEqualTo(0))))
        .thenAnswer((_) async => Left(ValidationFailure('Invalid ID')));
  });

  test('captureAny - capturar argumentos', () async {
    when(mockRepository.createUser(any))
        .thenAnswer((_) async => Right(testUser));

    await mockRepository.createUser(testUser);

    // Capturar el argumento pasado
    final captured = verify(mockRepository.createUser(captureAny)).captured;
    expect(captured.single, equals(testUser));
  });
});
```

### Verificaciones

```dart
group('Verification', () {
  test('verify - fue llamado', () async {
    when(mockRepository.getUser(1))
        .thenAnswer((_) async => Right(testUser));

    await usecase(1);

    // Verificar que se llamó exactamente una vez
    verify(mockRepository.getUser(1)).called(1);
  });

  test('verifyNever - nunca fue llamado', () async {
    when(mockRepository.getUser(1))
        .thenAnswer((_) async => Right(testUser));

    await usecase(1);

    // Verificar que deleteUser nunca fue llamado
    verifyNever(mockRepository.deleteUser(any));
  });

  test('verifyNoMoreInteractions - sin más interacciones', () async {
    when(mockRepository.getUser(1))
        .thenAnswer((_) async => Right(testUser));

    await usecase(1);

    verify(mockRepository.getUser(1)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('verifyInOrder - orden específico', () async {
    when(mockRepository.getUser(any))
        .thenAnswer((_) async => Right(testUser));

    await mockRepository.getUser(1);
    await mockRepository.getUser(2);
    await mockRepository.getUser(3);

    verifyInOrder([
      mockRepository.getUser(1),
      mockRepository.getUser(2),
      mockRepository.getUser(3),
    ]);
  });
});
```

---

## 🧪 Testing de Use Cases

### Ejemplo Completo

```dart
/// test/features/user/domain/usecases/get_users_test.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([UserRepository])
import 'get_users_test.mocks.dart';

void main() {
  late GetUsers usecase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = GetUsers(mockRepository);
  });

  group('GetUsers UseCase', () {
    final tUsers = [
      User(id: 1, name: 'User 1', email: 'u1@test.com', createdAt: DateTime(2024)),
      User(id: 2, name: 'User 2', email: 'u2@test.com', createdAt: DateTime(2024)),
    ];

    test(
      'should return list of users when repository succeeds',
      () async {
        // Arrange
        when(mockRepository.getUsers())
            .thenAnswer((_) async => Right(tUsers));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result, Right(tUsers));
        verify(mockRepository.getUsers()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return ServerFailure when repository fails',
      () async {
        // Arrange
        when(mockRepository.getUsers())
            .thenAnswer((_) async => Left(ServerFailure()));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result, Left(ServerFailure()));
        verify(mockRepository.getUsers()).called(1);
      },
    );

    test(
      'should return empty list when no users exist',
      () async {
        // Arrange
        when(mockRepository.getUsers())
            .thenAnswer((_) async => const Right([]));

        // Act
        final result = await usecase(NoParams());

        // Assert
        result.fold(
          (failure) => fail('Should not return failure'),
          (users) => expect(users, isEmpty),
        );
      },
    );
  });
}
```

### Testing de Repository

```dart
/// test/features/user/data/repositories/user_repository_impl_test.dart

@GenerateMocks([
  UserRemoteDataSource,
  UserLocalDataSource,
  NetworkInfo,
])
import 'user_repository_impl_test.mocks.dart';

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getUsers', () {
    final tUserModels = [
      UserModel(id: 1, name: 'User 1', email: 'u1@test.com', createdAt: DateTime(2024)),
    ];

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when call to remote is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.getUsers())
              .thenAnswer((_) async => tUserModels);

          // Act
          final result = await repository.getUsers();

          // Assert
          verify(mockRemoteDataSource.getUsers());
          expect(result, Right(tUserModels));
        },
      );

      test(
        'should cache data locally when call to remote is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.getUsers())
              .thenAnswer((_) async => tUserModels);

          // Act
          await repository.getUsers();

          // Assert
          verify(mockRemoteDataSource.getUsers());
          verify(mockLocalDataSource.cacheUsers(tUserModels));
        },
      );

      test(
        'should return ServerFailure when call to remote fails',
        () async {
          // Arrange
          when(mockRemoteDataSource.getUsers())
              .thenThrow(ServerException('Server error'));

          // Act
          final result = await repository.getUsers();

          // Assert
          verify(mockRemoteDataSource.getUsers());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, Left(ServerFailure('Server error')));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return cached data when cache has data',
        () async {
          // Arrange
          when(mockLocalDataSource.getCachedUsers())
              .thenAnswer((_) async => tUserModels);

          // Act
          final result = await repository.getUsers();

          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedUsers());
          expect(result, Right(tUserModels));
        },
      );

      test(
        'should return CacheFailure when cache is empty',
        () async {
          // Arrange
          when(mockLocalDataSource.getCachedUsers())
              .thenThrow(CacheException('No cache'));

          // Act
          final result = await repository.getUsers();

          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedUsers());
          expect(result, Left(CacheFailure('No hay datos en caché')));
        },
      );
    });
  });
}
```

---

## 🔄 Test-Driven Development

### Ciclo Red-Green-Refactor

```
    ┌─────────────────┐
    │   RED           │
    │ Escribir test   │
    │ que falla       │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │   GREEN         │
    │ Escribir código │
    │ mínimo          │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │   REFACTOR      │
    │ Mejorar código  │
    │ sin romper test │
    └────────┬────────┘
             │
             └──────────► Repetir
```

### Ejemplo TDD

```dart
// ═══════════════════════════════════════════════════════════════
// PASO 1: RED - Escribir el test primero (FALLA)
// ═══════════════════════════════════════════════════════════════

// test/core/utils/email_validator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/core/utils/email_validator.dart';

void main() {
  late EmailValidator validator;

  setUp(() {
    validator = EmailValidator();
  });

  group('EmailValidator', () {
    test('should return true for valid email', () {
      expect(validator.isValid('test@example.com'), isTrue);
    });

    test('should return false for email without @', () {
      expect(validator.isValid('testexample.com'), isFalse);
    });

    test('should return false for email without domain', () {
      expect(validator.isValid('test@'), isFalse);
    });

    test('should return false for empty string', () {
      expect(validator.isValid(''), isFalse);
    });
  });
}

// Ejecutar test: FALLA (clase no existe)

// ═══════════════════════════════════════════════════════════════
// PASO 2: GREEN - Implementar código mínimo (PASA)
// ═══════════════════════════════════════════════════════════════

// lib/core/utils/email_validator.dart
class EmailValidator {
  bool isValid(String email) {
    if (email.isEmpty) return false;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}

// Ejecutar test: PASA ✓

// ═══════════════════════════════════════════════════════════════
// PASO 3: REFACTOR - Mejorar sin romper tests
// ═══════════════════════════════════════════════════════════════

// lib/core/utils/email_validator.dart
class EmailValidator {
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Valida si el email tiene formato correcto.
  ///
  /// Retorna `true` si el email es válido, `false` en caso contrario.
  bool isValid(String email) {
    if (email.isEmpty) return false;
    return _emailRegex.hasMatch(email);
  }

  /// Obtiene el dominio de un email válido.
  ///
  /// Lanza [FormatException] si el email es inválido.
  String getDomain(String email) {
    if (!isValid(email)) {
      throw FormatException('Invalid email format');
    }
    return email.split('@').last;
  }
}

// Ejecutar test: PASA ✓ (y añadimos más tests para getDomain)
```

### Beneficios de TDD

| Beneficio            | Descripción                           |
| -------------------- | ------------------------------------- |
| **Mejor diseño**     | Pensar en la API antes de implementar |
| **Código testeable** | Código escrito para ser testeable     |
| **Documentación**    | Tests como especificación viva        |
| **Confianza**        | Refactoring sin miedo                 |
| **Menos bugs**       | Detectar problemas temprano           |

---

## 📊 Code Coverage

### Generar Reporte

```bash
# Ejecutar tests con coverage
flutter test --coverage

# Generar HTML report (requiere lcov)
genhtml coverage/lcov.info -o coverage/html

# Abrir reporte
open coverage/html/index.html
```

### Configurar VS Code

```json
// .vscode/settings.json
{
  "coverage-gutters.showLineCoverage": true,
  "coverage-gutters.coverageFileNames": ["lcov.info", "coverage/lcov.info"]
}
```

### Interpretar Coverage

```
File                                    | % Lines | % Functions
----------------------------------------|---------|-----------
lib/core/error/failures.dart            |  100.0% |     100.0%
lib/features/user/domain/entities/      |   95.0% |     100.0%
lib/features/user/domain/usecases/      |  100.0% |     100.0%
lib/features/user/data/models/          |   87.5% |      90.0%
lib/features/user/data/repositories/    |   75.0% |      80.0%
----------------------------------------|---------|-----------
Total                                   |   85.0% |      90.0%
```

### Cobertura Recomendada

| Capa                | Coverage Mínimo | Objetivo |
| ------------------- | --------------- | -------- |
| Domain (Use Cases)  | 100%            | 100%     |
| Domain (Entities)   | 90%             | 100%     |
| Data (Repositories) | 80%             | 90%      |
| Data (Models)       | 80%             | 90%      |
| Data (Data Sources) | 70%             | 80%      |
| Presentation (BLoC) | 90%             | 100%     |

---

## ✅ Best Practices

### Naming Conventions

```dart
// ✅ Describe el comportamiento esperado
test('should return user when repository succeeds', () { ... });
test('should throw ValidationException when email is empty', () { ... });
test('should emit [Loading, Loaded] when data is fetched', () { ... });

// ❌ Nombres vagos
test('test user', () { ... });
test('works', () { ... });
```

### Un Assert por Test

```dart
// ✅ Un concepto por test
test('should return user with correct id', () {
  final result = repository.getUser(1);
  expect(result.id, equals(1));
});

test('should return user with correct name', () {
  final result = repository.getUser(1);
  expect(result.name, equals('Test'));
});

// ❌ Múltiples conceptos
test('should return correct user', () {
  final result = repository.getUser(1);
  expect(result.id, equals(1));
  expect(result.name, equals('Test'));
  expect(result.email, equals('test@test.com'));
  expect(result.createdAt, isNotNull);
});
```

### Tests Independientes

```dart
// ✅ Cada test es independiente
setUp(() {
  // Crear nuevas instancias para cada test
  mockRepository = MockUserRepository();
  usecase = GetUser(mockRepository);
});

// ❌ Estado compartido entre tests
late User sharedUser; // No hacer esto
```

---

## 📖 Recursos

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Test Package](https://pub.dev/packages/test)
- [TDD by Example - Kent Beck](https://www.amazon.com/Test-Driven-Development-Kent-Beck/dp/0321146530)

---

> **Duración estimada:** 1.5 horas
