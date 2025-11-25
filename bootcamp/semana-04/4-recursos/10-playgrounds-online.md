# 💻 Playgrounds Online

## 📋 Contenido

Plataformas para practicar Flutter y navegación sin instalación local.

---

## 🎮 Plataformas Recomendadas

### 1. DartPad

| Campo            | Valor                               |
| ---------------- | ----------------------------------- |
| **URL**          | [dartpad.dev](https://dartpad.dev/) |
| **Soporte**      | Dart + Flutter                      |
| **Nivel**        | 🟢🟡🔴 Todos                        |
| **Limitaciones** | Sin paquetes externos               |

**Características:**

- Editor en navegador
- Ejecución inmediata
- Compartir código via URL
- Ejemplos precargados
- Soporte Flutter web

**Usos para Navegación:**

- Practicar Navigator básico
- Probar transiciones
- Experimentar con widgets
- Prototipar rápido

---

### 2. Zapp.run

| Campo            | Valor                         |
| ---------------- | ----------------------------- |
| **URL**          | [zapp.run](https://zapp.run/) |
| **Soporte**      | Flutter completo              |
| **Nivel**        | 🟡🔴 Intermedio-Avanzado      |
| **Limitaciones** | Requiere cuenta para guardar  |

**Características:**

- IDE completo en navegador
- Soporte de paquetes pub.dev
- Múltiples archivos
- Hot reload
- Compartir proyectos

**Usos para Navegación:**

- Probar go_router
- Proyectos multi-archivo
- Experimentar con paquetes
- Colaboración

---

### 3. FlutLab

| Campo            | Valor                             |
| ---------------- | --------------------------------- |
| **URL**          | [flutlab.io](https://flutlab.io/) |
| **Soporte**      | Flutter completo                  |
| **Nivel**        | 🟡🔴 Intermedio-Avanzado          |
| **Limitaciones** | Tier gratuito limitado            |

**Características:**

- IDE en la nube
- Proyectos guardados
- Build para Android/iOS
- Importar proyectos GitHub

---

### 4. Replit

| Campo            | Valor                             |
| ---------------- | --------------------------------- |
| **URL**          | [replit.com](https://replit.com/) |
| **Soporte**      | Flutter (template)                |
| **Nivel**        | 🟢🟡                              |
| **Limitaciones** | Performance variable              |

**Características:**

- Múltiples lenguajes
- Colaboración en tiempo real
- Terminal integrada
- Hosting gratuito

---

## 📝 Ejercicios para Practicar

### Ejercicio 1: Navigator Básico (DartPad)

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Primera Pantalla')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondScreen(),
              ),
            );
          },
          child: const Text('Ir a Segunda'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segunda Pantalla')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Volver'),
        ),
      ),
    );
  }
}
```

### Ejercicio 2: Pasar Datos (DartPad)

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const ListScreen());
  }
}

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  final items = const ['Flutter', 'Dart', 'Navigator', 'Routes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: items[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item)),
      body: Center(
        child: Text('Detalle de: $item', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
```

### Ejercicio 3: Bottom Navigation (DartPad)

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final _pages = const [
    Center(child: Text('Home', style: TextStyle(fontSize: 32))),
    Center(child: Text('Search', style: TextStyle(fontSize: 32))),
    Center(child: Text('Profile', style: TextStyle(fontSize: 32))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Nav Demo')),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

---

## 🔗 URLs Directas

| Plataforma      | URL                                                              |
| --------------- | ---------------------------------------------------------------- |
| DartPad         | [dartpad.dev](https://dartpad.dev/)                              |
| DartPad Flutter | [dartpad.dev/?id=flutter](https://dartpad.dev/?null_safety=true) |
| Zapp            | [zapp.run](https://zapp.run/)                                    |
| FlutLab         | [flutlab.io](https://flutlab.io/)                                |
| Replit Flutter  | [replit.com/new/flutter](https://replit.com/new/flutter)         |

---

## ✅ Checklist de Práctica

- [ ] Probé DartPad con Flutter
- [ ] Creé navegación básica online
- [ ] Experimenté con pasar datos
- [ ] Practiqué Bottom Navigation
- [ ] Exploré Zapp.run para proyectos complejos
