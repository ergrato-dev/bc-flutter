# 📂 Proyecto Semana 08 - TravelDiary

## 📋 Índice de Contenidos

| Archivo                                  | Descripción                                |
| ---------------------------------------- | ------------------------------------------ |
| [README.md](./README.md)                 | Este archivo - Especificación del proyecto |
| [GUIA-DISENO.md](./GUIA-DISENO.md)       | Guía de diseño y UI/UX                     |
| [EJEMPLOS-DATOS.md](./EJEMPLOS-DATOS.md) | Datos de ejemplo y mocks                   |

---

# 🗺️ TravelDiary - Diario de Viajes

## 📖 Descripción

**TravelDiary** es una aplicación completa de diario de viajes que permite a los usuarios documentar sus experiencias con fotos geolocalizadas, visualizar rutas en mapas interactivos y recibir recordatorios para capturar momentos.

Este proyecto integrador de la Semana 08 combina todas las características nativas aprendidas: cámara/galería, geolocalización, mapas, notificaciones, sensores y gestión de permisos.

---

## 🎯 Objetivos de Aprendizaje

Al completar este proyecto, habrás practicado:

- ✅ Captura y selección de imágenes con `image_picker` y `camera`
- ✅ Obtención de ubicación con `geolocator`
- ✅ Visualización de mapas con `google_maps_flutter`
- ✅ Notificaciones locales con `flutter_local_notifications`
- ✅ Gestión de permisos con `permission_handler`
- ✅ Persistencia local de datos
- ✅ Arquitectura limpia con Provider

---

## ⏱️ Tiempo Estimado

**3-4 horas** de desarrollo

---

## 📋 Requisitos Funcionales

### RF01: Gestión de Entradas

| ID     | Requisito                       | Prioridad |
| ------ | ------------------------------- | --------- |
| RF01.1 | Crear nueva entrada de diario   | Alta      |
| RF01.2 | Ver lista de entradas por fecha | Alta      |
| RF01.3 | Ver detalle de una entrada      | Alta      |
| RF01.4 | Editar entrada existente        | Media     |
| RF01.5 | Eliminar entrada                | Media     |

### RF02: Captura de Fotos

| ID     | Requisito                   | Prioridad |
| ------ | --------------------------- | --------- |
| RF02.1 | Tomar foto con la cámara    | Alta      |
| RF02.2 | Seleccionar foto de galería | Alta      |
| RF02.3 | Múltiples fotos por entrada | Media     |
| RF02.4 | Vista previa de fotos       | Alta      |
| RF02.5 | Eliminar foto de entrada    | Media     |

### RF03: Geolocalización

| ID     | Requisito                                    | Prioridad |
| ------ | -------------------------------------------- | --------- |
| RF03.1 | Obtener ubicación actual automáticamente     | Alta      |
| RF03.2 | Seleccionar ubicación manualmente en mapa    | Media     |
| RF03.3 | Guardar coordenadas con cada entrada         | Alta      |
| RF03.4 | Mostrar nombre del lugar (reverse geocoding) | Baja      |

### RF04: Mapa de Viajes

| ID     | Requisito                             | Prioridad |
| ------ | ------------------------------------- | --------- |
| RF04.1 | Mostrar mapa con todas las entradas   | Alta      |
| RF04.2 | Marcadores personalizados por entrada | Alta      |
| RF04.3 | Ver info de entrada al tocar marcador | Alta      |
| RF04.4 | Dibujar ruta entre puntos de un viaje | Media     |
| RF04.5 | Filtrar por fecha o viaje             | Baja      |

### RF05: Recordatorios

| ID     | Requisito                        | Prioridad |
| ------ | -------------------------------- | --------- |
| RF05.1 | Programar recordatorio diario    | Alta      |
| RF05.2 | Notificación push con acción     | Media     |
| RF05.3 | Configurar hora del recordatorio | Media     |
| RF05.4 | Activar/desactivar recordatorios | Alta      |

### RF06: Permisos

