# 📖 Glosario Técnico - Semana 04

## Navegación y Rutas en Flutter

Este glosario contiene los términos técnicos esenciales sobre navegación en Flutter.

---

## 🔤 Índice Alfabético

| Letra | Términos                                         |
| ----- | ------------------------------------------------ |
| **A** | Arguments, AppBar                                |
| **B** | Back Button, BottomNavigationBar, BuildContext   |
| **C** | Context, CupertinoPageRoute                      |
| **D** | Deep Linking, Drawer, DefaultTabController       |
| **G** | GlobalKey, GoRouter                              |
| **I** | IndexedStack, initialRoute                       |
| **M** | MaterialPageRoute, MaterialApp                   |
| **N** | Navigator, NavigatorState, Named Routes          |
| **O** | onGenerateRoute, onUnknownRoute                  |
| **P** | PageRoute, PageRouteBuilder, Pop, PopScope, Push |
| **R** | Route, RouteSettings, Router, RouterDelegate     |
| **S** | Scaffold, ShellRoute, Stack                      |
| **T** | TabBar, TabBarView, TabController                |
| **W** | WillPopScope                                     |

---

## 📚 Definiciones

### A

#### **Arguments**

```
Datos que se pasan entre pantallas durante la navegación.
```

- **Tipo**: `Object?`
- **Uso**: Pasar información de una pantalla a otra
- **Ejemplo**: ID de producto, datos de usuario

```dart
// Enviar
Navigator.pushNamed(context, '/detail', arguments: {'id': '123'});

// Recibir
final args = ModalRoute.of(context)!.settings.arguments as Map;
```

#### **AppBar**

```
Widget que muestra una barra de aplicación en la parte superior de la pantalla.
```

- **Incluye**: Título, acciones, botón de navegación
- **Back button**: Se muestra automáticamente con Navigator

---

### B

#### **Back Button**

```
Botón de retroceso que aparece automáticamente en el AppBar
cuando hay pantallas anteriores en el stack.
```

- **Comportamiento**: Llama a `Navigator.pop()`
- **Personalizable**: Con `leading` en AppBar

#### **BottomNavigationBar**

```
Widget que muestra una barra de navegación en la parte inferior
de la pantalla con múltiples destinos.
```

- **Uso**: Navegación principal entre secciones
- **Máximo recomendado**: 3-5 items
- **Material 3**: Usar `NavigationBar`

```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ],
)
```

#### **BuildContext**

```
Referencia a la ubicación de un widget en el árbol de widgets.
Necesario para acceder al Navigator.
```

- **Uso en navegación**: `Navigator.of(context)`
- **Importante**: El context debe tener acceso al Navigator

---

### C

#### **Context**

```
Ver BuildContext. Término corto para referirse al BuildContext.
```

#### **CupertinoPageRoute**

```
PageRoute que proporciona transiciones estilo iOS (slide from right).
```

- **Animación**: Desliza desde la derecha
- **Gesto**: Swipe back habilitado
- **Uso**: Apps con diseño iOS

```dart
Navigator.push(
  context,
  CupertinoPageRoute(builder: (context) => DetailScreen()),
);
```

---

### D

#### **Deep Linking**

```
Capacidad de abrir una pantalla específica de la app desde una URL externa.
```

- **Ejemplo**: `myapp://products/123`
- **Uso**: Marketing, notificaciones, web
- **Soporte**: Navigator 2.0, GoRouter

#### **DefaultTabController**

```
Widget que proporciona un TabController a sus descendientes.
```

- **Uso**: Simplificar implementación de TabBar
- **Gestiona**: Índice actual y animaciones

```dart
DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(tabs: [...]),
    ),
    body: TabBarView(children: [...]),
  ),
)
```

#### **Drawer**

```
Panel lateral que se desliza desde el borde de la pantalla,
usado para navegación o configuración.
```

- **Apertura**: Swipe o hamburger menu
- **Contenido típico**: Menú de navegación, perfil de usuario

```dart
Scaffold(
  drawer: Drawer(
    child: ListView(
      children: [
        DrawerHeader(...),
        ListTile(title: Text('Home')),
      ],
    ),
  ),
)
```

---

### G

#### **GlobalKey**

```
Clave única que identifica un widget a través de todo el árbol.
```

