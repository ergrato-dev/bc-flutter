# 📷 Cámara y Galería en Flutter

## 🎯 Objetivos del Módulo

Al completar este módulo, serás capaz de:

- [ ] Capturar fotos usando la cámara del dispositivo
- [ ] Grabar videos con control de calidad
- [ ] Seleccionar imágenes de la galería
- [ ] Procesar y comprimir imágenes
- [ ] Manejar permisos de cámara y almacenamiento
- [ ] Implementar preview de cámara en tiempo real

---

## 📦 Paquetes Principales

### image_picker (Recomendado para empezar)

> Solución simple para captura y selección de imágenes

```yaml
dependencies:
  image_picker: ^1.0.4
```

### camera (Control avanzado)

> Control completo sobre la cámara para casos más complejos

```yaml
dependencies:
  camera: ^0.10.5+5
```

---

## 1️⃣ image_picker: Captura Simple

### Configuración Inicial

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Permisos -->
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
    
    <!-- Feature requerida -->
    <uses-feature android:name="android.hardware.camera" android:required="false"/>
    
    <application>
        <!-- File Provider para Android 10+ -->
        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/file_paths"/>
        </provider>
    </application>
</manifest>
```

#### iOS (`ios/Runner/Info.plist`)

```xml
<dict>
    <key>NSCameraUsageDescription</key>
    <string>Esta app necesita acceso a la cámara para tomar fotos</string>
    
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Esta app necesita acceso a la galería para seleccionar fotos</string>
    
    <key>NSMicrophoneUsageDescription</key>
    <string>Esta app necesita acceso al micrófono para grabar videos</string>
</dict>
```

---

### Implementación Básica

```dart
/**
 * ImagePickerService
 * 
 * ¿Qué hace?
 * Servicio que encapsula la funcionalidad de captura y selección de imágenes.
 * 
 * ¿Para qué?
 * Centralizar la lógica de manejo de imágenes, facilitando su reutilización
 * en diferentes partes de la aplicación.
 * 
 * ¿Cómo funciona?
 * 1. Utiliza image_picker para acceder a cámara/galería
 * 2. Maneja los permisos automáticamente
 * 3. Devuelve la imagen seleccionada o null si se cancela
 */

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // Instancia singleton del picker
  final ImagePicker _picker = ImagePicker();
  
  /// Captura una foto desde la cámara
  /// 
  /// [maxWidth] - Ancho máximo de la imagen (opcional)
  /// [maxHeight] - Alto máximo de la imagen (opcional)
  /// [quality] - Calidad de compresión 0-100 (default: 80)
  /// 
  /// Retorna el archivo de imagen o null si se cancela
  Future<File?> capturePhoto({
    double? maxWidth,
    double? maxHeight,
    int quality = 80,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
        preferredCameraDevice: CameraDevice.rear, // Cámara trasera
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error al capturar foto: $e');
      return null;
    }
  }
  
  /// Selecciona una imagen de la galería
  Future<File?> pickFromGallery({
    double? maxWidth,
    double? maxHeight,
    int quality = 80,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error al seleccionar imagen: $e');
      return null;
    }
  }
  
  /// Selecciona múltiples imágenes de la galería
  Future<List<File>> pickMultipleImages({
    double? maxWidth,
    double? maxHeight,
    int quality = 80,
    int? limit,
  }) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
        limit: limit,
      );
      
      return images.map((xFile) => File(xFile.path)).toList();
    } catch (e) {
      print('Error al seleccionar imágenes: $e');
      return [];
    }
  }
  
  /// Graba un video desde la cámara
  /// 
  /// [maxDuration] - Duración máxima del video
  Future<File?> recordVideo({
    Duration? maxDuration,
    CameraDevice preferredCamera = CameraDevice.rear,
  }) async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: maxDuration,
        preferredCameraDevice: preferredCamera,
      );
      
      if (video != null) {
        return File(video.path);
      }
      return null;
    } catch (e) {
      print('Error al grabar video: $e');
      return null;
    }
  }
  
  /// Selecciona un video de la galería
  Future<File?> pickVideoFromGallery({
    Duration? maxDuration,
  }) async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: maxDuration,
      );
      
      if (video != null) {
        return File(video.path);
      }
      return null;
    } catch (e) {
      print('Error al seleccionar video: $e');
      return null;
    }
  }
}
```

---

### Widget de Captura de Imagen

```dart
/**
 * ImageCaptureWidget
 * 
 * Widget reutilizable para capturar o seleccionar imágenes.
 * Muestra un diálogo con opciones de cámara y galería.
 */

