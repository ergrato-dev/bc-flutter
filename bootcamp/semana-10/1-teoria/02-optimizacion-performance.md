# 02 - Optimización y Performance

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- [ ] Optimizar assets (imágenes, fuentes, iconos)
- [ ] Reducir el tamaño del bundle de la aplicación
- [ ] Implementar lazy loading de recursos
- [ ] Identificar y resolver problemas de performance
- [ ] Usar herramientas de profiling de Flutter

---

## 📚 Contenido

### 1. Optimización de Imágenes

Las imágenes son uno de los mayores contribuyentes al tamaño de la app.

#### Formatos Recomendados

| Formato | Uso                          | Características                    |
| ------- | ---------------------------- | ---------------------------------- |
| **WebP**| Recomendado para Flutter     | 25-35% menor que PNG/JPEG          |
| **PNG** | Transparencias               | Buena calidad, tamaño medio        |
| **JPEG**| Fotos sin transparencia      | Compresión con pérdida             |
| **SVG** | Iconos y gráficos vectoriales| Escalable, muy pequeño             |

#### Compresión de Imágenes

```bash
# Instalar herramientas de compresión
# En macOS
brew install pngquant jpegoptim webp

# Comprimir PNG
pngquant --quality=65-80 --ext .png --force assets/images/*.png

# Comprimir JPEG
jpegoptim --max=80 assets/images/*.jpg

# Convertir a WebP
cwebp -q 80 input.png -o output.webp
```

#### Resoluciones Múltiples

```
assets/
├── images/
│   ├── 1.0x/          # Base resolution (mdpi)
│   │   └── logo.png
│   ├── 1.5x/          # hdpi
│   │   └── logo.png
│   ├── 2.0x/          # xhdpi
│   │   └── logo.png
│   ├── 3.0x/          # xxhdpi
│   │   └── logo.png
│   └── 4.0x/          # xxxhdpi
│       └── logo.png
```

```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/images/
```

#### Carga de Imágenes Optimizada

```dart
/**
 * Widget: OptimizedImage
 * 
 * ¿Qué hace?
 * Carga imágenes de forma optimizada con placeholder y manejo de errores
 * 
 * ¿Para qué?
 * Mejora la experiencia de usuario mientras cargan las imágenes
 * Reduce el uso de memoria con cacheWidth/cacheHeight
 */

import 'package:flutter/material.dart';

class OptimizedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const OptimizedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener el devicePixelRatio para calcular el cacheSize óptimo
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cacheWidth = width != null ? (width! * devicePixelRatio).toInt() : null;
    final cacheHeight = height != null ? (height! * devicePixelRatio).toInt() : null;

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      // Limitar el tamaño en memoria
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      // Placeholder mientras carga
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      // Imagen de error
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        );
      },
    );
  }
}
```

---

### 2. App Icons y Splash Screen

#### flutter_launcher_icons

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
  # Adaptive icon para Android (API 26+)
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
  # Web favicon
  web:
    generate: true
    image_path: "assets/icon/app_icon.png"
    background_color: "#FFFFFF"
    theme_color: "#1976D2"
  # Windows
  windows:
    generate: true
    image_path: "assets/icon/app_icon.png"
  # macOS
  macos:
    generate: true
    image_path: "assets/icon/app_icon.png"
```

```bash
# Generar iconos
flutter pub run flutter_launcher_icons
```

#### flutter_native_splash

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_native_splash: ^2.3.5

flutter_native_splash:
  color: "#1976D2"
  image: assets/splash/splash_logo.png
  
  # Android
  android: true
  android_12:
    color: "#1976D2"
    icon_background_color: "#FFFFFF"
    image: assets/splash/splash_logo.png
  
  # iOS
  ios: true
  
  # Web
  web: true
  
  # Modo oscuro (opcional)
  color_dark: "#121212"
  image_dark: assets/splash/splash_logo_dark.png
```

```bash
# Generar splash screen
flutter pub run flutter_native_splash:create

# Remover splash (si necesario)
flutter pub run flutter_native_splash:remove
```

---

### 3. Reducción del Tamaño del Bundle