| ID     | Requisito                             | Prioridad |
| ------ | ------------------------------------- | --------- |
| RF06.1 | Solicitar permisos al inicio          | Alta      |
| RF06.2 | Manejar permisos denegados gracefully | Alta      |
| RF06.3 | Guiar a configuración si bloqueado    | Media     |

---

## 📐 Arquitectura

### Estructura del Proyecto

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── api_keys.dart          # ⚠️ No subir a Git
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       ├── date_formatter.dart
│       └── location_utils.dart
├── data/
│   ├── models/
│   │   ├── diary_entry.dart
│   │   ├── photo.dart
│   │   ├── location.dart
│   │   └── trip.dart
│   ├── repositories/
│   │   ├── diary_repository.dart
│   │   └── trip_repository.dart
│   └── services/
│       ├── camera_service.dart
│       ├── location_service.dart
│       ├── notification_service.dart
│       ├── storage_service.dart
│       └── permission_service.dart
├── presentation/
│   ├── providers/
│   │   ├── diary_provider.dart
│   │   ├── location_provider.dart
│   │   ├── notification_provider.dart
│   │   └── permission_provider.dart
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── onboarding/
│   │   │   └── permissions_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── diary/
│   │   │   ├── diary_list_screen.dart
│   │   │   ├── diary_detail_screen.dart
│   │   │   └── diary_form_screen.dart
│   │   ├── map/
│   │   │   └── map_screen.dart
│   │   └── settings/
│   │       └── settings_screen.dart
│   └── widgets/
│       ├── common/
│       │   ├── loading_widget.dart
│       │   └── error_widget.dart
│       ├── diary/
│       │   ├── diary_card.dart
│       │   └── photo_grid.dart
│       └── map/
│           └── custom_marker.dart
└── config/
    └── routes.dart
```

### Diagrama de Flujo

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Splash    │────▶│  Permissions │────▶│    Home     │
└─────────────┘     └──────────────┘     └─────────────┘
                                               │
                    ┌──────────────────────────┼──────────────────────────┐
                    │                          │                          │
                    ▼                          ▼                          ▼
            ┌─────────────┐           ┌─────────────┐             ┌─────────────┐
            │  Diary List │           │     Map     │             │  Settings   │
            └─────────────┘           └─────────────┘             └─────────────┘
                    │
         ┌──────────┴──────────┐
         ▼                     ▼
  ┌─────────────┐      ┌─────────────┐
  │ Diary Detail│      │ Diary Form  │
  └─────────────┘      └─────────────┘
```

---

## 🛠️ Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  provider: ^6.1.1

  # Camera & Gallery
  image_picker: ^1.0.4
  camera: ^0.10.5+5

  # Location & Maps
  geolocator: ^10.1.0
  google_maps_flutter: ^2.5.0
  geocoding: ^2.1.1

  # Notifications
  flutter_local_notifications: ^16.1.0
  timezone: ^0.9.2

  # Permissions
  permission_handler: ^11.1.0

  # Storage
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  path: ^1.8.3

  # UI
  cached_network_image: ^3.3.0
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

---

## 💾 Modelos de Datos

### DiaryEntry

```dart
class DiaryEntry {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final Location? location;
  final List<Photo> photos;
  final String? tripId;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Constructor, copyWith, toJson, fromJson...
}
```

### Photo

```dart
class Photo {
  final String id;
  final String localPath;
  final DateTime takenAt;
  final Location? location;

  // Constructor, toJson, fromJson...
}
```

### Location

```dart
class Location {
  final double latitude;
  final double longitude;
  final String? placeName;
  final String? address;

  // Constructor, toJson, fromJson...
}
```

### Trip

```dart
class Trip {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> entryIds;

  // Constructor, toJson, fromJson...
}
```

---

## 🎨 Pantallas Principales

### 1. Splash Screen

- Logo de la app
- Verificación de permisos iniciales
- Navegación a Onboarding o Home

### 2. Permissions Screen (Onboarding)

- Lista de permisos necesarios
- Explicación de cada permiso
- Botones de solicitud
- Skip para permisos opcionales

