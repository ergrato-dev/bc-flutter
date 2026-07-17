# Ejercicio 03 — Platform Channel: Nivel de Batería

> Invocarás código nativo Android (Kotlin, ya escrito) desde Dart con un `MethodChannel` para leer
> el nivel de batería real del dispositivo, descomentando el lado Dart paso a paso.

## 🎯 Objetivos

- Invocar un método nativo con `MethodChannel.invokeMethod`
- Manejar `PlatformException` y `MissingPluginException` en el lado Dart
- Leer y entender el lado nativo (Kotlin) — sin necesitar escribirlo desde cero

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador **Android** corriendo (este ejercicio
  solo tiene implementación nativa Android — ver nota de iOS abajo)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ℹ️ A diferencia de los ejercicios 01 y 02, este starter **sí incluye** las carpetas `android/`
> e `ios/` completas (generadas con `flutter create`) — es indispensable para tener un
> `MainActivity.kt` real donde registrar el `MethodChannel`. Los ejercicios 01 y 02 no las
> necesitan porque `permission_handler`/`geolocator` ya traen su propia implementación nativa.

## 🐳 Validar con Docker

```bash
docker run --rm -v "$(pwd)/starter:/app" -w /app ghcr.io/cirruslabs/flutter:stable flutter analyze
docker run --rm -v "$(pwd)/starter:/app" -w /app ghcr.io/cirruslabs/flutter:stable flutter build apk --debug
```

> `flutter build apk --debug` compila también el lado Kotlin (`MainActivity.kt`) — es la forma de
> verificar que el platform channel nativo compila sin errores, sin necesitar un dispositivo.

---

## Paso 1: declarar el MethodChannel

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — agrega la constante
`_batteryChannel` fuera de cualquier clase, con el mismo nombre de canal que ya usa
`MainActivity.kt`.

---

## Paso 2: invocar el método nativo

**Descomenta la sección `PASO 2`** — agrega `_getBatteryLevel()` y conéctalo al botón "Obtener
nivel de batería".

✅ **Verifica en un emulador/dispositivo Android real** (no en Chrome/desktop — este platform
channel no tiene implementación en esas plataformas): al presionar el botón, el texto muestra el
porcentaje real de batería del emulador/dispositivo.

---

## 📱 Sobre el lado nativo (MainActivity.kt)

`android/app/src/main/kotlin/.../MainActivity.kt` ya está completo — **no necesitas escribir
Kotlin** para este ejercicio. Léelo de todas formas: es exactamente el patrón de la teoría 04
(`setMethodCallHandler`, `result.success`/`result.error`). El equivalente en Swift
(`ios/Runner/AppDelegate.swift`) también está escrito como referencia, pero **no se puede
verificar en este bootcamp** (requiere host macOS con Xcode — ver `docs/docker-setup.md`).

## ✅ Resultado final

Un platform channel funcional de punta a punta — Dart invoca, Kotlin responde con datos reales
del dispositivo — la pieza que completa el panorama de esta semana: cuando ningún plugin de
pub.dev cubre lo que necesitas, esto es lo que hay debajo.
