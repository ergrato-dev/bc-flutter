# 📍 Práctica 2: LocationTracker

## 🎯 Objetivo

Desarrollar una aplicación que rastree la ubicación del usuario en tiempo real, mostrando el recorrido en un mapa interactivo con cálculo de distancia recorrida.

---

## ⏱️ Tiempo Estimado

45 minutos

---

## 📋 Requisitos Funcionales

### Funcionalidades Principales

1. **Ubicación Actual**

   - Mostrar posición actual en el mapa
   - Actualizar automáticamente
   - Mostrar información (lat, lng, precisión)

2. **Tracking de Ruta**

   - Iniciar/detener rastreo
   - Dibujar ruta en el mapa (polyline)
   - Mostrar marcadores de inicio y actual

3. **Cálculo de Distancia**

   - Calcular distancia total recorrida
   - Mostrar en metros/kilómetros
   - Actualizar en tiempo real

4. **Controles de Mapa**
   - Zoom in/out
   - Centrar en ubicación actual
   - Tipo de mapa (normal, satélite)

---

## 🛠️ Tecnologías

```yaml
dependencies:
  geolocator: ^10.1.0
  google_maps_flutter: ^2.5.0
  permission_handler: ^11.1.0
```

---

## 📐 Estructura del Proyecto

```
lib/
├── main.dart
├── services/
│   ├── location_service.dart   # Lógica de geolocalización
│   └── permission_service.dart # Manejo de permisos
├── screens/
│   └── tracker_screen.dart     # Pantalla principal
├── widgets/
│   ├── map_widget.dart         # Widget del mapa
│   └── stats_panel.dart        # Panel de estadísticas
└── models/
    └── track_point.dart        # Modelo de punto de ruta
```

---

## 💻 Código Base

### 1. Modelo de Punto de Ruta

```dart
/**
 * TrackPoint
 *
 * Modelo que representa un punto en la ruta rastreada.
 * Incluye coordenadas, timestamp y datos adicionales.
 */

import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackPoint {
  final LatLng position;
  final DateTime timestamp;
  final double altitude;
  final double speed;
  final double accuracy;

  TrackPoint({
    required this.position,
    required this.timestamp,
    this.altitude = 0.0,
    this.speed = 0.0,
    this.accuracy = 0.0,
  });

  /// Crea un TrackPoint desde Position de geolocator
  factory TrackPoint.fromPosition(dynamic position) {
    return TrackPoint(
      position: LatLng(position.latitude, position.longitude),
      timestamp: position.timestamp ?? DateTime.now(),
      altitude: position.altitude,
      speed: position.speed,
      accuracy: position.accuracy,
    );
  }

  /// Convierte a Map para serialización
  Map<String, dynamic> toMap() {
    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': timestamp.toIso8601String(),
      'altitude': altitude,
      'speed': speed,
      'accuracy': accuracy,
    };
  }
}
```

### 2. Servicio de Ubicación

```dart
/**
 * LocationService
 *
 * Servicio para obtener y rastrear la ubicación del usuario.
 */

import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  StreamSubscription<Position>? _positionSubscription;

  /// Verifica y solicita permisos de ubicación
  Future<bool> checkAndRequestPermission() async {
    // Verificar si el servicio está habilitado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Verificar permisos
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Obtiene la posición actual
  Future<Position?> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
    } catch (e) {
      print('Error al obtener posición: $e');
      return null;
    }
  }

  /// Inicia el stream de posiciones
  Stream<Position> startTracking({
    int distanceFilter = 5,
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }

  /// Calcula la distancia entre dos puntos en metros
  double calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  /// Calcula la distancia total de una ruta
  double calculateTotalDistance(List<LatLng> points) {
    if (points.length < 2) return 0.0;

    double total = 0.0;
    for (int i = 1; i < points.length; i++) {
      total += calculateDistance(points[i - 1], points[i]);
    }
    return total;
  }

  /// Abre la configuración de ubicación
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// Abre la configuración de la app
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
```

### 3. Pantalla Principal