import 'dart:io';
import 'package:flutter/material.dart';

class ImageCaptureWidget extends StatefulWidget {
  final Function(File) onImageSelected;
  final double? maxWidth;
  final double? maxHeight;
  final int quality;
  final Widget? placeholder;
  
  const ImageCaptureWidget({
    Key? key,
    required this.onImageSelected,
    this.maxWidth = 1024,
    this.maxHeight = 1024,
    this.quality = 80,
    this.placeholder,
  }) : super(key: key);
  
  @override
  State<ImageCaptureWidget> createState() => _ImageCaptureWidgetState();
}

class _ImageCaptureWidgetState extends State<ImageCaptureWidget> {
  final ImagePickerService _imageService = ImagePickerService();
  File? _selectedImage;
  bool _isLoading = false;
  
  /// Muestra el diálogo de opciones
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle visual
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Título
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Seleccionar imagen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              // Opción: Cámara
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
                title: const Text('Tomar foto'),
                subtitle: const Text('Usar la cámara del dispositivo'),
                onTap: () {
                  Navigator.pop(context);
                  _captureFromCamera();
                },
              ),
              
              // Opción: Galería
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.photo_library, color: Colors.white),
                ),
                title: const Text('Elegir de galería'),
                subtitle: const Text('Seleccionar imagen existente'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery();
                },
              ),
              
              // Cancelar
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Captura imagen desde la cámara
  Future<void> _captureFromCamera() async {
    setState(() => _isLoading = true);
    
    final image = await _imageService.capturePhoto(
      maxWidth: widget.maxWidth,
      maxHeight: widget.maxHeight,
      quality: widget.quality,
    );
    
    setState(() => _isLoading = false);
    
    if (image != null) {
      setState(() => _selectedImage = image);
      widget.onImageSelected(image);
    }
  }
  
  /// Selecciona imagen de la galería
  Future<void> _pickFromGallery() async {
    setState(() => _isLoading = true);
    
    final image = await _imageService.pickFromGallery(
      maxWidth: widget.maxWidth,
      maxHeight: widget.maxHeight,
      quality: widget.quality,
    );
    
    setState(() => _isLoading = false);
    
    if (image != null) {
      setState(() => _selectedImage = image);
      widget.onImageSelected(image);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : _showImageSourceDialog,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[400]!,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: _buildContent(),
      ),
    );
  }
  
  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_selectedImage != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Imagen seleccionada
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
            ),
          ),
          // Botón para cambiar
          Positioned(
            right: 8,
            bottom: 8,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.edit, size: 18),
                color: Colors.white,
                onPressed: _showImageSourceDialog,
              ),
            ),
          ),
        ],
      );
    }
    
    // Placeholder
    return widget.placeholder ?? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_a_photo,
          size: 48,
          color: Colors.grey[500],
        ),
        const SizedBox(height: 8),
        Text(
          'Agregar imagen',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
```

---

## 2️⃣ camera: Control Avanzado

### Cuándo Usar camera en lugar de image_picker

| Caso de Uso | image_picker | camera |
|-------------|--------------|--------|
| Captura simple de fotos | ✅ | ❌ |
| Selección de galería | ✅ | ❌ |
| Preview en tiempo real | ❌ | ✅ |
| Controles de cámara (zoom, flash) | ❌ | ✅ |
| Filtros en vivo | ❌ | ✅ |
| QR Scanner | ❌ | ✅ |
| Video streaming | ❌ | ✅ |

### Implementación con camera

```dart
/**
 * CameraService
 * 
 * Servicio para control avanzado de la cámara.
 * Permite preview en tiempo real, zoom, flash, y más.
 */

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CameraService {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  int _currentCameraIndex = 0;
  
  /// Getters
  bool get isInitialized => _isInitialized;
  CameraController? get controller => _controller;
  bool get isRecording => _controller?.value.isRecordingVideo ?? false;
  
  /// Inicializa las cámaras disponibles
  Future<void> initialize({
    ResolutionPreset resolution = ResolutionPreset.high,
    bool enableAudio = true,
  }) async {
    try {
      // Obtener cámaras disponibles
      _cameras = await availableCameras();
      
      if (_cameras.isEmpty) {
        throw CameraException('NO_CAMERAS', 'No se encontraron cámaras');
      }
      
      // Inicializar con la cámara trasera por defecto
      await _initializeCamera(
        _cameras[_currentCameraIndex],
        resolution,
        enableAudio,
      );
    } catch (e) {
      print('Error al inicializar cámara: $e');
      rethrow;
    }
  }
  
  Future<void> _initializeCamera(
    CameraDescription camera,
    ResolutionPreset resolution,
    bool enableAudio,
  ) async {
    // Liberar controlador anterior
    await _controller?.dispose();
    
    _controller = CameraController(
      camera,
      resolution,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    
    await _controller!.initialize();
    _isInitialized = true;
  }
  
  /// Cambia entre cámara frontal y trasera
  Future<void> switchCamera({
    ResolutionPreset resolution = ResolutionPreset.high,
    bool enableAudio = true,
  }) async {
    if (_cameras.length < 2) return;
    
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
    _isInitialized = false;
    
    await _initializeCamera(
      _cameras[_currentCameraIndex],
      resolution,
      enableAudio,
    );
  }
  
  /// Captura una foto
  Future<File?> takePicture() async {
    if (!_isInitialized || _controller == null) {
      throw CameraException('NOT_INITIALIZED', 'Cámara no inicializada');
    }
    
    try {
      // Capturar imagen
      final XFile image = await _controller!.takePicture();
      
      // Mover a directorio de documentos
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = path.join(directory.path, fileName);
      
      final File savedFile = File(image.path);
      return await savedFile.copy(savedPath);
    } catch (e) {
      print('Error al tomar foto: $e');
      return null;
    }
  }
  
  /// Inicia grabación de video
  Future<void> startVideoRecording() async {
    if (!_isInitialized || _controller == null) return;
    if (_controller!.value.isRecordingVideo) return;
    
    try {
      await _controller!.startVideoRecording();
    } catch (e) {
      print('Error al iniciar grabación: $e');
    }
  }
  
  /// Detiene grabación y retorna el archivo
  Future<File?> stopVideoRecording() async {
    if (!_isInitialized || _controller == null) return null;
    if (!_controller!.value.isRecordingVideo) return null;
    
    try {
      final XFile video = await _controller!.stopVideoRecording();
      
      // Mover a directorio de documentos
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final savedPath = path.join(directory.path, fileName);
      
      final File savedFile = File(video.path);
      return await savedFile.copy(savedPath);
    } catch (e) {
      print('Error al detener grabación: $e');
      return null;
    }
  }
  
  /// Controles de cámara
  
  /// Establece el nivel de zoom
  Future<void> setZoomLevel(double zoom) async {
    if (!_isInitialized || _controller == null) return;
    
    final minZoom = await _controller!.getMinZoomLevel();
    final maxZoom = await _controller!.getMaxZoomLevel();
    
    final clampedZoom = zoom.clamp(minZoom, maxZoom);
    await _controller!.setZoomLevel(clampedZoom);
  }
  
  /// Obtiene los límites de zoom
  Future<(double min, double max)> getZoomLimits() async {
    if (!_isInitialized || _controller == null) return (1.0, 1.0);
    
    final minZoom = await _controller!.getMinZoomLevel();
    final maxZoom = await _controller!.getMaxZoomLevel();
    return (minZoom, maxZoom);
  }
  
  /// Cambia el modo de flash
  Future<void> setFlashMode(FlashMode mode) async {
    if (!_isInitialized || _controller == null) return;
    await _controller!.setFlashMode(mode);
  }
  
  /// Establece el punto de enfoque
  Future<void> setFocusPoint(Offset point) async {
    if (!_isInitialized || _controller == null) return;
    await _controller!.setFocusPoint(point);
  }
  
  /// Establece el punto de exposición
  Future<void> setExposurePoint(Offset point) async {
    if (!_isInitialized || _controller == null) return;
    await _controller!.setExposurePoint(point);
  }
  
  /// Libera recursos
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
    _isInitialized = false;
  }
}
```

---

### Widget de Preview de Cámara

```dart
/**
 * CameraPreviewWidget
 * 
 * Widget que muestra el preview de la cámara en tiempo real
 * con controles para captura, zoom, flash y cambio de cámara.
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewWidget extends StatefulWidget {
  final Function(File) onPhotoTaken;
  final Function(File)? onVideoRecorded;
  final bool allowVideo;
  
  const CameraPreviewWidget({
    Key? key,
    required this.onPhotoTaken,
    this.onVideoRecorded,
    this.allowVideo = false,
  }) : super(key: key);
  
  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  final CameraService _cameraService = CameraService();
  bool _isInitializing = true;
  String? _error;
  double _currentZoom = 1.0;
  double _minZoom = 1.0;
  double _maxZoom = 1.0;
  FlashMode _flashMode = FlashMode.auto;
  bool _isRecording = false;
  
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }
  
  Future<void> _initializeCamera() async {
    try {
      await _cameraService.initialize();
      final zoomLimits = await _cameraService.getZoomLimits();
      
      setState(() {
        _isInitializing = false;
        _minZoom = zoomLimits.$1;
        _maxZoom = zoomLimits.$2;
      });
    } catch (e) {
      setState(() {
        _isInitializing = false;
        _error = e.toString();
      });
    }
  }
  
  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }
  
  /// Captura foto
  Future<void> _takePicture() async {
    final file = await _cameraService.takePicture();
    if (file != null) {
      widget.onPhotoTaken(file);
    }
  }
  
  /// Toggle grabación de video
  Future<void> _toggleVideoRecording() async {
    if (!widget.allowVideo) return;
    
    if (_isRecording) {
      final file = await _cameraService.stopVideoRecording();
      setState(() => _isRecording = false);
      if (file != null && widget.onVideoRecorded != null) {
        widget.onVideoRecorded!(file);
      }
    } else {
      await _cameraService.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }
  
  /// Cambia el modo de flash
  void _toggleFlash() {
    setState(() {
      switch (_flashMode) {
        case FlashMode.off:
          _flashMode = FlashMode.auto;
          break;
        case FlashMode.auto:
          _flashMode = FlashMode.always;
          break;
        case FlashMode.always:
        case FlashMode.torch:
          _flashMode = FlashMode.off;
          break;
      }
    });
    _cameraService.setFlashMode(_flashMode);
  }
  
  IconData _getFlashIcon() {
    switch (_flashMode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
      case FlashMode.torch:
        return Icons.flash_on;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeCamera,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }
    
    final controller = _cameraService.controller;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: Text('Cámara no disponible'));
    }
    
    return Stack(
      fit: StackFit.expand,
      children: [
        // Preview de cámara
        GestureDetector(
          onScaleUpdate: (details) {
            final newZoom = (_currentZoom * details.scale).clamp(_minZoom, _maxZoom);
            _cameraService.setZoomLevel(newZoom);
            setState(() => _currentZoom = newZoom);
          },
          onTapDown: (details) {
            // Enfoque en el punto tocado
            final size = MediaQuery.of(context).size;
            final point = Offset(
              details.localPosition.dx / size.width,
              details.localPosition.dy / size.height,
            );
            _cameraService.setFocusPoint(point);
          },
          child: CameraPreview(controller),
        ),
        
        // Controles superiores
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cerrar
                CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                
                // Flash
                CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: Icon(_getFlashIcon(), color: Colors.white),
                    onPressed: _toggleFlash,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Indicador de grabación
        if (_isRecording)
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.fiber_manual_record, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text('REC', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        
        // Slider de zoom
        if (_maxZoom > _minZoom)
          Positioned(
            right: 16,
            top: 150,
            bottom: 150,
            child: RotatedBox(
              quarterTurns: -1,
              child: Slider(
                value: _currentZoom,
                min: _minZoom,
                max: _maxZoom,
                onChanged: (value) {
                  _cameraService.setZoomLevel(value);
                  setState(() => _currentZoom = value);
                },
              ),
            ),
          ),
        
        // Controles inferiores
        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Galería (placeholder)
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.black45,
                  child: Icon(Icons.photo_library, color: Colors.white),
                ),
                
                // Botón de captura
                GestureDetector(
                  onTap: _takePicture,
                  onLongPress: widget.allowVideo ? _toggleVideoRecording : null,
                  onLongPressUp: widget.allowVideo && _isRecording 
                      ? _toggleVideoRecording 
                      : null,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isRecording ? Colors.red : Colors.white,
                        width: 4,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isRecording ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ),
                
                // Cambiar cámara
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
                    onPressed: () async {
                      await _cameraService.switchCamera();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
```

---

## 3️⃣ Procesamiento de Imágenes

### Compresión y Redimensionamiento

```dart
/**
 * ImageProcessor
 * 
 * Utilidades para procesar imágenes:
 * compresión, redimensionamiento, rotación, etc.
 */

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageProcessor {
  
  /// Comprime una imagen manteniendo la calidad
  /// 
  /// [file] - Archivo de imagen original
  /// [quality] - Calidad de compresión (0-100)
  /// [maxWidth] - Ancho máximo opcional
  /// [maxHeight] - Alto máximo opcional
  static Future<File?> compress({
    required File file,
    int quality = 80,
    int? maxWidth,
    int? maxHeight,
  }) async {
    try {
      // Leer bytes de la imagen
      final bytes = await file.readAsBytes();
      
      // Decodificar imagen
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return null;
      
      // Redimensionar si es necesario
      if (maxWidth != null || maxHeight != null) {
        image = img.copyResize(
          image,
          width: maxWidth,
          height: maxHeight,
          maintainAspect: true,
        );
      }
      
      // Codificar con compresión
      final compressedBytes = img.encodeJpg(image, quality: quality);
      
      // Guardar archivo comprimido
      final directory = await getTemporaryDirectory();
      final fileName = 'compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final outputPath = path.join(directory.path, fileName);
      
      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(compressedBytes);
      
      return outputFile;
    } catch (e) {
      print('Error al comprimir imagen: $e');
      return null;
    }
  }
  
  /// Redimensiona una imagen
  static Future<File?> resize({
    required File file,
    required int width,
    int? height,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return null;
      
      image = img.copyResize(
        image,
        width: width,
        height: height,
        maintainAspect: height == null,
      );
      
      final resizedBytes = img.encodeJpg(image, quality: 90);
      
      final directory = await getTemporaryDirectory();
      final fileName = 'resized_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final outputPath = path.join(directory.path, fileName);
      
      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(resizedBytes);
      
      return outputFile;
    } catch (e) {
      print('Error al redimensionar: $e');
      return null;
    }
  }
  
  /// Genera un thumbnail
  static Future<File?> createThumbnail({
    required File file,
    int size = 150,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return null;
      
      // Crear thumbnail cuadrado
      final thumbnail = img.copyResizeCropSquare(image, size: size);
      
      final thumbnailBytes = img.encodeJpg(thumbnail, quality: 80);
      
      final directory = await getTemporaryDirectory();
      final fileName = 'thumb_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final outputPath = path.join(directory.path, fileName);
      
      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(thumbnailBytes);
      
      return outputFile;
    } catch (e) {
      print('Error al crear thumbnail: $e');
      return null;
    }
  }
  
  /// Rota una imagen
  static Future<File?> rotate({
    required File file,
    required int angle, // 90, 180, 270
  }) async {
    try {
      final bytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return null;
      
      image = img.copyRotate(image, angle: angle.toDouble());
      
      final rotatedBytes = img.encodeJpg(image, quality: 90);
      
      final directory = await getTemporaryDirectory();
      final fileName = 'rotated_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final outputPath = path.join(directory.path, fileName);
      
      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(rotatedBytes);
      
      return outputFile;
    } catch (e) {
      print('Error al rotar imagen: $e');
      return null;
    }
  }
  
  /// Obtiene las dimensiones de una imagen
  static Future<Size?> getImageDimensions(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return null;
      
      return Size(image.width.toDouble(), image.height.toDouble());
    } catch (e) {
      return null;
    }
  }
  
  /// Calcula el tamaño del archivo en formato legible
  static String getFileSizeString(File file) {
    final bytes = file.lengthSync();
    
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
```

---

## 4️⃣ Manejo de Permisos

### PermissionHandler para Cámara y Galería

```dart
/**
 * CameraPermissionHandler
 * 
 * Maneja los permisos de cámara y almacenamiento
 * de forma centralizada.
 */

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermissionHandler {
  
  /// Solicita permiso de cámara
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.status;
    
    if (status.isGranted) {
      return true;
    }
    
    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }
    
    if (status.isPermanentlyDenied) {
      // El usuario denegó permanentemente, abrir configuración
      return false;
    }
    
    return false;
  }
  
  /// Solicita permiso de galería/fotos
  static Future<bool> requestPhotosPermission() async {
    // En Android 13+ se usa Permission.photos
    // En versiones anteriores se usa Permission.storage
    Permission permission;
    
    if (await Permission.photos.status.isDenied) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }
    
    final status = await permission.status;
    
    if (status.isGranted || status.isLimited) {
      return true;
    }
    
    if (status.isDenied) {
      final result = await permission.request();
      return result.isGranted || result.isLimited;
    }
    
    return false;
  }
  
  /// Solicita todos los permisos necesarios para cámara
  static Future<Map<String, bool>> requestAllCameraPermissions() async {
    final results = <String, bool>{};
    
    results['camera'] = await requestCameraPermission();
    results['photos'] = await requestPhotosPermission();
    
    // Micrófono para video
    final micStatus = await Permission.microphone.request();
    results['microphone'] = micStatus.isGranted;
    
    return results;
  }
  
  /// Muestra diálogo cuando el permiso está denegado permanentemente
  static Future<void> showPermissionDeniedDialog(
    BuildContext context, {
    required String permission,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permiso requerido'),
        content: Text(
          'Para usar esta función, necesitas dar permiso de $permission. '
          '¿Deseas abrir la configuración de la app?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Abrir configuración'),
          ),
        ],
      ),
    );
  }
  
  /// Verifica si la cámara está disponible
  static Future<bool> isCameraAvailable() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }
}
```

---

## 📝 Resumen

| Paquete | Uso | Complejidad |
|---------|-----|-------------|
| **image_picker** | Captura simple, selección de galería | ⭐ Baja |
| **camera** | Preview en vivo, controles avanzados | ⭐⭐⭐ Alta |
| **image** | Procesamiento (comprimir, redimensionar) | ⭐⭐ Media |

### Flujo Recomendado

1. **Solicitar permisos** antes de acceder a cámara/galería
2. **Usar image_picker** para la mayoría de casos
3. **Usar camera** solo si necesitas preview en vivo
4. **Comprimir imágenes** antes de subirlas a servidor
5. **Generar thumbnails** para listas y grids

---

## 🔗 Navegación

| Anterior | Índice | Siguiente |
|----------|--------|-----------|
| [README Teoría](./README.md) | [Semana 8](../README.md) | [Geolocalización](./02-geolocalizacion-mapas.md) |
