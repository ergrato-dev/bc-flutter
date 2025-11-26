# Práctica 02: Optimización de Assets

## 📋 Información General

| Campo           | Detalle                                      |
| --------------- | -------------------------------------------- |
| **Duración**    | 35 minutos                                   |
| **Dificultad**  | ⭐⭐ Intermedio                              |
| **Prerequisitos** | Proyecto Flutter con imágenes              |
| **Objetivos**   | Optimizar assets y generar iconos/splash     |

---

## 🎯 Objetivos de Aprendizaje

Al completar esta práctica, serás capaz de:

- [ ] Generar app icons para todas las plataformas
- [ ] Configurar splash screen nativo
- [ ] Organizar assets en múltiples resoluciones
- [ ] Optimizar imágenes para reducir tamaño

---

## 📝 Descripción del Ejercicio

Configurarás los assets visuales de tu aplicación de forma profesional, incluyendo iconos adaptativos, splash screen y optimización de imágenes.

---

## 🚀 Instrucciones

### Paso 1: Preparar Assets Base

Crea la estructura de assets:

```
assets/
├── icon/
│   ├── app_icon.png         # 1024x1024 (base)
│   └── app_icon_foreground.png  # Para adaptive icon
├── splash/
│   └── splash_logo.png      # Logo para splash
├── images/
│   ├── 1.0x/               # mdpi
│   ├── 2.0x/               # xhdpi
│   └── 3.0x/               # xxhdpi
└── fonts/
    └── (tus fuentes)
```

### Paso 2: Configurar flutter_launcher_icons

Añade al `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
  min_sdk_android: 21
  
  # Android Adaptive Icon
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
  
  # Web
  web:
    generate: true
    image_path: "assets/icon/app_icon.png"
    background_color: "#FFFFFF"
    theme_color: "#1976D2"
  
  # Windows
  windows:
    generate: true
    image_path: "assets/icon/app_icon.png"
    icon_size: 48
  
  # macOS
  macos:
    generate: true
    image_path: "assets/icon/app_icon.png"
```

Ejecuta:

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Paso 3: Configurar flutter_native_splash

Añade al `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_native_splash: ^2.3.5

flutter_native_splash:
  # Color de fondo
  color: "#1976D2"
  
  # Logo en el centro
  image: assets/splash/splash_logo.png
  
  # Tamaño del logo (opcional)
  # branding: assets/splash/branding.png
  # branding_mode: bottom
  
  # Plataformas
  android: true
  ios: true
  web: true
  
  # Android 12+ splash
  android_12:
    color: "#1976D2"
    icon_background_color: "#FFFFFF"
    image: assets/splash/splash_logo.png
  
  # Modo oscuro (opcional)
  color_dark: "#121212"
  # image_dark: assets/splash/splash_logo_dark.png
```

Ejecuta:

```bash
flutter pub get
flutter pub run flutter_native_splash:create
```

### Paso 4: Registrar Assets en pubspec.yaml

```yaml
flutter:
  assets:
    # Iconos
    - assets/icon/
    
    # Splash
    - assets/splash/
    
    # Imágenes (Flutter detecta automáticamente 2.0x, 3.0x)
    - assets/images/
    
  fonts:
    - family: CustomFont
      fonts:
        - asset: assets/fonts/CustomFont-Regular.ttf
        - asset: assets/fonts/CustomFont-Bold.ttf
          weight: 700
```

### Paso 5: Crear Widget de Imagen Optimizada

```dart
/**
 * Archivo: lib/core/widgets/optimized_image.dart
 * 
 * ¿Qué hace?
 * Widget para cargar imágenes de forma optimizada
 * 
 * ¿Para qué?
 * Reduce uso de memoria y mejora performance
 */

import 'package:flutter/material.dart';

class OptimizedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const OptimizedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // Calcular tamaño de cache basado en pixel ratio
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cacheWidth = width != null 
        ? (width! * devicePixelRatio).toInt() 
        : null;
    final cacheHeight = height != null 
        ? (height! * devicePixelRatio).toInt() 
        : null;

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      // Limitar tamaño en memoria
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      // Loading indicator
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        
        return placeholder ?? Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
            ),
          ),
        );
      },
      // Error handling
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(
            Icons.broken_image_outlined,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}

/// Para imágenes locales con múltiples resoluciones
class OptimizedAssetImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;

  const OptimizedAssetImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      // Flutter selecciona automáticamente la resolución correcta
      // basándose en la estructura 1.0x, 2.0x, 3.0x
    );
  }
}
```

### Paso 6: Verificar Optimización

```bash
# Analizar tamaño del APK
flutter build apk --analyze-size

# Ver desglose de tamaño
# Se abrirá una herramienta web con el análisis
```

---

## ✅ Criterios de Aceptación

| Criterio                              | Cumplido |
| ------------------------------------- | -------- |
| App icon generado (Android + iOS)     | ☐        |
| Adaptive icon configurado (Android)   | ☐        |
| Splash screen funcionando             | ☐        |
| Assets organizados por resolución     | ☐        |
| Widget OptimizedImage creado          | ☐        |
| Build sin errores de assets           | ☐        |

---

## 🎯 Entregables

1. Screenshots del app icon en dispositivo/emulador
2. Video del splash screen
3. Resultado de `--analyze-size`

---

## 💡 Tips

- El icono base debe ser 1024x1024 sin transparencia
- Para splash, usa imágenes PNG con fondo transparente
- Evita imágenes muy grandes en splash (máx 200KB)
- Usa WebP para imágenes dentro de la app

---

## 🔧 Comandos Útiles

```bash
# Regenerar iconos
flutter pub run flutter_launcher_icons

# Regenerar splash
flutter pub run flutter_native_splash:create

# Remover splash personalizado
flutter pub run flutter_native_splash:remove

# Limpiar y reconstruir
flutter clean && flutter pub get
```

---

## 🔗 Navegación

| ⬅️ Anterior                                          | 🏠 Índice                 | Siguiente ➡️                              |
| ---------------------------------------------------- | ------------------------- | ----------------------------------------- |
| [Config Producción](./practica-01-config-produccion.md) | [Semana 10](../README.md) | [Build y Firma](./practica-03-build-firma.md) |
