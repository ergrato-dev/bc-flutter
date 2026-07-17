# Glosario — Semana 09: Autenticación Completa

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## A

**AuthRepository**: contrato + implementación con Dio para el login — mismo patrón que
`ItemsRepository` (semana 6), aplicado al endpoint de autenticación.

## F

**Firebase Auth**: servicio gestionado de autenticación de Google — alternativa a JWT propio
donde el SDK persiste la sesión solo, sin necesitar `flutter_secure_storage` manual.

**flutter_secure_storage**: paquete que persiste pares clave-valor usando el almacenamiento
cifrado nativo de cada plataforma (Keychain en iOS, Keystore en Android) — el único lugar
correcto para guardar un token de sesión.

## G

**Guard de rutas**: mecanismo que impide navegar a ciertas rutas según una condición (por
ejemplo, estar autenticado) — implementado en `go_router` con la función `redirect`.

## H

**handler.next() / handler.reject()**: métodos de un `Interceptor` de Dio — `next()` continúa el
request (posiblemente modificado), `reject()` lo cancela antes de enviarlo.

## I

**Interceptor**: clase de Dio que intercepta cada request antes de enviarse (`onRequest`), cada
respuesta al recibirse, o cada error al ocurrir — usada esta semana para agregar el header
`Authorization` a cada request automáticamente.

## J

**JWT (JSON Web Token)**: formato de token de sesión — una cadena firmada que codifica la
identidad del usuario y su validez, sin que el servidor tenga que guardar sesiones en memoria.

## O

**onRequest**: callback de `InterceptorsWrapper` que se ejecuta antes de que Dio envíe cada
request — el lugar correcto para agregar headers comunes a todas las llamadas.

## R

**redirect**: función de `GoRouter` que se evalúa antes de cada navegación — retorna una ruta
nueva para redirigir, o `null` para dejar pasar la navegación original.

**refreshListenable**: `Listenable` opcional de `GoRouter` que, al notificar, hace que el mismo
router vuelva a evaluar `redirect` sin reconstruirse — alternativa a reconstruir el `GoRouter`
completo (la estrategia usada en este proyecto).

## T

**Token de sesión**: cadena que el servidor emite al hacer login y que el cliente reenvía en
cada request (típicamente en el header `Authorization`) para demostrar quién es sin reenviar la
contraseña.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../../docs/plan-estudios.md)
