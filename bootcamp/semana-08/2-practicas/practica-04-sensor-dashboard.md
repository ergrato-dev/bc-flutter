# 📊 Práctica 4: SensorDashboard

## 🎯 Objetivo

Crear un dashboard interactivo que visualice datos de sensores del dispositivo (acelerómetro, giroscopio) en tiempo real con gráficas dinámicas.

---

## ⏱️ Tiempo Estimado

45 minutos

---

## 📋 Requisitos Funcionales

### Funcionalidades Principales

1. **Lectura de Sensores**

   - Acelerómetro (aceleración en X, Y, Z)
   - Giroscopio (rotación en X, Y, Z)
   - Magnetómetro (orientación)

2. **Visualización de Datos**

   - Valores en tiempo real
   - Gráficas de línea históricas
   - Indicadores visuales de nivel

3. **Control de Sensores**

   - Iniciar/pausar lectura
   - Ajustar frecuencia de muestreo
   - Seleccionar sensores activos

4. **Análisis**
   - Detectar movimiento brusco
   - Detectar orientación del dispositivo
   - Historial de eventos

---

## 🛠️ Tecnologías

```yaml
dependencies:
  sensors_plus: ^4.0.2
  fl_chart: ^0.66.0
  provider: ^6.1.1
```

---

## 📐 Estructura del Proyecto

```
lib/
├── main.dart
├── providers/
│   └── sensor_provider.dart    # Estado de sensores
├── screens/
│   ├── dashboard_screen.dart   # Dashboard principal
│   └── sensor_detail_screen.dart # Detalle de un sensor
├── widgets/
│   ├── sensor_card.dart        # Card de sensor
│   ├── sensor_chart.dart       # Gráfica de sensor
│   └── orientation_indicator.dart # Indicador de orientación
└── models/
    └── sensor_data.dart        # Modelo de datos
```

---

## 💻 Código Base

### 1. Modelo de Datos

```dart
/**
 * SensorData
 *
 * Modelo inmutable para representar una lectura de sensor.
 * Incluye timestamp para ordenar históricamente.
 */

class SensorData {
  final double x;
  final double y;
  final double z;
  final DateTime timestamp;

  const SensorData({
    required this.x,
    required this.y,
    required this.z,
    required this.timestamp,
  });

  /// Magnitud total del vector
  double get magnitude =>
      (x * x + y * y + z * z).abs().toDouble();

  /// Crea una copia con valores modificados
  SensorData copyWith({
    double? x,
    double? y,
    double? z,
    DateTime? timestamp,
  }) {
    return SensorData(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() => 'SensorData(x: $x, y: $y, z: $z)';
}

/// Tipo de sensor disponible
enum SensorType {
  accelerometer,
  gyroscope,
  magnetometer,
}

/// Extensión para nombres legibles
extension SensorTypeExtension on SensorType {
  String get displayName {
    switch (this) {
      case SensorType.accelerometer:
        return 'Acelerómetro';
      case SensorType.gyroscope:
        return 'Giroscopio';
      case SensorType.magnetometer:
        return 'Magnetómetro';
    }
  }

  String get unit {
    switch (this) {
      case SensorType.accelerometer:
        return 'm/s²';
      case SensorType.gyroscope:
        return 'rad/s';
      case SensorType.magnetometer:
        return 'μT';
    }
  }
}
```

### 2. Provider de Sensores