- **Uso en navegación**: Acceder a NavigatorState desde cualquier lugar
- **Patrón**: Navigation Service

```dart
final navigatorKey = GlobalKey<NavigatorState>();

// Navegar sin context
navigatorKey.currentState?.pushNamed('/route');
```

#### **GoRouter**

```
Paquete oficial de Flutter para routing declarativo.
Simplifica Navigator 2.0.
```

- **Features**: Deep linking, redirects, sub-routes
- **URL**: pub.dev/packages/go_router

```dart
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => HomeScreen()),
    GoRoute(path: '/details/:id', builder: (_, state) => DetailScreen()),
  ],
);
```

---

### I

#### **IndexedStack**

```
Widget que muestra un solo hijo de una lista, manteniendo
el estado de todos los hijos.
```

- **Uso**: Preservar estado en Bottom Navigation
- **Diferencia con PageView**: No hay animación de cambio

```dart
IndexedStack(
  index: _currentIndex,
  children: [
    HomeTab(),    // Estado preservado
    SearchTab(),  // Estado preservado
    ProfileTab(), // Estado preservado
  ],
)
```

#### **initialRoute**

```
La ruta que se muestra cuando la app inicia.
```

- **Default**: `'/'`
- **Configuración**: En MaterialApp

```dart
MaterialApp(
  initialRoute: '/home',
  routes: {...},
)
```

---

### M

#### **MaterialApp**

```
Widget raíz que configura la app con Material Design,
incluyendo navegación.
```

- **Propiedades de navegación**:
  - `routes`: Mapa de rutas nombradas
  - `initialRoute`: Ruta inicial
  - `onGenerateRoute`: Generador de rutas
  - `navigatorKey`: Clave del Navigator

#### **MaterialPageRoute**

```
PageRoute que proporciona transiciones estilo Material Design.
```

- **Animación Android**: Fade + slide up
- **Animación iOS**: Slide from right

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(),
    settings: RouteSettings(name: '/detail'),
  ),
);
```

---

### N

#### **Named Routes (Rutas Nombradas)**

```
Sistema de navegación donde las rutas se identifican por strings.
```

- **Ventajas**: Centralización, mantenibilidad
- **Configuración**: En `routes` de MaterialApp

```dart
// Definir
routes: {
  '/': (context) => HomeScreen(),
  '/detail': (context) => DetailScreen(),
}

// Usar
Navigator.pushNamed(context, '/detail');
```

#### **Navigator**

```
Widget que gestiona un stack de objetos Route.
Implementa navegación estilo stack (LIFO).
```

- **Métodos principales**:
  - `push()`: Agregar ruta al stack
  - `pop()`: Remover ruta del stack
  - `pushReplacement()`: Reemplazar ruta actual
  - `pushAndRemoveUntil()`: Limpiar stack

```dart
// Acceder al Navigator
Navigator.of(context)

// Push
Navigator.push(context, MaterialPageRoute(...));

