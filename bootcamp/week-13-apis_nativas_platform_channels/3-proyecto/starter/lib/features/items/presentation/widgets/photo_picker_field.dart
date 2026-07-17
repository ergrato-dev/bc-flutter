import 'dart:io';

import 'package:flutter/material.dart';
// ignore: unused_import — se usa al descomentar el PASO 2 (ImagePicker, ImageSource).
import 'package:image_picker/image_picker.dart';
// ignore: unused_import — se usa al descomentar el PASO 1 (Permission, openAppSettings).
import 'package:permission_handler/permission_handler.dart';

// ============================================
// WIDGET: PhotoPickerField
// Campo de foto para CreateItemScreen — permission_handler (permiso de
// cámara) + image_picker (cámara/galería). Mismo patrón de las teorías 01
// y 02, aplicado al dominio de tu proyecto.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Tu trabajo esta semana es completar los TODOs de abajo: asegurar el
// permiso de cámara, invocar ImagePicker, y guardar la ruta elegida.
class PhotoPickerField extends StatefulWidget {
  const PhotoPickerField({super.key, required this.onChanged});

  final ValueChanged<String?> onChanged;

  @override
  State<PhotoPickerField> createState() => _PhotoPickerFieldState();
}

class _PhotoPickerFieldState extends State<PhotoPickerField> {
  String? _photoPath;

  // TODO temporal: en el PASO 1, agrega el método `_ensureCameraPermission`
  // — ver instrucciones al final del archivo.

  // TODO temporal: en el PASO 2, agrega el método `_pick(ImageSource
  // source)` — ver instrucciones al final del archivo.

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: _photoPath != null ? FileImage(File(_photoPath!)) : null,
          child: _photoPath == null ? const Icon(Icons.add_a_photo, size: 32) : null,
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          // TODO temporal: en el PASO 3, reemplaza este onPressed por
          // `() => _pick(ImageSource.camera)` — ver instrucciones abajo.
          onPressed: () => debugPrint('tomar foto'),
        ),
        IconButton(
          icon: const Icon(Icons.photo_library),
          // TODO temporal: en el PASO 3, reemplaza este onPressed por
          // `() => _pick(ImageSource.gallery)` — ver instrucciones abajo.
          onPressed: () => debugPrint('elegir de galería'),
        ),
      ],
    );
  }
}

// ============================================
// PASO 1: asegurar el permiso de cámara
// ============================================
// Agrega este método a `_PhotoPickerFieldState` (ver teoría 01):
//
// Future<bool> _ensureCameraPermission() async {
//   var status = await Permission.camera.status;
//
//   if (status.isDenied) {
//     status = await Permission.camera.request();
//   }
//
//   if (status.isPermanentlyDenied) {
//     await openAppSettings();
//     return false;
//   }
//
//   return status.isGranted;
// }

// ============================================
// PASO 2: elegir la imagen (cámara o galería)
// ============================================
// Agrega este método (ver teoría 02 — la galería no necesita el permiso
// explícito, solo la cámara):
//
// Future<void> _pick(ImageSource source) async {
//   if (source == ImageSource.camera && !await _ensureCameraPermission()) {
//     return;
//   }
//
//   final photo = await ImagePicker().pickImage(source: source);
//   if (photo == null) return; // el usuario canceló, no es un error
//
//   setState(() => _photoPath = photo.path);
//   widget.onChanged(photo.path);
// }

// ============================================
// PASO 3: conectar los botones
// ============================================
// Reemplaza los dos `onPressed` de arriba por:
//
// onPressed: () => _pick(ImageSource.camera),   // botón de cámara
// onPressed: () => _pick(ImageSource.gallery),  // botón de galería
//
// ✅ Verifica en un dispositivo/emulador real: el botón de cámara pide
// permiso la primera vez; el de galería abre el selector de sistema
// directamente (sin diálogo de permiso, ver teoría 02). Ambos actualizan el
// `CircleAvatar` con la foto elegida.