```dart
/**
 * SensorProvider
 *
 * Gestiona el estado y streams de todos los sensores.
 * Mantiene un historial limitado para las gráficas.
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorProvider extends ChangeNotifier {
  // Configuración
  static const int maxHistoryLength = 50;
  static const Duration samplingPeriod = Duration(milliseconds: 100);

  // Subscripciones
  StreamSubscription<AccelerometerEvent>? _accelerometerSub;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSub;
  StreamSubscription<MagnetometerEvent>? _magnetometerSub;

  // Datos actuales
  SensorData? _accelerometerData;
  SensorData? _gyroscopeData;
  SensorData? _magnetometerData;

  // Historial para gráficas
  final List<SensorData> _accelerometerHistory = [];
  final List<SensorData> _gyroscopeHistory = [];
  final List<SensorData> _magnetometerHistory = [];

  // Estados
  bool _isListening = false;
  Set<SensorType> _activeSensors = {
    SensorType.accelerometer,
    SensorType.gyroscope,
  };

  // Detección de movimiento
  bool _shakeDetected = false;
  static const double shakeThreshold = 15.0;

  // Getters
  SensorData? get accelerometerData => _accelerometerData;
  SensorData? get gyroscopeData => _gyroscopeData;
  SensorData? get magnetometerData => _magnetometerData;

  List<SensorData> get accelerometerHistory =>
      List.unmodifiable(_accelerometerHistory);
  List<SensorData> get gyroscopeHistory =>
      List.unmodifiable(_gyroscopeHistory);
  List<SensorData> get magnetometerHistory =>
      List.unmodifiable(_magnetometerHistory);

  bool get isListening => _isListening;
  Set<SensorType> get activeSensors => Set.unmodifiable(_activeSensors);
  bool get shakeDetected => _shakeDetected;

  /// Inicia la escucha de sensores
  void startListening() {
    if (_isListening) return;
    _isListening = true;

    if (_activeSensors.contains(SensorType.accelerometer)) {
      _startAccelerometer();
    }

    if (_activeSensors.contains(SensorType.gyroscope)) {
      _startGyroscope();
    }

    if (_activeSensors.contains(SensorType.magnetometer)) {
      _startMagnetometer();
    }

    notifyListeners();
  }

  /// Detiene la escucha de sensores
  void stopListening() {
    _accelerometerSub?.cancel();
    _gyroscopeSub?.cancel();
    _magnetometerSub?.cancel();

    _accelerometerSub = null;
    _gyroscopeSub = null;
    _magnetometerSub = null;

    _isListening = false;
    notifyListeners();
  }

  /// Activa o desactiva un sensor
  void toggleSensor(SensorType type, bool active) {
    if (active) {
      _activeSensors.add(type);
      if (_isListening) {
        _startSensor(type);
      }
    } else {
      _activeSensors.remove(type);
      _stopSensor(type);
    }
    notifyListeners();
  }

  /// Limpia el historial
  void clearHistory() {
    _accelerometerHistory.clear();
    _gyroscopeHistory.clear();
    _magnetometerHistory.clear();
    notifyListeners();
  }

  /// Reinicia la detección de shake
  void resetShakeDetection() {
    _shakeDetected = false;
    notifyListeners();
  }

  void _startSensor(SensorType type) {
    switch (type) {
      case SensorType.accelerometer:
        _startAccelerometer();
        break;
      case SensorType.gyroscope:
        _startGyroscope();
        break;
      case SensorType.magnetometer:
        _startMagnetometer();
        break;
    }
  }

  void _stopSensor(SensorType type) {
    switch (type) {
      case SensorType.accelerometer:
        _accelerometerSub?.cancel();
        _accelerometerSub = null;
        break;
      case SensorType.gyroscope:
        _gyroscopeSub?.cancel();
        _gyroscopeSub = null;
        break;
      case SensorType.magnetometer:
        _magnetometerSub?.cancel();
        _magnetometerSub = null;
        break;
    }
  }

  void _startAccelerometer() {
    _accelerometerSub = accelerometerEventStream(
      samplingPeriod: samplingPeriod,
    ).listen((event) {
      final data = SensorData(
        x: event.x,
        y: event.y,
        z: event.z,
        timestamp: DateTime.now(),
      );

      _accelerometerData = data;
      _addToHistory(_accelerometerHistory, data);

      // Detectar shake
      if (data.magnitude > shakeThreshold) {
        _shakeDetected = true;
      }

      notifyListeners();
    });
  }

  void _startGyroscope() {
    _gyroscopeSub = gyroscopeEventStream(
      samplingPeriod: samplingPeriod,
    ).listen((event) {
      final data = SensorData(
        x: event.x,
        y: event.y,
        z: event.z,
        timestamp: DateTime.now(),
      );

      _gyroscopeData = data;
      _addToHistory(_gyroscopeHistory, data);
      notifyListeners();
    });
  }

  void _startMagnetometer() {
    _magnetometerSub = magnetometerEventStream(
      samplingPeriod: samplingPeriod,
    ).listen((event) {
      final data = SensorData(
        x: event.x,
        y: event.y,
        z: event.z,
        timestamp: DateTime.now(),
      );

      _magnetometerData = data;
      _addToHistory(_magnetometerHistory, data);
      notifyListeners();
    });
  }

  void _addToHistory(List<SensorData> history, SensorData data) {
    history.add(data);
    if (history.length > maxHistoryLength) {
      history.removeAt(0);
    }
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
  }
}
```

### 3. Widget de Gráfica

