# 💻 Prácticas - Semana 8: Características Nativas y Plugins

## 📋 Índice de Prácticas

Esta carpeta contiene los ejercicios prácticos de la Semana 8, enfocados en la integración de características nativas del dispositivo.

---

## 🎯 Resumen de Prácticas

| #   | Práctica                           | Dificultad      | Tiempo | Tecnologías               |
| --- | ---------------------------------- | --------------- | ------ | ------------------------- |
| 1   | [PhotoCapture](#práctica-1)        | ⭐ Básica       | 30 min | image_picker, permissions |
| 2   | [LocationTracker](#práctica-2)     | ⭐⭐ Intermedia | 45 min | geolocator, google_maps   |
| 3   | [NotificationManager](#práctica-3) | ⭐⭐ Intermedia | 45 min | local_notifications       |
| 4   | [SensorDashboard](#práctica-4)     | ⭐⭐ Intermedia | 40 min | sensors_plus              |
| 5   | [DeviceIntegration](#práctica-5)   | ⭐⭐⭐ Avanzada | 50 min | Integración múltiple      |

---

## 📂 Archivos de Prácticas

### [Práctica 1: PhotoCapture](./practica-01-photo-capture.md)

> **Dificultad:** ⭐ Básica | **Tiempo:** 30 min

Crea una aplicación de captura y edición básica de fotos.

**Aprenderás:**

- Configurar permisos de cámara y galería
- Capturar fotos con image_picker
- Seleccionar imágenes de la galería
- Mostrar preview de imágenes
- Guardar imágenes localmente

---

### [Práctica 2: LocationTracker](./practica-02-location-tracker.md)

> **Dificultad:** ⭐⭐ Intermedia | **Tiempo:** 45 min

Desarrolla un rastreador de ubicación con mapa interactivo.

**Aprenderás:**

- Solicitar permisos de ubicación
- Obtener posición actual
- Stream de posiciones en tiempo real
- Integrar Google Maps
- Dibujar rutas en el mapa
- Calcular distancias

---

### [Práctica 3: NotificationManager](./practica-03-notification-manager.md)

> **Dificultad:** ⭐⭐ Intermedia | **Tiempo:** 45 min

Implementa un sistema completo de notificaciones locales.

**Aprenderás:**

- Configurar notificaciones locales
- Crear canales de notificación
- Notificaciones inmediatas y programadas
- Acciones en notificaciones
- Manejar taps y payloads

---

### [Práctica 4: SensorDashboard](./practica-04-sensor-dashboard.md)

> **Dificultad:** ⭐⭐ Intermedia | **Tiempo:** 40 min

Crea un dashboard que muestra datos de los sensores del dispositivo.

**Aprenderás:**

- Acceder al acelerómetro
- Leer datos del giroscopio
- Usar el magnetómetro
- Visualizar datos en tiempo real
- Detectar movimientos

---

### [Práctica 5: DeviceIntegration](./practica-05-device-integration.md)

> **Dificultad:** ⭐⭐⭐ Avanzada | **Tiempo:** 50 min

Integra múltiples características nativas en una app cohesiva.

**Aprenderás:**

- Combinar cámara + ubicación + notificaciones
- Crear fotos geolocalizadas
- Programar recordatorios basados en ubicación
- Arquitectura para features nativos
- Manejo centralizado de permisos

---

## 📦 Dependencias Comunes

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Permisos
  permission_handler: ^11.1.0

  # Cámara y Galería
  image_picker: ^1.0.4

  # Geolocalización
  geolocator: ^10.1.0
  google_maps_flutter: ^2.5.0
  geocoding: ^2.1.1

  # Notificaciones
  flutter_local_notifications: ^16.1.0
  timezone: ^0.9.2

  # Sensores
  sensors_plus: ^3.1.0

  # Almacenamiento
  path_provider: ^2.1.1
```

---

## 🎯 Objetivos de Aprendizaje

Al completar estas prácticas serás capaz de:

- [ ] Configurar permisos por plataforma (Android/iOS)
- [ ] Solicitar permisos al usuario correctamente
- [ ] Capturar y procesar imágenes
- [ ] Obtener y rastrear ubicación
- [ ] Mostrar mapas con marcadores y rutas
- [ ] Implementar notificaciones locales
- [ ] Acceder a sensores del dispositivo
- [ ] Integrar múltiples features nativos

---

## 📊 Progresión de Dificultad

```
Práctica 1: PhotoCapture
    │ (Fundamentos de permisos y cámara)
    ▼
Práctica 2: LocationTracker
    │ (Geolocalización y mapas)
    ▼
Práctica 3: NotificationManager
    │ (Sistema de notificaciones)
    ▼
Práctica 4: SensorDashboard
    │ (Sensores del dispositivo)
    ▼
Práctica 5: DeviceIntegration
    (Integración de todo lo aprendido)
```

---

## ✅ Checklist de Completitud

- [ ] Práctica 1: PhotoCapture completada
- [ ] Práctica 2: LocationTracker completada
- [ ] Práctica 3: NotificationManager completada
- [ ] Práctica 4: SensorDashboard completada
- [ ] Práctica 5: DeviceIntegration completada

---

## 🔗 Navegación

| Anterior               | Índice                   | Siguiente                  |
| ---------------------- | ------------------------ | -------------------------- |
| [Teoría](../1-teoria/) | [Semana 8](../README.md) | [Proyecto](../3-proyecto/) |
