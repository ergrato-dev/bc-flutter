# Interceptors y Configuración Avanzada

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es un interceptor y en qué punto del ciclo de vida del request actúa
- Cómo usar `LogInterceptor` para depurar requests/responses
- Cómo escribir un interceptor propio
- Por qué la instancia de `Dio` debe ser única en toda la app (y cómo lograrlo con Riverpod)

## 📋 Conceptos Clave

### 1. Qué es un interceptor

Un interceptor es código que se ejecuta automáticamente **antes de enviar** un request,
**al recibir** una respuesta, o **cuando ocurre un error** — sin que cada llamada a `dio.get()`
tenga que repetir esa lógica.

```
request  ──▶ onRequest  ──▶ servidor ──▶ onResponse ──▶ código que llamó a dio.get()
                                              │
                                          onError (si falló)
```

Casos de uso típicos: logging, agregar un header de autenticación a **todos** los requests,
reintentar automáticamente ante ciertos errores, medir tiempos de respuesta.

### 2. LogInterceptor — el interceptor que trae Dio

```dart
final dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'))
  ..interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true),
  );
```

Con esto, cada request/response se imprime en la consola de debug — indispensable mientras
desarrollas, pero **nunca debe llegar a un build de release** (expone URLs, headers y payloads).

> ⚠️ En un proyecto real, envuelve `LogInterceptor` en `if (kDebugMode) { ... }` (de
> `package:flutter/foundation.dart`) para que solo corra en desarrollo.

### 3. Interceptor propio

```dart
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer <token>';
    handler.next(options); // deja continuar el request con los cambios aplicados
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // punto centralizado para, por ejemplo, cerrar sesión si el token expiró
    handler.next(err);
  }
}
```

Cada método (`onRequest`, `onResponse`, `onError`) recibe un `handler` — **siempre debes
llamar `handler.next(...)`** (o `.resolve()`/`.reject()`) para que el flujo continúe; si lo
omites, el request queda colgado indefinidamente.

> 💡 En semana 9 (Autenticación) reescribirás `AuthInterceptor` para inyectar el token real
> desde `flutter_secure_storage` — hoy solo entiendes el mecanismo.

### 4. Una sola instancia de Dio por app

Crear una instancia de `Dio` en cada pantalla o cada método duplica configuración
(`BaseOptions`, interceptors) y desperdicia conexiones. La instancia debe vivir **una sola vez**
y compartirse.

```dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
}
```

- `@Riverpod(keepAlive: true)` (en vez de `@riverpod` a secas) evita que Riverpod destruya la
  instancia cuando nadie la está observando — no tiene sentido recrear el cliente HTTP cada vez
  que cambias de pantalla.
- Cualquier repository que necesite hacer requests hace `ref.watch(dioProvider)` en vez de
  instanciar su propio `Dio()`.

### 5. `keepAlive` — cuándo usarlo

| Provider | `keepAlive` | Por qué |
|---|---|---|
| `dioProvider` | `true` | El cliente HTTP debe vivir toda la sesión de la app |
| `itemsProvider` (AsyncNotifier de datos) | `false` (default) | Puede recrearse — no cuesta caro volver a pedir datos |

Por defecto (sin `keepAlive`), Riverpod usa `autoDispose`: destruye el estado del provider
cuando ningún widget lo está observando — libera memoria automáticamente. `dioProvider` es la
excepción deliberada.

## ✅ Checklist de Verificación

- [ ] Sé explicar qué es un interceptor con mis propias palabras
- [ ] Puedo agregar `LogInterceptor` a una instancia de Dio
- [ ] Entiendo por qué `handler.next()` es obligatorio en un interceptor propio
- [ ] Sé por qué `dioProvider` usa `keepAlive: true`

## 📚 Próximo paso

[Manejo de Errores con DioException →](03-manejo-de-errores-dioexception.md)
