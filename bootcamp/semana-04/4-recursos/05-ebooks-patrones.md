# 📖 eBooks: Patrones de Diseño Flutter

## 📋 Contenido

Libros sobre arquitectura, patrones y mejores prácticas en Flutter.

---

## 📚 eBooks Recomendados

### 1. Flutter Architecture Blueprints

| Campo | Valor |
|-------|-------|
| **Autor** | wasabeef |
| **Formato** | GitHub Repository |
| **Idioma** | Inglés |
| **Precio** | Gratis |
| **URL** | [github.com/wasabeef/flutter-architecture-blueprints](https://github.com/wasabeef/flutter-architecture-blueprints) |

**Contenido:**
- Clean Architecture
- MVVM Pattern
- Repository Pattern
- Navigation patterns
- Dependency Injection

---

### 2. Pragmatic Flutter

| Campo | Valor |
|-------|-------|
| **Autor** | Priyanka Tyagi |
| **Editorial** | CRC Press |
| **Capítulos Relevantes** | 6, 7, 8 |
| **Idioma** | Inglés |
| **Precio** | Pago |
| **URL** | [amazon.com](https://www.amazon.com/Pragmatic-Flutter-Building-Cross-Platform-Applications/dp/0367612070) |

**Contenido:**
- App architecture
- State management
- Navigation strategies
- Scalable patterns

---

### 3. Clean Architecture for Flutter

| Campo | Valor |
|-------|-------|
| **Autor** | Reso Coder |
| **Formato** | Tutorial Series + eBook |
| **Idioma** | Inglés |
| **Precio** | Gratis |
| **URL** | [resocoder.com/flutter-clean-architecture](https://resocoder.com/category/tutorials/flutter/tdd-clean-architecture/) |

**Contenido:**
- Capas de arquitectura
- Casos de uso
- Entities y Models
- Presentación y navegación
- Testing

---

### 4. Design Patterns in Dart and Flutter

| Campo | Valor |
|-------|-------|
| **Autor** | Varios |
| **Formato** | Web/PDF |
| **Idioma** | Inglés |
| **Precio** | Gratis |
| **URL** | [dart.dev/guides/language/effective-dart](https://dart.dev/guides/language/effective-dart) |

**Patrones Cubiertos:**
- Singleton
- Factory
- Builder
- Observer
- Strategy

---

## 🏗️ Patrones de Navegación

### Navigation Service Pattern

```dart
/// Servicio centralizado de navegación
/// 
/// ¿Qué hace? Abstrae la navegación del contexto
/// ¿Para qué? Testing y desacoplamiento
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }
}
```

### Router Pattern

```dart
/// Router centralizado con factory
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/details':
        final args = settings.arguments as DetailsArgs;
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(args: args),
        );
      default:
        return MaterialPageRoute(builder: (_) => NotFoundScreen());
    }
  }
}
```

---

## 📁 Carpeta ebooks-free/

| Archivo | Descripción |
|---------|-------------|
| `clean-architecture-flutter.pdf` | Guía de arquitectura limpia |
| `design-patterns-dart.pdf` | Patrones en Dart |
| `flutter-scalable-folder-structure.pdf` | Estructura de proyectos |

---

## 📝 Conceptos Clave

### Principios SOLID en Flutter

| Principio | Aplicación en Navegación |
|-----------|-------------------------|
| **S**ingle Responsibility | Una clase para rutas |
| **O**pen/Closed | Rutas extensibles |
| **L**iskov Substitution | Screens intercambiables |
| **I**nterface Segregation | Interfaces específicas |
| **D**ependency Inversion | Inyectar NavigationService |

### Checklist de Arquitectura

- [ ] Entiendo Clean Architecture
- [ ] Aplico separación de capas
- [ ] Uso Navigation Service
- [ ] Implemento Router centralizado
- [ ] Mis rutas son testeables
