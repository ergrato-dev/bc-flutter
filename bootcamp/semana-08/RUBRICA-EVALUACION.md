# 📊 Rúbrica de Evaluación - Semana 8

## 🎯 Características Nativas y Plugins

**Duración:** 8 horas | **Total:** 100 puntos

---

## 📈 Distribución de Puntos

| Componente             | Peso | Puntos  |
| ---------------------- | ---- | ------- |
| Teoría y Comprensión   | 15%  | 15      |
| Prácticas (5)          | 35%  | 35      |
| Proyecto TravelDiary   | 45%  | 45      |
| Documentación y Código | 5%   | 5       |
| **TOTAL**              | 100% | **100** |

---

## 1️⃣ Teoría y Comprensión (15 puntos)

### Conceptos de Características Nativas (8 pts)

| Nivel            | Criterio                                                      | Puntos |
| ---------------- | ------------------------------------------------------------- | ------ |
| **Excelente**    | Domina Platform Channels, permisos, y arquitectura de plugins | 8      |
| **Bueno**        | Comprende la comunicación Flutter-Nativo y manejo de permisos | 6-7    |
| **Suficiente**   | Entiende conceptos básicos de plugins y permisos              | 4-5    |
| **Insuficiente** | Confunde conceptos o no comprende la arquitectura             | 0-3    |

### Conocimiento de Packages (7 pts)

| Nivel            | Criterio                                                  | Puntos |
| ---------------- | --------------------------------------------------------- | ------ |
| **Excelente**    | Conoce y diferencia todos los packages principales        | 7      |
| **Bueno**        | Usa correctamente image_picker, geolocator, notifications | 5-6    |
| **Suficiente**   | Conoce packages básicos pero confunde algunos             | 3-4    |
| **Insuficiente** | No conoce o confunde los packages principales             | 0-2    |

---

## 2️⃣ Prácticas (35 puntos)

### Práctica 1: PhotoCapture (7 pts)

| Criterio               | Excelente                                | Bueno                                | Suficiente                      | Insuficiente         |
| ---------------------- | ---------------------------------------- | ------------------------------------ | ------------------------------- | -------------------- |
| **Captura de imagen**  | Cámara y galería funcionan perfectamente | Ambas funcionan con pequeños errores | Una funciona correctamente      | No funciona          |
| **Manejo de permisos** | Permisos manejados con todos los estados | Maneja granted/denied                | Solicita pero no maneja estados | No solicita permisos |
| **Preview de imagen**  | Preview fluido con opciones de edición   | Preview funcional                    | Preview básico                  | Sin preview          |

**Puntuación:**

- 7 pts: Todos los criterios excelentes
- 5-6 pts: Mayoría buenos, funcionalidad completa
- 3-4 pts: Funciona pero con limitaciones
- 0-2 pts: No funcional o incompleto

### Práctica 2: LocationTracker (7 pts)

| Criterio                   | Excelente                                | Bueno                           | Suficiente                             | Insuficiente            |
| -------------------------- | ---------------------------------------- | ------------------------------- | -------------------------------------- | ----------------------- |
| **Obtención de ubicación** | Ubicación precisa con manejo de errores  | Obtiene ubicación correctamente | Ubicación básica sin manejo de errores | No obtiene ubicación    |
| **Stream de ubicación**    | Stream continuo con configuración óptima | Stream funcional                | Stream básico                          | Sin stream              |
| **Visualización en mapa**  | Mapa con marcadores, rutas y controles   | Mapa con marcador de ubicación  | Mapa básico                            | Sin mapa o no funcional |

**Puntuación:**

- 7 pts: Tracking fluido con todas las features
- 5-6 pts: Tracking funcional con mapa
- 3-4 pts: Obtiene ubicación pero limitado
- 0-2 pts: No funcional

### Práctica 3: NotificationManager (7 pts)

| Criterio                   | Excelente                                  | Bueno                 | Suficiente          | Insuficiente        |
| -------------------------- | ------------------------------------------ | --------------------- | ------------------- | ------------------- |
| **Notificaciones locales** | Inmediatas, programadas y periódicas       | Dos tipos funcionando | Un tipo funcionando | No funcionan        |
| **Personalización**        | Sonido, vibración, iconos, acciones        | Sonido y vibración    | Básica              | Sin personalización |
| **Manejo de taps**         | Navegación a pantalla específica con datos | Navegación básica     | Detecta tap         | No maneja taps      |

**Puntuación:**

- 7 pts: Sistema completo de notificaciones
- 5-6 pts: Notificaciones funcionales con personalización
- 3-4 pts: Notificaciones básicas
- 0-2 pts: No funcional

### Práctica 4: SensorDashboard (7 pts)

| Criterio                | Excelente                                 | Bueno                            | Suficiente               | Insuficiente      |
| ----------------------- | ----------------------------------------- | -------------------------------- | ------------------------ | ----------------- |
| **Lectura de sensores** | Múltiples sensores con filtrado           | 3+ sensores funcionando          | 1-2 sensores             | Sin lectura       |
| **Visualización**       | Gráficos en tiempo real y datos numéricos | Datos en tiempo real             | Datos estáticos          | Sin visualización |
| **Optimización**        | Streams bien manejados, sin memory leaks  | Streams cancelados correctamente | Funciona pero con issues | Memory leaks      |

