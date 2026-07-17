# Integration Tests y Buenas Prácticas

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es un integration test y en qué se diferencia de un widget test
- Cómo estructurar un flujo E2E básico con `integration_test`
- Cómo medir cobertura (`coverage`) y qué significa (y qué no)
- Buenas prácticas transversales para mantener una suite de tests sana

## 📋 Conceptos Clave

### 1. `integration_test` — el nivel más alto de la pirámide

A diferencia de un widget test (que corre en un entorno simulado sin GPU), un integration test
corre la app **completa** en un dispositivo o emulador real, ejecutando el binario real de la
app — el nivel más cercano a lo que experimenta un usuario, y también el más lento.

```dart
// integration_test/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:domain_testing_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login y navegación al detalle de un elemento', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Login con las credenciales fake del curso (dummyjson.com).
    await tester.enterText(find.byKey(const Key('username-field')), 'emilys');
    await tester.enterText(find.byKey(const Key('password-field')), 'emilyspass');
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
  });
}
```

### 2. Correrlo

```bash
flutter test integration_test/app_test.dart -d <device-id>
```

A diferencia de `flutter test` (headless, corre en Docker), un integration test **necesita** un
dispositivo/emulador real — no corre dentro del contenedor de este bootcamp (ver
`docs/docker-setup.md`, semana 1).

### 3. Cobertura (`coverage`) — qué mide y qué no

```bash
docker compose run --rm flutter flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

Cobertura dice **qué líneas se ejecutaron**, no si el test verificó algo significativo. Un test
que llama a una función sin ningún `expect()` puede dar 100% de cobertura sin probar nada —
persigue tests con buenos `expect`, no un número de cobertura alto por sí solo.

### 4. La pirámide, en la práctica de este proyecto

| Nivel | Qué se prueba en el proyecto de este bootcamp | Cantidad esperada |
|---|---|---|
| Unit | Use cases (`GetItems`, `CreateItem`, `Login`) | Muchos, uno por caso relevante |
| Widget | Cubits (`blocTest`) y widgets clave (`ItemCard`, formularios) | Varios |
| Golden | Componentes visuales estables (`LoadingRing`) | Pocos, selectivos |
| Integration | Un flujo crítico completo (login → listar → crear) | Uno o dos |

### 5. Buenas prácticas transversales

- **Un test, un motivo de fallo**: si un test falla por dos razones distintas a la vez, divídelo.
- **`setUp()`/`tearDown()`** para preparar y limpiar estado repetido entre tests del mismo
  `group` — evita copiar el mismo bloque en cada `test()`.
- **Nombres descriptivos**: el nombre del test es lo primero que se lee cuando falla en CI.
- **Nunca mockear lo que se está probando**: si el test mockea el propio use case bajo prueba,
  no está probando nada real.
- **CI ejecuta la suite completa en cada push** — un test que "a veces falla" (flaky) erosiona la
  confianza en todo el pipeline; investigar y arreglar, no ignorar reintentando.

## ⚠️ Errores Comunes

- **Perseguir 100% de cobertura como objetivo en sí mismo**: mejor cobertura útil (rutas de
  error incluidas) que cobertura completa de código trivial (getters, constructores).
- **Un integration test por cada pantalla**: son lentos y frágiles — reservarlos para los 1-3
  flujos más críticos del negocio.
- **Tests que dependen del orden de ejecución**: cada test debe poder correr solo y en cualquier
  orden — estado compartido entre tests es una fuente común de flakiness.

## 📚 Recursos Adicionales

- [integration_test — Flutter docs](https://docs.flutter.dev/testing/integration-tests)
- [Flutter docs — Testing overview (pirámide)](https://docs.flutter.dev/testing/overview)
- [lcov/genhtml — documentación](https://github.com/linux-test-project/lcov)

## ✅ Checklist de Verificación

Antes de pasar a las prácticas, verifica que entiendes:

- [ ] Por qué un integration test no corre en el mismo Docker headless que `flutter test`
- [ ] Qué mide (y qué no mide) la cobertura
- [ ] Por qué hay que reservar los integration tests para pocos flujos críticos