// Pop
Navigator.pop(context);
```

#### **NavigatorState**

```
Estado del widget Navigator. Permite acceso programático
a las operaciones de navegación.
```

- **Acceso**: Via GlobalKey o Navigator.of(context)

---

### O

#### **onGenerateRoute**

```
Callback que genera rutas dinámicamente cuando se usa pushNamed.
```

- **Uso**: Rutas con argumentos, validación
- **Retorno**: Route o null

```dart
MaterialApp(
  onGenerateRoute: (settings) {
    if (settings.name == '/detail') {
      final args = settings.arguments as DetailArgs;
      return MaterialPageRoute(
        builder: (context) => DetailScreen(args: args),
      );
    }
    return null;
  },
)
```

#### **onUnknownRoute**

```
Callback que maneja rutas no encontradas (404).
```

```dart
MaterialApp(
  onUnknownRoute: (settings) {
    return MaterialPageRoute(
      builder: (context) => NotFoundScreen(),
    );
  },
)
```

---

### P

#### **PageRoute**

```
Clase abstracta base para rutas que ocupan toda la pantalla.
```

- **Subclases**: MaterialPageRoute, CupertinoPageRoute
- **Características**: Transiciones, modal barrier

#### **PageRouteBuilder**

```
PageRoute que permite personalizar las transiciones de navegación.
```

```dart
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(opacity: animation, child: child);
  },
)
```

#### **Pop**

```
Operación que remueve la ruta actual del stack del Navigator.
```

- **Con datos**: `Navigator.pop(context, result)`
- **Verificar**: `Navigator.canPop(context)`

#### **PopScope**

```
Widget que intercepta el gesto de pop (back button).
Reemplazo de WillPopScope en Flutter 3.12+.
```

```dart
PopScope(
  canPop: false,
  onPopInvokedWithResult: (didPop, result) {
    if (!didPop) {
      // Manejar intento de pop
    }
  },
  child: Scaffold(...),
)
```

#### **Push**

```
Operación que agrega una nueva ruta al stack del Navigator.
```

- **Variantes**:
  - `push()`: Push básico
  - `pushNamed()`: Con ruta nombrada
  - `pushReplacement()`: Reemplaza actual
  - `pushAndRemoveUntil()`: Limpia stack

---

### R

#### **Route**

```
Abstracción que representa una entrada en el stack del Navigator.
```

- **Tipos**: PageRoute, PopupRoute, ModalRoute
- **Información**: RouteSettings

#### **RouteSettings**

```
Datos inmutables sobre una ruta: nombre y argumentos.
```

```dart
RouteSettings(
  name: '/detail',
  arguments: {'id': '123'},
)
```

#### **Router (Navigator 2.0)**

```
Widget que configura navegación declarativa con Navigator 2.0.
```

- **Componentes**: RouterDelegate, RouteInformationParser
- **Uso**: Apps complejas, web, deep linking

#### **RouterDelegate**

```
Clase que define cómo el Router construye el Navigator
basado en el estado de la app.
```

---

### S

#### **Scaffold**

```
Estructura visual básica de Material Design que incluye
AppBar, Drawer, BottomNavigationBar, FAB.
```

- **Navegación**: Integra Drawer y BottomNav

#### **ShellRoute (GoRouter)**

```
Ruta que envuelve sub-rutas con UI compartida
(ej: Bottom Navigation persistente).
```

```dart
ShellRoute(
  builder: (context, state, child) => MainShell(child: child),
  routes: [
    GoRoute(path: '/home', ...),
    GoRoute(path: '/profile', ...),
  ],
)
```

#### **Stack (Navigation Stack)**

```
Estructura de datos LIFO (Last In, First Out) que mantiene
el historial de pantallas navegadas.
```

- **Push**: Agregar al tope
- **Pop**: Remover del tope
- **Visualización**: Pantalla actual está en el tope

---

### T

#### **TabBar**

```
Widget que muestra una fila de tabs horizontales.
```

- **Requiere**: TabController o DefaultTabController
- **Compañero**: TabBarView

#### **TabBarView**

```
Widget que muestra el contenido correspondiente al tab seleccionado.
```

- **Sincronizado**: Con TabBar via TabController

#### **TabController**

```
Controlador que sincroniza TabBar con TabBarView.
```

- **Gestiona**: Índice, animación, listeners

---

### W

#### **WillPopScope (Deprecated)**

```
Widget antiguo para interceptar el back button.
Reemplazado por PopScope en Flutter 3.12+.
```

---

## 🔄 Relaciones entre Conceptos

```
MaterialApp
    │
    ├── Navigator (gestiona el stack)
    │       │
    │       ├── Route (entrada en el stack)
    │       │     ├── MaterialPageRoute
    │       │     ├── CupertinoPageRoute
    │       │     └── PageRouteBuilder
    │       │
    │       └── RouteSettings (nombre + argumentos)
    │
    ├── routes (mapa de rutas nombradas)
    │
    ├── onGenerateRoute (rutas dinámicas)
    │
    └── onUnknownRoute (404)
```

---

## 📊 Comparativa Rápida

| Concepto    | Navigator 1.0 | Navigator 2.0 / GoRouter |
| ----------- | ------------- | ------------------------ |
| Estilo      | Imperativo    | Declarativo              |
| Deep Link   | Manual        | Automático               |
| Complejidad | Baja          | Media-Alta               |
| Web         | Limitado      | Completo                 |
| Testing     | Difícil       | Más fácil                |

---

## 🏷️ Tags de Referencia

`#navigation` `#routes` `#navigator` `#flutter` `#push` `#pop` `#bottomnav` `#drawer` `#tabs` `#gorouter` `#deeplink`
