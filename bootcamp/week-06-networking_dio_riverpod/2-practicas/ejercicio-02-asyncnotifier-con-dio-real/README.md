# Ejercicio 02 — AsyncNotifier con Dio Real

> Combinarás Dio (ejercicio 01) con `AsyncNotifier` (semana 5) para cargar datos reales de una
> API, y traducirás `DioException` a un mensaje entendible, descomentando código paso a paso.

## 🎯 Objetivos

- Exponer una instancia de Dio como provider `keepAlive`
- Declarar un `AsyncNotifier` cuyo `build()` hace un GET real
- Capturar `DioException` y lanzar un mensaje de error propio

## 📋 Requisitos

- Ejercicio 01 completado
- Semana 5 completada (`AsyncNotifier`, `.when()`)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

> ⚠️ **Cada vez que descomentes un paso**, vuelve a correr `dart run build_runner build` antes
> de `flutter run`.

---

## Paso 1: dioProvider

```dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'))
    ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` (incluye descomentar
`part 'main.g.dart';` junto a los imports). Regenera con build_runner.

> 💡 `@Riverpod(keepAlive: true)` — a diferencia de `@riverpod` a secas — evita que Riverpod
> destruya la instancia de Dio cuando ninguna pantalla la está observando.

---

## Paso 2: PostsNotifier con GET real

```dart
@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  Future<List<String>> build() async {
    final dio = ref.watch(dioProvider);
    final response = await dio.get('/posts');
    return (response.data as List)
        .map((json) => json['title'] as String)
        .toList();
  }
}
```

**Descomenta la sección `PASO 2`.** Regenera con build_runner.

✅ **Verifica**: la app muestra un spinner y luego una lista de ~100 títulos reales de
`jsonplaceholder.typicode.com/posts`.

---

## Paso 3: Traducir DioException

```dart
Future<List<String>> build() async {
  final dio = ref.watch(dioProvider);
  try {
    final response = await dio.get('/posts');
    return (response.data as List)
        .map((json) => json['title'] as String)
        .toList();
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionError) {
      throw Exception('Sin conexión a internet');
    }
    throw Exception('No se pudo cargar la información');
  }
}
```

**Reemplaza el `build()` del PASO 2 por esta versión** (sección `PASO 3`, comentada más abajo en
el archivo). Regenera con build_runner.

✅ **Verifica**: activa el modo avión y reinicia la app (hot restart) — el mensaje de error debe
ser "Sin conexión a internet", no el texto crudo de `DioException`.

---

## ✅ Resultado final

Un `AsyncNotifier` que carga datos reales vía Dio, maneja los 3 estados con `.when()`, y
traduce errores de red a mensajes entendibles — el mismo patrón que usarás en el proyecto de
esta semana con un repository de por medio.
