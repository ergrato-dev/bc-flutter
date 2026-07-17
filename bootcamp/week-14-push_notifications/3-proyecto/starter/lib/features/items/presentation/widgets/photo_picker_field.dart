import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// ============================================
// WIDGET: PhotoPickerField
// Campo de foto para CreateItemScreen — permission_handler (permiso de
// cámara) + image_picker (cámara/galería). Mismo patrón de las teorías 01
// y 02 de semana 13, aplicado al dominio de tu proyecto.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo (semana 13) — no necesitas modificarlo.
class PhotoPickerField extends StatefulWidget {
  const PhotoPickerField({super.key, required this.onChanged});

  final ValueChanged<String?> onChanged;

  @override
  State<PhotoPickerField> createState() => _PhotoPickerFieldState();
}

class _PhotoPickerFieldState extends State<PhotoPickerField> {
  String? _photoPath;

  Future<bool> _ensureCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }

  Future<void> _pick(ImageSource source) async {
    if (source == ImageSource.camera && !await _ensureCameraPermission()) {
      return;
    }

    final photo = await ImagePicker().pickImage(source: source);
    if (photo == null) return; // el usuario canceló, no es un error

    setState(() => _photoPath = photo.path);
    widget.onChanged(photo.path);
  }

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
          onPressed: () => _pick(ImageSource.camera),
        ),
        IconButton(
          icon: const Icon(Icons.photo_library),
          onPressed: () => _pick(ImageSource.gallery),
        ),
      ],
    );
  }
}
