# Proyecto Semana 09 — Autenticación Completa

## 🎯 Objetivo

Agregar login/logout al proyecto de semana 8: autenticación con JWT contra una API real, token
guardado de forma segura, y toda la app protegida por un guard de rutas.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🌐 API utilizada

El login usa `https://dummyjson.com` (independiente de `jsonplaceholder.typicode.com`, usada
para tus datos de dominio) — usuario de prueba `emilys`, contraseña `emilyspass`. Ver teoría 02.

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
dart run build_runner build
flutter run
```

> ⚠️ **Cada vez que modifiques un provider** (`@riverpod`), vuelve a correr
> `dart run build_runner build` antes de `flutter run`.

## 🐳 Validar con Docker

```bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

## 🛠️ Qué debes completar

1. `lib/providers/auth_provider.dart` — dentro de `login()`, persiste el token en
   `flutter_secure_storage`; dentro de `logout()`, borra el token y limpia el cache de semana 8
   (favoritos e items) — ver teoría 03 y 06.
2. `lib/providers/dio_provider.dart` — dentro del interceptor, lee el token guardado y agrégalo
   como header `Authorization` a cada request — ver teoría 04.

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Login/logout funcionando, con el guard de rutas redirigiendo automáticamente
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../../rubrica-evaluacion.md)
