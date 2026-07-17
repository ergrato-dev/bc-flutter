# Ejercicio 01 — permission_handler: Permiso de Cámara

> Implementarás el ciclo completo de un permiso — verificar, solicitar, y manejar la denegación
> permanente — usando `permission_handler` sobre el permiso de cámara, descomentando código paso
> a paso.

## 🎯 Objetivos

- Verificar el estado de un permiso con `Permission.camera.status`
- Solicitarlo con `.request()` y reaccionar a cada `PermissionStatus`
- Redirigir a Ajustes con `openAppSettings()` cuando el estado es `permanentlyDenied`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo
- Dispositivo/emulador real — el permiso de cámara no tiene sentido en Chrome/desktop

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

> ⚠️ Este ejercicio requiere el permiso declarado en tu proyecto real (no en este starter
> aislado): agrega `<uses-permission android:name="android.permission.CAMERA"/>` en
> `android/app/src/main/AndroidManifest.xml`, y `NSCameraUsageDescription` en
> `ios/Runner/Info.plist` — ver teoría 01.

---

## Paso 1: verificar el estado sin pedirlo

```dart
Future<void> _checkStatus() async {
  final status = await Permission.camera.status;
  setState(() => _status = status);
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — conéctalo al botón
"Verificar estado".

✅ **Verifica**: al presionar el botón, el texto muestra `PermissionStatus.denied` (o el estado
actual) sin que aparezca ningún diálogo — `.status` solo consulta.

---

## Paso 2: solicitar el permiso

```dart
Future<void> _requestPermission() async {
  final status = await Permission.camera.request();
  setState(() => _status = status);
}
```

**Descomenta la sección `PASO 2`** — conéctalo al botón "Solicitar permiso".

✅ **Verifica**: la primera vez, aparece el diálogo nativo del sistema. Si concedes, el texto
cambia a `PermissionStatus.granted`.

---

## Paso 3: manejar permanentlyDenied con openAppSettings

```dart
Widget _buildActions() {
  if (_status?.isPermanentlyDenied ?? false) {
    return ElevatedButton(
      onPressed: () => openAppSettings(),
      child: const Text('Abrir Ajustes'),
    );
  }
  return ElevatedButton(onPressed: _requestPermission, child: const Text('Solicitar permiso'));
}
```

**Descomenta la sección `PASO 3`** — reemplaza el botón fijo "Solicitar permiso" por el resultado
de `_buildActions()`.

✅ **Verifica**: deniega el permiso dos veces seguidas (o marca "no volver a preguntar" en
Android). El botón cambia a "Abrir Ajustes" — presionarlo te lleva a la pantalla de ajustes de la
app, porque `.request()` ya no muestra el diálogo del sistema en ese estado.

---

## ✅ Resultado final

El ciclo completo de un permiso — verificar, solicitar, y el camino de escape cuando el usuario lo
denegó permanentemente — el mismo patrón que usarás para la foto de tu dominio en el proyecto de
esta semana.
