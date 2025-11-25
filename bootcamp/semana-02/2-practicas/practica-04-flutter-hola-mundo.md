# 💻 Práctica 4: Primera App Flutter - Hola Mundo Personalizado

**⏱️ Duración:** 45 minutos  
**📊 Dificultad:** ⭐ Fácil  
**🎯 Conceptos:** StatelessWidget, MaterialApp, Scaffold, widgets básicos, temas

---

## 🎯 Objetivo

Crear tu **primera aplicación Flutter personalizada** que muestre información de forma atractiva usando widgets básicos y personalización de temas.

---

## 📚 Conceptos que Aplicaremos

- ✅ `MaterialApp` y configuración
- ✅ `StatelessWidget`
- ✅ `Scaffold`, `AppBar`, `Body`
- ✅ Widgets de texto e íconos
- ✅ `Column`, `Row` para layouts
- ✅ `Container` con decoración
- ✅ Personalización de colores y temas
- ✅ Hot Reload

---

## 🖼️ Resultado Esperado

Una app con:
- AppBar con título personalizado
- Ícono grande central
- Título de bienvenida
- Subtítulo descriptivo
- Tarjetas de información
- Botón de acción
- Colores y diseño atractivo

---

## 📋 Instrucciones

### Paso 1: Crear Proyecto (5 min)

```bash
# Crear nuevo proyecto
flutter create mi_primera_app

# Entrar al proyecto
cd mi_primera_app

# Abrir en VS Code
code .

# Ejecutar app
flutter run
```

**Tareas:**
1. Crea el proyecto Flutter
2. Abre `lib/main.dart`
3. Ejecuta la app para verificar que funciona
4. Familiarízate con hot reload (Cmd/Ctrl + S)

### Paso 2: Limpiar y Crear Estructura Base (10 min)

Elimina todo el contenido de `lib/main.dart` y reemplázalo con:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyFirstApp());
}

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
      appBar: AppBar(
        title: const Text('¡Hola Flutter!'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Aquí irá nuestra app'),
      ),
    );
  }
}
```

**Tareas:**
1. Copia el código base
2. Guarda y verifica que compile
3. Ve tu app básica en el emulador
4. Entiende cada parte del código

### Paso 3: Personalizar el Tema (10 min)

Modifica el `MaterialApp` para personalizar colores:

```dart
class MyFirstApp extends StatelessWidget {
  const MyFirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Primera App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Color primario
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        
        // Tipografía
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        
        // Usar Material 3
        useMaterial3: true,
        
        // Personalizar AppBar
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}
```

**Tareas:**
1. Cambia el `seedColor` a tu color favorito
2. Experimenta con diferentes colores: `Colors.teal`, `Colors.orange`, etc.
3. Observa cómo cambia toda la app con hot reload
4. Ajusta los tamaños de fuente a tu gusto

### Paso 4: Crear el Contenido Principal (15 min)

Reemplaza el `body` de `HomePage` con contenido más rico:

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Mi Primera App Flutter'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono grande
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.flutter_dash,
                  size: 70,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Título principal
              Text(
                '¡Bienvenido a Flutter!',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 10),
              
              // Subtítulo
              Text(
                'Tu primera aplicación móvil multiplataforma',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Tarjetas de información
              _buildInfoCard(
                context,
                icon: Icons.phone_android,
                title: 'Multiplataforma',
                description: 'Una base de código para iOS y Android',
              ),
              
              const SizedBox(height: 15),
              
              _buildInfoCard(
                context,
                icon: Icons.flash_on,
                title: 'Hot Reload',
                description: 'Ver cambios instantáneamente',
              ),
              
              const SizedBox(height: 15),
              
              _buildInfoCard(
                context,
                icon: Icons.palette,
                title: 'Hermosas UIs',
                description: 'Widgets ricos y personalizables',
              ),
              
              const SizedBox(height: 30),
              
              // Botón de acción
              ElevatedButton.icon(
                onPressed: () {
                  // Por ahora solo imprime en consola
                  print('¡Botón presionado!');
                },
                icon: const Icon(Icons.rocket_launch),
                label: const Text('Comenzar a Explorar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Método auxiliar para crear tarjetas
  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ícono
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
          ),
          
          const SizedBox(width: 15),
          
          // Texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

**Tareas:**
1. Copia el código completo
2. Observa cómo se estructura el layout
3. Experimenta cambiando íconos (busca en [Material Icons](https://fonts.google.com/icons))
4. Modifica los textos con tu información
5. Ajusta colores y espaciados

### Paso 5: Personalización Final (5 min)

Ahora personaliza la app a tu gusto:

```dart
// Cambia estos valores para personalizar:

