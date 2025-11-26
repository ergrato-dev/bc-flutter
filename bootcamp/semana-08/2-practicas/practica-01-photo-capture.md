# 📷 Práctica 1: PhotoCapture

## 🎯 Objetivo

Crear una aplicación que permita capturar fotos con la cámara, seleccionar imágenes de la galería, y mostrarlas en una galería local.

---

## ⏱️ Tiempo Estimado

30 minutos

---

## 📋 Requisitos Funcionales

### Funcionalidades Principales

1. **Captura de Foto**

   - Abrir cámara y tomar foto
   - Preview antes de confirmar
   - Guardar en almacenamiento local

2. **Selección de Galería**

   - Abrir galería del dispositivo
   - Seleccionar una o múltiples imágenes
   - Importar a la app

3. **Galería Local**

   - Mostrar todas las fotos capturadas/seleccionadas
   - Vista en grid
   - Tap para ver en pantalla completa

4. **Manejo de Permisos**
   - Solicitar permiso de cámara
   - Solicitar permiso de galería
   - Manejar denegación de permisos

---

## 🛠️ Tecnologías

```yaml
dependencies:
  image_picker: ^1.0.4
  permission_handler: ^11.1.0
  path_provider: ^2.1.1
```

---

## 📐 Estructura del Proyecto

```
lib/
├── main.dart
├── services/
│   ├── image_service.dart       # Lógica de captura/selección
│   └── permission_service.dart  # Manejo de permisos
├── screens/
│   ├── home_screen.dart         # Pantalla principal con galería
│   └── image_detail_screen.dart # Vista de imagen completa
└── widgets/
    ├── photo_grid.dart          # Grid de fotos
    └── capture_button.dart      # FAB con opciones
```

---

## 💻 Código Base

### 1. Servicio de Permisos

```dart
/**
 * PermissionService
 *
 * ¿Qué hace?
 * Centraliza la lógica de solicitud y verificación de permisos.
 *
 * ¿Para qué?
 * Tener un punto único para manejar todos los permisos de la app,
 * facilitando el mantenimiento y la reutilización.
 */

import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Solicita permiso de cámara
  /// Retorna true si fue otorgado
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }

    // Permanentemente denegado
    return false;
  }

  /// Solicita permiso de galería/fotos
  static Future<bool> requestGalleryPermission() async {
    // Android 13+ usa photos, versiones anteriores usan storage
    final permission = await Permission.photos.status.isDenied
        ? Permission.photos
        : Permission.storage;

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

  /// Verifica si el permiso de cámara está denegado permanentemente
  static Future<bool> isCameraPermanentlyDenied() async {
    return await Permission.camera.isPermanentlyDenied;
  }

  /// Abre la configuración de la app
  static Future<bool> openSettings() async {
    return await openAppSettings();
  }
}
```

### 2. Servicio de Imágenes

```dart
/**
 * ImageService
 *
 * Servicio para capturar y seleccionar imágenes.
 * Maneja la lógica de image_picker y almacenamiento.
 */

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageService {
  final ImagePicker _picker = ImagePicker();

  /// Captura una foto desde la cámara
  Future<File?> capturePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image == null) return null;

      // Guardar en directorio de la app
      return await _saveImageLocally(File(image.path));
    } catch (e) {
      print('Error al capturar foto: $e');
      return null;
    }
  }

  /// Selecciona una imagen de la galería
  Future<File?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image == null) return null;

      return await _saveImageLocally(File(image.path));
    } catch (e) {
      print('Error al seleccionar imagen: $e');
      return null;
    }
  }

  /// Selecciona múltiples imágenes
  Future<List<File>> pickMultipleFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      final savedImages = <File>[];
      for (final image in images) {
        final saved = await _saveImageLocally(File(image.path));
        if (saved != null) {
          savedImages.add(saved);
        }
      }

      return savedImages;
    } catch (e) {
      print('Error al seleccionar imágenes: $e');
      return [];
    }
  }

  /// Guarda una imagen en el directorio de la app
  Future<File?> _saveImageLocally(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${directory.path}/photos');

      // Crear directorio si no existe
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      // Generar nombre único
      final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = path.join(imagesDir.path, fileName);

      // Copiar imagen
      return await image.copy(savedPath);
    } catch (e) {
      print('Error al guardar imagen: $e');
      return null;
    }
  }

  /// Obtiene todas las imágenes guardadas
  Future<List<File>> getSavedImages() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${directory.path}/photos');

      if (!await imagesDir.exists()) {
        return [];
      }

      final files = await imagesDir.list().toList();
      final images = files
          .whereType<File>()
          .where((f) => f.path.endsWith('.jpg') || f.path.endsWith('.png'))
          .toList();

      // Ordenar por fecha (más reciente primero)
      images.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

      return images;
    } catch (e) {
      print('Error al obtener imágenes: $e');
      return [];
    }
  }

  /// Elimina una imagen
  Future<bool> deleteImage(File image) async {
    try {
      await image.delete();
      return true;
    } catch (e) {
      print('Error al eliminar imagen: $e');
      return false;
    }
  }
}
```

