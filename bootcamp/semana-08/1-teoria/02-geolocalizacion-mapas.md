# 📍 Geolocalización y Mapas en Flutter

## 🎯 Objetivos del Módulo

Al completar este módulo, serás capaz de:

- [ ] Obtener la ubicación actual del usuario
- [ ] Rastrear la posición en tiempo real
- [ ] Integrar Google Maps en tu aplicación
- [ ] Agregar marcadores, polilíneas y polígonos
- [ ] Implementar geocoding y reverse geocoding
- [ ] Calcular distancias entre puntos
- [ ] Configurar permisos de ubicación correctamente

---

## 📦 Paquetes Principales

```yaml
dependencies:
  # Obtener ubicación
  geolocator: ^10.1.0

  # Geocoding (dirección ↔ coordenadas)
  geocoding: ^2.1.1

  # Google Maps
  google_maps_flutter: ^2.5.0

  # Permisos
  permission_handler: ^11.1.0
```

---

## 1️⃣ Configuración de Permisos

### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Permisos de ubicación -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

    <!-- Ubicación en segundo plano (opcional) -->
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>

    <!-- Para Android 12+ -->
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>

    <application
        android:label="@string/app_name"
        ...>

        <!-- API Key de Google Maps -->
        <meta-data
            android:name="com.google.android.geo.API_KEY"
            android:value="TU_API_KEY_AQUI"/>

    </application>
</manifest>
```

### iOS (`ios/Runner/Info.plist`)

```xml
<dict>
    <!-- Ubicación en uso -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>Esta app necesita tu ubicación para mostrarte lugares cercanos</string>

    <!-- Ubicación siempre (si es necesario) -->
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>Esta app necesita tu ubicación para enviarte notificaciones de lugares cercanos</string>

    <!-- Ubicación siempre (legacy) -->
    <key>NSLocationAlwaysUsageDescription</key>
    <string>Esta app necesita tu ubicación en segundo plano</string>
</dict>
```

### iOS (`ios/Runner/AppDelegate.swift`)

```swift
import UIKit
import Flutter
import GoogleMaps // Agregar import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("TU_API_KEY_AQUI") // Agregar esta línea
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

## 2️⃣ Geolocator: Obtener Ubicación

### Servicio de Ubicación

```dart
/**
 * LocationService
 *
 * ¿Qué hace?
 * Servicio centralizado para obtener y rastrear la ubicación del usuario.
 *
 * ¿Para qué?
 * Encapsular toda la lógica de geolocalización en un solo lugar,
 * facilitando el manejo de permisos, errores y streaming de posición.
 *
 * ¿Cómo funciona?
 * 1. Verifica permisos y servicios de ubicación
 * 2. Obtiene la posición actual o inicia streaming
 * 3. Maneja errores y estados de carga
 */

import 'dart:async';
import 'package:geolocator/geolocator.dart';

/// Resultado de verificación de servicios de ubicación
enum LocationServiceStatus {
  enabled,
  disabled,
  permissionDenied,
  permissionDeniedForever,
}

class LocationService {
  // Configuración de precisión por defecto
  static const LocationSettings _defaultSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10, // Metros mínimos para notificar cambio
  );

  /// Verifica si los servicios de ubicación están habilitados
  /// y si tenemos los permisos necesarios.
  Future<LocationServiceStatus> checkLocationServices() async {
    // 1. Verificar si el servicio de ubicación está habilitado
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationServiceStatus.disabled;
    }

    // 2. Verificar permisos
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Solicitar permiso
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return LocationServiceStatus.permissionDenied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationServiceStatus.permissionDeniedForever;
    }

    return LocationServiceStatus.enabled;
  }

  /// Obtiene la posición actual del usuario
  ///
  /// [accuracy] - Precisión deseada (default: high)
  /// [timeout] - Tiempo máximo de espera
  ///
  /// Retorna la posición o lanza excepción si falla
  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    // Verificar servicios primero
    final status = await checkLocationServices();

    switch (status) {
      case LocationServiceStatus.disabled:
        throw LocationServiceException('Servicios de ubicación deshabilitados');
      case LocationServiceStatus.permissionDenied:
        throw LocationServiceException('Permiso de ubicación denegado');
      case LocationServiceStatus.permissionDeniedForever:
        throw LocationServiceException(
          'Permiso denegado permanentemente. Habilítalo en configuración.',
        );
      case LocationServiceStatus.enabled:
        break;
    }

    // Obtener posición
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: accuracy,
      timeLimit: timeout,
    );
  }

  /// Obtiene la última posición conocida (más rápido, menos preciso)
  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  /// Stream de posiciones para rastreo en tiempo real
  ///
  /// [accuracy] - Precisión deseada
  /// [distanceFilter] - Distancia mínima en metros para emitir nuevo evento
  /// [intervalDuration] - Intervalo mínimo entre actualizaciones (Android)
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10,
    Duration? intervalDuration,
  }) {
    late LocationSettings settings;

    if (intervalDuration != null) {
      // Android específico con intervalo
      settings = AndroidSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
        intervalDuration: intervalDuration,
        forceLocationManager: false,
      );
    } else {
      settings = LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      );
    }

    return Geolocator.getPositionStream(locationSettings: settings);
  }

  /// Calcula la distancia entre dos puntos en metros
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Calcula el bearing (dirección) entre dos puntos
  double calculateBearing({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Abre la configuración de ubicación del dispositivo
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  /// Abre la configuración de la app
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }
}

/// Excepción personalizada para errores de ubicación
class LocationServiceException implements Exception {
  final String message;
  LocationServiceException(this.message);

  @override
  String toString() => message;
}
```

