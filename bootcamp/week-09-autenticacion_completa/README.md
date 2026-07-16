# Semana 09 — Autenticación Completa

> **Fase 2 — Estado y Datos** | Semana 9 de 19 | ⏱️ 16 horas

Esta semana agrega autenticación al proyecto de semana 8 — el usuario inicia sesión con JWT
contra una API real, el token se guarda cifrado con `flutter_secure_storage`, y toda la app
queda protegida por un guard de rutas reactivo.

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Explicar qué es un token de sesión (JWT) y cuándo preferir JWT propio sobre Firebase Auth
- [ ] Hacer login vía `POST` y modelarlo con un `AuthRepository` (mismo patrón que semana 6)
- [ ] Guardar y leer un token de forma segura con `flutter_secure_storage`
- [ ] Agregar el token a cada request con un `Interceptor` de Dio
- [ ] Convertir `appRouter` de constante a provider de Riverpod, reactivo al estado de auth
- [ ] Limpiar todo lo persistido (token + cache de semana 8) al cerrar sesión

## 📚 Requisitos previos

- Semana 8 (Persistencia Local) completada — `SharedPreferences`, Hive, `overrideWithValue()`
- Flutter SDK local configurado (`flutter doctor` sin errores) + emulador/simulador corriendo
- Docker (para `flutter analyze`/`flutter test` reproducibles)
- Conexión a internet (usa la API pública `dummyjson.com` para login)

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Introducción a Autenticación Móvil](1-teoria/01-introduccion-a-autenticacion-movil.md)
2. [Login y Registro con JWT](1-teoria/02-login-y-registro-con-jwt.md)
3. [flutter_secure_storage — Persistencia Segura de Tokens](1-teoria/03-flutter-secure-storage-tokens.md)
4. [Interceptor de Autenticación con Dio](1-teoria/04-interceptor-de-autenticacion-con-dio.md)
5. [Guards de Rutas con go_router](1-teoria/05-guards-de-rutas-con-go-router.md)
6. [Firebase Auth como Alternativa y Buenas Prácticas](1-teoria/06-firebase-auth-como-alternativa-y-buenas-practicas.md)

### Prácticas

1. [Ejercicio 01 — Login con JWT](2-practicas/ejercicio-01-login-con-jwt/README.md)
2. [Ejercicio 02 — flutter_secure_storage](2-practicas/ejercicio-02-flutter-secure-storage/README.md)
3. [Ejercicio 03 — Interceptor y Guard de Rutas](2-practicas/ejercicio-03-interceptor-y-guard-de-rutas/README.md)

### Proyecto

[Autenticación Completa](3-proyecto/README.md) — agrega login con JWT, token cifrado y guard de
rutas al proyecto de tu dominio, sobre el proyecto de semana 8.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado, con login/logout funcionando
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 08 — Persistencia Local](../week-08-persistencia_local/README.md) | [Semana 10 — Clean Architecture y Bloc →](../week-10-clean_architecture_y_bloc/README.md)
