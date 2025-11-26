# 📖 Glosario Semana 08 - Características Nativas y Plugins

## 📋 Índice Alfabético

- [A](#a) | [B](#b) | [C](#c) | [D](#d) | [E](#e) | [F](#f) | [G](#g)
- [H](#h) | [I](#i) | [J](#j) | [K](#k) | [L](#l) | [M](#m) | [N](#n)
- [O](#o) | [P](#p) | [Q](#q) | [R](#r) | [S](#s) | [T](#t)
- [U](#u) | [V](#v) | [W](#w) | [X](#x) | [Y](#y) | [Z](#z)

---

## A

### Accelerometer (Acelerómetro)
**Definición:** Sensor que mide la aceleración del dispositivo en tres ejes (X, Y, Z), incluyendo la gravedad.

**Uso en Flutter:**
```dart
accelerometerEvents.listen((event) {
  print('X: ${event.x}, Y: ${event.y}, Z: ${event.z}');
});
```

**Unidad:** m/s² (metros por segundo al cuadrado)

---

### APNs (Apple Push Notification service)
**Definición:** Servicio de Apple para enviar notificaciones push a dispositivos iOS, macOS, tvOS y watchOS.

**Relación:** Firebase Cloud Messaging actúa como intermediario con APNs para apps Flutter en iOS.

---

### API Key
**Definición:** Clave de identificación que autoriza el uso de servicios de terceros como Google Maps o Firebase.

**Seguridad:** 
- Nunca subir a repositorios públicos
- Usar restricciones por aplicación
- Almacenar en archivos de configuración ignorados por Git

---

## B

### Background Location
**Definición:** Capacidad de obtener la ubicación del dispositivo cuando la app está en segundo plano o cerrada.

**Consideraciones:**
- Requiere permisos especiales
- Mayor consumo de batería
- Configuración específica por plataforma

---

### BitmapDescriptor
**Definición:** Clase de Google Maps Flutter que define la imagen visual de un marcador en el mapa.

**Tipos:**
- `defaultMarker` - Marcador estándar
- `defaultMarkerWithHue` - Color personalizado
- `fromBytes` - Imagen personalizada

---

## C

### Camera Controller
**Definición:** Controlador que gestiona la cámara del dispositivo, permitiendo configurar resolución, enfoque, flash y captura.

**Ciclo de vida:**
1. Inicializar
2. Configurar
3. Usar
4. Dispose

---

### Channel (Notification Channel)
**Definición:** En Android 8+, categoría que agrupa notificaciones con comportamiento similar (sonido, vibración, importancia).

**Configuración:**
```dart
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance',
  'High Importance Notifications',
  importance: Importance.high,
);
```

---

### Compass (Brújula)
**Definición:** Funcionalidad que usa el magnetómetro para determinar la orientación hacia el norte magnético.

---

## D

### Data Message
**Definición:** Tipo de mensaje FCM que contiene solo datos personalizados, sin mostrar notificación automática.

**Características:**
- Siempre ejecuta código de la app
- Funciona en foreground y background
- Requiere manejo manual de UI

---

### Deep Linking
**Definición:** Técnica que permite abrir una pantalla específica de la app desde una notificación u otro origen externo.

---

## E

### Event Channel
**Definición:** Canal de comunicación en Platform Channels para recibir streams de eventos desde código nativo.

**Uso:** Ideal para datos continuos como ubicación o sensores.

---

## F

### FCM (Firebase Cloud Messaging)
**Definición:** Servicio de Firebase para enviar notificaciones push y mensajes de datos a dispositivos móviles y web.

**Componentes:**
- FCM Server
- Device Token
- Topics
- Conditions

---

### Flash Mode
**Definición:** Configuración del flash de la cámara.

**Opciones:**
- `FlashMode.off` - Apagado
- `FlashMode.auto` - Automático
- `FlashMode.always` - Siempre encendido
- `FlashMode.torch` - Linterna

---

### Foreground Service
**Definición:** Servicio de Android que ejecuta operaciones visibles al usuario con una notificación persistente.

**Uso:** Tracking de ubicación continuo, reproducción de música.

---

## G

### Geocoding
**Definición:** Proceso de convertir una dirección textual en coordenadas geográficas (latitud/longitud).

**Ejemplo:** "Barcelona, España" → (41.3851, 2.1734)

---

### Geofencing
**Definición:** Técnica que define zonas geográficas virtuales y detecta cuando el dispositivo entra o sale de ellas.

**Aplicaciones:**
- Recordatorios basados en ubicación
- Marketing por proximidad
- Automatización del hogar

---

### Geolocator
**Definición:** Package de Flutter para obtener la ubicación del dispositivo usando GPS, red y otros proveedores.

---

### GeoPoint
**Definición:** Estructura de datos que representa un punto geográfico con latitud y longitud.

---

### Gyroscope (Giroscopio)
**Definición:** Sensor que mide la velocidad de rotación del dispositivo en tres ejes.

**Unidad:** rad/s (radianes por segundo)

---

## H

### Heads-up Notification
**Definición:** Notificación que aparece como banner flotante en la parte superior de la pantalla, incluso sobre otras apps.

**Requisitos:** Alta prioridad/importancia en la configuración.

---

## I

### Image Picker
**Definición:** Package que permite seleccionar imágenes de la galería o capturar nuevas con la cámara.

**Opciones:**
- `pickImage` - Seleccionar/capturar imagen
- `pickVideo` - Seleccionar/capturar video
- `pickMultiImage` - Múltiples imágenes

---

### Info.plist
**Definición:** Archivo de configuración de iOS que contiene metadatos de la app, incluyendo descripciones de permisos.

**Keys comunes:**
- `NSCameraUsageDescription`
- `NSLocationWhenInUseUsageDescription`
- `NSPhotoLibraryUsageDescription`

---

## J

### JSON Payload
**Definición:** Datos estructurados en formato JSON que acompañan a una notificación para su procesamiento.

---

## K

### Keystore
**Definición:** Almacén seguro para claves criptográficas en Android, usado para firmar apps y proteger API keys.

---

## L

### LatLng
**Definición:** Clase que representa coordenadas geográficas en Google Maps Flutter.

```dart
final position = LatLng(41.3851, 2.1734); // Barcelona
```

---

### Local Notification
**Definición:** Notificación generada localmente por la app sin necesidad de servidor externo.

**Usos:**
- Recordatorios
- Alarmas
- Actualizaciones de estado

---

### Location Permission
**Definición:** Permiso que debe otorgar el usuario para acceder a su ubicación.

**Niveles:**
- `whenInUse` - Solo cuando la app está activa
- `always` - Incluso en background

---

## M

### Magnetometer
**Definición:** Sensor que mide el campo magnético ambiental, usado principalmente para brújulas.

**Unidad:** μT (microteslas)

---

### Marker
**Definición:** Elemento visual en un mapa que indica una ubicación específica.

**Propiedades:**
- Position
- Icon
- InfoWindow
- onTap callback

---

### Method Channel
**Definición:** Canal de comunicación en Platform Channels para llamadas de método punto a punto entre Dart y código nativo.

---

## N

### Notification Message
**Definición:** Tipo de mensaje FCM que muestra automáticamente una notificación al usuario.

**Comportamiento:**
- Foreground: requiere manejo manual
- Background: muestra automáticamente

---

## O

### OnTap Callback
**Definición:** Función que se ejecuta cuando el usuario toca una notificación, usado para navegación o acciones.

---

## P

### Payload
**Definición:** Datos adicionales adjuntos a una notificación que se pasan al handler cuando el usuario interactúa con ella.

---

### Permission
**Definición:** Autorización que el usuario debe conceder para que la app acceda a recursos del sistema.

**Estados:**
- `granted` - Concedido
- `denied` - Denegado
- `permanentlyDenied` - Bloqueado permanentemente
- `restricted` - Restringido (iOS)

---

### Platform Channel
**Definición:** Mecanismo de Flutter para comunicación bidireccional entre código Dart y código nativo (Java/Kotlin, Swift/Obj-C).

---

### Polyline
**Definición:** Línea compuesta por múltiples puntos que representa una ruta en el mapa.

---

### Push Notification
**Definición:** Notificación enviada desde un servidor remoto al dispositivo del usuario a través de un servicio como FCM.

---

## Q

### Quality (Image Quality)
**Definición:** Nivel de compresión al capturar o seleccionar imágenes.

**Rango:** 0-100 (0 = máxima compresión, 100 = sin compresión)

---

## R

### Resolution Preset
**Definición:** Configuración predefinida de resolución para la cámara.

**Opciones:** low, medium, high, veryHigh, ultraHigh, max

---

### Reverse Geocoding
**Definición:** Proceso inverso al geocoding: convertir coordenadas en una dirección legible.

**Ejemplo:** (41.3851, 2.1734) → "Las Ramblas, Barcelona, España"

---

## S

### Scheduled Notification
**Definición:** Notificación programada para mostrarse en una fecha y hora específicas.

---

### Sensor Event
**Definición:** Dato emitido por un sensor que contiene las lecturas en sus ejes.

---

### Silent Push
**Definición:** Notificación push que no muestra UI al usuario pero despierta la app para procesamiento en background.

---

## T

### Token (FCM Token)
**Definición:** Identificador único de un dispositivo para recibir notificaciones push.

**Características:**
- Puede cambiar
- Debe actualizarse en el servidor
- Único por instalación de app

---

### Topic (FCM Topic)
**Definición:** Canal de suscripción para enviar notificaciones a grupos de usuarios sin conocer sus tokens.

```dart
FirebaseMessaging.instance.subscribeToTopic('news');
```

---

## U

### User Accelerometer
**Definición:** Variante del acelerómetro que excluye la gravedad, mostrando solo la aceleración del usuario.

---

## V

### Vibration Pattern
**Definición:** Secuencia de tiempos (en milisegundos) que define el patrón de vibración de una notificación.

```dart
vibrationPattern: [0, 250, 250, 250]
```

---

## W

### Waypoint
**Definición:** Punto intermedio en una ruta entre origen y destino.

---

## X

### XFile
**Definición:** Clase que representa un archivo multiplataforma, retornada por image_picker.

**Propiedades:** path, name, mimeType, readAsBytes()

---

## Z

### Zoom (Maps)
**Definición:** Nivel de acercamiento del mapa.

**Rango típico:** 1 (mundo) - 21 (edificio individual)

---

### Zoned Schedule
**Definición:** Programación de notificaciones considerando la zona horaria del dispositivo.

```dart
await plugin.zonedSchedule(
  id,
  title,
  body,
  tz.TZDateTime.from(scheduledDate, tz.local),
  // ...
);
```

---

## 📊 Resumen de Packages Clave

| Package | Propósito | Términos Relacionados |
|---------|-----------|----------------------|
| `image_picker` | Fotos/Videos | XFile, Quality |
| `camera` | Control de cámara | Controller, ResolutionPreset, FlashMode |
| `geolocator` | Ubicación | LatLng, Permission, Accuracy |
| `google_maps_flutter` | Mapas | Marker, Polyline, BitmapDescriptor |
| `flutter_local_notifications` | Notificaciones locales | Channel, Payload, Scheduled |
| `firebase_messaging` | Push notifications | Token, Topic, FCM |
| `sensors_plus` | Sensores | Accelerometer, Gyroscope, Magnetometer |
| `permission_handler` | Permisos | Permission, Status |

---

## 🔗 Navegación

| Anterior | Índice | Siguiente |
|----------|--------|-----------|
| [Recursos](../4-recursos/README.md) | [Semana 08](../README.md) | [Semana 09](../../semana-09/README.md) |
