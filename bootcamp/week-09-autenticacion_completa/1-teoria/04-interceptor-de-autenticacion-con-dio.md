# Interceptor de Autenticación con Dio

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo agregar el token a cada request con un `Interceptor` de Dio
- Por qué el interceptor lee el token en cada request, no una sola vez
- Qué hace un interceptor de `onError` ante un `401` (mención, no implementación esta semana)

## 📋 Conceptos Clave

### 1. InterceptorsWrapper.onRequest

Ya conoces `LogInterceptor` desde semana 6. `InterceptorsWrapper` te deja escribir el tuyo:

```dart
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await ref.read(secureStorageProvider).read(key: 'auth_token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options); // continúa el request con los headers ya modificados
    },
  ),
);
```

`onRequest` se ejecuta **antes** de que Dio envíe cada request — es el lugar correcto para
agregar un header común a todas las llamadas, en vez de repetirlo a mano en cada método del
repository.

### 2. Por qué lee el token en cada request, no una sola vez

```dart
// ❌ MAL — el token queda "congelado" en el momento en que se creó el Dio
final token = await ref.read(secureStorageProvider).read(key: 'auth_token');
dio.options.headers['Authorization'] = 'Bearer $token';

// ✅ BIEN — el interceptor lee el token fresco en cada request
onRequest: (options, handler) async {
  final token = await ref.read(secureStorageProvider).read(key: 'auth_token');
  if (token != null) options.headers['Authorization'] = 'Bearer $token';
  handler.next(options);
},
```

`dioProvider` es `keepAlive: true` (semana 6) — se crea una sola vez y vive durante toda la app.
Si el token se leyera solo al crear el Dio, un login posterior (o un logout) nunca se reflejaría
en los requests siguientes. El interceptor resuelve esto: se ejecuta en **cada** request, así que
siempre lee el valor actual.

### 3. `handler.next()` vs `handler.reject()`

- `handler.next(options)` — continúa el request con los `options` (posiblemente modificados).
- `handler.reject(error)` — cancela el request antes de que salga, retornando un error
  directamente (útil para rechazar un request si, por ejemplo, no hay token y el endpoint lo
  requiere obligatoriamente).

Este proyecto siempre usa `handler.next()` — el request continúa con o sin token, porque
`jsonplaceholder` (la API de tus datos de dominio) no rechaza requests sin `Authorization`. En un
backend propio que sí lo exija, `handler.reject()` te permite cortar el request localmente en vez
de esperar el `401` del servidor.

### 4. Mención: onError y logout automático en 401

Un patrón común en apps de producción es agregar también un interceptor de `onError` que, ante
una respuesta `401` (token expirado o inválido), dispare un logout automático y redirija a login.
Esta semana no lo implementa — la app basada en `jsonplaceholder` nunca devuelve `401` real,
así que no hay forma de probarlo con la API de práctica — pero ahora sabes dónde iría: otro
`InterceptorsWrapper` con `onError: (error, handler) { if (error.response?.statusCode == 401) {
...disparar logout... } handler.next(error); }`.

## ✅ Checklist de Verificación

- [ ] Sé agregar un header a cada request con `InterceptorsWrapper.onRequest`
- [ ] Sé por qué el token se lee dentro del interceptor y no al crear el Dio
- [ ] Sé la diferencia entre `handler.next()` y `handler.reject()`
- [ ] Sé dónde iría un interceptor de `onError` para logout automático en 401

## 📚 Próximo paso

[Guards de Rutas con go_router →](05-guards-de-rutas-con-go-router.md)
