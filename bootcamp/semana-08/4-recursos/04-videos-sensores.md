# 🎬 Videos: Sensores del Dispositivo

## 📋 Contenido

Videos sobre acceso a sensores del dispositivo: acelerómetro, giroscopio, brújula y más.

---

## 🎥 Canales en Español

### 1. Código Facilito - Sensores Flutter

| Recurso | Descripción |
|---------|-------------|
| **Canal** | [Código Facilito](https://www.youtube.com/@codigofacilito) |
| **Tema** | Sensores en Flutter |
| **Nivel** | Intermedio |
| **Duración** | ~45 min |

**Contenido:**
- Package sensors_plus
- Acelerómetro y giroscopio
- Lectura en tiempo real
- Visualización de datos

---

### 2. DevTalles - Brújula y Orientación

| Recurso | Descripción |
|---------|-------------|
| **Canal** | [DevTalles](https://www.youtube.com/@DevTalles) |
| **Tema** | Compass App Flutter |
| **Nivel** | Básico-Intermedio |
| **Duración** | ~35 min |

**Contenido:**
- Magnetómetro
- Cálculo de orientación
- UI de brújula animada
- Calibración

---

## 🎥 Canales en Inglés

### 3. Johannes Milke - Device Sensors

| Recurso | Descripción |
|---------|-------------|
| **Canal** | [Johannes Milke](https://www.youtube.com/@JohannesMilke) |
| **Tema** | Flutter Sensors Tutorial |
| **Nivel** | Intermedio |
| **Duración** | ~30 min |

**Contenido:**
- sensors_plus overview
- Accelerometer events
- Gyroscope events
- User accelerometer

---

### 4. Flutter Explained - Shake Detection

| Recurso | Descripción |
|---------|-------------|
| **Canal** | [Flutter Explained](https://www.youtube.com/@FlutterExplained) |
| **Tema** | Shake to Action |
| **Nivel** | Básico |
| **Duración** | ~20 min |

**Contenido:**
- Detectar shake gesture
- Threshold configuration
- Acciones al agitar
- Debouncing

---

### 5. Raja Yogan - Step Counter App

| Recurso | Descripción |
|---------|-------------|
| **Canal** | [Raja Yogan](https://www.youtube.com/@RajaYogan) |
| **Tema** | Pedometer Flutter |
| **Nivel** | Intermedio |
| **Duración** | ~40 min |

**Contenido:**
- Contador de pasos
- Background tracking
- Gráficas de actividad
- Health Kit integration

---

### 6. The Flutter Way - Motion Games

| Recurso | Descripción |
|---------|-------------|
| **Canal** | [The Flutter Way](https://www.youtube.com/@TheFlutterWay) |
| **Tema** | Tilt Controlled Game |
| **Nivel** | Avanzado |
| **Duración** | ~1h |

**Contenido:**
- Juego controlado por inclinación
- Acelerómetro para controles
- Physics simulation
- Performance optimization

---

## 📺 Playlists Recomendadas

### Sensors & Hardware in Flutter

| Playlist | Videos | Duración Total |
|----------|--------|----------------|
| [Flutter Sensors Series](https://youtube.com/playlist?...) | 6 videos | ~2h |
| [Device Hardware Access](https://youtube.com/playlist?...) | 8 videos | ~3h |
| [Motion Controlled Apps](https://youtube.com/playlist?...) | 5 videos | ~2h |

---

## 📱 Sensores Disponibles

| Sensor | Package | Descripción |
|--------|---------|-------------|
| Acelerómetro | sensors_plus | Aceleración en X, Y, Z |
| Giroscopio | sensors_plus | Rotación en X, Y, Z |
| Magnetómetro | sensors_plus | Campo magnético |
| User Accelerometer | sensors_plus | Aceleración sin gravedad |
| Podómetro | pedometer | Contador de pasos |
| Barómetro | environment_sensors | Presión atmosférica |
| Luz ambiental | light | Nivel de luz |
| Proximidad | proximity_sensor | Cercanía de objetos |

---

## 🎯 Ruta de Aprendizaje Sugerida

```
1. Johannes Milke - Sensors Tutorial (30 min)
   └── Fundamentos de sensores
   
2. Flutter Explained - Shake Detection (20 min)
   └── Aplicación práctica simple
   
3. Código Facilito - Sensores Flutter (45 min)
   └── Visualización de datos
   
4. DevTalles - Brújula (35 min)
   └── Magnetómetro avanzado
   
5. The Flutter Way - Motion Games (1h)
   └── Proyecto completo
```

---

## 💡 Tips para el Estudio

- ✅ Obligatorio: dispositivo físico (simulador no tiene sensores reales)
- ✅ Calibra los sensores antes de cada prueba
- ✅ Considera el consumo de batería en lecturas continuas
- ✅ Filtra el ruido con algoritmos de suavizado
- ✅ Define intervalos de lectura apropiados

---

## 📊 Consideraciones de Rendimiento

```dart
// Intervalo de lectura recomendado
const normalInterval = Duration(milliseconds: 100);     // UI updates
const gameInterval = Duration(milliseconds: 16);        // 60 FPS
const backgroundInterval = Duration(milliseconds: 1000); // Background

// Filtro de ruido simple (low-pass filter)
filteredValue = filteredValue * 0.8 + newValue * 0.2;
```

---

## 🔗 Navegación

| Anterior | Índice | Siguiente |
|----------|--------|-----------|
| [Videos Notificaciones](./03-videos-notificaciones.md) | [Recursos](./README.md) | [eBooks Plugins](./05-ebooks-plugins-flutter.md) |