---

### Widget de Ubicación Actual

```dart
/**
 * CurrentLocationWidget
 *
 * Widget que muestra la ubicación actual del usuario
 * con manejo de estados de carga, error y permisos.
 */

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationWidget extends StatefulWidget {
  final Function(Position)? onLocationObtained;

  const CurrentLocationWidget({
    Key? key,
    this.onLocationObtained,
  }) : super(key: key);

  @override
  State<CurrentLocationWidget> createState() => _CurrentLocationWidgetState();
}

class _CurrentLocationWidgetState extends State<CurrentLocationWidget> {
  final LocationService _locationService = LocationService();

  Position? _currentPosition;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final position = await _locationService.getCurrentPosition();

      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });

      widget.onLocationObtained?.call(position);
    } on LocationServiceException catch (e) {
      setState(() {
        _error = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error desconocido: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Tu ubicación',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (!_isLoading)
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _getLocation,
                    tooltip: 'Actualizar ubicación',
                  ),
              ],
            ),

            const Divider(),

            // Contenido
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Obteniendo ubicación...'),
                    ],
                  ),
                ),
              )
            else if (_error != null)
              _buildErrorWidget()
            else if (_currentPosition != null)
              _buildLocationInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Column(
      children: [
        Icon(
          Icons.location_off,
          size: 48,
          color: Colors.red[400],
        ),
        const SizedBox(height: 8),
        Text(
          _error!,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red[700]),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _getLocation,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => _locationService.openLocationSettings(),
              icon: const Icon(Icons.settings),
              label: const Text('Configuración'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationInfo() {
    final position = _currentPosition!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          'Latitud',
          position.latitude.toStringAsFixed(6),
          Icons.north,
        ),
        _buildInfoRow(
          'Longitud',
          position.longitude.toStringAsFixed(6),
          Icons.east,
        ),
        _buildInfoRow(
          'Altitud',
          '${position.altitude.toStringAsFixed(1)} m',
          Icons.height,
        ),
        _buildInfoRow(
          'Precisión',
          '±${position.accuracy.toStringAsFixed(0)} m',
          Icons.gps_fixed,
        ),
        _buildInfoRow(
          'Velocidad',
          '${(position.speed * 3.6).toStringAsFixed(1)} km/h',
          Icons.speed,
        ),
        const SizedBox(height: 8),
        Text(
          'Actualizado: ${_formatTimestamp(position.timestamp)}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(value),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}';
  }
}
```

---

## 3️⃣ Geocoding: Direcciones y Coordenadas

