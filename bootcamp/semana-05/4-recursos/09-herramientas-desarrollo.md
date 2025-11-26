# 🔧 Herramientas de Desarrollo

## 🎯 Contenido

Herramientas para debuggear y analizar estado en Flutter.

---

## 🛠️ Flutter DevTools

### Performance Tab

- Analiza rebuilds de widgets
- Identifica reconstrucciones innecesarias
- Timeline de frames

### Widget Inspector

- Árbol de widgets en tiempo real
- Ver providers activos
- Inspeccionar estado

```bash
# Abrir DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

---

## 💻 Extensiones VS Code

| Extensión                     | Descripción             |
| ----------------------------- | ----------------------- |
| **Flutter**                   | Soporte oficial Flutter |
| **Dart**                      | Soporte lenguaje Dart   |
| **Bloc**                      | Snippets para BLoC      |
| **Flutter Riverpod Snippets** | Snippets para Riverpod  |
| **Awesome Flutter Snippets**  | Snippets generales      |

---

## 🔍 Debugging Estado

### Provider

```dart
// Habilitar logs
Provider.debugCheckInvalidValueType = true;
```

### BLoC

```dart
// BlocObserver global
Bloc.observer = SimpleBlocObserver();

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}
```

---

## 📊 Análisis de Rendimiento

- **Flutter Inspector**: Widget rebuilds
- **Performance Overlay**: FPS en tiempo real
- **Timeline**: Análisis detallado de frames

```dart
// Habilitar overlay
MaterialApp(
  showPerformanceOverlay: true,
  // ...
)
```

---

## 🔗 Relacionados

- [Práctica 03: Optimización](../2-practicas/practica-03-selector-performance.md)
