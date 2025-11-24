# Semana 8: Características Nativas y Plugins

## 🎯 Objetivos de Aprendizaje

- Integrar funcionalidades nativas del dispositivo
- Usar la cámara y galería
- Implementar geolocalización
- Gestionar notificaciones
- Acceder a sensores del dispositivo
- Manejar permisos de manera efectiva

## 📚 Contenido Teórico

### 1. Permisos (1.5 horas)

#### Permission Handler

```yaml
dependencies:
  permission_handler: ^11.1.0
```

#### Solicitar Permisos

```dart
import 'package:permission_handler/permission_handler.dart';

Future<bool> solicitarPermisoCamara() async {
  final status = await Permission.camera.status;

  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    final result = await Permission.camera.request();
    return result.isGranted;
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
    return false;
  }
  return false;
}

// Múltiples permisos
Future<void> solicitarPermisos() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
    Permission.location,
  ].request();

  print(statuses[Permission.camera]);
}
```

#### Configurar Android

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

#### Configurar iOS

```xml
<!-- ios/Runner/Info.plist -->
<key>NSCameraUsageDescription</key>
<string>Necesitamos acceso a la cámara</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Necesitamos tu ubicación</string>
```

### 2. Cámara y Galería (2 horas)

#### Image Picker

```yaml
dependencies:
  image_picker: ^1.0.5
```

#### Usar Cámara

```dart
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final ImagePicker _picker = ImagePicker();

// Tomar foto
Future<File?> tomarFoto() async {
  final XFile? image = await _picker.pickImage(
    source: ImageSource.camera,
    maxWidth: 1920,
    maxHeight: 1080,
    imageQuality: 85,
  );

  if (image != null) {
    return File(image.path);
  }
  return null;
}

// Seleccionar de galería
Future<File?> seleccionarImagen() async {
  final XFile? image = await _picker.pickImage(
    source: ImageSource.gallery,
  );

  if (image != null) {
    return File(image.path);
  }
  return null;
}

// Múltiples imágenes
Future<List<File>> seleccionarMultiples() async {
  final List<XFile> images = await _picker.pickMultiImage();
  return images.map((xfile) => File(xfile.path)).toList();
}

// Video
Future<File?> grabarVideo() async {
  final XFile? video = await _picker.pickVideo(
    source: ImageSource.camera,
    maxDuration: Duration(seconds: 30),
  );

  if (video != null) {
    return File(video.path);
  }
  return null;
}
```

#### Image Cropper

```yaml
dependencies:
  image_cropper: ^5.0.1
```

```dart
Future<File?> recortarImagen(File imagen) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imagen.path,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Recortar',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
      ),
      IOSUiSettings(
        title: 'Recortar',
      ),
    ],
  );

  if (croppedFile != null) {
    return File(croppedFile.path);
  }
  return null;
}
```

### 3. Geolocalización (2 horas)

#### Geolocator

```yaml
dependencies:
  geolocator: ^10.1.0
```

#### Obtener Ubicación

```dart
import 'package:geolocator/geolocator.dart';

// Verificar servicios
Future<bool> verificarServiciosUbicacion() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }

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

// Obtener posición actual
Future<Position?> obtenerUbicacionActual() async {
  bool servicioOk = await verificarServiciosUbicacion();
  if (!servicioOk) return null;

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return position;
}

// Escuchar cambios de ubicación
StreamSubscription<Position>? positionStream;

void iniciarSeguimiento() {
  positionStream = Geolocator.getPositionStream(
    locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // metros
    ),
  ).listen((Position position) {
    print('${position.latitude}, ${position.longitude}');
  });
}

void detenerSeguimiento() {
  positionStream?.cancel();
}

// Calcular distancia
double calcularDistancia(
  double lat1, double lon1,
  double lat2, double lon2,
) {
  return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
}
```

#### Google Maps

```yaml
dependencies:
  google_maps_flutter: ^2.5.0
```

```dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  @override
  _MapaScreenState createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(4.7110, -74.0721), // Bogotá
        zoom: 12,
      ),
      onMapCreated: (controller) {
        mapController = controller;
      },
      markers: markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }

  void agregarMarcador(LatLng posicion) {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId('marker_${markers.length}'),
          position: posicion,
          infoWindow: InfoWindow(
            title: 'Marcador',
            snippet: 'Descripción',
          ),
        ),
      );
    });
  }
}
```

