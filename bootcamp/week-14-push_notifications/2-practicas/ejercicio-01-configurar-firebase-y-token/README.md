# Ejercicio 01 — Configurar Firebase y Obtener el Token

> Configura Firebase Cloud Messaging en un proyecto Flutter propio con FlutterFire CLI y obtén
> el FCM token del dispositivo.

## 🎯 Objetivos

- Crear un proyecto de Firebase gratuito y registrar tu app
- Generar `firebase_options.dart` con `flutterfire configure`
- Inicializar Firebase correctamente antes de `runApp()`
- Obtener el FCM token con `FirebaseMessaging.instance.getToken()`

## 📋 Requisitos

- Flutter SDK local configurado, emulador/simulador corriendo
- Cuenta de Google gratuita
- Teoría 01 y 02 de esta semana completadas

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ No podrás correr la app hasta completar el PASO 0 (crear tu proyecto de Firebase) — antes
> de eso, `flutter pub get` funciona, pero `firebase_options.dart` todavía no existe.

---

## Paso 0: crear tu proyecto de Firebase

1. Entra a [console.firebase.google.com](https://console.firebase.google.com/) y crea un
   proyecto nuevo (Google Analytics es opcional)
2. Dentro del proyecto, no hace falta "Agregar app" manualmente — `flutterfire configure` lo
   hace por ti en el paso siguiente

## Paso 1: FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Elige tu proyecto de Firebase recién creado, y selecciona las plataformas que vayas a probar
(Android y/o iOS). Esto genera `lib/firebase_options.dart` — **no lo commitees si vas a subir
tu solución a un repositorio compartido con compañeros** (identifica tu proyecto de Firebase).

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`: los imports de
`firebase_core`/`firebase_messaging`/`firebase_options.dart` y la inicialización dentro de
`main()`.

✅ **Verifica**: `flutter run` no debe lanzar ninguna excepción relacionada con Firebase al
arrancar — si ves `[core/no-app]`, revisa que `Firebase.initializeApp()` tenga `await` y esté
antes de `runApp()`.

---

## Paso 2: obtener el FCM token

El token identifica esta instalación de la app ante FCM — es lo que un backend necesitaría para
enviarte un mensaje directo.

```dart
// Ejemplo explicativo (no el código del ejercicio):
final token = await FirebaseMessaging.instance.getToken();
debugPrint('Token: $token');
```

**Descomenta la sección `PASO 2`** en `starter/lib/main.dart`: el método `_getToken()` y su
conexión con el botón "Obtener token".

✅ **Verifica**: al presionar el botón, el token (una cadena larga) debe aparecer en pantalla.
Cópialo — lo usarás en el Paso 3 para enviarte un mensaje de prueba.

---

## Paso 3: enviar un mensaje de prueba (sin escribir código)

1. Firebase Console → tu proyecto → **Messaging** → "Crear tu primera campaña"
2. "Mensaje de notificación de Firebase" → escribe un título y cuerpo cualquiera
3. En destino, elige "Dispositivo único de prueba" y pega el token del Paso 2
4. Envía — deberías ver la notificación llegar a tu dispositivo/emulador

## ✅ Resultado final

La app inicializa Firebase sin errores, muestra el FCM token del dispositivo en pantalla, y
recibes una notificación de prueba enviada desde Firebase Console.