```dart
/**
 * GeocodingService
 *
 * Servicio para convertir entre direcciones y coordenadas.
 *
 * Geocoding: Dirección → Coordenadas
 * Reverse Geocoding: Coordenadas → Dirección
 */

import 'package:geocoding/geocoding.dart';

class GeocodingService {

  /// Convierte una dirección en coordenadas (Geocoding)
  ///
  /// [address] - Dirección a buscar (ej: "Calle Principal 123, Ciudad")
  ///
  /// Retorna lista de posibles ubicaciones
  Future<List<Location>> getCoordinatesFromAddress(String address) async {
    try {
      final locations = await locationFromAddress(address);
      return locations;
    } catch (e) {
      print('Error en geocoding: $e');
      return [];
    }
  }

  /// Convierte coordenadas en una dirección (Reverse Geocoding)
  ///
  /// [latitude] - Latitud
  /// [longitude] - Longitud
  ///
  /// Retorna lista de posibles direcciones
  Future<List<Placemark>> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      return placemarks;
    } catch (e) {
      print('Error en reverse geocoding: $e');
      return [];
    }
  }

  /// Obtiene la primera dirección formateada
  Future<String?> getFormattedAddress({
    required double latitude,
    required double longitude,
  }) async {
    final placemarks = await getAddressFromCoordinates(
      latitude: latitude,
      longitude: longitude,
    );

    if (placemarks.isEmpty) return null;

    final place = placemarks.first;
    return _formatPlacemark(place);
  }

  /// Formatea un Placemark en una dirección legible
  String _formatPlacemark(Placemark place) {
    final parts = <String>[];

    if (place.street?.isNotEmpty ?? false) {
      parts.add(place.street!);
    }

    if (place.subLocality?.isNotEmpty ?? false) {
      parts.add(place.subLocality!);
    }

    if (place.locality?.isNotEmpty ?? false) {
      parts.add(place.locality!);
    }

    if (place.administrativeArea?.isNotEmpty ?? false) {
      parts.add(place.administrativeArea!);
    }

    if (place.postalCode?.isNotEmpty ?? false) {
      parts.add(place.postalCode!);
    }

    if (place.country?.isNotEmpty ?? false) {
      parts.add(place.country!);
    }

    return parts.join(', ');
  }

  /// Obtiene información detallada de una ubicación
  Future<PlaceDetails?> getPlaceDetails({
    required double latitude,
    required double longitude,
  }) async {
    final placemarks = await getAddressFromCoordinates(
      latitude: latitude,
      longitude: longitude,
    );

    if (placemarks.isEmpty) return null;

    final place = placemarks.first;

    return PlaceDetails(
      street: place.street ?? '',
      subLocality: place.subLocality ?? '',
      locality: place.locality ?? '',
      administrativeArea: place.administrativeArea ?? '',
      postalCode: place.postalCode ?? '',
      country: place.country ?? '',
      isoCountryCode: place.isoCountryCode ?? '',
      formattedAddress: _formatPlacemark(place),
    );
  }
}

/// Modelo para detalles de un lugar
class PlaceDetails {
  final String street;
  final String subLocality;
  final String locality;
  final String administrativeArea;
  final String postalCode;
  final String country;
  final String isoCountryCode;
  final String formattedAddress;

  PlaceDetails({
    required this.street,
    required this.subLocality,
    required this.locality,
    required this.administrativeArea,
    required this.postalCode,
    required this.country,
    required this.isoCountryCode,
    required this.formattedAddress,
  });
}
```

---

## 4️⃣ Google Maps: Mapas Interactivos

### Configuración de API Key

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un proyecto o selecciona uno existente
3. Habilita "Maps SDK for Android" y "Maps SDK for iOS"
4. Crea una API Key en "Credentials"
5. Restringe la key por plataforma (recomendado)

### Widget de Mapa Básico

