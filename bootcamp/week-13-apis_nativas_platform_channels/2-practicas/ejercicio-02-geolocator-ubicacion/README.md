# Ejercicio 02 — geolocator: Ubicación Actual

> Obtendrás la posición actual del dispositivo con `geolocator`, manejando su propia API de
> permisos (distinta a `permission_handler`) y verificando que el servicio de ubicación esté
> activo, descomentando código paso a paso.

## 🎯 Objetivos

- Verificar y solicitar permiso de ubicación con `Geolocator.checkPermission`/`requestPermission`
- Verificar que el servicio de ubicación del dispositivo esté activo
- Obtener la posición actual con `getCurrentPosition` y mostrar latitud/longitud

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo (el emulador simula una
  ubicación por defecto — no necesitas GPS real para este ejercicio)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ Igual que el ejercicio 01, este permiso debe estar declarado en tu proyecto real:
> `ACCESS_FINE_LOCATION` en `AndroidManifest.xml`, `NSLocationWhenInUseUsageDescription` en
> `Info.plist` — ver teoría 03.

---

## Paso 1: permiso de ubicación (API propia de geolocator)

```dart
Future<bool> _ensurePermission() async {
  var permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  return permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

---

## Paso 2: verificar que el servicio de ubicación esté activo

```dart
Future<bool> _ensureServiceEnabled() async {
  final enabled = await Geolocator.isLocationServiceEnabled();
  if (!enabled) {
    setState(() => _status = 'Activa la ubicación del dispositivo');
  }
  return enabled;
}
```

**Descomenta la sección `PASO 2`**.

---

## Paso 3: obtener la posición actual

```dart
Future<void> _getLocation() async {
  if (!await _ensurePermission()) {
    setState(() => _status = 'Permiso de ubicación denegado');
    return;
  }
  if (!await _ensureServiceEnabled()) return;

  final position = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
  );
  setState(() => _status = 'lat: ${position.latitude}, lng: ${position.longitude}');
}
```

**Descomenta la sección `PASO 3`** y conéctalo al botón "Obtener ubicación".

✅ **Verifica**: presiona el botón — la primera vez, aparece el diálogo nativo de permiso de
ubicación; al concederlo, el texto muestra la latitud/longitud simulada del emulador.

---

## ✅ Resultado final

El mismo patrón check → request → actuar del ejercicio 01, aplicado a la API propia de
`geolocator` — reconocer que es el mismo patrón, con un enum distinto, es la lección central de
esta semana.