```dart
/**
 * SensorChart
 *
 * Gráfica de línea que muestra el historial de un sensor.
 * Usa fl_chart para renderizado eficiente.
 */

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SensorChart extends StatelessWidget {
  final List<SensorData> data;
  final String title;
  final String unit;

  const SensorChart({
    Key? key,
    required this.data,
    required this.title,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text('Sin datos'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        // Gráfica
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 5,
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) => Text(
                      value.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                // Eje X (Rojo)
                _createLine(
                  spots: _createSpots((d) => d.x),
                  color: Colors.red,
                ),
                // Eje Y (Verde)
                _createLine(
                  spots: _createSpots((d) => d.y),
                  color: Colors.green,
                ),
                // Eje Z (Azul)
                _createLine(
                  spots: _createSpots((d) => d.z),
                  color: Colors.blue,
                ),
              ],
              minY: _calculateMinY(),
              maxY: _calculateMaxY(),
            ),
            duration: const Duration(milliseconds: 100),
          ),
        ),

        // Leyenda
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('X', Colors.red),
              const SizedBox(width: 16),
              _buildLegendItem('Y', Colors.green),
              const SizedBox(width: 16),
              _buildLegendItem('Z', Colors.blue),
            ],
          ),
        ),
      ],
    );
  }

  List<FlSpot> _createSpots(double Function(SensorData) getValue) {
    return List.generate(
      data.length,
      (index) => FlSpot(index.toDouble(), getValue(data[index])),
    );
  }

  LineChartBarData _createLine({
    required List<FlSpot> spots,
    required Color color,
  }) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  double _calculateMinY() {
    double min = 0;
    for (final d in data) {
      if (d.x < min) min = d.x;
      if (d.y < min) min = d.y;
      if (d.z < min) min = d.z;
    }
    return min - 2;
  }

  double _calculateMaxY() {
    double max = 0;
    for (final d in data) {
      if (d.x > max) max = d.x;
      if (d.y > max) max = d.y;
      if (d.z > max) max = d.z;
    }
    return max + 2;
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
```

### 4. Card de Sensor

```dart
/**
 * SensorCard
 *
 * Tarjeta que muestra los valores actuales de un sensor
 * con indicadores visuales de nivel.
 */

import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final SensorType type;
  final SensorData? data;
  final bool isActive;
  final VoidCallback onTap;

  const SensorCard({
    Key? key,
    required this.type,
    required this.data,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isActive ? 4 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getIcon(),
                        color: isActive ? Colors.blue : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        type.displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isActive ? 'Activo' : 'Inactivo',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Valores
              if (data != null) ...[
                _buildAxisRow('X', data!.x, Colors.red),
                const SizedBox(height: 8),
                _buildAxisRow('Y', data!.y, Colors.green),
                const SizedBox(height: 8),
                _buildAxisRow('Z', data!.z, Colors.blue),

                const Divider(height: 24),

                // Magnitud
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Magnitud'),
                    Text(
                      '${data!.magnitude.toStringAsFixed(2)} ${type.unit}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ] else
                const Center(
                  child: Text(
                    'Sin datos',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (type) {
      case SensorType.accelerometer:
        return Icons.speed;
      case SensorType.gyroscope:
        return Icons.rotate_right;
      case SensorType.magnetometer:
        return Icons.explore;
    }
  }

  Widget _buildAxisRow(String axis, double value, Color color) {
    // Normalizar valor para la barra (-20 a 20 → 0 a 1)
    final normalized = ((value + 20) / 40).clamp(0.0, 1.0);

    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Text(
            axis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: normalized,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: Text(
            value.toStringAsFixed(2),
            textAlign: TextAlign.right,
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }
}
```

### 5. Dashboard Screen

