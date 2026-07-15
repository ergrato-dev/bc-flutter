# MaterialApp, Scaffold y Cupertino

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- El rol de `MaterialApp` como raíz de una app Flutter
- La estructura estándar de una pantalla con `Scaffold`
- Cuándo usar Material vs Cupertino

## 📋 Conceptos Clave

### 1. MaterialApp: la raíz de tu app

```dart
MaterialApp(
  title: 'Mi App',
  theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
  home: const HomeScreen(),
)
```

`MaterialApp` configura cosas transversales a toda la app: tema visual, título (usado por el
sistema operativo), localización y — desde semana 3 — el sistema de navegación.

### 2. Scaffold: el esqueleto de una pantalla

```dart
Scaffold(
  appBar: AppBar(title: const Text('Inicio')),
  body: const Center(child: Text('Contenido de la pantalla')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),
)
```

`Scaffold` implementa la estructura visual básica de Material Design: barra superior (`appBar`),
contenido principal (`body`), botón flotante (`floatingActionButton`), y más (drawer, bottom
navigation bar — los verás cuando arme falta en semanas siguientes).

> 💡 **Diferencia con la web**: no hay "una página HTML por pantalla". Cada pantalla es
> simplemente un widget que retorna un `Scaffold` — la navegación entre "pantallas" (semana 3)
> es en realidad cambiar qué widget está siendo mostrado.

### 3. AppBar y theming básico

```dart
AppBar(
  title: const Text('Mi Dominio'),
  backgroundColor: Theme.of(context).colorScheme.primary,
  actions: [
    IconButton(icon: const Icon(Icons.search), onPressed: () {}),
  ],
)
```

`Theme.of(context)` accede al tema definido en `MaterialApp` — así evitas hardcodear colores
repetidos por toda la app.

### 4. Material vs Cupertino

Flutter incluye dos sistemas de widgets con apariencia distinta:

| | Material | Cupertino |
|---|---|---|
| Inspirado en | Android / Material Design (Google) | iOS (Apple) |
| Widget raíz | `MaterialApp` | `CupertinoApp` |
| Botón típico | `ElevatedButton` | `CupertinoButton` |
| Cuándo usarlo | Por defecto en este curso — funciona bien en ambas plataformas | Cuando quieres que la app se vea 100% nativa de iOS |

```dart
// Un mismo botón, en ambos sistemas:
ElevatedButton(onPressed: () {}, child: const Text('Material'));
CupertinoButton.filled(onPressed: () {}, child: const Text('Cupertino'));
```

> 💡 En este bootcamp usamos **Material** como estándar (igual que la mayoría de apps Flutter en
> producción, incluso las que corren en iOS) — Material se ve bien y es coherente en ambas
> plataformas sin duplicar código de UI.

## ⚠️ Errores Comunes

- Anidar un `Scaffold` dentro de otro sin necesidad (cada pantalla debería tener uno solo).
- Hardcodear colores (`Color(0xFF...)`) en vez de usar `Theme.of(context).colorScheme`.
- Mezclar widgets Material y Cupertino sin un propósito claro — elige un sistema y sé consistente.

## 📚 Recursos Adicionales

- [Flutter — Material Components](https://docs.flutter.dev/ui/widgets/material)
- [Flutter — Cupertino Components](https://docs.flutter.dev/ui/widgets/cupertino)
- [Material 3 en Flutter](https://docs.flutter.dev/ui/design/material)

## ✅ Checklist de Verificación

- [ ] Sé qué configura `MaterialApp` y qué configura `Scaffold`
- [ ] Puedo agregar un `AppBar` con acciones
- [ ] Entiendo cuándo elegir Material sobre Cupertino en este curso
