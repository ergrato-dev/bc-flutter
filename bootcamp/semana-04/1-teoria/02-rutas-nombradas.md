# 📚 Módulo 02: Rutas Nombradas y Generación de Rutas

## 🎯 Objetivos del Módulo

- Configurar rutas nombradas en MaterialApp
- Navegar usando nombres de rutas
- Pasar argumentos con rutas nombradas
- Implementar onGenerateRoute para rutas dinámicas
- Manejar rutas desconocidas

## ⏱️ Tiempo Estimado: 50 minutos

---

## 📚 Contenido

### 2.1 ¿Qué son las Rutas Nombradas?

Las **rutas nombradas** permiten definir todas las rutas de la app en un solo lugar y navegar usando strings como identificadores.

```
┌─────────────────────────────────────────────────────────────┐
│                    RUTAS NOMBRADAS                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   MaterialApp(                                              │
│     routes: {                                               │
│       '/': (ctx) => HomeScreen(),                           │
│       '/products': (ctx) => ProductsScreen(),               │
│       '/product-detail': (ctx) => DetailScreen(),           │
│       '/settings': (ctx) => SettingsScreen(),               │
│     }                                                       │
│   )                                                         │
│                                                             │
│   Navegación:                                               │
│   Navigator.pushNamed(context, '/products')                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Ventajas:**

- Rutas centralizadas y fáciles de mantener
- Nombres descriptivos y consistentes
- Facilita deep linking
- Mejor organización en apps grandes

---

### 2.2 Configuración Básica de Rutas

```dart
/**
 * Configuración de rutas nombradas en MaterialApp
 *
 * ¿Qué hace?
 * Define un mapa de rutas donde la clave es el nombre
 * y el valor es un builder que retorna el widget
 *
 * ¿Para qué?
 * Centralizar todas las rutas de la aplicación
 *
 * ¿Cómo funciona?
 * 1. Se define routes: {} en MaterialApp
 * 2. Cada ruta tiene un nombre (String) y un builder
 * 3. Se navega con Navigator.pushNamed()
 */

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App con Rutas Nombradas',

      // Ruta inicial
      initialRoute: '/',

      // Definición de rutas
      routes: {
        '/': (context) => const HomeScreen(),
        '/products': (context) => const ProductsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
```

---

### 2.3 Navegación con Rutas Nombradas

```dart
/**
 * Navigator.pushNamed()
 *
 * ¿Qué hace?
 * Navega a una ruta usando su nombre
 *
 * ¿Para qué?
 * Navegación más limpia y mantenible
 */

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Navegación con ruta nombrada
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/products');
              },
              child: const Text('Ver Productos'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Configuración'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Text('Mi Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 2.4 Pasar Argumentos con Rutas Nombradas

```dart
/**
 * Pasar argumentos a rutas nombradas
 *
 * ¿Qué hace?
 * Envía datos junto con la navegación nombrada
 *
 * ¿Para qué?
 * Pasar información como ID, objetos, configuraciones
 *
 * ¿Cómo funciona?
 * 1. Se envía con el parámetro arguments
 * 2. Se recibe con ModalRoute.of(context)?.settings.arguments
 */

// Modelo de datos
class Product {
  final String id;
  final String name;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.price,
  });
}

// Pantalla de lista - envía argumentos
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static const products = [
    Product(id: '1', name: 'Laptop', price: 999.99),
    Product(id: '2', name: 'Phone', price: 699.99),
    Product(id: '3', name: 'Tablet', price: 499.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            onTap: () {
              // Navegar pasando el producto como argumento
              Navigator.pushNamed(
                context,
                '/product-detail',
                arguments: product,
              );
            },
          );
        },
      ),
    );
  }
}

// Pantalla de detalle - recibe argumentos
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener argumentos de la ruta
    final product = ModalRoute.of(context)?.settings.arguments as Product?;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Producto no encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('ID: ${product.id}'),
          ],
        ),
      ),
    );
  }
}
```

---

### 2.5 Clase de Argumentos Tipada

```dart
/**
 * Usar clases específicas para argumentos
 *
 * ¿Qué hace?
 * Define una clase para los argumentos de cada pantalla
 *
 * ¿Para qué?
 * - Type safety (seguridad de tipos)
 * - Múltiples parámetros organizados
 * - Documentación implícita
 */

// Clase de argumentos para la pantalla de detalle
class ProductDetailArguments {
  final String productId;
  final bool showReviews;
  final String? referralCode;

  const ProductDetailArguments({
    required this.productId,
    this.showReviews = false,
    this.referralCode,
  });
}

// Enviar argumentos tipados
Navigator.pushNamed(
  context,
  '/product-detail',
  arguments: ProductDetailArguments(
    productId: '123',
    showReviews: true,
    referralCode: 'PROMO2024',
  ),
);

// Recibir argumentos tipados
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as ProductDetailArguments?;

    if (args == null) {
      return const Scaffold(
        body: Center(child: Text('Argumentos inválidos')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Producto ${args.productId}')),
      body: Column(
        children: [
          Text('ID: ${args.productId}'),
          if (args.showReviews) const Text('Mostrando reviews...'),
          if (args.referralCode != null)
            Text('Código: ${args.referralCode}'),
        ],
      ),
    );
  }
}
```

---

### 2.6 onGenerateRoute - Rutas Dinámicas

```dart
/**
 * onGenerateRoute
 *
 * ¿Qué hace?
 * Genera rutas dinámicamente cuando no están en el mapa routes
 *
 * ¿Para qué?
 * - Rutas con parámetros en la URL (/product/123)
 * - Lógica condicional de navegación
 * - Parseo de deep links
 *
 * ¿Cómo funciona?
 * 1. Se llama cuando la ruta no está en routes
 * 2. Recibe RouteSettings con nombre y argumentos
 * 3. Retorna un Route o null
 */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App con onGenerateRoute',
      initialRoute: '/',

      // Rutas estáticas
      routes: {
        '/': (context) => const HomeScreen(),
        '/products': (context) => const ProductsScreen(),
      },

      // Rutas dinámicas
      onGenerateRoute: (settings) {
        // Parsear rutas como /product/123
        if (settings.name?.startsWith('/product/') ?? false) {
          final productId = settings.name!.split('/').last;
          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(productId: productId),
            settings: settings,
          );
        }

        // Parsear rutas como /user/456/posts
        final uri = Uri.parse(settings.name ?? '');
        if (uri.pathSegments.length >= 2 &&
            uri.pathSegments[0] == 'user') {
          final userId = uri.pathSegments[1];

          if (uri.pathSegments.length == 3 &&
              uri.pathSegments[2] == 'posts') {
            return MaterialPageRoute(
              builder: (context) => UserPostsScreen(userId: userId),
            );
          }

          return MaterialPageRoute(
            builder: (context) => UserProfileScreen(userId: userId),
          );
        }

        // Ruta no encontrada
        return null;
      },

      // Ruta cuando no se encuentra ninguna
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
      },
    );
  }
}

// Pantalla de detalle con ID desde la URL
class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Producto $productId')),
      body: Center(
        child: Text('Mostrando producto: $productId'),
      ),
    );
  }
}

// Navegación a ruta dinámica
Navigator.pushNamed(context, '/product/123');
Navigator.pushNamed(context, '/user/456');
Navigator.pushNamed(context, '/user/456/posts');
```

---

### 2.7 Centralizar Rutas en una Clase

```dart
/**
 * Clase AppRoutes - Centralización de rutas
 *
 * ¿Qué hace?
 * Centraliza todos los nombres de rutas y la lógica de generación
 *
 * ¿Para qué?
 * - Evitar strings duplicados
 * - Autocompletado en el IDE
 * - Mantenimiento más fácil
 * - Single source of truth
 */

// Archivo: lib/config/routes.dart
class AppRoutes {
  // Prevenir instanciación
  AppRoutes._();

  // Nombres de rutas como constantes
  static const String home = '/';
  static const String products = '/products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String register = '/register';

  // Mapa de rutas estáticas
  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomeScreen(),
    products: (context) => const ProductsScreen(),
    cart: (context) => const CartScreen(),
    settings: (context) => const SettingsScreen(),
    profile: (context) => const ProfileScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
  };

  // Generador de rutas dinámicas
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productDetail:
        final product = settings.arguments as Product?;
        if (product != null) {
          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          );
        }
        return _errorRoute('Producto no especificado');

      case checkout:
        final cartItems = settings.arguments as List<CartItem>?;
        if (cartItems != null) {
          return MaterialPageRoute(
            builder: (context) => CheckoutScreen(items: cartItems),
          );
        }
        return _errorRoute('Carrito vacío');

      default:
        return null;
    }
  }

  // Ruta de error
  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(message)),
      ),
    );
  }

  // Ruta desconocida
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundScreen(),
    );
  }
}

// Uso en MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}

// Uso en navegación
Navigator.pushNamed(context, AppRoutes.products);
Navigator.pushNamed(context, AppRoutes.productDetail, arguments: product);
```

---

### 2.8 Rutas con Retorno de Datos

```dart
/**
 * pushNamed con retorno de datos
 *
 * ¿Qué hace?
 * Navega a una ruta nombrada y espera un resultado
 */

// Navegar y esperar resultado
Future<void> _selectCategory() async {
  final selectedCategory = await Navigator.pushNamed<String>(
    context,
    AppRoutes.categorySelector,
  );

  if (selectedCategory != null) {
    setState(() {
      _category = selectedCategory;
    });
  }
}

// Pantalla que retorna resultado
class CategorySelectorScreen extends StatelessWidget {
  const CategorySelectorScreen({super.key});

  static const categories = ['Electrónica', 'Ropa', 'Hogar', 'Deportes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Categoría')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              Navigator.pop(context, categories[index]);
            },
          );
        },
      ),
    );
  }
}
```

---

### 2.9 pushReplacementNamed y pushNamedAndRemoveUntil

```dart
/**
 * Variantes de navegación nombrada
 */

// Reemplazar pantalla actual
Navigator.pushReplacementNamed(context, AppRoutes.home);

// Limpiar stack y navegar
Navigator.pushNamedAndRemoveUntil(
  context,
  AppRoutes.login,
  (route) => false, // Remover todas las rutas
);

// Navegar y remover hasta cierta ruta
Navigator.pushNamedAndRemoveUntil(
  context,
  AppRoutes.home,
  ModalRoute.withName(AppRoutes.home), // Mantener home
);

// Ejemplo: Flujo de login
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLogin(BuildContext context) {
    // Simular login exitoso
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _handleLogin(context),
          child: const Text('Iniciar Sesión'),
        ),
      ),
    );
  }
}

// Ejemplo: Logout
void _handleLogout(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.login,
    (route) => false,
  );
}
```

---

## 💡 Puntos Clave

1. **routes: {}** define rutas estáticas en MaterialApp
2. **pushNamed()** navega usando el nombre de la ruta
3. **arguments** permite pasar datos con rutas nombradas
4. **onGenerateRoute** maneja rutas dinámicas
5. **Centralizar rutas** en una clase mejora mantenibilidad
6. **Usar constantes** para nombres de rutas evita typos

---

## ⚠️ Errores Comunes

### ❌ Typo en nombre de ruta

```dart
// MALO: Fácil de equivocarse
Navigator.pushNamed(context, '/produts'); // Typo!

// BUENO: Usar constantes
Navigator.pushNamed(context, AppRoutes.products);
```

### ❌ No manejar argumentos null

```dart
// MALO: Crash si arguments es null
final product = ModalRoute.of(context)!.settings.arguments as Product;

// BUENO: Manejar null safety
final args = ModalRoute.of(context)?.settings.arguments;
if (args is! Product) {
  return const ErrorScreen();
}
final product = args;
```

---

## 🔗 Referencias

- [Named Routes - Flutter Docs](https://docs.flutter.dev/cookbook/navigation/named-routes)
- [Pass Arguments to Named Route](https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments)

---

## ✅ Autoevaluación

1. ¿Dónde se definen las rutas nombradas?
2. ¿Cómo paso argumentos con pushNamed?
3. ¿Para qué sirve onGenerateRoute?
4. ¿Cuál es la ventaja de centralizar rutas en una clase?
5. ¿Cómo manejo una ruta desconocida?