### 3. Pantalla Principal

```dart
/**
 * HomeScreen
 *
 * Pantalla principal que muestra la galería de fotos
 * y botones para capturar/seleccionar imágenes.
 */

import 'dart:io';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImageService _imageService = ImageService();
  List<File> _images = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    setState(() => _isLoading = true);

    final images = await _imageService.getSavedImages();

    setState(() {
      _images = images;
      _isLoading = false;
    });
  }

  Future<void> _capturePhoto() async {
    // Verificar permiso
    final hasPermission = await PermissionService.requestCameraPermission();

    if (!hasPermission) {
      _showPermissionDeniedDialog('cámara');
      return;
    }

    final image = await _imageService.capturePhoto();

    if (image != null) {
      setState(() {
        _images.insert(0, image);
      });
    }
  }

  Future<void> _pickFromGallery() async {
    // Verificar permiso
    final hasPermission = await PermissionService.requestGalleryPermission();

    if (!hasPermission) {
      _showPermissionDeniedDialog('galería');
      return;
    }

    final image = await _imageService.pickFromGallery();

    if (image != null) {
      setState(() {
        _images.insert(0, image);
      });
    }
  }

  void _showPermissionDeniedDialog(String permission) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permiso requerido'),
        content: Text(
          'Para usar esta función necesitas dar permiso de $permission. '
          '¿Deseas abrir la configuración?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              PermissionService.openSettings();
            },
            child: const Text('Configuración'),
          ),
        ],
      ),
    );
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.camera_alt, color: Colors.white),
              ),
              title: const Text('Tomar foto'),
              onTap: () {
                Navigator.pop(context);
                _capturePhoto();
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.photo_library, color: Colors.white),
              ),
              title: const Text('Elegir de galería'),
              onTap: () {
                Navigator.pop(context);
                _pickFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openImageDetail(File image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailScreen(
          image: image,
          onDelete: () async {
            final deleted = await _imageService.deleteImage(image);
            if (deleted) {
              setState(() {
                _images.remove(image);
              });
            }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhotoCapture'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadImages,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showImageOptions,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_images.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No hay fotos',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Toca el botón + para agregar',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadImages,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          final image = _images[index];
          return GestureDetector(
            onTap: () => _openImageDetail(image),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                image,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
```

### 4. Pantalla de Detalle

```dart
/**
 * ImageDetailScreen
 *
 * Muestra una imagen en pantalla completa con opciones.
 */

import 'dart:io';
import 'package:flutter/material.dart';

class ImageDetailScreen extends StatelessWidget {
  final File image;
  final VoidCallback onDelete;

  const ImageDetailScreen({
    Key? key,
    required this.image,
    required this.onDelete,
  }) : super(key: key);

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar foto'),
        content: const Text('¿Estás seguro de que deseas eliminar esta foto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.file(
            image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

| Criterio       | Puntos | Descripción                              |
| -------------- | ------ | ---------------------------------------- |
| Permisos       | 2      | Solicita y maneja correctamente permisos |
| Captura        | 2      | Captura fotos correctamente              |
| Galería        | 1.5    | Selecciona imágenes de galería           |
| Almacenamiento | 1.5    | Guarda imágenes localmente               |
| UI             | 2      | Interfaz intuitiva y funcional           |
| Código limpio  | 1      | Documentación y estructura               |
| **Total**      | **10** |                                          |

---

## 🎁 Bonus

- [ ] Agregar filtros básicos a las fotos (+1)
- [ ] Permitir recortar imágenes (+1)
- [ ] Compartir imagen (+0.5)

---

## 🔗 Navegación

| Anterior              | Índice                   | Siguiente                                            |
| --------------------- | ------------------------ | ---------------------------------------------------- |
| [README](./README.md) | [Prácticas](./README.md) | [LocationTracker](./practica-02-location-tracker.md) |
