# 🎨 Assets - Semana 8: Características Nativas y Plugins

## 📁 Contenido

Esta carpeta contiene recursos visuales y diagramas para la Semana 8 del bootcamp.

## 📊 Diagramas Disponibles

| Archivo | Descripción | Uso |
|---------|-------------|-----|
| `01-arquitectura-plugins.svg` | Arquitectura de Platform Channels | Entender comunicación Flutter-Nativo |
| `02-permisos-flow.svg` | Flujo de solicitud de permisos | Implementar permisos correctamente |
| `03-camera-pipeline.svg` | Pipeline de captura de imagen | Proceso de cámara y galería |
| `04-location-stack.svg` | Stack de geolocalización | Capas de ubicación |
| `05-notifications-flow.svg` | Flujo de notificaciones | Local y push notifications |
| `06-sensors-overview.svg` | Overview de sensores | Tipos de sensores disponibles |

## 🎯 Cómo Usar

### En Markdown

```markdown
![Arquitectura Plugins](./0-assets/01-arquitectura-plugins.svg)
```

### En Flutter (para documentación)

```dart
/// Ver diagrama: semana-08/0-assets/01-arquitectura-plugins.svg
```

## 🎨 Especificaciones de Diseño

- **Fondo:** `#1E1E1E` (tema oscuro)
- **Colores principales:**
  - Azul: `#64B5F6`
  - Verde: `#81C784`
  - Naranja: `#FFB74D`
  - Rosa: `#F06292`
  - Púrpura: `#BA68C8`
  - Rojo: `#EF5350`
- **Texto:** `#E0E0E0` (claro), `#9E9E9E` (secundario)
- **Fuente:** Segoe UI, Arial, sans-serif
- **Sin gradientes:** Solo colores sólidos

## 📱 Temas Visualizados

### Platform Channels
- Method Channel
- Event Channel
- Basic Message Channel

### Permisos
- Estados: granted, denied, permanentlyDenied
- Flujo de solicitud
- Configuración de app settings

### Cámara y Galería
- Captura de foto/video
- Selección de imagen
- Procesamiento y compresión

### Geolocalización
- GPS, Network, Passive providers
- Foreground vs Background location
- Geofencing

### Notificaciones
- Locales vs Push
- Canales de notificación
- Acciones y payloads

---

## 🔗 Navegación

| Anterior | Índice | Siguiente |
|----------|--------|-----------|
| [Teoría](../1-teoria/) | [Semana 8](../README.md) | [Prácticas](../2-practicas/) |
