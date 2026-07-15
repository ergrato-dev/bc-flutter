# Glosario — Semana 05: Riverpod

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## A

**AsyncNotifier** (conceptual): un `Notifier` cuyo `build()` retorna `Future<T>`, generando un
provider observado como `AsyncValue<T>`.

**AsyncValue\<T\>**: representa el resultado de una operación asíncrona en 3 estados posibles:
`AsyncLoading`, `AsyncData<T>` o `AsyncError`.

## B

**build_runner**: herramienta que ejecuta generadores de código (como `riverpod_generator`)
sobre el proyecto, produciendo archivos `*.g.dart`.

## C

**ConsumerWidget**: equivalente a `StatelessWidget` con acceso a `ref` en `build()`.

**ConsumerStatefulWidget**: equivalente a `StatefulWidget` con acceso a `ref` como propiedad
de su `State`.

## N

**Notifier**: clase base (generada con `@riverpod`) para estado mutable — equivalente
conceptual a `ChangeNotifier` de Provider (semana 4), sin necesidad de `notifyListeners()`.

## P

**part 'archivo.g.dart'**: directiva que vincula un archivo Dart con su código generado por
`build_runner`.

**ProviderContainer**: equivalente a `ProviderScope` pero para tests — permite leer y mutar
providers sin montar ningún widget.

**ProviderScope**: widget raíz que almacena el estado de todos los providers de la app.

## R

**ref**: objeto que da acceso a los providers, ya sea dentro de un widget (`WidgetRef`) o
dentro de otro provider (`Ref`).

**ref.listen()**: suscribe a cambios de un provider para ejecutar efectos secundarios, sin
disparar un rebuild por sí mismo.

**ref.mounted**: indica si el provider sigue "vivo" — útil para evitar mutar `state` después de
un `await` si el provider ya fue destruido.

**ref.read()**: lee el valor actual de un provider sin suscribirse a cambios futuros — para
callbacks.

**ref.watch()**: lee un provider y suscribe al widget/provider actual a sus cambios — dentro de
`build()`.

**Riverpod**: librería de gestión de estado para Flutter, sucesora de Provider, que no depende
de `BuildContext`.

## W

**.when()**: método de `AsyncValue<T>` que obliga a manejar explícitamente los 3 estados
(`loading`, `error`, `data`).

**WidgetRef**: tipo del parámetro `ref` recibido por `ConsumerWidget.build()`.

---

> 📚 Plan de estudios completo del bootcamp: [docs/plan-estudios.md](../../../docs/plan-estudios.md)
