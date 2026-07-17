# Semana 13 — APIs Nativas y Platform Channels

> **Fase 3 — Avanzado** | Semana 13 de 19 | ⏱️ 16 horas

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Solicitar y manejar permisos en runtime con `permission_handler` (incluida la denegación
      permanente)
- [ ] Capturar o elegir una foto con `image_picker` y mostrarla con `Image.file`
- [ ] Obtener la ubicación actual con `geolocator`, manejando su propia API de permisos
- [ ] Invocar código nativo Android desde Dart con un `MethodChannel` propio
- [ ] Manejar `PlatformException`/`MissingPluginException` y divergencia entre plataformas
- [ ] Envolver una API nativa en un repository para poder simularla en tests

## 📚 Requisitos previos

- Semana anterior completada
- Flutter SDK local configurado (`flutter doctor` sin errores) + Docker

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| `1-teoria/`       | Material teórico             | 4h     |
| `2-practicas/`    | Ejercicios guiados           | 6h     |
| `3-proyecto/`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

1. [Permisos con permission_handler](1-teoria/01-permisos-con-permission-handler.md)
2. [Cámara con image_picker](1-teoria/02-camara-con-image-picker.md)
3. [Geolocalización con geolocator](1-teoria/03-geolocalizacion-con-geolocator.md)
4. [Platform Channels: MethodChannel](1-teoria/04-platform-channels-methodchannel.md)
5. [Manejo de Errores de Plataforma](1-teoria/05-manejo-de-errores-de-plataforma.md)
6. [Buenas Prácticas: Permisos y Testing](1-teoria/06-buenas-practicas-permisos-y-testing.md)

### Prácticas

1. [Ejercicio 01 — permission_handler: Permiso de Cámara](2-practicas/ejercicio-01-permission-handler-camara/README.md)
2. [Ejercicio 02 — geolocator: Ubicación Actual](2-practicas/ejercicio-02-geolocator-ubicacion/README.md)
3. [Ejercicio 03 — Platform Channel: Nivel de Batería](2-practicas/ejercicio-03-platform-channel-bateria/README.md)

### Proyecto

[APIs Nativas y Platform Channels](3-proyecto/README.md) — agrega captura/selección de foto
(`permission_handler` + `image_picker`) al proyecto Clean Architecture de semanas 10-12.

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

[← Semana 12 — Animaciones Avanzadas](../week-12-animaciones_avanzadas/README.md) | [Semana 14 — Push Notifications →](../week-14-push_notifications/README.md)