### 3. Home Screen

- Bottom Navigation con 3 tabs:
  - Diario (lista de entradas)
  - Mapa (vista de mapa)
  - Ajustes
- FAB para nueva entrada

### 4. Diary List Screen

- Lista de entradas ordenadas por fecha
- Card con foto principal, título, fecha, ubicación
- Búsqueda y filtros
- Pull to refresh

### 5. Diary Detail Screen

- Galería de fotos
- Información completa
- Mapa pequeño con ubicación
- Acciones: editar, eliminar, compartir

### 6. Diary Form Screen

- Campos: título, descripción
- Selector de fecha
- Grid de fotos con add/remove
- Mapa para seleccionar ubicación
- Botón guardar

### 7. Map Screen

- Google Map fullscreen
- Marcadores de todas las entradas
- Info window al tocar marcador
- Botón para centrar en ubicación actual
- Opción de ver ruta

### 8. Settings Screen

- Configuración de recordatorios
- Hora del recordatorio diario
- Toggle on/off
- Información de la app
- Gestionar permisos

---

## ✅ Criterios de Evaluación

### Funcionalidad (50 puntos)

| Criterio                     | Puntos |
| ---------------------------- | ------ |
| CRUD de entradas de diario   | 10     |
| Captura/selección de fotos   | 10     |
| Geolocalización automática   | 10     |
| Mapa con marcadores          | 10     |
| Notificaciones/recordatorios | 10     |

### Calidad Técnica (30 puntos)

| Criterio                     | Puntos |
| ---------------------------- | ------ |
| Arquitectura limpia          | 10     |
| Gestión de estado (Provider) | 10     |
| Manejo de permisos           | 5      |
| Código documentado           | 5      |

### UX/UI (20 puntos)

| Criterio                 | Puntos |
| ------------------------ | ------ |
| Diseño coherente         | 5      |
| Estados de carga y error | 5      |
| Navegación intuitiva     | 5      |
| Responsividad            | 5      |

### Total: 100 puntos

---

## 🎁 Bonus (hasta +20 puntos)

- [ ] Viajes agrupados (+5)
- [ ] Ruta en el mapa (+5)
- [ ] Modo offline completo (+5)
- [ ] Compartir entrada (+3)
- [ ] Exportar a PDF (+2)

---

## 📝 Entregables

1. **Código fuente** en repositorio Git
2. **README.md** con instrucciones de instalación
3. **Screenshots** de las pantallas principales
4. **Video demo** de 2-3 minutos (opcional pero recomendado)

---

## 🚀 Guía de Inicio

### Paso 1: Crear el proyecto

```bash
flutter create --org com.example travel_diary
cd travel_diary
```

### Paso 2: Agregar dependencias

Copia las dependencias del `pubspec.yaml` de arriba.

### Paso 3: Configurar permisos

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

#### iOS (`ios/Runner/Info.plist`)

```xml
<key>NSCameraUsageDescription</key>
<string>Para tomar fotos de tus viajes</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Para seleccionar fotos de tu galería</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Para etiquetar la ubicación de tus entradas</string>
```

### Paso 4: Configurar Google Maps

1. Obtén una API Key de Google Cloud Console
2. Habilita Maps SDK for Android e iOS
3. Configura las keys en los archivos nativos

### Paso 5: Implementar por fases

1. **Fase 1**: Estructura base y navegación
2. **Fase 2**: CRUD de entradas (sin fotos/ubicación)
3. **Fase 3**: Integrar cámara y galería
4. **Fase 4**: Agregar geolocalización
5. **Fase 5**: Implementar mapa
6. **Fase 6**: Notificaciones y recordatorios
7. **Fase 7**: Pulir UI y manejo de errores

---

## 🔗 Navegación

| Anterior                              | Índice                    | Siguiente                           |
| ------------------------------------- | ------------------------- | ----------------------------------- |
| [Prácticas](../2-practicas/README.md) | [Semana 08](../README.md) | [Recursos](../4-recursos/README.md) |
