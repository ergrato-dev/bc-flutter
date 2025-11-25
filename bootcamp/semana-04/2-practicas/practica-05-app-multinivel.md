# 💻 Práctica 05: App Multi-Nivel

## 📋 Información General

| Campo | Valor |
|-------|-------|
| **Dificultad** | ⭐⭐⭐ Avanzado |
| **Tiempo estimado** | 40 minutos |
| **Conceptos** | Navegación compleja, tabs + drawer, navegación anidada |

---

## 🎯 Objetivos

- Combinar múltiples patrones de navegación
- Implementar navegación anidada por tabs
- Gestionar flujos de navegación complejos
- Manejar el back button correctamente

---

## 📝 Descripción

Crearás una **app de e-commerce completa** que combina:
- **Drawer**: Menú lateral con categorías y configuración
- **BottomNavigation**: Home, Categorías, Carrito, Perfil
- **Navegación interna**: Cada tab tiene su propio flujo
- **Rutas nombradas**: Para pantallas principales

---

## 📋 Instrucciones

### Paso 1: Crear el Proyecto

```bash
flutter create practica_app_multinivel
cd practica_app_multinivel
```

### Paso 2: Configurar Rutas

Crea `lib/config/routes.dart`:

```dart
import 'package:flutter/material.dart';
import '../screens/main_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String main = '/';
  static const String productDetail = '/product-detail';
  static const String checkout = '/checkout';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes => {
    main: (context) => const MainScreen(),
    login: (context) => const LoginScreen(),
    checkout: (context) => const CheckoutScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == productDetail) {
      final productId = settings.arguments as String?;
      return MaterialPageRoute(
        builder: (context) => ProductDetailScreen(productId: productId ?? ''),
      );
    }
    return null;
  }
}
```

### Paso 3: Crear la Pantalla Principal

Crea `lib/screens/main_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'tabs/home_tab.dart';
import 'tabs/categories_tab.dart';
import 'tabs/cart_tab.dart';
import 'tabs/profile_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0;

  // Keys para navegación anidada
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        // Intentar pop en el navigator del tab actual
        final navigator = _navigatorKeys[_currentTab].currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
        }
      },
      child: Scaffold(
        drawer: _buildDrawer(),
        body: IndexedStack(
          index: _currentTab,
          children: [
            _buildTabNavigator(0, const HomeTab()),
            _buildTabNavigator(1, const CategoriesTab()),
            _buildTabNavigator(2, const CartTab()),
            _buildTabNavigator(3, const ProfileTab()),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentTab,
          onDestinationSelected: (index) {
            if (index == _currentTab) {
              // Tap en tab actual: ir al inicio
              _navigatorKeys[index].currentState?.popUntil(
                (route) => route.isFirst,
              );
            } else {
              setState(() => _currentTab = index);
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined),
              selectedIcon: Icon(Icons.category),
              label: 'Categorías',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: 'Carrito',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNavigator(int index, Widget child) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.store, size: 30),
                ),
                SizedBox(height: 8),
                Text(
                  'Mi Tienda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.local_offer),
            title: const Text('Ofertas'),
            onTap: () {
              Navigator.pop(context);
              // Navegar a ofertas
            },
          ),
          ListTile(
            leading: const Icon(Icons.new_releases),
            title: const Text('Novedades'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Ayuda'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
```

### Paso 4: Crear los Tabs

Crea `lib/screens/tabs/home_tab.dart`:

```dart
import 'package:flutter/material.dart';
import '../../config/routes.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              height: 150,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '¡Ofertas de Temporada!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Productos destacados
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Productos Destacados',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _ProductCard(
                    productId: 'product_$index',
                    name: 'Producto ${index + 1}',
                    price: (index + 1) * 29.99,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.productDetail,
                        arguments: 'product_$index',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String productId;
  final String name;
  final double price;
  final VoidCallback onTap;

  const _ProductCard({
    required this.productId,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.green[700]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

Crea `lib/screens/tabs/categories_tab.dart`:

```dart
import 'package:flutter/material.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Electrónica', 'icon': Icons.devices, 'count': 42},
      {'name': 'Ropa', 'icon': Icons.checkroom, 'count': 128},
      {'name': 'Hogar', 'icon': Icons.home, 'count': 65},
      {'name': 'Deportes', 'icon': Icons.sports_soccer, 'count': 34},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(cat['icon'] as IconData),
              ),
              title: Text(cat['name'] as String),
              subtitle: Text('${cat['count']} productos'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navegar a lista de productos de la categoría
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsScreen(
                      category: cat['name'] as String,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 40),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Producto ${index + 1}'),
                      Text(
                        '\$${(index + 1) * 19.99}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

Crea `lib/screens/tabs/cart_tab.dart`:

```dart
import 'package:flutter/material.dart';
import '../../config/routes.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image),
                  ),
                  title: Text('Producto ${index + 1}'),
                  subtitle: Text('\$${(index + 1) * 29.99}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      const Text('1'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total'),
                    Text(
                      '\$179.97',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.checkout);
                  },
                  child: const Text('Pagar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

Crea `lib/screens/tabs/profile_tab.dart`:

```dart
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          const Text(
            'Usuario Demo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Mis Pedidos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Direcciones'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Métodos de Pago'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
```

### Paso 5: Crear Pantallas Adicionales

Crea `lib/screens/product_detail_screen.dart`:

```dart
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Producto $productId')),
      body: const Center(child: Text('Detalle del producto')),
    );
  }
}
```

Crea `lib/screens/checkout_screen.dart`:

```dart
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: const Center(child: Text('Proceso de pago')),
    );
  }
}
```

Crea `lib/screens/login_screen.dart`:

```dart
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(child: Text('Pantalla de login')),
    );
  }
}
```

### Paso 6: Actualizar main.dart

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
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.main,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
```

---

## ✅ Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| Navegación combinada (drawer + bottom) | 2 |
| Navegación anidada funcional | 2 |
| Manejo correcto del back button | 1 |
| Rutas nombradas implementadas | 1 |
| **Total** | **6** |

---

## 🚀 Desafío Extra

1. Agregar animaciones de transición personalizadas
2. Implementar deep linking
3. Agregar persistencia del estado de navegación
