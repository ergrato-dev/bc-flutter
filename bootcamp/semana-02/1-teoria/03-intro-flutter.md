# 03. Introducción a Flutter

**Duración:** 2.5 horas (incluye configuración)  
**Modalidad:** Teoría + Configuración práctica  
**Objetivo:** Configurar Flutter y crear la primera aplicación

---

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Entender qué es Flutter y cuándo usarlo
- ✅ Instalar y configurar Flutter SDK
- ✅ Configurar el entorno de desarrollo
- ✅ Crear y ejecutar proyectos Flutter
- ✅ Comprender la estructura de un proyecto
- ✅ Usar hot reload y hot restart
- ✅ Crear widgets básicos (StatelessWidget)
- ✅ Entender el widget tree

---

## PARTE 1: ¿Qué es Flutter? (30 minutos)

### 1️⃣ **Introducción a Flutter**

```
/**
 * What?
 * Flutter es un framework UI de Google para crear aplicaciones nativas
 * multiplataforma desde una única base de código
 *
 * For?
 * Desarrollar apps para móvil (iOS/Android), web y desktop con Dart
 *
 * Impact?
 * Desarrollo más rápido, UI consistente, performance nativa
 */
```

#### **¿Por qué Flutter?**

✅ **Multiplataforma:** Una base de código para móvil, web y desktop  
✅ **Performance nativa:** Compila a código nativo (ARM/x86)  
✅ **Hot Reload:** Ver cambios instantáneamente  
✅ **Widgets ricos:** Material Design y Cupertino (iOS)  
✅ **Lenguaje moderno:** Dart con null safety  
✅ **Comunidad activa:** +2M de desarrolladores

#### **Arquitectura de Flutter**

```
┌─────────────────────────────────────┐
│         Tu Aplicación (Dart)        │
├─────────────────────────────────────┤
│          Flutter Framework          │
│  (Widgets, Rendering, Animation)    │
├─────────────────────────────────────┤
│          Flutter Engine (C/C++)     │
│    (Skia, Dart Runtime, Platform)   │
├─────────────────────────────────────┤
│      Platform (iOS/Android/Web)     │
└─────────────────────────────────────┘
```

#### **Flutter vs Otros Frameworks**

| Framework    | Lenguaje     | Performance | Hot Reload | UI                  |
| ------------ | ------------ | ----------- | ---------- | ------------------- |
| **Flutter**  | Dart         | Nativa      | ✅ Rápido  | Widgets propios     |
| React Native | JavaScript   | Bridge      | ✅ Medio   | Componentes nativos |
| Native       | Swift/Kotlin | Nativa      | ❌ Lento   | Nativo              |
| Ionic        | HTML/CSS/JS  | WebView     | ✅ Rápido  | Web                 |

---

## PARTE 2: Instalación y Configuración (45 minutos)

### 2️⃣ **Instalar Flutter SDK**

#### **Linux (Ubuntu/Debian)**

```bash
# 1. Instalar dependencias
sudo apt-get update
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# 2. Descargar Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# 3. Agregar a PATH
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# 4. Verificar instalación
flutter doctor

# 5. Instalar Android Studio (opcional pero recomendado)
# Descargar desde: https://developer.android.com/studio

# 6. Aceptar licencias de Android
flutter doctor --android-licenses
```

#### **macOS**

```bash
# 1. Instalar con Homebrew
brew install --cask flutter

# 2. O descargar manualmente
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# 3. Agregar a PATH
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# 4. Verificar instalación
flutter doctor

# 5. Instalar Xcode desde App Store
# 6. Configurar command-line tools
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# 7. Instalar CocoaPods
sudo gem install cocoapods
```

#### **Windows**

```powershell
# 1. Descargar Flutter SDK
# https://docs.flutter.dev/get-started/install/windows

# 2. Extraer en C:\src\flutter

# 3. Agregar a PATH del sistema
# C:\src\flutter\bin

# 4. Verificar instalación
flutter doctor

# 5. Instalar Android Studio
# https://developer.android.com/studio

# 6. Aceptar licencias
flutter doctor --android-licenses
```

