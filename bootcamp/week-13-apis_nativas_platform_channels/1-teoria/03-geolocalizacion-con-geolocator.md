# Geolocalización con geolocator

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué `geolocator` maneja sus propios permisos, sin pasar por `permission_handler`
- Cómo obtener la posición actual del dispositivo y qué precisión elegir
- Cómo verificar que el servicio de ubicación del dispositivo esté activo (más allá del permiso)

## 📋 Conceptos Clave

### 1. geolocator tiene su propia API de permisos

A diferencia de la cámara (teoría 01-02), `geolocator` **no** usa `permission_handler` para su
propio permiso — expone sus métodos equivalentes:

```dart
Future<bool> ensureLocationPermission() async {
  var permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    // Igual que permanentlyDenied en permission_handler — no vuelvas a
    // pedirlo, dirige al usuario a Ajustes.
    return false;
  }

  return permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;
}
```

El enum es distinto (`LocationPermission` en vez de `PermissionStatus`), pero el patrón
check → request → actuar es **el mismo** que en teoría 01 — reconocer el patrón general te permite
transferirlo a cualquier plugin nuevo que uses, no solo a los dos de esta semana.

### 2. El servicio de ubicación es una capa aparte del permiso

Un usuario puede haber concedido el permiso de ubicación a tu app y, aun así, tener el GPS del
dispositivo completamente apagado. `geolocator` te permite verificar esto por separado:

```dart
final serviceEnabled = await Geolocator.isLocationServiceEnabled();
if (!serviceEnabled) {
  // El permiso puede estar concedido, pero sin GPS/ubicación activa en el
  // dispositivo, ninguna posición va a resolver — pide al usuario que lo
  // active desde los ajustes rápidos del sistema.
  return null;
}
```

Ignorar esta verificación es una fuente común de bugs "funciona en mi dispositivo" — tu emulador
casi siempre tiene una ubicación simulada activa, pero un dispositivo real con GPS apagado se
queda esperando indefinidamente sin este chequeo.

### 3. Obtener la posición actual

```dart
final position = await Geolocator.getCurrentPosition(
  locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
);

debugPrint('lat: ${position.latitude}, lng: ${position.longitude}');
```

`LocationAccuracy` va de `lowest` a `best` — mayor precisión implica más tiempo de respuesta y más
consumo de batería. Para la mayoría de casos de una app de dominio (mostrar la sucursal más
cercana, por ejemplo), `medium` es suficiente; reserva `best`/`bestForNavigation` para navegación
turn-by-turn real.

### 4. Streams de posición (mención, no requerido esta semana)

`Geolocator.getPositionStream()` retorna un `Stream<Position>` que emite cada vez que el
dispositivo se mueve más allá de un umbral configurable — útil para un mapa que sigue al usuario
en tiempo real. Esta semana trabajas con `getCurrentPosition()` (una sola lectura); el stream
completo se retoma si tu dominio lo necesita en un proyecto posterior.

## ✅ Checklist de Verificación

- [ ] Sé que `geolocator` usa su propia API de permisos (`LocationPermission`), no
      `permission_handler`
- [ ] Sé verificar `isLocationServiceEnabled()` además del permiso
- [ ] Sé obtener la posición actual con `getCurrentPosition()` y elegir una `LocationAccuracy`
      razonable
- [ ] Reconozco el patrón check → request → actuar como el mismo de teoría 01, aplicado a un
      plugin distinto

## 📚 Próximo paso

[Platform Channels: MethodChannel →](04-platform-channels-methodchannel.md)
