# 📚 Teoría - Semana 10: Proyecto Final y Deployment

## 📋 Índice de Módulos

| #   | Módulo                                                         | Duración | Nivel    |
| --- | -------------------------------------------------------------- | -------- | -------- |
| 01  | [Arquitectura de Producción](./01-arquitectura-produccion.md)  | 45 min   | ⭐⭐⭐   |
| 02  | [Optimización y Performance](./02-optimizacion-performance.md) | 45 min   | ⭐⭐⭐   |
| 03  | [Preparación para Stores](./03-preparacion-stores.md)          | 50 min   | ⭐⭐⭐   |
| 04  | [CI/CD y Deployment](./04-ci-cd-deployment.md)                 | 40 min   | ⭐⭐⭐⭐ |

**Tiempo total de teoría:** ~3 horas

---

## 🎯 Objetivos por Módulo

### 01 - Arquitectura de Producción

- Configurar app para entorno de producción
- Implementar variables de entorno
- Configurar flavors (dev, staging, prod)
- Manejar configuraciones sensibles

### 02 - Optimización y Performance

- Optimizar assets (imágenes, fuentes)
- Reducir tamaño del bundle
- Implementar lazy loading
- Profiling y debugging de performance

### 03 - Preparación para Stores

- Generar iconos y splash screens
- Configurar metadata de la app
- Preparar screenshots y descripciones
- Requisitos de Play Store y App Store

### 04 - CI/CD y Deployment

- Configurar GitHub Actions
- Automatizar builds y tests
- Distribución con Firebase App Distribution
- Publicación en stores

---

## 🔗 Prerrequisitos

Antes de comenzar esta semana, asegúrate de:

- [ ] Tener cuenta de Google Play Console (para Android)
- [ ] Tener cuenta de Apple Developer (para iOS, opcional)
- [ ] Conocer Clean Architecture (Semana 9)
- [ ] Tener experiencia con Firebase (Semana 8)
- [ ] Dominar gestión de estado (Semana 5)

---

## 📦 Dependencias Principales

```yaml
dependencies:
  # Analytics y Monitoring
  firebase_core: ^2.24.0
  firebase_analytics: ^10.7.0
  firebase_crashlytics: ^3.4.7
  firebase_performance: ^0.9.3

  # Environment
  flutter_dotenv: ^5.1.0

dev_dependencies:
  # Icons y Splash
  flutter_launcher_icons: ^0.13.1
  flutter_native_splash: ^2.3.5

  # Build
  build_runner: ^2.4.7
```

---

## 🛠️ Herramientas Necesarias

| Herramienta       | Uso                       | Obligatorio |
| ----------------- | ------------------------- | ----------- |
| Android Studio    | Build Android             | ✅          |
| Xcode             | Build iOS (solo Mac)      | ⚠️          |
| Firebase Console  | Analytics, Crashlytics    | ✅          |
| Play Console      | Publicar Android          | ⚠️          |
| App Store Connect | Publicar iOS              | ⚠️          |
| GitHub Actions    | CI/CD                     | ✅          |
| Fastlane          | Automatización (opcional) | ❌          |

---

## 📊 Estructura del Proyecto Final

```
lib/
├── main.dart                    # Entry point
├── main_dev.dart               # Entry point desarrollo
├── main_prod.dart              # Entry point producción
├── app.dart                    # App configuration
├── core/
│   ├── config/
│   │   ├── env.dart           # Variables de entorno
│   │   ├── app_config.dart    # Configuración global
│   │   └── flavors.dart       # Flavors (dev/staging/prod)
│   ├── constants/
│   ├── themes/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   ├── screens/
│   └── widgets/
└── di/
    └── injection.dart          # Dependency injection
```

---

## 🔗 Navegación

| ⬅️ Anterior                                      | 🏠 Índice                |
| ------------------------------------------------ | ------------------------ |
| [Semana 9: Arquitectura](../semana-09/README.md) | [Bootcamp](../README.md) |

---

> **💡 Tip:** Esta semana es la culminación del bootcamp. Aprovecha para integrar todo lo aprendido en un proyecto profesional.