### 3️⃣ **Verificar Instalación**

```bash
# Ejecutar flutter doctor
flutter doctor

# Salida esperada:
# [✓] Flutter (Channel stable, 3.16.0)
# [✓] Android toolchain - develop for Android devices
# [✓] Chrome - develop for the web
# [✓] Android Studio (version 2023.1)
# [✓] VS Code (version 1.85)
# [✓] Connected device (1 available)
```

### 4️⃣ **Configurar VS Code**

```bash
# 1. Instalar extensiones
code --install-extension Dart-Code.dart-code
code --install-extension Dart-Code.flutter

# 2. Configuración recomendada (settings.json)
# {
#   "dart.flutterSdkPath": "/home/user/flutter",
#   "dart.debugExternalPackageLibraries": true,
#   "dart.debugSdkLibraries": false,
#   "[dart]": {
#     "editor.formatOnSave": true,
#     "editor.formatOnType": true,
#     "editor.rulers": [80],
#     "editor.selectionHighlight": false,
#     "editor.suggest.snippetsPreventQuickSuggestions": false,
#     "editor.suggestSelection": "first",
#     "editor.tabCompletion": "onlySnippets",
#     "editor.wordBasedSuggestions": false
#   }
# }
```

### 5️⃣ **Crear Emulador Android**

```bash
# 1. Abrir Android Studio
# 2. Tools > Device Manager
# 3. Create Virtual Device
# 4. Seleccionar: Pixel 6 Pro
# 5. System Image: Android 13 (API 33)
# 6. Finish

# Iniciar emulador desde terminal
flutter emulators
flutter emulators --launch Pixel_6_Pro_API_33

# Ver dispositivos conectados
flutter devices
```

---

## PARTE 3: Primer Proyecto Flutter (45 minutos)

### 6️⃣ **Crear Proyecto**

```bash
# Crear nuevo proyecto
flutter create my_first_app

# Estructura generada:
# my_first_app/
# ├── android/           # Código Android nativo
# ├── ios/               # Código iOS nativo
# ├── lib/               # Código Dart (tu app)
# │   └── main.dart      # Punto de entrada
# ├── test/              # Tests unitarios
# ├── web/               # Archivos web
# ├── pubspec.yaml       # Dependencias
# └── README.md

# Entrar al proyecto
cd my_first_app

# Ejecutar aplicación
flutter run
```

### 7️⃣ **Estructura del Proyecto**

```
my_first_app/
│
├── lib/                    # 📱 CÓDIGO DE LA APP
│   └── main.dart          # Punto de entrada principal
│
├── android/               # 🤖 Configuración Android
│   ├── app/
│   └── build.gradle
│
├── ios/                   # 🍎 Configuración iOS
│   ├── Runner/
│   └── Podfile
│
├── test/                  # 🧪 Tests
│   └── widget_test.dart
│
├── pubspec.yaml          # 📦 DEPENDENCIAS Y ASSETS
│   # - Dependencias de paquetes
│   # - Assets (imágenes, fuentes)
│   # - Configuración de la app
│
├── .gitignore            # Archivos ignorados por Git
├── analysis_options.yaml # Reglas de linting
└── README.md             # Documentación
```

### 8️⃣ **Archivo `main.dart` por Defecto**

```dart
import 'package:flutter/material.dart';

/**
 * What?
 * Punto de entrada de toda aplicación Flutter
 *
 * For?
 * Inicializar la app y ejecutar el widget raíz
 *
 * Impact?
 * Primera función que se ejecuta al iniciar la app
 */
void main() {
  runApp(const MyApp());
}

/**
 * Widget raíz de la aplicación
 * Configura el tema y define la pantalla inicial
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 9️⃣ **Entendiendo el Código**

#### **`void main()` - Punto de Entrada**

```dart
void main() {
  runApp(const MyApp());
}

