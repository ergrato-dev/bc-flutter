# Introducción a la Navegación y go_router

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- La diferencia entre Navigator 1.0 (imperativo) y Navigator 2.0 (declarativo)
- Por qué este bootcamp usa `go_router` en vez de Navigator puro
- Cómo instalar y configurar `go_router` en una app existente

## 📋 Conceptos Clave

### 1. Navigator 1.0: navegación imperativa

Flutter incluye un sistema de navegación desde el día uno, basado en una pila (stack) de
pantallas que se apilan y desapilan:

```dart
// Navegar hacia adelante (apila una nueva pantalla)
Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreen()));

// Volver atrás (desapila)
Navigator.pop(context);
```

Es **imperativo**: le dices a Flutter paso a paso qué hacer ("apila esto", "desapila"). Funciona
bien para apps simples, pero se vuelve difícil de mantener cuando necesitas: URLs (para Flutter
Web), deep links, o restaurar el estado de navegación tras cerrar y reabrir la app.

### 2. Navigator 2.0 y navegación declarativa

Navigator 2.0 (desde Flutter 1.22) permite describir la navegación como **estado**: "la URL
actual es `/items/42`" en vez de una secuencia de comandos push/pop. Es más potente pero su API
nativa (`Router`, `RouteInformationParser`, `RouterDelegate`) es verbosa para uso diario.

### 3. Por qué go_router

`go_router` es un paquete oficial del equipo de Flutter que envuelve Navigator 2.0 con una API
mucho más simple, manteniendo sus beneficios:

```dart
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/detail', builder: (context, state) => const DetailScreen()),
  ],
);
```

> 💡 **Comparación con React Navigation**: `go_router` es al ecosistema Flutter lo que
> `react-navigation` es a React Native — la solución de navegación de facto, con la diferencia
> de que `go_router` está mantenido por el propio equipo de Flutter (`flutter.dev` como
> publisher), no por un tercero.

Ventajas concretas sobre Navigator 1.0 puro:

- **URLs reales** — funciona en Flutter Web sin código adicional
- **Deep links** — configurar qué pantalla abrir desde un link externo es directo (semana 6 de
  teoría, más abajo en el temario)
- **Rutas anidadas y `ShellRoute`** — navegación con tabs persistentes (verás esto en el
  archivo 4 de esta semana)
- **Redirecciones centralizadas** — útil para proteger rutas que requieren login (lo
  conectarás con autenticación real en semana 9)

### 4. Instalación

```bash
flutter pub add go_router
```

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router en vez de MaterialApp — reemplaza `home:` por el router
    return MaterialApp.router(routerConfig: _router);
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  ],
);
```

> ⚠️ **`MaterialApp.router`, no `MaterialApp`**: es el cambio que más se olvida al agregar
> `go_router` a una app existente — `home:` y `routerConfig:` son mutuamente excluyentes.

## ⚠️ Errores Comunes

- Dejar `MaterialApp` con `home:` en vez de cambiar a `MaterialApp.router`.
- Usar `Navigator.push` mezclado con `go_router` sin necesidad — una vez que adoptas
  `go_router`, navega con `context.go()`/`context.push()` (verás la diferencia en el archivo 2).
- Definir el `GoRouter` dentro de `build()` — debe ser una instancia única (top-level o `final`
  de clase), no se recrea en cada rebuild.

## 📚 Recursos Adicionales

- [go_router — pub.dev](https://pub.dev/packages/go_router)
- [Flutter — Navigation and routing](https://docs.flutter.dev/ui/navigation)
- [go_router — Get started](https://pub.dev/documentation/go_router/latest/topics/Get%20started-topic.html)

## ✅ Checklist de Verificación

- [ ] Entiendo la diferencia entre navegación imperativa y declarativa
- [ ] Sé por qué este curso usa go_router en vez de Navigator puro
- [ ] Puedo configurar `MaterialApp.router` con un `GoRouter` básico