### 4. Notificaciones (2.5 horas)

#### Flutter Local Notifications

```yaml
dependencies:
  flutter_local_notifications: ^16.3.0
```

#### Configuración

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacionesService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> inicializar() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );
  }

  static void onNotificationTap(NotificationResponse response) {
    // Manejar tap en notificación
    print('Notificación presionada: ${response.payload}');
  }

  // Notificación simple
  static Future<void> mostrarNotificacion({
    required int id,
    required String titulo,
    required String cuerpo,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'Descripción del canal',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails =
        DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(id, titulo, cuerpo, details, payload: payload);
  }

  // Notificación programada
  static Future<void> programarNotificacion({
    required int id,
    required String titulo,
    required String cuerpo,
    required DateTime fechaHora,
  }) async {
    await _notifications.zonedSchedule(
      id,
      titulo,
      cuerpo,
      tz.TZDateTime.from(fechaHora, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_channel',
          'Notificaciones Programadas',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Notificación periódica
  static Future<void> notificacionPeriodica() async {
    await _notifications.periodicallyShow(
      0,
      'Recordatorio',
      'No olvides completar tu tarea',
      RepeatInterval.daily,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'periodic_channel',
          'Notificaciones Periódicas',
        ),
      ),
    );
  }

  // Cancelar notificación
  static Future<void> cancelar(int id) async {
    await _notifications.cancel(id);
  }

  // Cancelar todas
  static Future<void> cancelarTodas() async {
    await _notifications.cancelAll();
  }
}
```

### 5. Otros Plugins Útiles (bonus)

#### URL Launcher

```dart
// Abrir URL, teléfono, email
import 'package:url_launcher/url_launcher.dart';

Future<void> abrirURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

Future<void> llamarTelefono(String numero) async {
  final Uri uri = Uri.parse('tel:$numero');
  await launchUrl(uri);
}
```

#### Share

```dart
// Compartir contenido
import 'package:share_plus/share_plus.dart';

void compartirTexto(String texto) {
  Share.share(texto);
}

void compartirArchivo(String path) {
  Share.shareXFiles([XFile(path)]);
}
```

## 💻 Ejercicios Prácticos

### Ejercicio 1: Gestor de Permisos

Crea una pantalla de configuración que:

- Muestre estado de todos los permisos
- Permita solicitar cada permiso
- Explique por qué se necesita cada uno
- Redirija a configuración si es necesario

### Ejercicio 2: Editor de Fotos Básico

Desarrolla app para:

- Tomar foto o seleccionar de galería
- Recortar imagen
- Aplicar filtros básicos
- Guardar resultado localmente

### Ejercicio 3: Rastreador de Ubicación

Implementa app que:

- Muestre ubicación actual en mapa
- Trace ruta mientras camina
- Calcule distancia recorrida
- Guarde rutas históricas

### Ejercicio 4: Sistema de Recordatorios

Crea app de recordatorios con:

- Crear recordatorio con fecha/hora
- Notificación en el momento indicado
- Lista de recordatorios pendientes
- Cancelar recordatorios

### Ejercicio 5: Scanner de QR

Desarrolla:

- Lector de códigos QR
- Generador de códigos QR
- Historial de escaneos
- Compartir códigos

## 🔨 Proyecto de la Semana

**App de Red Social de Fotos (Instagram-like)**

Desarrolla una aplicación social con todas las características nativas:

**Características:**

1. **Captura de Contenido**

   - Tomar foto con cámara
   - Seleccionar de galería
   - Recortar y editar foto
   - Agregar filtros
   - Grabar video corto (15s)

2. **Publicaciones**

   - Crear post con foto/video
   - Agregar descripción
   - Etiquetar ubicación (mapa)
   - Agregar hashtags
   - Compartir

3. **Geolocalización**

   - Obtener ubicación actual
   - Mostrar mapa en publicación
   - Explorar publicaciones cercanas
   - Mapa con pins de publicaciones

4. **Notificaciones**

   - Notificación cuando alguien comenta
   - Notificación de nuevos seguidores
   - Recordatorio para publicar
   - Notificaciones programadas

5. **Feed de Publicaciones**

   - Lista de publicaciones
   - Doble tap para like
   - Comentarios
   - Compartir
   - Guardar favoritos

6. **Perfil de Usuario**
   - Foto de perfil (editable)
   - Grid de publicaciones
   - Contador de posts
   - Bio editable

**Requisitos técnicos:**

```dart
// Modelos
class Publicacion {
  final String id;
  final String usuarioId;
  final String imagenUrl;
  final String descripcion;
  final List<String> hashtags;
  final Ubicacion? ubicacion;
  final DateTime fecha;
  int likes;
  List<Comentario> comentarios;
}

class Ubicacion {
  final double latitud;
  final double longitud;
  final String? nombre;
}

class Usuario {
  final String id;
  final String nombre;
  final String username;
  final String? fotoUrl;
  final String? bio;
  int seguidores;
  int siguiendo;
}

// Servicios
class CamaraService {
  Future<File?> tomarFoto() async { }
  Future<File?> seleccionarImagen() async { }
  Future<File?> editarImagen(File imagen) async { }
}

class UbicacionService {
  Future<Ubicacion?> obtenerUbicacionActual() async { }
  Future<List<Publicacion>> obtenerPublicacionesCercanas() async { }
}

class NotificacionesService {
  Future<void> notificarNuevoLike(String usuarioId) async { }
  Future<void> notificarNuevoComentario(String usuarioId) async { }
  Future<void> recordatorioPublicar() async { }
}
```

**Pantallas:**

1. Feed principal
2. Cámara/Editor
3. Crear publicación
4. Detalle de publicación
5. Mapa de publicaciones
6. Perfil de usuario
7. Configuración de notificaciones

**Funcionalidades adicionales:**

- Stories (24h)
- Modo oscuro
- Múltiples idiomas
- Compartir a otras apps
- Descargar publicaciones

## 📖 Recursos

### Documentación

- [Image Picker](https://pub.dev/packages/image_picker)
- [Geolocator](https://pub.dev/packages/geolocator)
- [Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [Permission Handler](https://pub.dev/packages/permission_handler)
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)

### Paquetes Útiles

- [camera](https://pub.dev/packages/camera)
- [image_picker](https://pub.dev/packages/image_picker)
- [image_cropper](https://pub.dev/packages/image_cropper)
- [geolocator](https://pub.dev/packages/geolocator)
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter)
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- [permission_handler](https://pub.dev/packages/permission_handler)
- [url_launcher](https://pub.dev/packages/url_launcher)
- [share_plus](https://pub.dev/packages/share_plus)
- [qr_code_scanner](https://pub.dev/packages/qr_code_scanner)

## ✅ Checklist de Completitud

- [ ] Ejercicio 1: Gestor de permisos completado
- [ ] Ejercicio 2: Editor de fotos completado
- [ ] Ejercicio 3: Rastreador completado
- [ ] Ejercicio 4: Recordatorios completado
- [ ] Ejercicio 5: Scanner QR completado
- [ ] Proyecto: Red social completado
- [ ] Permisos configurados correctamente
- [ ] Funcionalidades nativas probadas
- [ ] App probada en dispositivo físico
- [ ] Código subido al repositorio

## 🎓 Evaluación

- **Ejercicios prácticos (1-5):** 30%
- **Proyecto de la semana:** 60%
- **Integración de funcionalidades nativas:** 10%

## 📝 Notas Importantes

- Siempre verificar permisos antes de usar funcionalidad
- Probar en dispositivos físicos (emuladores tienen limitaciones)
- Manejar errores de permisos denegados
- Considerar diferentes versiones de Android/iOS
- Probar notificaciones en segundo plano

## 🔧 Tips

```dart
// Verificar si está en emulador
import 'dart:io';
bool get esEmulador => !Platform.isAndroid && !Platform.isIOS;

// Optimizar imágenes antes de guardar
import 'package:image/image.dart' as img;

Future<File> comprimirImagen(File file) async {
  final bytes = await file.readAsBytes();
  final image = img.decodeImage(bytes);
  final compressed = img.encodeJpg(image!, quality: 85);
  return await file.writeAsBytes(compressed);
}

// Manejar lifecycle de ubicación
@override
void dispose() {
  positionStream?.cancel();
  super.dispose();
}
```

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 7](../semana-07/README.md) | **Siguiente:** [Semana 9 →](../semana-09/README.md)