```dart
/**
 * BasicMapWidget
 *
 * Widget de Google Maps con funcionalidad básica:
 * - Mostrar ubicación actual
 * - Agregar marcadores
 * - Centrar mapa en posición
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class BasicMapWidget extends StatefulWidget {
  final LatLng? initialPosition;
  final double initialZoom;
  final Set<Marker>? markers;
  final Function(LatLng)? onTap;
  final Function(GoogleMapController)? onMapCreated;

  const BasicMapWidget({
    Key? key,
    this.initialPosition,
    this.initialZoom = 15.0,
    this.markers,
    this.onTap,
    this.onMapCreated,
  }) : super(key: key);

  @override
  State<BasicMapWidget> createState() => _BasicMapWidgetState();
}

class _BasicMapWidgetState extends State<BasicMapWidget> {
  GoogleMapController? _mapController;
  final LocationService _locationService = LocationService();

  LatLng _currentPosition = const LatLng(0, 0);
  Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    // Si hay posición inicial, usarla
    if (widget.initialPosition != null) {
      setState(() {
        _currentPosition = widget.initialPosition!;
        _isLoading = false;
      });
      return;
    }

    // Obtener ubicación actual
    try {
      final position = await _locationService.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
    } catch (e) {
      // Usar posición por defecto si falla
      setState(() {
        _currentPosition = const LatLng(40.4168, -3.7038); // Madrid
        _isLoading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    widget.onMapCreated?.call(controller);
  }

  /// Centra el mapa en la ubicación actual
  Future<void> centerOnCurrentLocation() async {
    try {
      final position = await _locationService.getCurrentPosition();
      final latLng = LatLng(position.latitude, position.longitude);

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(latLng, widget.initialZoom),
      );

      setState(() => _currentPosition = latLng);
    } catch (e) {
      print('Error al centrar: $e');
    }
  }

  /// Agrega un marcador en la posición indicada
  void addMarker({
    required String id,
    required LatLng position,
    String? title,
    String? snippet,
    BitmapDescriptor? icon,
    Function()? onTap,
  }) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(
        title: title ?? '',
        snippet: snippet ?? '',
      ),
      icon: icon ?? BitmapDescriptor.defaultMarker,
      onTap: onTap,
    );

    setState(() {
      _markers.add(marker);
    });
  }

  /// Elimina un marcador
  void removeMarker(String id) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == id);
    });
  }

  /// Limpia todos los marcadores
  void clearMarkers() {
    setState(() {
      _markers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando mapa...'),
          ],
        ),
      );
    }

    return Stack(
      children: [
        // Mapa
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: widget.initialZoom,
          ),
          markers: widget.markers ?? _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false, // Usamos nuestro propio botón
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
          onTap: widget.onTap,
        ),

        // Botón para centrar en ubicación actual
        Positioned(
          right: 16,
          bottom: 100,
          child: FloatingActionButton(
            mini: true,
            heroTag: 'centerLocation',
            onPressed: centerOnCurrentLocation,
            child: const Icon(Icons.my_location),
          ),
        ),

        // Botones de zoom
        Positioned(
          right: 16,
          bottom: 160,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                heroTag: 'zoomIn',
                onPressed: () {
                  _mapController?.animateCamera(CameraUpdate.zoomIn());
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                mini: true,
                heroTag: 'zoomOut',
                onPressed: () {
                  _mapController?.animateCamera(CameraUpdate.zoomOut());
                },
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
```

---

### Mapa con Marcadores y Rutas

```dart
/**
 * MapWithRouteWidget
 *
 * Mapa avanzado con:
 * - Marcadores de origen y destino
 * - Polilínea de ruta
 * - Cálculo de distancia
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithRouteWidget extends StatefulWidget {
  final LatLng origin;
  final LatLng destination;
  final List<LatLng>? routePoints;

  const MapWithRouteWidget({
    Key? key,
    required this.origin,
    required this.destination,
    this.routePoints,
  }) : super(key: key);

  @override
  State<MapWithRouteWidget> createState() => _MapWithRouteWidgetState();
}

class _MapWithRouteWidgetState extends State<MapWithRouteWidget> {
  GoogleMapController? _mapController;

  Set<Marker> get _markers => {
    Marker(
      markerId: const MarkerId('origin'),
      position: widget.origin,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: const InfoWindow(title: 'Origen'),
    ),
    Marker(
      markerId: const MarkerId('destination'),
      position: widget.destination,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: 'Destino'),
    ),
  };

  Set<Polyline> get _polylines {
    if (widget.routePoints == null || widget.routePoints!.isEmpty) {
      // Línea directa si no hay puntos de ruta
      return {
        Polyline(
          polylineId: const PolylineId('route'),
          points: [widget.origin, widget.destination],
          color: Colors.blue,
          width: 4,
          patterns: [PatternItem.dash(20), PatternItem.gap(10)],
        ),
      };
    }

    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: widget.routePoints!,
        color: Colors.blue,
        width: 5,
      ),
    };
  }

  /// Calcula los bounds para mostrar toda la ruta
  LatLngBounds _getBounds() {
    double minLat = widget.origin.latitude;
    double maxLat = widget.origin.latitude;
    double minLng = widget.origin.longitude;
    double maxLng = widget.origin.longitude;

    for (final point in [widget.origin, widget.destination]) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  void _fitBounds() {
    final bounds = _getBounds();
    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 80), // 80 = padding
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        _mapController = controller;
        // Esperar un momento y ajustar los bounds
        Future.delayed(const Duration(milliseconds: 500), _fitBounds);
      },
      initialCameraPosition: CameraPosition(
        target: widget.origin,
        zoom: 12,
      ),
      markers: _markers,
      polylines: _polylines,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
```

---

## 5️⃣ Tracking en Tiempo Real

