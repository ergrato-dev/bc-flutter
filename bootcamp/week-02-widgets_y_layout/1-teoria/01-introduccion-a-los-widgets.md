# Introducción a los Widgets

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Por qué "todo es un widget" en Flutter
- La diferencia entre `StatelessWidget` y `StatefulWidget`
- Cómo funciona el hot reload y por qué es distinto de recargar la página en web

## 📋 Conceptos Clave

### 1. Todo es un widget

En Flutter, cada elemento visual —un texto, un botón, un espacio en blanco, incluso el layout
que organiza a otros widgets— es un **widget**. Un widget es una descripción inmutable de cómo
debería verse una parte de la interfaz en un momento dado.

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Hola, Flutter')),
      ),
    );
  }
}
```

> 💡 **Diferencia con React Native**: en RN, `<View>`/`<Text>` son componentes que renderizan
> elementos nativos por debajo. En Flutter, los widgets **no** son elementos nativos — Flutter
> dibuja cada píxel con su propio motor de renderizado (Skia/Impeller), lo que da consistencia
> visual perfecta entre iOS y Android.

### 2. `build()` y el widget tree

Cada widget implementa un método `build(BuildContext context)` que retorna **otro widget**
(o un árbol de ellos). Flutter llama a `build()` cada vez que necesita saber qué dibujar — esto
forma el **widget tree**: una jerarquía de widgets anidados, desde `MaterialApp` en la raíz
hasta el `Text` más profundo.

### 3. StatelessWidget vs StatefulWidget

```dart
// StatelessWidget: no tiene estado mutable propio.
// Se reconstruye solo cuando cambian sus parámetros (props) desde afuera.
class Greeting extends StatelessWidget {
  const Greeting({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Text('Hola, $name');
}

// StatefulWidget: tiene estado mutable interno, gestionado por un objeto State separado.
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    // setState() le dice a Flutter: "mi estado cambió, vuelve a llamar build()"
    setState(() => _count++);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _increment,
      child: Text('Toques: $_count'),
    );
  }
}
```

> 💡 **Cuándo usar cada uno**: si el widget solo depende de los parámetros que recibe (props),
> usa `StatelessWidget`. Si necesita recordar algo entre reconstrucciones (un contador, el texto
> de un input, si un checkbox está marcado), usa `StatefulWidget`. Desde semana 4 verás
> alternativas a `setState` para estado que se comparte entre widgets.

### 4. Hot reload vs hot restart

- **Hot reload** (`r` en la consola de `flutter run`): inyecta el código modificado en la app
  corriendo, **preservando el estado actual**. Ideal para ajustar UI rápidamente.
- **Hot restart** (`R`): reinicia la app desde cero, perdiendo el estado. Necesario cuando
  cambias código que Dart no puede recargar en caliente (ej. variables globales, `main()`).

## ⚠️ Errores Comunes

- Olvidar `const` en widgets que no cambian — no es solo estilo, afecta performance (semana 16).
- Poner lógica de negocio dentro de `build()` — este método puede llamarse muchas veces, no debe
  tener efectos secundarios costosos.
- Usar `StatefulWidget` quando `StatelessWidget` bastaría, complicando el código sin necesidad.

## 📚 Recursos Adicionales

- [Flutter — Introduction to widgets](https://docs.flutter.dev/ui/widgets-intro)
- [Flutter — StatefulWidget class](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)

## ✅ Checklist de Verificación

- [ ] Entiendo qué significa "todo es un widget"
- [ ] Sé cuándo usar StatelessWidget vs StatefulWidget
- [ ] Entiendo la diferencia entre hot reload y hot restart
