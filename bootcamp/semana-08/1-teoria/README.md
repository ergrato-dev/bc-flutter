# 📚 Teoría - Semana 8: Características Nativas y Plugins

## 📖 Módulos de Estudio

Esta carpeta contiene el contenido teórico de la Semana 8, enfocado en la integración de características nativas del dispositivo en aplicaciones Flutter.

---

## 📋 Índice de Módulos

### [01. Cámara y Galería](./01-camara-galeria.md)

> **Tiempo estimado:** 60 minutos

Aprende a capturar fotos y videos, seleccionar imágenes de la galería, y procesarlas para su uso en la aplicación.

**Contenido:**

- 📷 Paquetes: image_picker, camera
- 🖼️ Selección de imágenes
- 📹 Captura de video
- 🔄 Procesamiento de imágenes
- 💾 Almacenamiento de medios
- ⚙️ Configuración de permisos

---

### [02. Geolocalización y Mapas](./02-geolocalizacion-mapas.md)

> **Tiempo estimado:** 75 minutos

Domina la obtención de ubicación del usuario, integración de mapas interactivos y técnicas de geofencing.

**Contenido:**

- 📍 Paquetes: geolocator, google_maps_flutter
- 🗺️ Obtener ubicación actual
- 🔄 Stream de posiciones
- 📌 Marcadores y rutas
- 🎯 Geocoding y reverse geocoding
- 🔲 Geofencing básico

---

### [03. Notificaciones](./03-notificaciones.md)

> **Tiempo estimado:** 60 minutos

Implementa notificaciones locales y push notifications para mantener a los usuarios informados.

**Contenido:**

- 🔔 Notificaciones locales
- ☁️ Push notifications (FCM)
- 📱 Canales de notificación
- 🎯 Acciones y deep linking
- ⏰ Notificaciones programadas
- 🔧 Configuración por plataforma

---

## 🎯 Objetivos de Aprendizaje

Al completar estos módulos, serás capaz de:

- [ ] Capturar fotos y videos con la cámara del dispositivo
- [ ] Seleccionar imágenes de la galería
- [ ] Obtener la ubicación actual del usuario
- [ ] Mostrar mapas interactivos con marcadores
- [ ] Implementar notificaciones locales
- [ ] Configurar push notifications con Firebase
- [ ] Manejar permisos de manera correcta
- [ ] Configurar cada plataforma (iOS/Android)

---

## 📦 Dependencias Principales

```yaml
dependencies:
  # Permisos
  permission_handler: ^11.1.0

  # Cámara y Galería
  image_picker: ^1.0.4
  camera: ^0.10.5+5

  # Geolocalización
  geolocator: ^10.1.0
  geocoding: ^2.1.1
  google_maps_flutter: ^2.5.0

  # Notificaciones
  flutter_local_notifications: ^16.1.0
  firebase_messaging: ^14.7.4
  firebase_core: ^2.24.2
```

---

## ⚠️ Configuración por Plataforma

### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<!-- Cámara -->
<uses-permission android:name="android.permission.CAMERA"/>
<uses-feature android:name="android.hardware.camera" android:required="true"/>

<!-- Galería -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>

<!-- Ubicación -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>

<!-- Notificaciones -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

### iOS (`ios/Runner/Info.plist`)

```xml
<!-- Cámara -->
<key>NSCameraUsageDescription</key>
<string>Esta app necesita acceso a la cámara para tomar fotos</string>

<!-- Galería -->
<key>NSPhotoLibraryUsageDescription</key>
<string>Esta app necesita acceso a la galería para seleccionar fotos</string>

<!-- Ubicación -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>Esta app necesita tu ubicación para mostrar lugares cercanos</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Esta app necesita tu ubicación en segundo plano</string>
```

---

## 📊 Flujo de Aprendizaje Recomendado

```
1. Leer módulo de Cámara/Galería
   ↓
2. Práctica 1: PhotoCapture
   ↓
3. Leer módulo de Geolocalización
   ↓
4. Práctica 2: LocationTracker
   ↓
5. Leer módulo de Notificaciones
   ↓
6. Práctica 3: NotificationManager
   ↓
7. Prácticas integradoras (4-5)
   ↓
8. Proyecto DeviceExplorer
```

---

## 🔗 Navegación

| Anterior               | Índice                   | Siguiente                    |
| ---------------------- | ------------------------ | ---------------------------- |
| [Assets](../0-assets/) | [Semana 8](../README.md) | [Prácticas](../2-practicas/) |
