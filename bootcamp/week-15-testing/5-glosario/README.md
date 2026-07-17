# Glosario — Semana 15: Testing

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

---

**Arrange-Act-Assert (AAA)**
Patrón para estructurar un test en tres bloques: preparar los datos/mocks (arrange), ejecutar
la acción bajo prueba (act), y verificar el resultado (assert) — facilita leer un test como una
historia, no como un bloque de código plano.

**blocTest**
Función de `bloc_test` que reemplaza el patrón manual de suscribirse a un stream y acumular
estados — recibe `build` (crea el Cubit/Bloc), `act` (dispara el evento/método), y `expect`
(la lista de estados esperados, en orden).

**Coverage (cobertura)**
Porcentaje de líneas de código ejecutadas por la suite de tests — `flutter test
--coverage` genera `coverage/lcov.info`, legible con `genhtml` para un reporte visual. No mide
si los tests son buenos, solo si el código se ejecutó.

**Finder**
Objeto que describe qué widget buscar en el árbol durante un widget test — `find.text('...')`,
`find.byType(...)`, `find.byKey(...)`. Se combina con `expect(finder, findsOneWidget)` o
`findsNothing`.

**Golden test**
Test que compara un `render` actual contra una imagen de referencia guardada
(`matchesGoldenFile`) — detecta regresiones visuales (un padding roto, un color incorrecto) que
un widget test normal (que solo verifica texto/tipos) no detecta.

**Integration test**
Test que corre la app completa (o gran parte de ella) en un dispositivo/emulador real, simulando
la interacción de un usuario de punta a punta — el nivel más lento y más caro de la pirámide de
testing, por eso hay pocos.

**mocktail**
Paquete para crear mocks en Dart sin generación de código (`class MockFoo extends Mock
implements Foo {}`) — alternativa a `mockito` que no requiere `build_runner`.

**Mock**
Clase base de `mocktail` — extenderla (`extends Mock`) y declarar `implements` de la interfaz
real produce un doble de prueba cuyo comportamiento se define con `when()`.

**pumpAndSettle()**
Avanza los frames del widget test hasta que no quedan animaciones ni `Future`s pendientes — falla
(nunca termina) si algo anima indefinidamente (ver spinners indeterminados, semana 13-14).

**pumpWidget()**
Monta un widget en el árbol de un widget test — equivalente a `runApp()`, pero dentro del
entorno de test, sin necesitar un dispositivo real.

**registerFallbackValue()**
Función de `mocktail` que registra un valor de reemplazo para un tipo que se usa como argumento
en un `when(...)` con matchers (`any()`) — necesaria cuando el tipo no tiene un constructor
trivial que `mocktail` pueda inferir solo.

**testWidgets()**
Variante de `test()` para widget tests — recibe un `WidgetTester` (`tester`) que permite
`pumpWidget`, `tap`, `enterText`, `pump`, todo dentro de un entorno simulado sin GPU real.

**Testing pyramid (pirámide de testing)**
Modelo que recomienda muchos unit tests (rápidos, baratos), menos widget tests, y pocos
integration tests (lentos, caros) — invertirla (muchos E2E, pocos unit) hace la suite lenta y
frágil.

**verify()**
Función de `mocktail` que confirma que un método del mock fue (o no fue) invocado, cuántas
veces, y con qué argumentos — complementa a `when()`, que define comportamiento; `verify()`
confirma interacción.

**when() / thenAnswer() / thenReturn()**
Trío de `mocktail` para programar el comportamiento de un mock: `when(() =>
mock.metodo()).thenReturn(valor)` para valores síncronos, `.thenAnswer((_) async => valor)` para
`Future`s.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../docs/plan-estudios.md)