```dart
/**
 * LocationTrackerWidget
 *
 * Widget que rastrea la ubicación en tiempo real
 * y dibuja el recorrido en el mapa.
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationTrackerWidget extends StatefulWidget {
  final Function(List<LatLng>)? onPathUpdated;
  final Function(double)? onDistanceUpdated;

  const LocationTrackerWidget({
    Key? key,
    this.onPathUpdated,
    this.onDistanceUpdated,
  }) : super(key: key);

  @override
  State<LocationTrackerWidget> createState() => _LocationTrackerWidgetState();
}

class _LocationTrackerWidgetState extends State<LocationTrackerWidget> {
  final LocationService _locationService = LocationService();
  GoogleMapController? _mapController;

  StreamSubscription<Position>? _positionSubscription;

  final List<LatLng> _path = [];
  double _totalDistance = 0.0;
  bool _isTracking = false;
  Position? _lastPosition;

  @override
  void dispose() {
    _stopTracking();
    _mapController?.dispose();
    super.dispose();
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
      _path.clear();
      _totalDistance = 0.0;
    });

    _positionSubscription = _locationService.getPositionStream(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, // Cada 5 metros
    ).listen(
      _onPositionUpdate,
      onError: (error) {
        print('Error en tracking: $error');
        _stopTracking();
      },
    );
  }

  void _stopTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = null;

    setState(() {
      _isTracking = false;
    });
  }

  void _onPositionUpdate(Position position) {
    final newPoint = LatLng(position.latitude, position.longitude);

    // Calcular distancia desde el último punto
    if (_lastPosition != null) {
      final distance = _locationService.calculateDistance(
        startLatitude: _lastPosition!.latitude,
        startLongitude: _lastPosition!.longitude,
        endLatitude: position.latitude,
        endLongitude: position.longitude,
      );
      _totalDistance += distance;
      widget.onDistanceUpdated?.call(_totalDistance);
    }

    setState(() {
      _path.add(newPoint);
      _lastPosition = position;
    });

    widget.onPathUpdated?.call(_path);

    // Centrar mapa en la nueva posición
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(newPoint),
    );
  }

  Set<Polyline> get _polylines {
    if (_path.length < 2) return {};

    return {
      Polyline(
        polylineId: const PolylineId('tracking_path'),
        points: _path,
        color: Colors.blue,
        width: 5,
      ),
    };
  }

  Set<Marker> get _markers {
    final markers = <Marker>{};

    if (_path.isNotEmpty) {
      // Marcador de inicio
      markers.add(Marker(
        markerId: const MarkerId('start'),
        position: _path.first,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Inicio'),
      ));

      // Marcador de posición actual
      if (_path.length > 1) {
        markers.add(Marker(
          markerId: const MarkerId('current'),
          position: _path.last,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'Posición actual'),
        ));
      }
    }

    return markers;
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    }
    return '${(meters / 1000).toStringAsFixed(2)} km';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Panel de información
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              // Distancia
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Distancia',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      _formatDistance(_totalDistance),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Puntos registrados
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Puntos',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '${_path.length}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Botón de control
              ElevatedButton.icon(
                onPressed: _isTracking ? _stopTracking : _startTracking,
                icon: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
                label: Text(_isTracking ? 'Detener' : 'Iniciar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isTracking ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // Mapa
        Expanded(
          child: GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: const CameraPosition(
              target: LatLng(40.4168, -3.7038), // Madrid por defecto
              zoom: 15,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ),
      ],
    );
  }
}
```

---

## 📝 Resumen

| Funcionalidad      | Paquete             | Complejidad |
| ------------------ | ------------------- | ----------- |
| Ubicación actual   | geolocator          | ⭐ Baja     |
| Stream de posición | geolocator          | ⭐⭐ Media  |
| Geocoding          | geocoding           | ⭐ Baja     |
| Mapa básico        | google_maps_flutter | ⭐⭐ Media  |
| Marcadores y rutas | google_maps_flutter | ⭐⭐ Media  |
| Tracking en vivo   | geolocator + maps   | ⭐⭐⭐ Alta |

### Consideraciones Importantes

1. **Permisos**: Siempre solicitar antes de acceder a ubicación
2. **Batería**: El tracking continuo consume mucha batería
3. **Precisión**: `high` es más preciso pero consume más batería
4. **Background**: Requiere configuración adicional por plataforma
5. **API Key**: Proteger y restringir tu API key de Google Maps

---

## 🔗 Navegación

| Anterior                                   | Índice                   | Siguiente                                |
| ------------------------------------------ | ------------------------ | ---------------------------------------- |
| [Cámara y Galería](./01-camara-galeria.md) | [Semana 8](../README.md) | [Notificaciones](./03-notificaciones.md) |
