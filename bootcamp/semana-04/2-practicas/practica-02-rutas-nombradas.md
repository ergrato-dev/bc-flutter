# 💻 Práctica 02: Rutas Nombradas

## 📋 Información General

| Campo               | Valor                                               |
| ------------------- | --------------------------------------------------- |
| **Dificultad**      | ⭐⭐ Intermedio                                     |
| **Tiempo estimado** | 30 minutos                                          |
| **Conceptos**       | Named routes, arguments, onGenerateRoute, AppRoutes |

---

## 🎯 Objetivos

- Configurar rutas nombradas en MaterialApp
- Pasar argumentos con pushNamed
- Implementar onGenerateRoute para rutas dinámicas
- Centralizar rutas en una clase

---

## 📝 Descripción

Crearás una **app de catálogo de productos** con múltiples pantallas usando rutas nombradas:

1. **Home**: Pantalla principal con categorías
2. **Productos**: Lista de productos por categoría
3. **Detalle**: Información del producto
4. **Carrito**: Resumen de compra

---

## 🔧 Requisitos Técnicos

- Flutter SDK 3.0+
- Práctica 01 completada (conceptos previos)

---

## 📋 Instrucciones

### Paso 1: Crear el Proyecto

```bash
flutter create practica_rutas_nombradas
cd practica_rutas_nombradas
```

### Paso 2: Definir los Modelos

Crea `lib/models/product.dart`:

```dart
/// Modelo de Producto
class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

/// Datos de ejemplo
class ProductData {
  static const List<Product> products = [
    Product(
      id: '1',
      name: 'Laptop Pro',
      category: 'electronics',
      price: 1299.99,
      imageUrl: 'laptop',
      description: 'Laptop de alto rendimiento',
    ),
    Product(
      id: '2',
      name: 'Smartphone X',
      category: 'electronics',
      price: 899.99,
      imageUrl: 'phone',
      description: 'Último modelo de smartphone',
    ),
    Product(
      id: '3',
      name: 'Camiseta Sport',
      category: 'clothing',
      price: 29.99,
      imageUrl: 'shirt',
      description: 'Camiseta deportiva transpirable',
    ),
    Product(
      id: '4',
      name: 'Zapatillas Runner',
      category: 'clothing',
      price: 89.99,
      imageUrl: 'shoes',
      description: 'Zapatillas para correr',
    ),
  ];

  static List<Product> getByCategory(String category) {
    return products.where((p) => p.category == category).toList();
  }

  static Product? getById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
```

### Paso 3: Crear la Clase de Rutas

Crea `lib/config/routes.dart`:

```dart
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/products_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/not_found_screen.dart';
import '../models/product.dart';

/// Clase que centraliza todas las rutas de la aplicación
///
/// ¿Qué hace? Define nombres de rutas y genera las rutas
/// ¿Para qué? Evitar strings duplicados, facilitar mantenimiento
class AppRoutes {
  // Prevenir instanciación
  AppRoutes._();

  // Nombres de rutas como constantes
  static const String home = '/';
  static const String products = '/products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';

  // Rutas estáticas (sin argumentos)
  static Map<String, WidgetBuilder> get staticRoutes => {
    home: (context) => const HomeScreen(),
    cart: (context) => const CartScreen(),
  };

  /// Generador de rutas dinámicas
  ///
  /// ¿Cómo funciona?
  /// 1. Recibe RouteSettings con nombre y argumentos
  /// 2. Evalúa el nombre de la ruta
  /// 3. Extrae argumentos si los hay
  /// 4. Retorna MaterialPageRoute con la pantalla correspondiente
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // TODO: Implementar generación de rutas
    //
    // Para '/products':
    //   - Extraer categoría de arguments
    //   - Retornar ProductsScreen con la categoría
    //
    // Para '/product-detail':
    //   - Extraer producto de arguments
    //   - Retornar ProductDetailScreen con el producto

    return null;
  }

  /// Ruta para cuando no se encuentra la ruta solicitada
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => NotFoundScreen(routeName: settings.name),
    );
  }
}

/// Clase para argumentos de la pantalla de productos
class ProductsArguments {
  final String category;
  final String categoryName;

  const ProductsArguments({
    required this.category,
    required this.categoryName,
  });
}
```

### Paso 4: Crear las Pantallas

Crea `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../config/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // TODO: Navegar al carrito con ruta nombrada
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categorías',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _CategoryCard(
                    icon: Icons.devices,
                    title: 'Electrónica',
                    color: Colors.blue,
                    onTap: () {
                      // TODO: Navegar a productos con argumentos
                      // Categoría: 'electronics'
                    },
                  ),
                  _CategoryCard(
                    icon: Icons.checkroom,
                    title: 'Ropa',
                    color: Colors.orange,
                    onTap: () {
                      // TODO: Navegar a productos con argumentos
                      // Categoría: 'clothing'
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

Crea `lib/screens/products_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../config/routes.dart';
import '../models/product.dart';

class ProductsScreen extends StatelessWidget {
  final String category;
  final String categoryName;

  const ProductsScreen({
    super.key,
    required this.category,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final products = ProductData.getByCategory(category);

    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: products.isEmpty
          ? const Center(child: Text('No hay productos'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(_getIcon(product.imageUrl)),
                    ),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Navegar al detalle con el producto
                    },
                  ),
                );
              },
            ),
    );
  }

  IconData _getIcon(String imageUrl) {
    switch (imageUrl) {
      case 'laptop':
        return Icons.laptop;
      case 'phone':
        return Icons.phone_android;
      case 'shirt':
        return Icons.checkroom;
      case 'shoes':
        return Icons.directions_run;
      default:
        return Icons.shopping_bag;
    }
  }
}
```

Crea `lib/screens/product_detail_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Nombre
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),

            // Precio
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Descripción
            Text(
              'Descripción',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 24),

            // Botón agregar al carrito
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} agregado al carrito'),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Agregar al Carrito'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

Crea `lib/screens/cart_screen.dart`:

```dart
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Tu carrito está vacío'),
          ],
        ),
      ),
    );
  }
}
```

Crea `lib/screens/not_found_screen.dart`:

```dart
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  final String? routeName;

  const NotFoundScreen({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Página no encontrada',
              style: TextStyle(fontSize: 20),
            ),
            if (routeName != null)
              Text(
                'Ruta: $routeName',
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Paso 5: Actualizar main.dart

```dart
import 'package:flutter/material.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Productos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.staticRoutes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
```

---

## 💡 Pistas

<details>
<summary>Pista 1: Navegar con argumentos</summary>

```dart
Navigator.pushNamed(
  context,
  AppRoutes.products,
  arguments: ProductsArguments(
    category: 'electronics',
    categoryName: 'Electrónica',
  ),
);
```

</details>

<details>
<summary>Pista 2: onGenerateRoute para products</summary>

```dart
if (settings.name == products) {
  final args = settings.arguments as ProductsArguments?;
  if (args != null) {
    return MaterialPageRoute(
      builder: (context) => ProductsScreen(
        category: args.category,
        categoryName: args.categoryName,
      ),
    );
  }
}
```

</details>

---

## ✅ Criterios de Evaluación

| Criterio                         | Puntos |
| -------------------------------- | ------ |
| Rutas nombradas configuradas     | 2      |
| Argumentos pasados correctamente | 2      |
| onGenerateRoute implementado     | 1      |
| Clase AppRoutes centralizada     | 1      |
| **Total**                        | **6**  |

---

## 🚀 Desafío Extra

1. Implementar rutas con parámetros en URL (`/product/123`)
2. Agregar transiciones personalizadas por tipo de ruta
3. Implementar deep linking
