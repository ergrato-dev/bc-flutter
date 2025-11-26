# 🛠️ Herramientas de Desarrollo

## 📋 Contenido

Herramientas útiles para desarrollo con características nativas en Flutter.

---

## 🔧 Consolas y Dashboards

### Google Cloud Console

| Herramienta       | Uso                           | Link                                                          |
| ----------------- | ----------------------------- | ------------------------------------------------------------- |
| **Cloud Console** | Gestión de APIs de Google     | [console.cloud.google.com](https://console.cloud.google.com/) |
| **API Library**   | Habilitar APIs (Maps, Places) | [Link](https://console.cloud.google.com/apis/library)         |
| **Credentials**   | Crear API Keys                | [Link](https://console.cloud.google.com/apis/credentials)     |
| **Billing**       | Controlar costos              | [Link](https://console.cloud.google.com/billing)              |

**Configuración recomendada:**

- Crear proyecto específico para la app
- Restringir API keys por aplicación
- Configurar alertas de billing
- Usar quotas para limitar uso

---

### Firebase Console

| Herramienta          | Uso                   | Link                                                                |
| -------------------- | --------------------- | ------------------------------------------------------------------- |
| **Firebase Console** | Gestión general       | [console.firebase.google.com](https://console.firebase.google.com/) |
| **Cloud Messaging**  | Enviar notificaciones | [Link](https://console.firebase.google.com/project/_/messaging)     |
| **Crashlytics**      | Monitoreo de errores  | [Link](https://console.firebase.google.com/project/_/crashlytics)   |
| **Analytics**        | Métricas de uso       | [Link](https://console.firebase.google.com/project/_/analytics)     |

**Herramientas de testing:**

- Firebase Test Lab
- FCM Notification Composer
- Analytics DebugView

---

## 📱 Testing en Dispositivos

### Android

| Herramienta              | Uso                         | Instalación                                                   |
| ------------------------ | --------------------------- | ------------------------------------------------------------- |
| **Android Studio**       | IDE completo                | [developer.android.com](https://developer.android.com/studio) |
| **ADB**                  | Debug por línea de comandos | Incluido en Android Studio                                    |
| **Logcat**               | Ver logs del dispositivo    | Android Studio / CLI                                          |
| **Device File Explorer** | Explorar archivos           | Android Studio                                                |

**Comandos ADB útiles:**

```bash
# Ver dispositivos conectados
adb devices

# Ver logs de la app
adb logcat | grep flutter

# Instalar APK
adb install app-release.apk

# Capturar screenshot
adb exec-out screencap -p > screen.png

# Simular ubicación
adb emu geo fix <longitude> <latitude>
```

---

### iOS

| Herramienta     | Uso          | Ubicación                   |
| --------------- | ------------ | --------------------------- |
| **Xcode**       | IDE para iOS | App Store                   |
| **Simulator**   | Emulador iOS | Incluido en Xcode           |
| **Instruments** | Profiling    | Xcode > Open Developer Tool |
| **Console.app** | Ver logs iOS | Applications/Utilities      |

**Comandos útiles:**

```bash
# Listar simuladores
xcrun simctl list devices

# Abrir simulador específico
open -a Simulator --args -CurrentDeviceUDID <UDID>

# Enviar push al simulador
xcrun simctl push <device> <bundle-id> payload.json
```

---

## 🌐 APIs de Prueba

### Mock Location Services

| Herramienta        | Plataforma    | Uso                |
| ------------------ | ------------- | ------------------ |
| Fake GPS (Android) | Android       | Simular ubicación  |
| Xcode Location     | iOS Simulator | Simular rutas      |
| GPX Files          | Ambos         | Rutas predefinidas |

### FCM Testing

| Herramienta          | Uso                   | Link                                    |
| -------------------- | --------------------- | --------------------------------------- |
| **Firebase Console** | Enviar notificaciones | Firebase                                |
| **Postman**          | Enviar via API        | [postman.com](https://www.postman.com/) |
| **cURL**             | Línea de comandos     | CLI                                     |

**Ejemplo cURL para FCM:**

```bash
curl -X POST \
  'https://fcm.googleapis.com/fcm/send' \
  -H 'Authorization: key=<SERVER_KEY>' \
  -H 'Content-Type: application/json' \
  -d '{
    "to": "<DEVICE_TOKEN>",
    "notification": {
      "title": "Test",
      "body": "Hello World"
    }
  }'
```

---

## 🔍 Debugging Tools

### Flutter DevTools

| Feature              | Uso                 | Acceso   |
| -------------------- | ------------------- | -------- |
| **Widget Inspector** | Inspeccionar UI     | DevTools |
| **Performance**      | Analizar FPS        | DevTools |
| **Memory**           | Detectar leaks      | DevTools |
| **Network**          | Ver peticiones HTTP | DevTools |
| **Logging**          | Ver logs            | DevTools |

**Abrir DevTools:**

```bash
flutter run
# Presionar 'd' en terminal
# O abrir URL mostrada en consola
```

---

### VS Code Extensions

| Extensión      | Uso                  | ID                           |
| -------------- | -------------------- | ---------------------------- |
| Flutter        | Soporte Flutter      | Dart-Code.flutter            |
| Dart           | Soporte Dart         | Dart-Code.dart-code          |
| Pubspec Assist | Gestión dependencias | jeroen-meijer.pubspec-assist |
| Flutter Intl   | i18n                 | localizely.flutter-intl      |
| Error Lens     | Errores inline       | usernamehw.errorlens         |

---

## 📊 Monitoreo y Analytics

### Performance Monitoring

| Herramienta          | Qué mide          | Link                                  |
| -------------------- | ----------------- | ------------------------------------- |
| Firebase Performance | App performance   | Firebase Console                      |
| Sentry               | Errores y crashes | [sentry.io](https://sentry.io/)       |
| Instabug             | Feedback y bugs   | [instabug.com](https://instabug.com/) |

### App Analytics

| Herramienta        | Métricas          | Link                                    |
| ------------------ | ----------------- | --------------------------------------- |
| Firebase Analytics | Eventos, usuarios | Firebase Console                        |
| Mixpanel           | Comportamiento    | [mixpanel.com](https://mixpanel.com/)   |
| Amplitude          | Producto          | [amplitude.com](https://amplitude.com/) |

---

## 🗺️ Map Tools

### Diseño de Mapas

| Herramienta     | Uso                      | Link                                                        |
| --------------- | ------------------------ | ----------------------------------------------------------- |
| **Snazzy Maps** | Estilos para Google Maps | [snazzymaps.com](https://snazzymaps.com/)                   |
| **Mapstyle**    | Editor de estilos        | [mapstyle.withgoogle.com](https://mapstyle.withgoogle.com/) |
| **GeoJSON.io**  | Crear polígonos          | [geojson.io](https://geojson.io/)                           |

### Generadores

| Herramienta        | Uso                | Link         |
| ------------------ | ------------------ | ------------ |
| **Icon Generator** | Custom markers     | Online tools |
| **KML to GeoJSON** | Convertir formatos | Online tools |
| **GPX Generator**  | Rutas de prueba    | Online tools |

---

## 📦 Package Managers

### FlutterFire CLI

```bash
# Instalar
dart pub global activate flutterfire_cli

# Configurar proyecto
flutterfire configure

# Ver opciones
flutterfire --help
```

### Pub.dev Tools

| Comando                 | Uso                    |
| ----------------------- | ---------------------- |
| `flutter pub add <pkg>` | Agregar dependencia    |
| `flutter pub get`       | Descargar dependencias |
| `flutter pub outdated`  | Ver actualizaciones    |
| `flutter pub upgrade`   | Actualizar packages    |

---

## 💡 Workflow Recomendado

### Para Features Nativos

```
1. Configurar permisos en AndroidManifest/Info.plist
2. Agregar package con flutter pub add
3. Implementar con dispositivo físico
4. Probar en ambas plataformas
5. Manejar errores y edge cases
6. Verificar en release mode
```

### Debug Checklist

- [ ] ¿Permisos configurados correctamente?
- [ ] ¿API Keys válidas y sin restricciones?
- [ ] ¿Probado en dispositivo físico?
- [ ] ¿Funciona en background?
- [ ] ¿Manejo de errores implementado?

---

## 🔗 Navegación

| Anterior                                             | Índice                  | Siguiente                                  |
| ---------------------------------------------------- | ----------------------- | ------------------------------------------ |
| [Webgrafía Tutoriales](./08-webgrafia-tutoriales.md) | [Recursos](./README.md) | [Comunidades](./10-comunidades-soporte.md) |