#### Análisis del Bundle

```bash
# Analizar tamaño del APK
flutter build apk --analyze-size

# Analizar tamaño del App Bundle
flutter build appbundle --analyze-size

# Analizar tamaño de iOS
flutter build ipa --analyze-size
```

#### Tree Shaking y Code Splitting

Flutter automáticamente elimina código no usado, pero puedes ayudar:

```dart
// ❌ Importar todo el paquete
import 'package:flutter/material.dart';

// ✅ Importar solo lo necesario (cuando aplique)
import 'package:flutter/material.dart' show Container, Text, Colors;
```

#### Defer Loading de Librerías

```dart
/**
 * Carga diferida de librerías pesadas
 * Útil para features que no se usan inmediatamente
 */

// Definir la importación diferida
import 'heavy_feature.dart' deferred as heavyFeature;

Future<void> loadHeavyFeature() async {
  // Cargar la librería cuando se necesite
  await heavyFeature.loadLibrary();
  // Ahora puedes usar heavyFeature
  heavyFeature.showHeavyWidget();
}
```

#### Split APKs por ABI

```bash
# Generar APKs separados por arquitectura
flutter build apk --split-per-abi

# Resultado:
# app-armeabi-v7a-release.apk  (~5MB menor)
# app-arm64-v8a-release.apk    (~5MB menor)
# app-x86_64-release.apk       (para emuladores)
```

#### Configuración de ProGuard

```proguard
# android/app/proguard-rules.pro

# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase (si usas)
-keep class com.google.firebase.** { *; }

# Mantener clases de modelos si usas JSON serialization
-keepattributes *Annotation*
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
```

```groovy
// android/app/build.gradle
android {
    buildTypes {
        release {
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

---

### 4. Performance de Widgets

#### const Constructors

```dart
// ❌ Sin const - se reconstruye siempre
Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('Hello'),
  );
}

// ✅ Con const - optimizado
Widget build(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Hello'),
  );
}
```

#### RepaintBoundary

```dart
/**
 * RepaintBoundary aísla el repintado de widgets
 * Útil para widgets que se actualizan frecuentemente
 */

class AnimatedWidget extends StatelessWidget {
  const AnimatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: MyComplexPainter(),
      ),
    );
  }
}
```

#### AutomaticKeepAliveClientMixin

```dart
/**
 * Mantiene el estado de tabs/páginas en memoria
 * Evita reconstruir widgets cuando cambias de tab
 */

class MyTabContent extends StatefulWidget {
  const MyTabContent({super.key});

  @override
  State<MyTabContent> createState() => _MyTabContentState();
}

class _MyTabContentState extends State<MyTabContent>
    with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Requerido
    return const Text('Tab content mantenido en memoria');
  }
}
```

#### ListView.builder vs ListView

```dart
// ❌ Crea todos los items de una vez
ListView(
  children: items.map((item) => ItemWidget(item: item)).toList(),
)

// ✅ Crea items bajo demanda (lazy)
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(item: items[index]),
)

// ✅ Con separadores
ListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(item: items[index]),
  separatorBuilder: (context, index) => const Divider(),
)
```

---

### 5. Profiling y DevTools

#### Flutter DevTools

```bash
# Abrir DevTools
flutter pub global activate devtools
flutter pub global run devtools

# O desde VS Code: Ctrl+Shift+P → "Flutter: Open DevTools"
```

#### Performance Overlay

```dart
MaterialApp(
  // Mostrar overlay de performance
  showPerformanceOverlay: true,
  // Mostrar overlay de checkerboard
  checkerboardRasterCacheImages: true,
  checkerboardOffscreenLayers: true,
)
```

#### Profile Mode

```bash
# Ejecutar en modo profile (para análisis de performance real)
flutter run --profile

# Build en modo profile
flutter build apk --profile
```

#### Timeline Events

```dart
import 'dart:developer' as developer;

void expensiveOperation() {
  developer.Timeline.startSync('ExpensiveOperation');
  
  // ... código costoso ...
  
  developer.Timeline.finishSync();
}
```

---

### 6. Optimización de Memoria

#### Image Cache

```dart
/**
 * Configurar el cache de imágenes
 */

