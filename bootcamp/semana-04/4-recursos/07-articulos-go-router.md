# 📝 Artículos: GoRouter y Paquetes de Routing

## 📋 Contenido

Artículos sobre GoRouter, AutoRoute y otros paquetes de navegación.

---

## 📰 Artículos Recomendados

### 1. GoRouter: The Official Flutter Router

| Campo              | Valor                                                            |
| ------------------ | ---------------------------------------------------------------- |
| **Autor**          | Flutter Team                                                     |
| **Fuente**         | pub.dev / flutter.dev                                            |
| **Tiempo lectura** | 20 min                                                           |
| **Nivel**          | 🟡 Intermedio                                                    |
| **URL**            | [pub.dev/packages/go_router](https://pub.dev/packages/go_router) |

**Resumen:**

- Routing declarativo simplificado
- Deep linking automático
- Redirects y guards
- Sub-routes y shell routes
- Integración con Navigator 2.0

---

### 2. Getting Started with GoRouter

| Campo              | Valor                                            |
| ------------------ | ------------------------------------------------ |
| **Autor**          | Chris Sells                                      |
| **Fuente**         | Medium                                           |
| **Tiempo lectura** | 15 min                                           |
| **Nivel**          | 🟡 Intermedio                                    |
| **URL**            | [medium.com/flutter](https://medium.com/flutter) |

**Resumen:**

- Instalación y configuración
- Definir rutas básicas
- Parámetros de ruta
- Navegación programática
- Error handling

---

### 3. AutoRoute: Code Generation for Routes

| Campo              | Valor                                                              |
| ------------------ | ------------------------------------------------------------------ |
| **Autor**          | Milad Akarie                                                       |
| **Fuente**         | pub.dev                                                            |
| **Tiempo lectura** | 25 min                                                             |
| **Nivel**          | 🔴 Avanzado                                                        |
| **URL**            | [pub.dev/packages/auto_route](https://pub.dev/packages/auto_route) |

**Resumen:**

- Generación de código para rutas
- Type-safe navigation
- Nested navigation
- Route guards
- Tab navigation

---

### 4. Comparativa de Paquetes de Routing

| Campo              | Valor                                      |
| ------------------ | ------------------------------------------ |
| **Autor**          | Varios                                     |
| **Fuente**         | Dev.to                                     |
| **Tiempo lectura** | 18 min                                     |
| **Nivel**          | 🟡 Intermedio                              |
| **URL**            | [dev.to/flutter](https://dev.to/t/flutter) |

**Paquetes comparados:**

- go_router
- auto_route
- beamer
- routemaster
- Navigator 2.0 vanilla

---

## 📊 Comparativa de Paquetes

| Paquete         | Popularidad | Curva | Deep Link | Type-Safe |
| --------------- | ----------- | ----- | --------- | --------- |
| **go_router**   | ⭐⭐⭐⭐⭐  | Media | ✅        | Parcial   |
| **auto_route**  | ⭐⭐⭐⭐    | Alta  | ✅        | ✅        |
| **beamer**      | ⭐⭐⭐      | Alta  | ✅        | Parcial   |
| **routemaster** | ⭐⭐        | Media | ✅        | No        |

---

## 📝 Código de Ejemplo: GoRouter

### Configuración Básica

```dart
// pubspec.yaml
dependencies:
  go_router: ^12.0.0

// lib/config/router.dart
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailsScreen(id: id);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);

// main.dart
MaterialApp.router(
  routerConfig: router,
);
```

### Navegación con GoRouter

```dart
// Navegar a ruta
context.go('/details/123');

// Push (agrega al stack)
context.push('/details/123');

// Pop
context.pop();

// Con query parameters
context.go('/search?query=flutter&page=1');

// Obtener parámetros
final query = GoRouterState.of(context).uri.queryParameters['query'];
```

### Shell Routes (Bottom Navigation)

```dart
GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithBottomNav(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeTab(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchTab(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileTab(),
        ),
      ],
    ),
  ],
);
```

### Redirects y Guards

```dart
GoRouter(
  redirect: (context, state) {
    final isLoggedIn = AuthService.isLoggedIn;
    final isLoggingIn = state.matchedLocation == '/login';

    if (!isLoggedIn && !isLoggingIn) {
      return '/login';
    }
    if (isLoggedIn && isLoggingIn) {
      return '/';
    }
    return null; // No redirect
  },
  routes: [...],
);
```

---

## 🔗 Recursos de Paquetes

### GoRouter

- [Documentación oficial](https://pub.dev/packages/go_router)
- [Migration guide](https://docs.flutter.dev/development/ui/navigation)
- [Examples repository](https://github.com/flutter/packages/tree/main/packages/go_router/example)

### AutoRoute

- [pub.dev/packages/auto_route](https://pub.dev/packages/auto_route)
- [GitHub repository](https://github.com/Milad-Akarie/auto_route_library)

---

## ✅ Checklist de Aprendizaje

- [ ] Instalé y configuré GoRouter
- [ ] Definí rutas con path parameters
- [ ] Implementé query parameters
- [ ] Configuré redirects/guards
- [ ] Exploré ShellRoute para bottom nav
- [ ] Conozco alternativas (auto_route)