**Puntuación:**

- 7 pts: Dashboard completo y optimizado
- 5-6 pts: Múltiples sensores funcionando
- 3-4 pts: Sensores básicos
- 0-2 pts: No funcional

### Práctica 5: PermissionsManager (7 pts)

| Criterio                | Excelente                                                                     | Bueno                               | Suficiente            | Insuficiente        |
| ----------------------- | ----------------------------------------------------------------------------- | ----------------------------------- | --------------------- | ------------------- |
| **Gestión de permisos** | Todos los estados manejados (granted, denied, permanently denied, restricted) | granted, denied, permanently denied | granted/denied básico | No maneja estados   |
| **UI de estados**       | UI diferente para cada estado con acciones                                    | UI clara por estado                 | UI básica             | Sin feedback visual |
| **Settings redirect**   | Abre configuración cuando permanentlyDenied                                   | Intenta abrir settings              | No implementado       | -                   |

**Puntuación:**

- 7 pts: Gestión completa y profesional
- 5-6 pts: Maneja estados principales
- 3-4 pts: Funcionalidad básica
- 0-2 pts: No funcional

---

## 3️⃣ Proyecto TravelDiary (45 puntos)

### Funcionalidad Core (18 pts)

| Feature              | Excelente (18)                                   | Bueno (14-17)                    | Suficiente (10-13)     | Insuficiente (0-9)  |
| -------------------- | ------------------------------------------------ | -------------------------------- | ---------------------- | ------------------- |
| **Captura de fotos** | Cámara y galería con compresión                  | Ambas fuentes funcionan          | Una fuente funciona    | No funciona         |
| **Geolocalización**  | Auto-tagging con precisión y mapas               | Ubicación guardada correctamente | Ubicación básica       | Sin ubicación       |
| **Notificaciones**   | Recordatorios programables y push                | Notificaciones locales completas | Notificaciones básicas | Sin notificaciones  |
| **CRUD de entradas** | Crear, leer, actualizar, eliminar con validación | CRUD completo                    | CR básico              | Solo lectura o nada |

### Integración de Features (12 pts)

| Criterio                                          | Puntos |
| ------------------------------------------------- | ------ |
| Todas las features trabajan juntas sin conflictos | 12     |
| Features integradas con pequeños issues           | 9-11   |
| Algunas features integradas                       | 5-8    |
| Features aisladas, sin integración                | 0-4    |

### UI/UX (8 pts)

| Aspecto              | Excelente                               | Bueno                     | Suficiente          | Insuficiente       |
| -------------------- | --------------------------------------- | ------------------------- | ------------------- | ------------------ |
| **Diseño**           | Material Design consistente, responsive | Diseño limpio y funcional | UI funcional básica | UI pobre           |
| **Estados de carga** | Loading, error, empty states para todo  | Mayoría de estados        | Algunos estados     | Sin estados        |
| **Navegación**       | Flujo intuitivo, deep links             | Navegación clara          | Navegación básica   | Navegación confusa |

**Puntuación UI/UX:**

- 8 pts: Todos los aspectos excelentes
- 6-7 pts: Diseño bueno, algunos detalles menores
- 4-5 pts: Funcional pero mejorable
- 0-3 pts: UI deficiente

### Persistencia y Performance (7 pts)

| Criterio                                                  | Puntos |
| --------------------------------------------------------- | ------ |
| Datos persistidos, imágenes optimizadas, sin memory leaks | 7      |
| Persistencia funcional, performance aceptable             | 5-6    |
| Persistencia básica, algunos issues de performance        | 3-4    |
| Sin persistencia o con serios problemas de performance    | 0-2    |

---

## 4️⃣ Documentación y Calidad de Código (5 puntos)

### Documentación (3 pts)

| Nivel            | Criterio                                                | Puntos |
| ---------------- | ------------------------------------------------------- | ------ |
| **Excelente**    | Comentarios completos, README del proyecto, guía de uso | 3      |
| **Bueno**        | Comentarios en funciones principales, README básico     | 2      |
| **Suficiente**   | Algunos comentarios                                     | 1      |
| **Insuficiente** | Sin documentación                                       | 0      |

### Calidad de Código (2 pts)

| Nivel            | Criterio                                       | Puntos |
| ---------------- | ---------------------------------------------- | ------ |
| **Excelente**    | Código limpio, bien estructurado, sin warnings | 2      |
| **Bueno**        | Código organizado con warnings menores         | 1.5    |
| **Suficiente**   | Código funcional pero desorganizado            | 1      |
| **Insuficiente** | Código difícil de leer, muchos warnings        | 0      |

---

## 🎯 Escala de Calificación Final

