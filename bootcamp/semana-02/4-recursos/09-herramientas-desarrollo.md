# 🛠️ 09 - Herramientas de Desarrollo Flutter

> **Categoría**: Herramientas / IDEs / Extensiones  
> **Nivel**: Todos  
> **Plataformas**: Windows, macOS, Linux

---

## 🎯 Objetivo

Configurar un entorno de desarrollo productivo con las mejores herramientas para Flutter.

---

## 💻 IDEs y Editores

### 1. **Visual Studio Code** ⭐ (Recomendado)

**URL**: [https://code.visualstudio.com/](https://code.visualstudio.com/)

**Extensiones Esenciales**:

#### Flutter & Dart

- **Flutter** (Dart-Code.flutter) - Extension oficial
- **Dart** (Dart-Code.dart-code) - Soporte del lenguaje
- **Pubspec Assist** - Gestión de dependencias
- **Flutter Widget Snippets** - Snippets de widgets

#### Productividad

- **Error Lens** - Errores inline
- **Bracket Pair Colorizer 2** - Colorea paréntesis
- **Auto Rename Tag** - Renombra tags automáticamente
- **GitLens** - Integración Git avanzada
- **TODO Highlight** - Resalta TODOs
- **Path Intellisense** - Autocompletado de rutas

#### Temas y UI

- **Material Icon Theme** - Iconos de archivos
- **Dracula Official** - Tema oscuro popular
- **One Dark Pro** - Otro tema oscuro

**Configuración Recomendada** (`settings.json`):

```json
{
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "editor.rulers": [80],
    "editor.selectionHighlight": false,
    "editor.suggest.snippetsPreventQuickSuggestions": false,
    "editor.suggestSelection": "first",
    "editor.tabCompletion": "onlySnippets",
    "editor.wordBasedSuggestions": false
  },
  "dart.flutterSdkPath": "/ruta/a/flutter",
  "dart.lineLength": 80,
  "dart.previewFlutterUiGuides": true,
  "dart.previewFlutterUiGuidesCustomTracking": true
}
```

---

### 2. **Android Studio**

**URL**: [https://developer.android.com/studio](https://developer.android.com/studio)

**Plugins Necesarios**:

- Flutter Plugin
- Dart Plugin

**Ventajas**:

- ✅ Emuladores Android integrados
- ✅ Android SDK incluido
- ✅ Layout Inspector avanzado
- ✅ Profiler robusto

**Desventajas**:

- ❌ Más pesado que VS Code
- ❌ Consume más recursos

---

### 3. **IntelliJ IDEA**

**URL**: [https://www.jetbrains.com/idea/](https://www.jetbrains.com/idea/)

Similar a Android Studio pero con más features. Version Community es gratuita.

---

## 🔧 Flutter DevTools

**¿Qué es?**: Suite de herramientas de debugging y performance para Flutter.

**Cómo Acceder**:

```bash
# Ejecutar app en modo debug
flutter run

# En terminal, presiona 'v' para abrir DevTools
# O ve a http://localhost:9100 en navegador
```

**Herramientas Incluidas**:

### 1. **Flutter Inspector** ⭐

- Visualizar widget tree
- Ver propiedades de widgets
- Debug layout issues
- Show/hide rendering layers

**Uso**:

- Inspecciona estructura de tu app
- Identifica widgets problemáticos
- Ve constraints y sizes

### 2. **Performance View**

- Frame rendering times
- Identificar jank (stuttering)
- GPU y CPU usage
- Timeline de eventos

**Métricas Clave**:

- Mantener 60 FPS (16ms por frame)
- Identificar frames lentos (>16ms)

### 3. **Memory View**

- Heap usage
- Detectar memory leaks
- Snapshot de memoria
- Garbage collection stats

### 4. **Network View**

- HTTP requests monitoring
- Request/response details
- Timing de requests
- Headers y body

### 5. **Logging View**

- Console logs centralizados
- Filtros por nivel
- Stack traces

---

## 📱 Emuladores y Dispositivos

### Android Emulator

**Crear Emulador**:

```bash
# Listar AVDs disponibles
flutter emulators

# Crear nuevo AVD (desde Android Studio)
# Tools > Device Manager > Create Device

# Lanzar emulador
flutter emulators --launch <emulator_id>

# O simplemente
flutter run
# Flutter auto-detecta emuladores disponibles
```

**Emulador Recomendado**:

- Device: Pixel 6 o Pixel 7
- API Level: 33 o 34 (Android 13/14)
- RAM: 2048 MB mínimo, 4096 MB ideal
- Enable hardware acceleration (HAXM en Intel, Hyper-V en Windows)

---

### iOS Simulator (solo macOS)

```bash
# Abrir simulator
open -a Simulator

# Listar devices
xcrun simctl list devices

# Ejecutar en iOS
flutter run -d ios
```

---

### Dispositivo Físico

**Android**:

1. Habilitar "Developer Options" en Settings
2. Activar "USB Debugging"
3. Conectar por USB
4. Aceptar depuración en dispositivo

```bash
# Verificar conexión
adb devices

# Ejecutar en dispositivo
flutter run
```

**iOS** (requiere macOS + Xcode):

1. Conectar iPhone/iPad
2. Trust computer
3. Configurar signing en Xcode
4. `flutter run`

---

## 🎨 Herramientas de Diseño

### 1. **FlutterFlow** (No-Code Builder)

**URL**: [https://flutterflow.io/](https://flutterflow.io/)

- Visual builder para Flutter
- Genera código Dart
- Útil para prototipado rápido

---

### 2. **Figma to Flutter Plugins**

- **FlutLab** - Convierte Figma a código Flutter
- **DhiWise** - Figma a Flutter código

---

### 3. **Panache** (Theme Editor)

**URL**: [https://rxlabz.github.io/panache/](https://rxlabz.github.io/panache/)

- Editor visual de ThemeData
- Genera código de tema
- Preview en tiempo real

---

## 🐛 Debugging Tools

### 1. **Dart Debug Extension (VS Code)**

**Breakpoints**:

- Click izquierdo en número de línea
- Conditional breakpoints: click derecho

**Debug Controls**:

- F5: Start Debugging
- F10: Step Over
- F11: Step Into
- Shift+F11: Step Out
- Ctrl+Shift+F5: Hot Restart

### 2. **Flutter Logs**

```dart
// En código
import 'dart:developer' as developer;

developer.log('Message', name: 'MyApp');

// O más simple
print('Debug message');
debugPrint('Flutter debug message');
```

### 3. **Assert Statements**

```dart
assert(text != null, 'Text cannot be null');
```

---

## 📊 Performance Tools

### 1. **Flutter Performance Overlay**

```bash
# Ejecutar con overlay
flutter run --profile

# En app corriendo, presiona 'P' para toggle overlay
```

Muestra:

- FPS en tiempo real
- Frame rendering time
- GPU y UI threads

### 2. **Flutter Driver** (Integration Testing)

```bash
flutter drive --target=test_driver/app.dart
```

---

## 🧪 Testing Tools

### 1. **flutter test**

```bash
# Ejecutar todos los tests
flutter test

# Un archivo específico
flutter test test/widget_test.dart

# Con coverage
flutter test --coverage
```

### 2. **Integration Tests**

```bash
flutter drive --target=test_driver/app.dart
```

---

## 📦 Gestión de Dependencias

### 1. **pub.dev**

**URL**: [https://pub.dev/](https://pub.dev/)

Repositorio oficial de packages Dart/Flutter.

**Buscar packages**:

```bash
# En terminal
flutter pub search <query>

# O en web: pub.dev
```

**Agregar dependency**:

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  provider: ^6.1.1
```

```bash
flutter pub get
```

### 2. **Pubspec Assist** (VS Code Extension)

- `Ctrl+Shift+P` > "Pubspec Assist: Add Dependency"
- Busca y agrega packages automáticamente

---

## 🔄 Version Control

### Git Integration

**VS Code**:

- Source Control panel (Ctrl+Shift+G)
- GitLens extension

**Comandos útiles**:

```bash
# Inicializar repo
git init

# Agregar .gitignore para Flutter
curl https://raw.githubusercontent.com/flutter/flutter/master/.gitignore > .gitignore

# Commit
git add .
git commit -m "Initial commit"

# Push
git push origin main
```

---

## 🚀 Productividad

### Snippets Útiles (VS Code)

Escribe y presiona Tab:

```
stless → StatelessWidget boilerplate
stful → StatefulWidget boilerplate
initS → initState() method
didChangeAppLifecycleState → lifecycle method
```

### Live Templates (Android Studio)

Similar a snippets en VS Code.

---

## 📱 Chrome DevTools (Web)

Para Flutter Web:

```bash
flutter run -d chrome

# Abre DevTools del navegador (F12)
```

Funciona como DevTools normal de web.

---

## 🎯 Herramientas Recomendadas por Nivel

**🟢 Básico (Semana 02)**:

- VS Code + Flutter Extension
- Android Emulator o Dispositivo físico
- Flutter Inspector
- Logging View

**🟡 Intermedio (Semana 04-06)**:

- DevTools completo
- Performance Overlay
- Memory Profiler
- Integration Tests

**🔴 Avanzado (Semana 08-10)**:

- Custom DevTools Extensions
- Performance profiling avanzado
- CI/CD integration
- Crash analytics (Firebase Crashlytics)

---

## ✅ Checklist de Setup

**Entorno Base**:

- [ ] Flutter SDK instalado
- [ ] VS Code con extensión Flutter
- [ ] Emulador Android configurado (o dispositivo físico)
- [ ] `flutter doctor` sin errores

**Extensiones VS Code**:

- [ ] Flutter y Dart oficiales
- [ ] Error Lens
- [ ] Bracket Pair Colorizer 2
- [ ] GitLens

**Herramientas**:

- [ ] DevTools accesible
- [ ] Git configurado
- [ ] pub.dev bookmarked

---

## 🔗 Recursos Relacionados

- Ver: [`08-documentacion-oficial.md`](08-documentacion-oficial.md#devtools)
- Ver: [`10-playgrounds-online.md`](10-playgrounds-online.md)
- **Teoría**: [`1-teoria/03-intro-flutter.md`](../1-teoria/03-intro-flutter.md)

---

**Actualizado**: Noviembre 2025 | **Nivel**: Semana 02 | **Tipo**: Herramientas