/**
 * runApp():
 * - Toma un Widget como argumento
 * - Infla el widget y lo adjunta a la pantalla
 * - Hace que el widget sea la raíz del widget tree
 */
```

#### **`MaterialApp` - Configuración de la App**

```dart
MaterialApp(
  title: 'Mi App',           // Título de la app (multitasking)
  theme: ThemeData(...),     // Tema visual
  home: MyHomePage(),        // Pantalla inicial
  debugShowCheckedModeBanner: false,  // Quitar banner DEBUG
)

/**
 * MaterialApp:
 * - Implementa Material Design
 * - Maneja navegación
 * - Configura tema global
 * - Envuelve la app con funcionalidad básica
 */
```

#### **`StatelessWidget` - Widget Sin Estado**

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna el árbol de widgets
    return MaterialApp(...);
  }
}

/**
 * StatelessWidget:
 * - Inmutable (no cambia con el tiempo)
 * - build() se llama solo una vez
 * - Usado para UI estática
 */
```

---

## PARTE 4: Widgets Básicos (30 minutos)

### 🔟 **Primera App Personalizada**

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyFirstApp());
}

/**
 * App simple con widgets básicos
 */
class MyFirstApp extends StatelessWidget {
  const MyFirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Primera App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar - Barra superior
      appBar: AppBar(
        title: const Text('¡Hola Flutter!'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      // Body - Contenido principal
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono
            const Icon(
              Icons.flutter_dash,
              size: 100,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            // Texto grande
            const Text(
              '¡Bienvenido a Flutter!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Texto secundario
            const Text(
              'Tu primera aplicación móvil',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 1️⃣1️⃣ **Widgets Fundamentales**

#### **`Scaffold` - Estructura Básica**

```dart
/**
 * What?
 * Implementa la estructura visual básica de Material Design
 *
 * For?
 * Proporcionar AppBar, Body, BottomNavigationBar, FloatingActionButton
 *
 * Impact?
 * Estructura estándar para pantallas
 */

Scaffold(
  appBar: AppBar(...),           // Barra superior
  body: Container(...),          // Contenido
  floatingActionButton: FloatingActionButton(...),
  bottomNavigationBar: BottomNavigationBar(...),
  drawer: Drawer(...),           // Menú lateral
)
```

#### **`Container` - Caja Personalizable**

```dart
/**
 * What?
 * Widget contenedor con padding, margin, decoration
 *
 * For?
 * Crear cajas con estilos, bordes, colores
 *
 * Impact?
 * Building block para layouts
 */

Container(
  width: 200,
  height: 100,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(horizontal: 20),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  ),
  child: const Text('Contenedor'),
)
```

#### **`Column` y `Row` - Layouts Verticales/Horizontales**

```dart
/**
 * What?
 * Widgets para organizar hijos vertical u horizontalmente
 *
 * For?
 * Crear layouts flexibles
 *
 * Impact?
 * Base del sistema de layouts en Flutter
 */

Column(
  mainAxisAlignment: MainAxisAlignment.center,    // Vertical
  crossAxisAlignment: CrossAxisAlignment.start,   // Horizontal
  children: [
    Text('Línea 1'),
    Text('Línea 2'),
    Text('Línea 3'),
  ],
)

Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    Icon(Icons.home),
    Icon(Icons.search),
    Icon(Icons.person),
  ],
)
```

#### **`Text` - Mostrar Texto**

```dart
/**
 * What?
 * Widget para mostrar texto
 *
 * For?
 * Renderizar texto con estilos
 *
 * Impact?
 * Componente más usado en cualquier app
 */

Text(
  'Hola Flutter',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    letterSpacing: 1.5,
    decoration: TextDecoration.underline,
  ),
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

#### **`Image` - Mostrar Imágenes**

```dart
/**
 * What?
 * Widget para mostrar imágenes
 *
 * For?
 * Cargar imágenes desde assets, red o memoria
 *
 * Impact?
 * Visual y engagement de la app
 */

// Desde assets
Image.asset(
  'assets/images/logo.png',
  width: 100,
  height: 100,
  fit: BoxFit.cover,
)

// Desde URL
Image.network(
  'https://picsum.photos/200',
  loadingBuilder: (context, child, progress) {
    if (progress == null) return child;
    return CircularProgressIndicator();
  },
)

// Ícono de Flutter
FlutterLogo(size: 100)
```

### 1️⃣2️⃣ **Ejemplo: Tarjeta de Perfil**

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarjeta de Perfil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: 350,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.indigo,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Nombre
              const Text(
                'Ana García López',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Título
              Text(
                'Flutter Developer',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 24),

              // Información de contacto
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoColumn(Icons.email, 'Email', 'ana@example.com'),
                  _buildInfoColumn(Icons.phone, 'Teléfono', '+34 600 000 000'),
                ],
              ),

              const SizedBox(height: 24),

              // Botón
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat),
                label: const Text('Enviar Mensaje'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.indigo, size: 30),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
```

---

## ✅ Hot Reload y Hot Restart

### **Hot Reload** 🔥

```
r (en la terminal)
Cmd/Ctrl + S (en VS Code)

- Recarga cambios instantáneamente
- Mantiene el estado de la app
- No reinicia la app
- Ideal para cambios en UI
```

### **Hot Restart** 🔄

```
R (en la terminal)
Shift + Cmd/Ctrl + F5 (en VS Code)

- Reinicia la app completamente
- Pierde el estado actual
- Aplica cambios en inicialización
- Necesario para cambios en main()
```

---

## 📝 Comandos Flutter Esenciales

```bash
# Crear proyecto
flutter create nombre_proyecto

# Ejecutar app
flutter run

# Ver dispositivos
flutter devices

# Limpiar build
flutter clean

# Obtener dependencias
flutter pub get

# Actualizar dependencias
flutter pub upgrade

# Analizar código
flutter analyze

# Ejecutar tests
flutter test

# Compilar APK (Android)
flutter build apk

# Compilar para iOS
flutter build ios

# Ver versión de Flutter
flutter --version

# Actualizar Flutter
flutter upgrade

# Ver información del doctor
flutter doctor -v
```

---

## ✅ Checklist de Comprensión

Al finalizar este módulo deberías poder:

- [ ] Explicar qué es Flutter y sus ventajas
- [ ] Instalar Flutter SDK correctamente
- [ ] Configurar emulador Android/iOS
- [ ] Crear un nuevo proyecto Flutter
- [ ] Entender la estructura de directorios
- [ ] Modificar `main.dart`
- [ ] Usar `Scaffold`, `AppBar`, `Container`
- [ ] Crear layouts con `Column` y `Row`
- [ ] Estilizar texto con `Text` y `TextStyle`
- [ ] Usar hot reload efectivamente

---

## 🔗 Próximos Pasos

**Siguiente semana:**  
[Semana 3: Widgets y Layouts](../../semana-03/README.md) - Profundizaremos en widgets avanzados, layouts complejos y navegación.

---

## 📚 Recursos Adicionales

### Documentación Oficial

- [Flutter Docs](https://flutter.dev/docs)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)

### Videos Recomendados

- [Flutter in 100 Seconds - Fireship](https://www.youtube.com/watch?v=lHhRhPV--G0)
- [Flutter Course for Beginners - freeCodeCamp](https://www.youtube.com/watch?v=VPvVD8t02U8)
- [Flutter Widget of the Week - Flutter](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)

### Comunidad

- [Flutter Community](https://flutter.dev/community)
- [r/FlutterDev](https://www.reddit.com/r/FlutterDev/)
- [Flutter Discord](https://discord.gg/flutter)
- [Stack Overflow - Flutter](https://stackoverflow.com/questions/tagged/flutter)

---

**⏱️ Tiempo de estudio:** 2.5 horas  
**📖 Nivel:** Principiante-Intermedio  
**🎯 Progreso:** 3/3 módulos de la Semana 2 completados
