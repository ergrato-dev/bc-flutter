# Ejercicio 03 — Deep Link al Tocar la Notificación

> Navega a una pantalla específica leyendo el `data` payload del mensaje — cubriendo tanto
> background como terminated.

## 🎯 Objetivos

- Leer `message.data` para decidir a dónde navegar
- Conectar `onMessageOpenedApp` (background → foreground) con `go_router`
- Resolver `getInitialMessage()` (terminated → foreground) antes de montar el router

## 📋 Requisitos

- Flutter SDK local configurado, emulador/simulador corriendo
- Teoría 05 de esta semana completada
- Tu propio proyecto de Firebase (repite `flutterfire configure` para este starter)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutterfire configure
flutter run
```

---

## Paso 1: inicializar Firebase

Igual que en los ejercicios anteriores: corre `flutterfire configure`, luego **abre
`starter/lib/main.dart`** y descomenta la sección `PASO 1`.

## Paso 2: resolver el mensaje inicial (terminated)

Antes de construir el router, hay que preguntar si la app se abrió desde una notificación con
la app completamente cerrada:

```dart
// Ejemplo explicativo (no el código del ejercicio):
final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
final initialLocation = _routeFromMessage(initialMessage) ?? '/';
```

**Descomenta la sección `PASO 2`** en `starter/lib/main.dart`.

## Paso 3: conectar `onMessageOpenedApp` (background)

```dart
// Ejemplo explicativo (no el código del ejercicio):
FirebaseMessaging.onMessageOpenedApp.listen((message) {
  final route = _routeFromMessage(message);
  if (route != null) router.push(route);
});
```

**Descomenta la sección `PASO 3`** en `starter/lib/main.dart`.

✅ **Verifica** (necesitas un backend o la consola no permite adjuntar `data` fácilmente — usa
`curl` con la API HTTP v1 de FCM, o simula tocando el botón "Simular notificación" del
`HomeScreen`, que llama a la misma función `_routeFromMessage` con un `RemoteMessage` de
prueba): tocar la notificación —o el botón de simulación— navega a
`DetailScreen` mostrando el `itemId` leído del `data` payload, tanto si la app estaba en
background como si estaba cerrada (reinicia la app después de simular terminated).

## ✅ Resultado final

La app navega a la pantalla de detalle correcta según el `itemId` del payload, sin importar si
el mensaje llegó con la app en background o completamente cerrada.
