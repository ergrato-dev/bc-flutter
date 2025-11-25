# 🎮 10 - Playgrounds Online

> Entornos online para practicar Flutter sin instalación.

---

## 🌐 Playgrounds Oficiales

| Plataforma  | Descripción         | URL                 |
| ----------- | ------------------- | ------------------- |
| **DartPad** | Playground oficial  | https://dartpad.dev |
| **Zapp!**   | IDE Flutter online  | https://zapp.run    |
| **FlutLab** | IDE completo online | https://flutlab.io  |

---

## 🎯 DartPad - Cómo Usar

### Características

- ✅ Ejecutar código Dart y Flutter
- ✅ Ejemplos preconfigurados
- ✅ Compartir código
- ✅ Sin registro necesario

### Ejemplos de Widgets

1. Ir a https://dartpad.dev
2. Seleccionar "New Pad" → "Flutter"
3. Probar los widgets de la semana

### Código de Inicio

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('¡Hola Flutter!'),
        ),
      ),
    );
  }
}
```

---

## 📚 Ejemplos en DartPad

| Ejemplo     | Tema           | URL                                           |
| ----------- | -------------- | --------------------------------------------- |
| Counter App | StatefulWidget | [Abrir](https://dartpad.dev/?sample=counter)  |
| Layouts     | Row/Column     | [Abrir](https://dartpad.dev/?sample=layouts)  |
| ListView    | Listas         | [Abrir](https://dartpad.dev/?sample=listview) |
