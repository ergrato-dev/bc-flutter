# Configuración de Firebase Cloud Messaging

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo crear un proyecto de Firebase y registrar tu app Android/iOS en él
- Qué hace `flutterfire configure` y por qué reemplaza la configuración manual
- Cómo inicializar Firebase en `main()` antes de `runApp()`
- Por qué los archivos de configuración nativos nunca se commitean

## 📋 Conceptos Clave

### 1. Crear un proyecto en Firebase Console

Firebase Cloud Messaging (FCM) es el servicio de Google para enviar notificaciones push. Todo
empieza creando un proyecto gratuito en
[console.firebase.google.com](https://console.firebase.google.com/):

1. "Agregar proyecto" → nombre del proyecto (puede ser distinto al de tu app)
2. Google Analytics es opcional — no lo necesitas para FCM
3. Dentro del proyecto, "Agregar app" → elige Android o iOS según lo que vayas a probar

> 💡 **Diferencia con otros frameworks**: a diferencia de un backend propio con WebSockets o
> polling, FCM mantiene la conexión persistente con cada dispositivo por ti — Google gestiona
> la infraestructura, tu backend (o la consola) solo envía el mensaje a un token o topic.

### 2. FlutterFire CLI — la forma correcta de configurar

Configurar Firebase a mano (copiar `google-services.json`, editar `build.gradle`, etc.) es
propenso a errores. El equipo de Firebase mantiene una CLI que lo automatiza:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

`flutterfire configure` pregunta a qué proyecto de Firebase conectar, qué plataformas
(Android/iOS) registrar, y genera automáticamente:

- `lib/firebase_options.dart` — configuración específica de cada plataforma, en Dart
- `android/app/google-services.json` — configuración nativa Android
- `ios/Runner/GoogleService-Info.plist` — configuración nativa iOS

### 3. Inicializar Firebase en `main()`

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized() es obligatorio antes de
  // cualquier llamada async previa a runApp() — sin esto, Firebase.initializeApp()
  // lanza una excepción porque el binding con la plataforma nativa aún no existe.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}
```

`DefaultFirebaseOptions.currentPlatform` viene del archivo generado por `flutterfire configure`
— selecciona automáticamente la configuración de Android o iOS según dónde corra la app.

### 4. Casos de Uso Móvil

Apps como Instagram o Uber usan FCM para notificar mensajes nuevos, cambios de estado de un
pedido o promociones — siempre con el mismo patrón: backend propio → Firebase Admin SDK → FCM →
dispositivo. La app cliente nunca envía notificaciones directamente a otro dispositivo.

## ⚠️ Errores Comunes

- **Olvidar `WidgetsFlutterBinding.ensureInitialized()`**: sin esto, `Firebase.initializeApp()`
  falla con `Null check operator used on a null value` o una excepción de plataforma — Flutter
  necesita el binding activo para hablar con el código nativo antes de que `runApp()` lo haga
  implícitamente.
- **Commitear `google-services.json`/`GoogleService-Info.plist` reales**: estos archivos
  identifican tu proyecto de Firebase. Este bootcamp los mantiene en `.gitignore` — cada
  estudiante corre `flutterfire configure` con su propio proyecto gratuito.
- **No esperar (`await`) `Firebase.initializeApp()`**: si se llama sin `await`, `runApp()` puede
  ejecutarse antes de que Firebase esté listo, y cualquier llamada a `FirebaseMessaging` falla.

## 📚 Recursos Adicionales

- [FlutterFire — Overview](https://firebase.google.com/docs/flutter/setup)
- [Firebase Console](https://console.firebase.google.com/)
- [firebase_core — pub.dev](https://pub.dev/packages/firebase_core)

## ✅ Checklist de Verificación

Antes de continuar a las prácticas, verifica que entiendes:

- [ ] Para qué sirve `flutterfire configure` y qué archivos genera
- [ ] Por qué `WidgetsFlutterBinding.ensureInitialized()` va antes de `Firebase.initializeApp()`
- [ ] Por qué los archivos de configuración nativos no se commitean