// 1. Ícono principal
Icon(
  Icons.rocket,  // Prueba: star, favorite, celebration, cake, etc.
  size: 70,
  color: Theme.of(context).colorScheme.primary,
),

// 2. Título
Text(
  '¡Hola Mundo desde Flutter!',  // Tu mensaje
  style: Theme.of(context).textTheme.headlineLarge,
),

// 3. Colores del tema
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.indigo,  // Prueba diferentes colores
  brightness: Brightness.light,
),

// 4. Agrega más tarjetas
_buildInfoCard(
  context,
  icon: Icons.favorite,
  title: 'Tu característica',
  description: 'Tu descripción personalizada',
),
```

**Experimenta con:**
- Diferentes íconos
- Colores del tema
- Textos personalizados
- Agregar más tarjetas
- Cambiar el fondo

---

## ✅ Checklist de Completación

- [ ] Proyecto Flutter creado correctamente
- [ ] App ejecutándose en emulador/dispositivo
- [ ] Tema personalizado con color favorito
- [ ] AppBar con título personalizado
- [ ] Ícono principal visible
- [ ] Tres tarjetas de información
- [ ] Botón funcional (imprime en consola)
- [ ] Hot reload funciona correctamente
- [ ] Contenido personalizado con tu información
- [ ] App se ve bien en diferentes tamaños

---

## 🚀 Desafíos Opcionales

### 1. Modo Oscuro

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ),
  themeMode: ThemeMode.system,  // Sigue el sistema
  home: const HomePage(),
);
```

### 2. Agregar FloatingActionButton

```dart
Scaffold(
  appBar: AppBar(...),
  body: ...,
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      print('FAB presionado!');
    },
    child: const Icon(Icons.add),
  ),
);
```

### 3. Agregar un Drawer (Menú lateral)

```dart
Scaffold(
  appBar: AppBar(...),
  drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
          ),
          child: Text(
            'Menú',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: () {
            print('Inicio');
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configuración'),
          onTap: () {
            print('Configuración');
          },
        ),
      ],
    ),
  ),
  body: ...,
);
```

### 4. Agregar Más Información Personal

```dart
// Después de las tarjetas, antes del botón
const Divider(height: 40),

Text(
  'Sobre mí',
  style: Theme.of(context).textTheme.headlineSmall,
),

const SizedBox(height: 10),

const Text(
  'Soy un desarrollador aprendiendo Flutter. '
  'Esta es mi primera aplicación y estoy emocionado '
  'por crear experiencias móviles increíbles.',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 14),
),
```

### 5. Animación Simple

```dart
// En el ícono principal
TweenAnimationBuilder(
  tween: Tween<double>(begin: 0, end: 1),
  duration: const Duration(seconds: 1),
  builder: (context, value, child) {
    return Transform.scale(
      scale: value,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.flutter_dash,
          size: 70,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  },
);
```

---

## 📸 Screenshots

Toma capturas de tu app y compártelas:

```bash
# En el emulador, presiona el botón de captura
# O usa el comando
flutter screenshot
```

---

## 📚 Recursos Adicionales

- [Material Design](https://m3.material.io/)
- [Material Icons](https://fonts.google.com/icons)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Color Tool](https://material.io/resources/color/)

---

## 💡 Tips

**Hot Reload:**
- Usa `r` en la terminal o `Cmd/Ctrl + S` en VS Code
- Mantiene el estado de la app
- Ideal para cambios visuales

**Hot Restart:**
- Usa `R` en la terminal o `Shift + Cmd/Ctrl + F5`
- Reinicia la app completamente
- Necesario para cambios en `main()`

**Debug Console:**
- Usa `print()` para depurar
- Verás los mensajes en la consola de VS Code

---

**⏱️ Tiempo:** 45 minutos  
**🎯 Dificultad:** ⭐ Fácil  
**🎨 Enfoque:** Visual y creativo

**🎉 ¡Felicidades!** Has creado tu primera app Flutter personalizada. Ahora tienes las bases para construir aplicaciones más complejas.
