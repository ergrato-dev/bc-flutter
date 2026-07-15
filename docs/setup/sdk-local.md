# 📱 Configuración del SDK Local (Flutter)

Necesaria para `flutter run` en un emulador/simulador — Docker no puede renderizar GUI
(ver [docs/docker-setup.md](../docker-setup.md) para el detalle de esta limitación).

## 📋 Requisitos Previos

| Herramienta | Notas |
|-------------|-------|
| Flutter SDK (canal stable) | `flutter doctor` debe pasar sin errores |
| Android Studio | Para el emulador Android y las Android SDK tools |
| Xcode | Solo macOS, para el simulador iOS |
| VS Code | Recomendado, con extensiones `Dart-Code.dart-code` y `Dart-Code.flutter` |

## 1. Instalar Flutter

Sigue la guía oficial para tu sistema operativo: https://docs.flutter.dev/get-started/install

```bash
flutter doctor
```

Resuelve **todos** los `✗` que reporte antes de continuar (licencias de Android, Xcode
command-line tools, etc.).

## 2. Configurar un Emulador/Simulador

### Android

1. Abrir Android Studio → Device Manager → Create Device
2. Elegir un dispositivo Pixel reciente + imagen system con Google Play
3. Iniciar el emulador antes de correr `flutter run`

### iOS (solo macOS)

```bash
open -a Simulator
```

## 3. Clonar y Ejecutar

```bash
git clone https://github.com/ergrato-dev/bc-flutter.git
cd bc-flutter/bootcamp/week-02-widgets_y_layout/3-proyecto/starter
flutter pub get
flutter run
```

## 4. Verificar Coherencia con la Versión Pineada del Curso

```bash
flutter --version
```

Compara contra la versión documentada en [docs/stack-versions.md](../stack-versions.md) — si
difiere, considera usar [FVM](https://fvm.app/) para fijar la versión exacta del curso sin
afectar otros proyectos en tu máquina.

## ❓ Resolución de Problemas

### `flutter doctor` reporta licencias de Android sin aceptar

```bash
flutter doctor --android-licenses
```

### El emulador no aparece en `flutter devices`

Inicia el emulador manualmente desde Android Studio antes de correr `flutter run` — a
diferencia de Expo/React Native, Flutter no lo levanta automáticamente.

---

→ Volver a [setup/README.md](README.md)
