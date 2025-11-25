# 🎮 10 - Playgrounds y Editores Online

> **Categoría**: Herramientas Online / Playgrounds  
> **Nivel**: Todos  
> **Acceso**: Navegador web (sin instalación)

---

## 🎯 Objetivo

Practicar Dart y Flutter sin instalar nada, directamente desde el navegador.

---

## 🚀 Dart Playgrounds

### 1. **DartPad** ⭐ (Official)

**URL**: [https://dartpad.dev/](https://dartpad.dev/)

**Características**:

- ✅ Editor Dart oficial de Google
- ✅ Syntax highlighting
- ✅ Autocomplete
- ✅ Ejecuta código Dart instantáneamente
- ✅ Soporte para Flutter widgets
- ✅ Modo Flutter UI preview
- ✅ Compartir código con URL

**Modos**:

1. **Dart**: Solo código Dart puro
2. **Flutter**: Widgets y UI preview

**Cómo Usar**:

```dart
// 1. Ve a dartpad.dev
// 2. Escribe código
void main() {
  print('Hola DartPad!');
}

// 3. Click "Run" o Ctrl+Enter
// 4. Ve output en panel derecho
```

**Flutter Mode**:

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('DartPad Flutter')),
        body: Center(
          child: Text('¡Hola desde DartPad!',
            style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
```

**Casos de Uso**:

- 🟢 Probar snippets rápidamente
- 🟢 Experimentar con widgets
- 🟢 Compartir código en foros/chats
- 🟢 Seguir tutoriales sin setup local
- 🟢 Hacer ejercicios del bootcamp

**Limitaciones**:

- ❌ No soporta packages externos (solo core)
- ❌ No persiste código (usa "Share")
- ❌ No testing avanzado

---

### 2. **Repl.it (Dart)**

**URL**: [https://replit.com/languages/dart](https://replit.com/languages/dart)

**Características**:

- ✅ Ejecuta Dart code
- ✅ Multiplayer mode (pair programming)
- ✅ Guarda proyectos en cuenta
- ✅ Git integration
- ✅ Packages soportados

**Ventajas sobre DartPad**:

- Múltiples archivos
- Packages de pub.dev
- Persistencia en la nube
- Colaboración en tiempo real

**Desventajas**:

- No preview de Flutter UI
- Requiere crear cuenta

**Uso**:

```bash
# 1. Crear cuenta en replit.com
# 2. Click "Create Repl"
# 3. Seleccionar "Dart"
# 4. Codificar y Run
```

---

## 📱 Flutter Playgrounds

### 3. **Zapp.run** ⭐ (Flutter Web)

**URL**: [https://zapp.run/](https://zapp.run/)

**Características**:

- ✅ Flutter completo en navegador
- ✅ Hot reload en web
- ✅ Múltiples archivos
- ✅ Soporta packages de pub.dev
- ✅ Preview en tiempo real
- ✅ Compartir proyectos con URL

**Ejemplo de Uso**:

1. Ve a zapp.run
2. Click "New Project"
3. Edita `main.dart`
4. Ve preview a la derecha en tiempo real
5. Agrega packages en `pubspec.yaml`

**Packages Soportados** (parcial):

- provider
- http
- intl
- shared_preferences (simulado)
- Y muchos más

**Casos de Uso**:

- 🟢 Probar apps Flutter completas
- 🟢 Demos y prototipos
- 🟢 Compartir código funcionando
- 🟢 Aprender sin instalar SDK

**Limitaciones**:

- ❌ Performance no tan buena como nativo
- ❌ Algunos packages no funcionan
- ❌ No acceso a features nativas (cámara, GPS)

---

### 4. **FlutLab**

**URL**: [https://flutlab.io/](https://flutlab.io/)

**Características**:

- ✅ IDE Flutter online completo
- ✅ Emulador en navegador
- ✅ GitHub integration
- ✅ Soporte completo de packages
- ✅ Firebase integration

**Versiones**:

- Free tier: Limitado
- Pro: $9/mes - Sin limitaciones

**Ventajas**:

- IDE más completo que Zapp
- Debugging tools
- Terminal integrado

**Desventajas**:

- Requiere cuenta
- Free tier muy limitado
- Puede ser lento

---

### 5. **CodePen** (Flutter Web)

**URL**: [https://codepen.io/](https://codepen.io/)

**Limitado para Flutter**, pero útil para:

- Demos visuales
- Compartir snippets
- Experimentación rápida

---

## 🎓 Playgrounds para Aprendizaje

### 6. **Dart Tutorials - dart.dev**

**URL**: [https://dart.dev/codelabs](https://dart.dev/codelabs)

**Codelabs Interactivos**:

- Todos ejecutables en DartPad
- Guías paso a paso
- Ejercicios con soluciones

**Destacados**:

- Iterable collections
- Asynchronous programming
- Null safety

---

### 7. **Flutter Codelabs**

**URL**: [https://flutter.dev/docs/codelabs](https://flutter.dev/docs/codelabs)

**Tutoriales Interactivos**:

- Ejecutar en DartPad o localmente
- Apps completas
- Material Design

**Recomendados para Semana 02**:

- "Write your first Flutter app"
- "Building layouts"
- "Adding interactivity"

---

## 🔧 Comparativa de Playgrounds

| Feature          | DartPad | Zapp.run   | FlutLab     | Repl.it |
| ---------------- | ------- | ---------- | ----------- | ------- |
| **Dart Puro**    | ✅      | ✅         | ✅          | ✅      |
| **Flutter UI**   | ✅      | ✅         | ✅          | ❌      |
| **Packages**     | ❌      | ✅ Parcial | ✅ Completo | ✅      |
| **Multi-file**   | ❌      | ✅         | ✅          | ✅      |
| **Gratis**       | ✅      | ✅         | 🟡 Limitado | ✅      |
| **Colaboración** | ❌      | ❌         | ✅ Pro      | ✅      |
| **Persistencia** | ❌      | ✅         | ✅          | ✅      |
| **Hot Reload**   | ✅      | ✅         | ✅          | ❌      |

---

## 📚 Cómo Usar Playgrounds en el Bootcamp

### Para Teoría (DartPad)

Mientras lees [`1-teoria/01-poo-dart.md`](../1-teoria/01-poo-dart.md):

1. Abre DartPad en pestaña paralela
2. Copia ejemplos de código
3. Ejecuta y experimenta
4. Modifica para probar variaciones

**Ejemplo**:

```dart
// De la teoría sobre clases
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void greet() => print('Hi, I\'m $name');
}

void main() {
  var person = Person('Ana', 25);
  person.greet();

  // TU EXPERIMENTO: Agregar más métodos
  // Probar diferentes constructores
}
```

---

### Para Prácticas (DartPad o Zapp)

**Ejercicios Dart** → DartPad  
**Ejercicios Flutter** → Zapp.run

**Workflow**:

1. Lee enunciado de práctica
2. Abre playground
3. Intenta resolver (30 min)
4. Compara con solución
5. Guarda tu código (copiar o share link)

---

### Para Proyecto (Local recomendado)

Si NO puedes instalar Flutter localmente:

- Usa **FlutLab** (mejor opción)
- O **Zapp.run** (más ligero)

**Limitación**: No tendrás acceso a features nativas reales.

---

## 💡 Tips para Playgrounds

### DartPad

1. **Keyboard Shortcuts**:

   - `Ctrl+Enter`: Run
   - `Ctrl+/`: Comment line
   - `Ctrl+Space`: Autocomplete
   - `Ctrl+Shift+F`: Format code

2. **Compartir Código**:

   ```
   1. Click "Share" (arriba derecha)
   2. Copia URL generada
   3. Comparte en Discord, foros, etc.
   ```

3. **Modo Flutter**:
   - Toggle "Flutter" en selector arriba izquierda
   - Preview aparece a la derecha

### Zapp.run

1. **Agregar Package**:

   ```yaml
   # En pubspec.yaml (tab arriba)
   dependencies:
     flutter:
       sdk: flutter
     http: ^1.1.0 # Agregar aquí
   ```

2. **Hot Reload Automático**:

   - Guarda archivo (Ctrl+S)
   - Preview se actualiza automáticamente

3. **Crear Múltiples Archivos**:
   ```
   lib/
   ├── main.dart
   ├── models/
   │   └── task.dart
   └── screens/
       └── home_screen.dart
   ```

---

## 🎯 Casos de Uso por Semana

**Semana 02**:

- 📖 Teoría POO → DartPad (probar clases, herencia, mixins)
- 📖 Teoría Colecciones → DartPad (map, where, fold)
- 💻 Práctica 01-03 → DartPad
- 💻 Práctica 04-05 → Zapp.run o DartPad Flutter mode
- 🔨 Proyecto → Local (o FlutLab si no puedes instalar)

**Semana 03-04**:

- Continuar con DartPad para snippets rápidos
- Zapp.run para prototipos de features
- Local para proyecto principal

---

## ✅ Checklist

**Configuración Inicial**:

- [ ] Bookmark DartPad ([dartpad.dev](https://dartpad.dev/))
- [ ] Crear cuenta en Repl.it (opcional)
- [ ] Probar Zapp.run con proyecto de ejemplo
- [ ] Familiarizarte con keyboard shortcuts DartPad

**Durante Bootcamp**:

- [ ] Usar DartPad para probar cada ejemplo de teoría
- [ ] Resolver prácticas Dart en DartPad
- [ ] Experimentar con Flutter en Zapp.run
- [ ] Compartir código con compañeros vía links

---

## 🔗 Recursos Relacionados

- Ver: [`09-herramientas-desarrollo.md`](09-herramientas-desarrollo.md) - IDEs locales
- Ver: [`08-documentacion-oficial.md`](08-documentacion-oficial.md) - Docs con DartPad embebido
- **Codelabs**: [https://dart.dev/codelabs](https://dart.dev/codelabs)

---

## 🚀 Ventajas de Playgrounds

**Para Aprender**:

- ✅ Cero configuración
- ✅ Feedback inmediato
- ✅ Bajo commitment
- ✅ Accesible desde cualquier dispositivo

**Para Enseñar/Compartir**:

- ✅ Enlaces directos a código funcionando
- ✅ No requiere que otros instalen nada
- ✅ Ideal para demos y tutoriales

**Para Experimentar**:

- ✅ Probar ideas rápidamente
- ✅ Sin miedo a "romper" nada local
- ✅ Iterar velozmente

---

**Actualizado**: Noviembre 2025 | **Nivel**: Semana 02 | **Tipo**: Herramientas Online