| Rango  | Calificación     | Descripción                                 |
| ------ | ---------------- | ------------------------------------------- |
| 90-100 | **Excelente**    | Dominio completo de características nativas |
| 80-89  | **Muy Bueno**    | Sólida comprensión y aplicación             |
| 70-79  | **Bueno**        | Competencia demostrada con áreas de mejora  |
| 60-69  | **Suficiente**   | Comprensión básica, necesita práctica       |
| 0-59   | **Insuficiente** | No alcanza los objetivos mínimos            |

---

## ✅ Checklist de Entrega

### Prácticas

- [ ] **Práctica 1:** PhotoCapture funcional con permisos
- [ ] **Práctica 2:** LocationTracker con mapa integrado
- [ ] **Práctica 3:** NotificationManager con tipos de notificación
- [ ] **Práctica 4:** SensorDashboard con visualización en tiempo real
- [ ] **Práctica 5:** PermissionsManager con todos los estados

### Proyecto TravelDiary

- [ ] Captura de fotos desde cámara y galería
- [ ] Geolocalización automática de entradas
- [ ] Mapa con marcadores de ubicaciones visitadas
- [ ] Sistema de notificaciones/recordatorios
- [ ] Persistencia de datos local
- [ ] UI responsive y estados de carga

### Documentación

- [ ] Código comentado en inglés
- [ ] README del proyecto
- [ ] Manejo de errores documentado

---

## 📋 Criterios Específicos por Package

### permission_handler

```dart
// ✅ Correcto: Maneja todos los estados
final status = await Permission.camera.request();
if (status.isGranted) {
  // Usar feature
} else if (status.isDenied) {
  // Mostrar rationale
} else if (status.isPermanentlyDenied) {
  await openAppSettings();
}

// ❌ Incorrecto: Solo verifica granted
if (await Permission.camera.isGranted) {
  // Usar feature
}
```

### image_picker

```dart
// ✅ Correcto: Maneja errores y compresión
try {
  final image = await picker.pickImage(
    source: ImageSource.camera,
    maxWidth: 1024,
    imageQuality: 80,
  );
  if (image != null) {
    // Procesar imagen
  }
} catch (e) {
  // Manejar error
}

// ❌ Incorrecto: Sin manejo de errores
final image = await picker.pickImage(source: ImageSource.camera);
```

### geolocator

```dart
// ✅ Correcto: Verifica servicios y permisos
final serviceEnabled = await Geolocator.isLocationServiceEnabled();
if (!serviceEnabled) {
  // Solicitar activar ubicación
  return;
}

final permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
  permission = await Geolocator.requestPermission();
}

// ❌ Incorrecto: Obtiene posición directamente
final position = await Geolocator.getCurrentPosition();
```

### flutter_local_notifications

```dart
// ✅ Correcto: Inicializa con configuración completa
await flutterLocalNotificationsPlugin.initialize(
  const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    ),
  ),
  onDidReceiveNotificationResponse: _handleNotificationTap,
);

// ❌ Incorrecto: Sin callback de respuesta
await flutterLocalNotificationsPlugin.initialize(settings);
```

---

## 🔧 Configuración Requerida

### Android (android/app/src/main/AndroidManifest.xml)

```xml
<!-- Permisos requeridos -->
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.VIBRATE"/>
```

### iOS (ios/Runner/Info.plist)

```xml
<key>NSCameraUsageDescription</key>
<string>Necesitamos acceso a la cámara para capturar fotos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Necesitamos acceso a la galería para seleccionar fotos</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Necesitamos tu ubicación para geoetiquetar las fotos</string>
```

---

## 🏆 Bonus (hasta +5 puntos extra)

| Bonus                                | Puntos |
| ------------------------------------ | ------ |
| Implementar Firebase Cloud Messaging | +2     |
| Añadir widgets de Home Screen        | +1     |
| Implementar geofencing               | +1     |
| Testing unitario de features nativas | +1     |

---

## ⚠️ Penalizaciones

| Infracción                     | Penalización |
| ------------------------------ | ------------ |
| Código sin comentarios         | -2 pts       |
| Aplicación crashea al ejecutar | -10 pts      |
| Memory leaks evidentes         | -3 pts       |
| No maneja permisos denegados   | -5 pts       |
| Entrega tardía (por día)       | -5 pts       |
| Código copiado sin atribución  | -20 pts      |

---

## 📝 Notas del Evaluador

```
Estudiante: _______________________
Fecha: ___________________________

Prácticas:
- P1 PhotoCapture:     ___/7
- P2 LocationTracker:  ___/7
- P3 NotificationMgr:  ___/7
- P4 SensorDashboard:  ___/7
- P5 PermissionsMgr:   ___/7

Proyecto TravelDiary:
- Funcionalidad Core:  ___/18
- Integración:         ___/12
- UI/UX:               ___/8
- Persistencia/Perf:   ___/7

Otros:
- Teoría:              ___/15
- Documentación:       ___/5

Subtotal:              ___/100
Bonus:                 ___/5
Penalizaciones:        ___

TOTAL FINAL:           ___/100

Observaciones:
_________________________________
_________________________________
_________________________________
```

---

> **Fecha de actualización:** Noviembre 2025
> **Versión:** 1.0
