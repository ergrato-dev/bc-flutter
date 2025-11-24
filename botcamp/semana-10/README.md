# Semana 10: Proyecto Final y Deployment

## 🎯 Objetivos de Aprendizaje

- Integrar todos los conocimientos adquiridos
- Desarrollar un proyecto completo end-to-end
- Optimizar la aplicación para producción
- Preparar la app para publicación
- Configurar CI/CD básico
- Publicar en stores (opcional)

## 📚 Contenido Teórico

### 1. Preparación para Producción (2 horas)

#### Optimización de Assets

**Comprimir Imágenes:**

```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/images/
```

```bash
# Optimizar con herramientas
pngquant assets/images/*.png
jpegoptim assets/images/*.jpg
```

**App Icons:**

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: 'assets/icon/app_icon.png'
  adaptive_icon_background: '#FFFFFF'
  adaptive_icon_foreground: 'assets/icon/foreground.png'
```

```bash
flutter pub run flutter_launcher_icons
```

**Splash Screen:**

```yaml
dev_dependencies:
  flutter_native_splash: ^2.3.5

flutter_native_splash:
  color: '#FFFFFF'
  image: assets/splash/splash_icon.png
  android: true
  ios: true
```

```bash
flutter pub run flutter_native_splash:create
```

#### Configuración de App

**Android - build.gradle:**

```gradle
// android/app/build.gradle
android {
    defaultConfig {
        applicationId "com.tuempresa.tuapp"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode 1
        versionName "1.0.0"
    }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

**iOS - Info.plist:**

```xml
<key>CFBundleDisplayName</key>
<string>Tu App</string>
<key>CFBundleShortVersionString</key>
<string>1.0.0</string>
<key>CFBundleVersion</key>
<string>1</string>
```

#### Variables de Entorno

```dart
// lib/config/env.dart
class Env {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.production.com',
  );

  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );

  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );
}

// Ejecutar con:
// flutter run --dart-define=API_URL=https://api.dev.com --dart-define=API_KEY=123
```

#### Obfuscación

```bash
# Build con obfuscación
flutter build apk --obfuscate --split-debug-info=build/debug-info
flutter build appbundle --obfuscate --split-debug-info=build/debug-info
flutter build ipa --obfuscate --split-debug-info=build/debug-info
```

### 2. Firma y Build (2 horas)

#### Android - Generar Keystore

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

**key.properties:**

```properties
# android/key.properties
storePassword=tu_password
keyPassword=tu_password
keyAlias=upload
storeFile=/ruta/a/upload-keystore.jks
```

**Build APK/Bundle:**

```bash
# APK
flutter build apk --release

# App Bundle (recomendado)
flutter build appbundle --release
```

#### iOS - Configuración

**Xcode Setup:**

1. Abrir `ios/Runner.xcworkspace`
2. Configurar Bundle Identifier
3. Seleccionar Team (cuenta de desarrollador)
4. Configurar Signing & Capabilities

**Build iOS:**

```bash
# Build para dispositivo
flutter build ios --release

# Build IPA (requiere Xcode)
flutter build ipa --release
```

### 3. Analytics y Monitoring (1.5 horas)

#### Firebase Analytics

```yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_analytics: ^10.7.0
```

```dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> logScreenView(String screenName) async {
    await analytics.logScreenView(screenName: screenName);
  }

  static Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }

  static Future<void> setUserId(String userId) async {
    await analytics.setUserId(id: userId);
  }
}
```

#### Crashlytics

```yaml
dependencies:
  firebase_crashlytics: ^3.4.7
```

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Capturar errores de Flutter
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // Capturar errores asíncronos
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

// Registrar error personalizado
FirebaseCrashlytics.instance.recordError(
  error,
  stackTrace,
  reason: 'Error personalizado',
);
```

### 4. CI/CD con GitHub Actions (1.5 horas)

**.github/workflows/flutter.yml:**

```yaml
name: Flutter CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          channel: 'stable'

      - name: Install dependencies
        run: flutter pub get

      - name: Analyze code
        run: flutter analyze

      - name: Run tests
        run: flutter test --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info

      - name: Build APK
        run: flutter build apk --release

      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: app-release
          path: build/app/outputs/flutter-apk/app-release.apk
```

### 5. Publicación (1 hora)

#### Google Play Store

**Requisitos:**

- Cuenta de desarrollador ($25 una vez)
- App Bundle firmado
- Íconos y screenshots
- Descripción y metadata
- Política de privacidad

**Play Console:**

1. Crear aplicación
2. Subir App Bundle
3. Completar listado de la tienda
4. Configurar precios
5. Enviar a revisión

#### Apple App Store

**Requisitos:**

- Cuenta de desarrollador ($99/año)
- IPA firmado
- Íconos y screenshots
- Descripción y metadata
- Política de privacidad

**App Store Connect:**

1. Crear app
2. Subir build con Xcode o Transporter
3. Completar información
4. Enviar a revisión

### 6. Versionamiento (0.5 hora)

**pubspec.yaml:**

```yaml
version: 1.0.0+1
# formato: MAJOR.MINOR.PATCH+BUILD_NUMBER
```

**Semantic Versioning:**

- MAJOR: Cambios incompatibles
- MINOR: Funcionalidades nuevas compatibles
- PATCH: Corrección de bugs

## 💻 Ejercicios Prácticos

### Ejercicio 1: Configuración de Assets

- Agregar app icon
- Configurar splash screen
- Optimizar imágenes
- Probar en dispositivo

### Ejercicio 2: Build de Producción

- Generar keystore
- Configurar signing
- Build APK y Bundle
- Probar instalación

### Ejercicio 3: Firebase Integration

- Configurar Firebase
- Implementar Analytics
- Configurar Crashlytics
- Probar eventos

### Ejercicio 4: CI/CD Setup

- Crear workflow de GitHub Actions
- Configurar tests automáticos
- Build automático
- Coverage report

### Ejercicio 5: Store Listing

- Crear metadata
- Diseñar screenshots
- Escribir descripción
- Preparar assets para store

## 🔨 Proyecto Final

**App Completa de tu Elección**

Desarrolla una aplicación completa que demuestre todos los conocimientos adquiridos:

### Opciones de Proyecto:

#### Opción 1: App de Fitness y Salud

- Registro de ejercicios
- Contador de calorías
- Planes de entrenamiento
- Estadísticas y gráficos
- Recordatorios
- Integración con wearables (opcional)

#### Opción 2: App de Finanzas Personales

- Registro de ingresos/gastos
- Categorías personalizadas
- Presupuestos
- Gráficos de análisis
- Exportar reportes
- Multi-moneda

#### Opción 3: App Social/Networking

- Perfiles de usuario
- Feed de publicaciones
- Chat en tiempo real
- Notificaciones
- Búsqueda de usuarios
- Compartir contenido

#### Opción 4: App de Productividad

- Gestor de proyectos
- Tareas con subtareas
- Calendario integrado
- Colaboración en equipo
- Seguimiento de tiempo
- Reportes

### Requisitos Obligatorios:

**1. Arquitectura:**

- Clean Architecture
- Separación de capas
- Dependency Injection
- State Management (Provider/BLoC)

**2. Features:**

- Autenticación (Firebase Auth o similar)
- Base de datos local (SQLite/Hive)
- Consumo de API REST
- Almacenamiento de imágenes
- Notificaciones push
- Geolocalización (si aplica)

**3. UI/UX:**

- Diseño atractivo y profesional
- Navegación intuitiva
- Animaciones suaves
- Responsive design
- Tema claro/oscuro
- Manejo de estados de carga

**4. Testing:**

- Unit tests (coverage > 70%)
- Widget tests
- BLoC/Provider tests
- Integration tests (opcional)

**5. Producción:**

- App icon profesional
- Splash screen
- Build firmado
- Obfuscación activada
- Analytics integrado
- Crashlytics configurado

**6. Documentación:**

- README completo
- Documentación de API
- Guía de instalación
- Screenshots
- Arquitectura documentada

**7. CI/CD:**

- GitHub Actions configurado
- Tests automáticos
- Build automático
- Code coverage

### Entregables:

1. **Código Fuente:**

   - Repositorio GitHub
   - README con instrucciones
   - Commits organizados
   - Branches: main, develop

2. **APK/IPA:**

   - Build de producción
   - Instrucciones de instalación

3. **Documentación:**

   - Documento de arquitectura
   - Diagramas de flujo
   - Screenshots de la app
   - Video demo (2-3 min)

4. **Presentación:**
   - Slides (15-20 diapositivas)
   - Demo en vivo
   - Explicar decisiones técnicas
   - Mostrar tests

### Criterios de Evaluación:

| Criterio                     | Peso |
| ---------------------------- | ---- |
| Funcionalidad completa       | 25%  |
| Arquitectura y código limpio | 20%  |
| UI/UX y diseño               | 15%  |
| Testing y cobertura          | 15%  |
| Documentación                | 10%  |
| Preparación para producción  | 10%  |
| Presentación                 | 5%   |

## 📖 Recursos

### Documentación

- [Flutter Deployment](https://flutter.dev/docs/deployment)
- [Play Store Guidelines](https://play.google.com/console/about/guides/)
- [App Store Guidelines](https://developer.apple.com/app-store/review/guidelines/)

### Herramientas

- [Firebase Console](https://console.firebase.google.com/)
- [Play Console](https://play.google.com/console)
- [App Store Connect](https://appstoreconnect.apple.com/)
- [GitHub Actions](https://github.com/features/actions)

### Paquetes Útiles

- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_analytics](https://pub.dev/packages/firebase_analytics)
- [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
- [package_info_plus](https://pub.dev/packages/package_info_plus)

## ✅ Checklist Final

### Desarrollo

- [ ] Todos los features implementados
- [ ] Arquitectura Clean implementada
- [ ] State management configurado
- [ ] Navegación funcionando
- [ ] APIs integradas
- [ ] Base de datos local funcionando

### Testing

- [ ] Unit tests escritos
- [ ] Widget tests escritos
- [ ] Integration tests (opcional)
- [ ] Coverage > 70%
- [ ] Tests pasando en CI

### UI/UX

- [ ] Diseño consistente
- [ ] Animaciones suaves
- [ ] Loading states
- [ ] Error handling
- [ ] Empty states
- [ ] Responsive design

### Producción

- [ ] App icon configurado
- [ ] Splash screen configurado
- [ ] Keystore generado
- [ ] App firmada
- [ ] Obfuscación activada
- [ ] Variables de entorno configuradas

### Analytics

- [ ] Firebase configurado
- [ ] Analytics implementado
- [ ] Crashlytics implementado
- [ ] Eventos siendo registrados

### CI/CD

- [ ] GitHub Actions configurado
- [ ] Tests automáticos
- [ ] Build automático
- [ ] Coverage report

### Documentación

- [ ] README completo
- [ ] Código documentado
- [ ] Arquitectura documentada
- [ ] Screenshots incluidos
- [ ] Video demo grabado

### Deployment (Opcional)

- [ ] Metadata preparada
- [ ] Screenshots de stores
- [ ] Descripción escrita
- [ ] Política de privacidad
- [ ] Subido a Play Store / App Store

## 🎓 Evaluación Final

**Proyecto Final:** 100%

- Funcionalidad: 25%
- Arquitectura: 20%
- UI/UX: 15%
- Testing: 15%
- Documentación: 10%
- Producción: 10%
- Presentación: 5%

## 📝 Notas Finales

### Consejos para la Presentación:

- Preparar demo funcional
- Tener plan B si falla algo
- Explicar decisiones técnicas
- Mostrar código importante
- Demostrar tests
- Ser conciso y claro

### Siguientes Pasos:

- Publicar en stores
- Agregar más features
- Mejorar performance
- Implementar backend propio
- Explorar Flutter Web/Desktop
- Contribuir a open source

### Recursos para Continuar Aprendiendo:

- [Flutter Weekly](https://flutterweekly.net/)
- [Flutter Community](https://flutter.dev/community)
- [Pub.dev](https://pub.dev/)
- [Flutter GitHub](https://github.com/flutter/flutter)
- [Stack Overflow Flutter](https://stackoverflow.com/questions/tagged/flutter)

## 🎉 ¡Felicitaciones!

Has completado el Bootcamp de Flutter. Ahora tienes las habilidades para:

- Desarrollar aplicaciones móviles profesionales
- Implementar arquitecturas escalables
- Integrar servicios backend
- Publicar apps en stores
- Trabajar en equipo con Git
- Escribir código limpio y testeado

### Próximos Retos:

1. Publicar tu primera app
2. Contribuir a proyectos open source
3. Crear tu portfolio de apps
4. Especializarte en un área (State Management, Animations, etc.)
5. Explorar Flutter para Web y Desktop

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 9](../semana-09/README.md)

**¡Éxito en tu carrera como desarrollador Flutter!** 🚀