```dart
/**
 * DashboardScreen
 *
 * Pantalla principal del dashboard de sensores.
 * Muestra cards, gráficas y controles.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Dashboard'),
        actions: [
          Consumer<SensorProvider>(
            builder: (context, provider, _) {
              if (provider.shakeDetected) {
                return IconButton(
                  icon: const Icon(Icons.vibration, color: Colors.orange),
                  onPressed: provider.resetShakeDetection,
                  tooltip: '¡Shake detectado!',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<SensorProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Controles
                _buildControls(context, provider),

                const SizedBox(height: 16),

                // Cards de sensores
                _buildSensorCards(context, provider),

                const SizedBox(height: 24),

                // Gráficas
                if (provider.isListening) ...[
                  _buildCharts(provider),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildControls(BuildContext context, SensorProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Botón Start/Stop
            ElevatedButton.icon(
              onPressed: () {
                if (provider.isListening) {
                  provider.stopListening();
                } else {
                  provider.startListening();
                }
              },
              icon: Icon(
                provider.isListening ? Icons.stop : Icons.play_arrow,
              ),
              label: Text(provider.isListening ? 'Detener' : 'Iniciar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: provider.isListening
                    ? Colors.red
                    : Colors.green,
              ),
            ),

            // Botón limpiar
            OutlinedButton.icon(
              onPressed: provider.clearHistory,
              icon: const Icon(Icons.clear),
              label: const Text('Limpiar'),
            ),

            // Configuración
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => _showSettings(context, provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCards(BuildContext context, SensorProvider provider) {
    return Column(
      children: [
        SensorCard(
          type: SensorType.accelerometer,
          data: provider.accelerometerData,
          isActive: provider.activeSensors.contains(SensorType.accelerometer),
          onTap: () => _navigateToDetail(
            context,
            SensorType.accelerometer,
            provider.accelerometerHistory,
          ),
        ),
        const SizedBox(height: 12),
        SensorCard(
          type: SensorType.gyroscope,
          data: provider.gyroscopeData,
          isActive: provider.activeSensors.contains(SensorType.gyroscope),
          onTap: () => _navigateToDetail(
            context,
            SensorType.gyroscope,
            provider.gyroscopeHistory,
          ),
        ),
        const SizedBox(height: 12),
        SensorCard(
          type: SensorType.magnetometer,
          data: provider.magnetometerData,
          isActive: provider.activeSensors.contains(SensorType.magnetometer),
          onTap: () => _navigateToDetail(
            context,
            SensorType.magnetometer,
            provider.magnetometerHistory,
          ),
        ),
      ],
    );
  }

  Widget _buildCharts(SensorProvider provider) {
    return Column(
      children: [
        if (provider.activeSensors.contains(SensorType.accelerometer))
          SensorChart(
            data: provider.accelerometerHistory,
            title: 'Acelerómetro',
            unit: 'm/s²',
          ),

        if (provider.activeSensors.contains(SensorType.gyroscope))
          SensorChart(
            data: provider.gyroscopeHistory,
            title: 'Giroscopio',
            unit: 'rad/s',
          ),

        if (provider.activeSensors.contains(SensorType.magnetometer))
          SensorChart(
            data: provider.magnetometerHistory,
            title: 'Magnetómetro',
            unit: 'μT',
          ),
      ],
    );
  }

  void _showSettings(BuildContext context, SensorProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sensores Activos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            for (final type in SensorType.values)
              SwitchListTile(
                title: Text(type.displayName),
                subtitle: Text('Unidad: ${type.unit}'),
                value: provider.activeSensors.contains(type),
                onChanged: (value) => provider.toggleSensor(type, value),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(
    BuildContext context,
    SensorType type,
    List<SensorData> history,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SensorDetailScreen(
          type: type,
          history: history,
        ),
      ),
    );
  }
}
```

### 6. Main con Provider

```dart
/**
 * main.dart
 *
 * Configuración de la app con Provider.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SensorProvider(),
      child: MaterialApp(
        title: 'Sensor Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const DashboardScreen(),
      ),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

| Criterio                  | Puntos | Descripción                                 |
| ------------------------- | ------ | ------------------------------------------- |
| Lectura de sensores       | 2.5    | Lee correctamente acelerómetro y giroscopio |
| Visualización tiempo real | 2      | Muestra valores actualizados en UI          |
| Gráficas históricas       | 2      | Implementa gráficas con fl_chart            |
| Control de sensores       | 1.5    | Start/stop, toggle sensores                 |
| Detección de eventos      | 1      | Detecta shake u otros eventos               |
| Código limpio             | 1      | Provider pattern, documentación             |
| **Total**                 | **10** |                                             |

---

## 🎁 Bonus

- [ ] Indicador de orientación 3D (+1)
- [ ] Exportar datos a CSV (+0.5)
- [ ] Alertas por umbral configurable (+0.5)

---

## 🔗 Navegación

| Anterior                                                     | Índice                   | Siguiente                                                  |
| ------------------------------------------------------------ | ------------------------ | ---------------------------------------------------------- |
| [NotificationManager](./practica-03-notification-manager.md) | [Prácticas](./README.md) | [PermissionsManager](./practica-05-permissions-manager.md) |