void main() {
  // Limitar el tamaño del cache de imágenes
  PaintingBinding.instance.imageCache.maximumSize = 100; // número de imágenes
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20; // 50 MB
  
  runApp(const MyApp());
}

// Limpiar cache manualmente
void clearImageCache() {
  PaintingBinding.instance.imageCache.clear();
  PaintingBinding.instance.imageCache.clearLiveImages();
}
```

#### Dispose Resources

```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late final AnimationController _controller;
  late final TextEditingController _textController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _textController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // ⚠️ SIEMPRE liberar recursos
    _controller.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

---

### 7. Network Optimization

#### Caching de Requests

```dart
/**
 * Implementación básica de cache para HTTP requests
 */

import 'package:http/http.dart' as http;
import 'dart:convert';

class CachedHttpClient {
  final Map<String, _CacheEntry> _cache = {};
  final Duration cacheDuration;

  CachedHttpClient({this.cacheDuration = const Duration(minutes: 5)});

  Future<dynamic> get(String url, {bool forceRefresh = false}) async {
    // Verificar cache
    if (!forceRefresh && _cache.containsKey(url)) {
      final entry = _cache[url]!;
      if (!entry.isExpired) {
        return entry.data;
      }
    }

    // Hacer request
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Guardar en cache
      _cache[url] = _CacheEntry(
        data: data,
        expiry: DateTime.now().add(cacheDuration),
      );
      return data;
    }
    
    throw Exception('Request failed: ${response.statusCode}');
  }

  void clearCache() => _cache.clear();
}

class _CacheEntry {
  final dynamic data;
  final DateTime expiry;

  _CacheEntry({required this.data, required this.expiry});

  bool get isExpired => DateTime.now().isAfter(expiry);
}
```

#### Compresión de Requests

```dart
import 'dart:io';

final client = HttpClient();

// Aceptar respuestas comprimidas
final request = await client.getUrl(Uri.parse(url));
request.headers.set(HttpHeaders.acceptEncodingHeader, 'gzip, deflate');
```

---

### 8. Checklist de Optimización

```markdown
## Pre-release Optimization Checklist

### Imágenes y Assets
- [ ] Imágenes comprimidas (WebP preferido)
- [ ] Múltiples resoluciones (1x, 2x, 3x)
- [ ] App icon generado para todas las plataformas
- [ ] Splash screen configurado

### Código
- [ ] const constructors donde sea posible
- [ ] ListView.builder para listas largas
- [ ] dispose() en todos los StatefulWidgets
- [ ] Sin print() en release (usar logger)

### Bundle
- [ ] APK split por ABI habilitado
- [ ] ProGuard/R8 configurado
- [ ] Tree shaking verificado
- [ ] --analyze-size ejecutado

### Performance
- [ ] Profile mode testeado
- [ ] Sin jank visible (60fps)
- [ ] Memory leaks verificados
- [ ] DevTools timeline limpio
```

---

## 🎯 Resumen

| Técnica                    | Impacto en Tamaño | Impacto en Performance |
| -------------------------- | ----------------- | ---------------------- |
| Compresión de imágenes     | ⬇️ Alto           | ➡️ Medio               |
| Split APK por ABI          | ⬇️ Alto           | ➡️ Ninguno             |
| ProGuard/minify            | ⬇️ Medio          | ⬆️ Bajo                |
| const constructors         | ➡️ Ninguno        | ⬆️ Medio               |
| ListView.builder           | ➡️ Ninguno        | ⬆️ Alto                |
| RepaintBoundary            | ➡️ Ninguno        | ⬆️ Alto                |
| Image cacheWidth/Height    | ➡️ Ninguno        | ⬆️ Alto                |

---

## 🔗 Navegación

| ⬅️ Anterior                                       | 🏠 Índice                 | Siguiente ➡️                                  |
| ------------------------------------------------- | ------------------------- | --------------------------------------------- |
| [Arquitectura Producción](./01-arquitectura-produccion.md) | [Semana 10](../README.md) | [Preparación Stores](./03-preparacion-stores.md) |
