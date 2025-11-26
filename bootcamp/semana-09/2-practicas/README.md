# 💻 Prácticas - Semana 9: Arquitectura y Testing

## 📋 Índice de Prácticas

Esta carpeta contiene los ejercicios prácticos de la Semana 9.

## 🗂️ Lista de Prácticas

| # | Práctica | Archivo | Duración | Dificultad |
|---|----------|---------|----------|------------|
| 1 | CleanLayer | [`practica-01-clean-layer.md`](./practica-01-clean-layer.md) | 30 min | ⭐⭐ |
| 2 | UnitTestBasics | [`practica-02-unit-test-basics.md`](./practica-02-unit-test-basics.md) | 25 min | ⭐⭐ |
| 3 | WidgetTestBasics | [`practica-03-widget-test-basics.md`](./practica-03-widget-test-basics.md) | 25 min | ⭐⭐ |
| 4 | MockingServices | [`practica-04-mocking-services.md`](./practica-04-mocking-services.md) | 25 min | ⭐⭐⭐ |
| 5 | IntegrationTests | [`practica-05-integration-tests.md`](./practica-05-integration-tests.md) | 15 min | ⭐⭐⭐ |

## 🎯 Objetivos por Práctica

### Práctica 1: CleanLayer
- Estructurar un proyecto con Clean Architecture
- Crear entidades y modelos separados
- Implementar repositorios e interfaces
- Definir use cases

### Práctica 2: UnitTestBasics
- Escribir tests unitarios básicos
- Aplicar patrón AAA
- Testear funciones puras
- Verificar excepciones

### Práctica 3: WidgetTestBasics
- Usar WidgetTester
- Encontrar widgets con find
- Simular taps y gestos
- Verificar texto y estados

### Práctica 4: MockingServices
- Crear mocks con Mockito
- Stubear respuestas
- Verificar llamadas a métodos
- Testear con dependencias

### Práctica 5: IntegrationTests
- Escribir tests de integración
- Testear flujos completos
- Usar integration_test package
- Automatizar tests E2E

## 📦 Packages Necesarios

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  test: ^1.24.9
  mockito: ^5.4.4
  build_runner: ^2.4.8
  bloc_test: ^9.1.5
  integration_test:
    sdk: flutter
```

## ⏱️ Tiempo Total

| Componente | Duración |
|------------|----------|
| Práctica 1 | 30 min |
| Práctica 2 | 25 min |
| Práctica 3 | 25 min |
| Práctica 4 | 25 min |
| Práctica 5 | 15 min |
| **Total** | **2h** |

## 📊 Progreso

- [ ] Práctica 1: CleanLayer completada
- [ ] Práctica 2: UnitTestBasics completada
- [ ] Práctica 3: WidgetTestBasics completada
- [ ] Práctica 4: MockingServices completada
- [ ] Práctica 5: IntegrationTests completada

## 🔗 Recursos Relacionados

- 📚 [Teoría de la semana](../1-teoria/README.md)
- 🔨 [Proyecto TestableApp](../3-proyecto/README.md)
- 📖 [Glosario técnico](../5-glosario/README.md)

---

## 💡 Tips para las Prácticas

### Testing

```dart
// ✅ Estructura AAA clara
test('should return sum of two numbers', () {
  // Arrange
  final calculator = Calculator();
  
  // Act
  final result = calculator.add(2, 3);
  
  // Assert
  expect(result, equals(5));
});
```

### Clean Architecture

```dart
// ✅ Use Case con Either para manejo de errores
class GetUser implements UseCase<User, int> {
  final UserRepository repository;
  
  GetUser(this.repository);
  
  @override
  Future<Either<Failure, User>> call(int userId) {
    return repository.getUser(userId);
  }
}
```

### Mocking

```dart
// ✅ Mock con Mockito
@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;
  
  setUp(() {
    mockRepository = MockUserRepository();
  });
  
  test('should get user from repository', () async {
    // Arrange
    when(mockRepository.getUser(1))
        .thenAnswer((_) async => Right(testUser));
    
    // Act & Assert
    ...
  });
}
```

---

> **Nota:** Ejecuta `flutter pub run build_runner build` después de crear mocks con `@GenerateMocks`.
