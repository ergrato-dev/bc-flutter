# Cámara con image_picker

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo capturar una foto o elegir una de la galería con `image_picker`
- Por qué `image_picker` maneja parte del permiso internamente, y cuándo igual conviene
  verificarlo tú con `permission_handler`
- Cómo mostrar la imagen elegida con `Image.file`

## 📋 Conceptos Clave

### 1. ImagePicker — una API, dos orígenes

`image_picker` expone una sola clase (`ImagePicker`) con un método (`pickImage`) que acepta de
dónde debe venir la imagen:

```dart
final picker = ImagePicker();

final XFile? photo = await picker.pickImage(source: ImageSource.camera);
// o
final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
```

Ambas llamadas retornan un `XFile?` — `null` si el usuario canceló (cerró la cámara o la galería
sin elegir nada), o el archivo elegido con su `.path` listo para usar.

### 2. Por qué el resultado es nullable

A diferencia de un `Future` que falla con una excepción, cancelar la selección **no** es un error
— es un resultado válido y esperado. Por eso `pickImage` retorna `null` en vez de lanzar, y tu
código debe verificar explícitamente antes de usar el archivo:

```dart
if (photo == null) return; // el usuario canceló, no es un error
setState(() => _photoPath = photo.path);
```

### 3. Qué permiso maneja image_picker, y qué conviene verificar tú

`ImageSource.gallery` usa el selector de sistema (Android Photo Picker / iOS `PHPicker`), que
**no requiere permiso de runtime** en versiones recientes de cada plataforma — el propio sistema
operativo entrega solo la foto elegida, sin darle a tu app acceso a toda la galería.

`ImageSource.camera` sí abre la cámara del dispositivo directamente, y **sí requiere** el permiso
`Permission.camera` — `image_picker` internamente ya intenta solicitarlo, pero delegar el chequeo
completo a la librería te deja sin control sobre el caso `permanentlyDenied` (no puedes mostrarle
al usuario una explicación antes de redirigirlo a Ajustes). Por eso el patrón recomendado sigue
siendo verificar tú el permiso (teoría 01) **antes** de llamar `pickImage(source: camera)`, para
decidir con criterio propio qué mostrar en cada estado.

### 4. Mostrar la imagen elegida

```dart
import 'dart:io';

Widget _preview(String? photoPath) {
  if (photoPath == null) {
    return const Icon(Icons.add_a_photo, size: 48);
  }
  return Image.file(File(photoPath), width: 96, height: 96, fit: BoxFit.cover);
}
```

`Image.file` (a diferencia de `Image.network`, que ya conoces desde semana 6) lee directamente del
sistema de archivos local — no hay petición HTTP de por medio. El `File` viene de `dart:io`, no de
Flutter — es la misma clase que usarías en cualquier programa Dart de servidor o CLI para leer un
archivo.

### 5. Elegir origen con una UI simple

Un patrón común es ofrecer ambas opciones con un `showModalBottomSheet` o dos botones simples:

```dart
Row(
  children: [
    IconButton(icon: const Icon(Icons.camera_alt), onPressed: () => _pick(ImageSource.camera)),
    IconButton(icon: const Icon(Icons.photo_library), onPressed: () => _pick(ImageSource.gallery)),
  ],
)
```

## ✅ Checklist de Verificación

- [ ] Sé usar `ImagePicker().pickImage(source: ...)` con `ImageSource.camera` y
      `ImageSource.gallery`
- [ ] Sé por qué el resultado es `XFile?` y por qué `null` no es un error
- [ ] Sé qué origen requiere permiso explícito de tu parte y cuál no
- [ ] Sé mostrar la imagen elegida con `Image.file` + `dart:io`

## 📚 Próximo paso

[Geolocalización con geolocator →](03-geolocalizacion-con-geolocator.md)
