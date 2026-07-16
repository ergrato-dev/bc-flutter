# Ejercicio 03 — Envío con Dio y Riverpod

> Enviarás un formulario real vía POST con Dio, modelando el envío como un `AsyncNotifier<void>`
> con estados loading/éxito/error, descomentando código paso a paso. Es el ejercicio más largo
> de la semana.

## 🎯 Objetivos

- Modelar un envío como `AsyncNotifier<void>` disparado por un método, no por `build()`
- Usar `AsyncValue.guard()` para envolver el POST sin `try`/`catch` manual
- Deshabilitar el formulario durante el envío y mostrar feedback de éxito/error

## 📋 Requisitos

- Ejercicios 01 y 02 completados
- Semana 6 completada (Dio, `DioException`)
- Conexión a internet (usa la API pública `jsonplaceholder.typicode.com`)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

---

## Paso 1: dioProvider + CreateNotifier idle

```dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
}

@riverpod
class CreateNotifier extends _$CreateNotifier {
  @override
  Future<void> build() async {
    // idle — no hace nada hasta que se llama create()
  }
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye descomentar
`part 'main.g.dart';` junto a los imports). Regenera con build_runner.

---

## Paso 2: create() con AsyncValue.guard()

```dart
Future<void> create(String title) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async {
    try {
      await ref.read(dioProvider).post('/posts', data: {'title': title});
    } on DioException catch (e) {
      throw Exception(
        e.type == DioExceptionType.connectionError
            ? 'Sin conexión a internet'
            : 'No se pudo enviar el formulario',
      );
    }
  });
}
```

**Descomenta el método `create()` dentro de `CreateNotifier`** (sección `PASO 2`). Regenera con
build_runner.

> 💡 `AsyncValue.guard()` retorna `AsyncData` (aunque el tipo genérico sea `void`, el `Future`
> completa igual) o `AsyncError` si algo lanza dentro del closure — el `try`/`catch` interno
> solo traduce `DioException` a un mensaje propio, mismo patrón del repository de semana 6.

---

## Paso 3: UI reactiva al estado del envío

```dart
final submitState = ref.watch(createNotifierProvider);
final isLoading = submitState.isLoading;

ref.listen(createNotifierProvider, (previous, next) {
  if (next.hasError && !next.isLoading) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${next.error}')));
  }
  if (previous?.isLoading == true && !next.isLoading && !next.hasError) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enviado con éxito')),
    );
    _formKey.currentState?.reset();
  }
});
```

**Descomenta la sección `PASO 3`** — agrega estas líneas al inicio de `build()` en
`_HomeScreenState`, y usa `isLoading` para deshabilitar el campo (`enabled: !isLoading`) y el
botón (`onPressed: isLoading ? null : ...`, mostrando un `CircularProgressIndicator` mientras
`isLoading` es `true`).

✅ **Verifica**: al enviar, el campo y el botón se deshabilitan brevemente, luego aparece
"Enviado con éxito" y el campo se limpia. Prueba en modo avión — debe aparecer el mensaje de
error traducido, no el texto crudo de `DioException`.

---

## ✅ Resultado final

Un formulario que envía datos reales con Dio, modelado como una acción de Riverpod con
loading/éxito/error — exactamente el patrón que usarás en el proyecto de esta semana para crear
un elemento de tu dominio.