```dart
/**
 * TrackerScreen
 *
 * Pantalla principal que muestra el mapa y controles de tracking.
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({Key? key}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  final LocationService _locationService = LocationService();

  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionSubscription;

  // Estado
  bool _isLoading = true;
  bool _isTracking = false;
  String? _error;

  // Datos de tracking
  LatLng? _currentPosition;
  final List<LatLng> _trackPoints = [];
  double _totalDistance = 0.0;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  @override
  void dispose() {
    _stopTracking();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    setState(() => _isLoading = true);

    final hasPermission = await _locationService.checkAndRequestPermission();

    if (!hasPermission) {
      setState(() {
        _isLoading = false;
        _error = 'Se requiere permiso de ubicación';
      });
      return;
    }

    final position = await _locationService.getCurrentPosition();

    if (position != null) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _error = 'No se pudo obtener la ubicación';
      });
    }
  }

  void _startTracking() {
    if (_isTracking) return;

    setState(() {
      _isTracking = true;
      _trackPoints.clear();
      _totalDistance = 0.0;
      _startTime = DateTime.now();
    });

    // Agregar punto inicial
    if (_currentPosition != null) {
      _trackPoints.add(_currentPosition!);
    }

    _positionSubscription = _locationService
        .startTracking(distanceFilter: 5)
        .listen(_onPositionUpdate);
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

    setState(() {
      // Calcular distancia desde el último punto
      if (_trackPoints.isNotEmpty) {
        final distance = _locationService.calculateDistance(
          _trackPoints.last,
          newPoint,
        );
        _totalDistance += distance;
      }

      _currentPosition = newPoint;
      _trackPoints.add(newPoint);
    });

    // Centrar mapa en la nueva posición
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(newPoint),
    );
  }

  void _centerOnCurrentLocation() {
    if (_currentPosition != null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 17),
      );
    }
  }

  void _clearTrack() {
    setState(() {
      _trackPoints.clear();
      _totalDistance = 0.0;
      _startTime = null;
    });
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    }
    return '${(meters / 1000).toStringAsFixed(2)} km';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Tracker'),
        actions: [
          if (_trackPoints.isNotEmpty && !_isTracking)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _clearTrack,
              tooltip: 'Limpiar ruta',
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Obteniendo ubicación...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeLocation,
              child: const Text('Reintentar'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _locationService.openAppSettings(),
              child: const Text('Abrir configuración'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Panel de estadísticas
        _buildStatsPanel(),

        // Mapa
        Expanded(
          child: Stack(
            children: [
              _buildMap(),
              _buildMapControls(),
            ],
          ),
        ),

        // Botón de control
        _buildControlButton(),
      ],
    );
  }

  Widget _buildStatsPanel() {
    final duration = _startTime != null
        ? DateTime.now().difference(_startTime!)
        : Duration.zero;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Distancia
          Column(
            children: [
              const Icon(Icons.straighten, color: Colors.blue),
              const SizedBox(height: 4),
              Text(
                _formatDistance(_totalDistance),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('Distancia', style: TextStyle(color: Colors.grey)),
            ],
          ),

          // Puntos
          Column(
            children: [
              const Icon(Icons.place, color: Colors.green),
              const SizedBox(height: 4),
              Text(
                '${_trackPoints.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('Puntos', style: TextStyle(color: Colors.grey)),
            ],
          ),

          // Tiempo
          if (_startTime != null)
            Column(
              children: [
                const Icon(Icons.timer, color: Colors.orange),
                const SizedBox(height: 4),
                Text(
                  _formatDuration(duration),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Tiempo', style: TextStyle(color: Colors.grey)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: (controller) => _mapController = controller,
      initialCameraPosition: CameraPosition(
        target: _currentPosition ?? const LatLng(0, 0),
        zoom: 16,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      markers: _buildMarkers(),
      polylines: _buildPolylines(),
    );
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};

    // Marcador de inicio
    if (_trackPoints.isNotEmpty) {
      markers.add(Marker(
        markerId: const MarkerId('start'),
        position: _trackPoints.first,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Inicio'),
      ));
    }

    // Marcador de posición actual (si hay más de un punto)
    if (_trackPoints.length > 1) {
      markers.add(Marker(
        markerId: const MarkerId('current'),
        position: _trackPoints.last,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Actual'),
      ));
    }

    return markers;
  }

  Set<Polyline> _buildPolylines() {
    if (_trackPoints.length < 2) return {};

    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: _trackPoints,
        color: Colors.blue,
        width: 5,
      ),
    };
  }

  Widget _buildMapControls() {
    return Positioned(
      right: 16,
      bottom: 16,
      child: Column(
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: 'center',
            onPressed: _centerOnCurrentLocation,
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 8),
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
    );
  }

  Widget _buildControlButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _isTracking ? _stopTracking : _startTracking,
          icon: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
          label: Text(_isTracking ? 'Detener' : 'Iniciar Tracking'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _isTracking ? Colors.red : Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

| Criterio      | Puntos | Descripción                               |
| ------------- | ------ | ----------------------------------------- |
| Permisos      | 1.5    | Solicita y maneja permisos correctamente  |
| Ubicación     | 2      | Obtiene posición actual y en tiempo real  |
| Mapa          | 2      | Muestra mapa con posición y controles     |
| Tracking      | 2      | Rastrea ruta y dibuja polyline            |
| Distancia     | 1.5    | Calcula y muestra distancia correctamente |
| Código limpio | 1      | Documentación y estructura                |
| **Total**     | **10** |                                           |

---

## 🎁 Bonus

- [ ] Guardar rutas en almacenamiento local (+1)
- [ ] Exportar ruta como GPX (+1)
- [ ] Mostrar velocidad promedio (+0.5)
- [ ] Cambiar tipo de mapa (satélite, terreno) (+0.5)

---

## 🔗 Navegación

| Anterior                                       | Índice                   | Siguiente                                                    |
| ---------------------------------------------- | ------------------------ | ------------------------------------------------------------ |
| [PhotoCapture](./practica-01-photo-capture.md) | [Prácticas](./README.md) | [NotificationManager](./practica-03-notification-manager.md) |
