# Glosario — Semana 06: Networking con Dio y Riverpod

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## A

**API REST**: interfaz que expone recursos remotos sobre HTTP, siguiendo convenciones de
verbos (GET/POST/PUT/DELETE) y status codes.

## B

**BaseOptions**: configuración centralizada de una instancia de Dio — `baseUrl`, timeouts,
headers por defecto.

## D

**Dio**: cliente HTTP para Dart/Flutter con soporte nativo de interceptors, timeouts, cancel
tokens y `FormData`.

**DioException**: excepción que Dio lanza ante cualquier falla de red — trae un campo `.type`
(`DioExceptionType`) que clasifica la causa.

**DioExceptionType**: enum que clasifica una `DioException` — `connectionTimeout`,
`receiveTimeout`, `badResponse`, `connectionError`, `cancel`, `unknown`.

## F

**fromJson**: constructor factory que convierte un `Map<String, dynamic>` (JSON decodificado)
en una instancia del modelo de dominio.

## I

**Interceptor**: clase que intercepta un request antes de enviarse, una respuesta al recibirse,
o un error al ocurrir — sin repetir esa lógica en cada llamada.

## K

**keepAlive**: modificador de un provider (`@Riverpod(keepAlive: true)`) que evita que Riverpod
lo destruya cuando nadie lo está observando — usado en `dioProvider` para no recrear el cliente
HTTP en cada navegación.

## L

**LogInterceptor**: interceptor incluido en Dio que imprime cada request/response en consola —
solo debe activarse en modo debug.

## R

**ref.invalidate()**: marca un provider como obsoleto, forzando que Riverpod vuelva a ejecutar
su `build()` — usado para reintentar una carga fallida.

**ref.refresh()**: igual que `ref.invalidate()`, pero retorna el nuevo valor — usado en
pull-to-refresh, donde `RefreshIndicator` necesita un `Future` que resolver.

**Repository**: clase cuya única responsabilidad es obtener datos (de una API, una base local,
etc.) — no conoce Riverpod ni `AsyncValue`. Se expone a través de una interfaz abstracta.

**Response\<T\>**: objeto que retorna Dio tras un request exitoso — incluye `data`,
`statusCode`, `statusMessage` y `headers`.

## T

**Timeout**: tiempo máximo de espera configurado en `BaseOptions` (`connectTimeout`,
`receiveTimeout`) antes de que Dio lance una `DioException`.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../../docs/plan-estudios.md)
