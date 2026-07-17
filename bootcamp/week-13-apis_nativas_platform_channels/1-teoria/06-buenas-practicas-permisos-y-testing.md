# Buenas Prácticas: Permisos y Testing

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué llamar a `permission_handler`/`image_picker`/`geolocator` directamente desde un widget
  hace tu código difícil de testear
- Cómo envolver una API nativa en una interfaz propia para poder simularla en tests con `mocktail`
- Una checklist de manejo de errores para cualquier API nativa nueva que integres

## 📋 Conceptos Clave

### 1. El problema: un test no puede otorgar un permiso real

Un `testWidgets` (semana 15 profundiza en esto) corre en un entorno simulado sin cámara, sin GPS y
sin diálogos nativos de permisos — si tu widget llama `Permission.camera.request()` directamente,
ese test se cuelga o falla, porque no hay un sistema operativo real detrás respondiendo.

### 2. La solución: la misma que ya conoces desde semana 6

Envuelve la API nativa en una interfaz (un repository, siguiendo Clean Architecture desde
semana 10) que tu capa de presentación consuma — exactamente el mismo principio que ya aplicaste
con `ItemsRepository` para no acoplar los widgets a `Dio` directamente.

```dart
// domain/repositories/photo_repository.dart
abstract class PhotoRepository {
  Future<String?> pickFromCamera();
}

// data/repositories/photo_repository_impl.dart — usa permission_handler + image_picker de verdad
class PhotoRepositoryImpl implements PhotoRepository {
  @override
  Future<String?> pickFromCamera() async {
    final granted = await _ensureCameraPermission();
    if (!granted) return null;
    final photo = await ImagePicker().pickImage(source: ImageSource.camera);
    return photo?.path;
  }
  // ...
}
```

Un test puede entonces usar una implementación falsa (`FakePhotoRepository implements
PhotoRepository`) que retorna una ruta fija, sin tocar cámara ni permisos reales — el mismo patrón
`Fake...Repository` que ya usaste en `test/widget_test.dart` desde semana 10.

### 3. mocktail para verificar interacciones, no solo retornos

Cuando necesitas verificar que se llamó un método (no solo simular su retorno), `mocktail` permite
crear un mock y comprobar la llamada:

```dart
class MockPhotoRepository extends Mock implements PhotoRepository {}

test('pide la foto de cámara al presionar el botón', () async {
  final repository = MockPhotoRepository();
  when(() => repository.pickFromCamera()).thenAnswer((_) async => '/tmp/photo.jpg');

  // ... construir el widget con `repository` inyectado y simular el tap ...

  verify(() => repository.pickFromCamera()).called(1);
});
```

Semana 15 (Testing) profundiza en `mocktail` con ejemplos completos — esta semana solo necesitas
reconocer que la arquitectura en capas (domain/data/presentation) es lo que hace esto posible; sin
esa separación, no hay nada que simular.

### 4. Checklist para cualquier API nativa nueva

- [ ] ¿El permiso necesario está declarado en `AndroidManifest.xml`/`Info.plist`, además de
      solicitado en runtime?
- [ ] ¿El resultado nulo/cancelado (usuario cerró la cámara, denegó el permiso) se maneja sin
      lanzar una excepción no capturada?
- [ ] ¿El caso `permanentlyDenied`/`deniedForever` redirige a `openAppSettings()` en vez de
      insistir con `request()`?
- [ ] ¿La llamada a la API nativa vive en un repository/servicio, no directamente en un widget?
- [ ] ¿Existe una implementación falsa de ese repository para tests, sin depender de hardware
      real?

## ✅ Checklist de Verificación

- [ ] Sé por qué un test no puede ejecutar código que llama directamente a una API nativa
- [ ] Sé envolver una API nativa en un repository siguiendo Clean Architecture
- [ ] Reconozco `mocktail` como la herramienta para simular esas dependencias en tests
- [ ] Tengo una checklist propia para integrar cualquier API nativa nueva sin dejar casos sin
      manejar

## 📚 Recursos Adicionales

- [Flutter docs — Platform channels](https://docs.flutter.dev/platform-integration/platform-channels)
- [permission_handler — pub.dev](https://pub.dev/packages/permission_handler)
- [image_picker — pub.dev](https://pub.dev/packages/image_picker)
- [geolocator — pub.dev](https://pub.dev/packages/geolocator)
