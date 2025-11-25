# 📚 Módulo 03: Navegación Avanzada

## 🎯 Objetivos del Módulo

- Implementar navegación con BottomNavigationBar
- Crear Drawer navigation
- Configurar TabBar y TabBarView
- Implementar navegación anidada
- Mantener estado entre tabs

## ⏱️ Tiempo Estimado: 50 minutos

---

## 📚 Contenido

### 3.1 BottomNavigationBar

```dart
/**
 * BottomNavigationBar
 *
 * ¿Qué hace?
 * Barra de navegación inferior con múltiples destinos
 *
 * ¿Para qué?
 * - Navegación principal entre secciones
 * - Acceso rápido a funcionalidades principales
 * - Patrón común en apps móviles
 *
 * ¿Cómo funciona?
 * 1. Se define en Scaffold.bottomNavigationBar
 * 2. Cada item representa una sección
 * 3. onTap cambia el índice seleccionado
 * 4. El body muestra la pantalla correspondiente
 */

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Lista de pantallas
  final List<Widget> _screens = const [
    HomeTab(),
    SearchTab(),
    FavoritesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, // Para 4+ items
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// Pantallas individuales
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: const Center(child: Text('Pantalla de Inicio')),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar')),
      body: const Center(child: Text('Pantalla de Búsqueda')),
    );
  }
}

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: const Center(child: Text('Pantalla de Favoritos')),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: const Center(child: Text('Pantalla de Perfil')),
    );
  }
}
```

---

### 3.2 Preservar Estado con IndexedStack

```dart
/**
 * IndexedStack para mantener estado
 *
 * ¿Qué hace?
 * Mantiene todos los widgets en memoria, mostrando solo uno
 *
 * ¿Para qué?
 * Preservar el estado de cada tab (scroll position, datos cargados)
 *
 * ¿Cómo funciona?
 * - Todos los hijos se construyen y mantienen en memoria
 * - Solo el hijo con el índice actual es visible
 * - Al cambiar de tab, el estado previo se conserva
 */

class MainScreenWithState extends StatefulWidget {
  const MainScreenWithState({super.key});

  @override
  State<MainScreenWithState> createState() => _MainScreenWithStateState();
}

class _MainScreenWithStateState extends State<MainScreenWithState> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack preserva el estado de cada tab
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeTab(),
          SearchTab(),
          FavoritesTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
```

---

### 3.3 NavigationBar (Material 3)

```dart
/**
 * NavigationBar - Material 3
 *
 * ¿Qué hace?
 * Versión moderna de BottomNavigationBar siguiendo Material 3
 *
 * ¿Para qué?
 * Apps que usan Material Design 3 (Flutter 3.0+)
 */

class MainScreenM3 extends StatefulWidget {
  const MainScreenM3({super.key});

  @override
  State<MainScreenM3> createState() => _MainScreenM3State();
}

class _MainScreenM3State extends State<MainScreenM3> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
        HomeTab(),
        SearchTab(),
        FavoritesTab(),
        ProfileTab(),
      ][_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Buscar',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
```

---

### 3.4 Drawer Navigation

```dart
/**
 * Drawer - Menú lateral deslizable
 *
 * ¿Qué hace?
 * Panel lateral que se desliza desde el borde de la pantalla
 *
 * ¿Para qué?
 * - Navegación secundaria
 * - Acceso a configuraciones
 * - Información del usuario
 * - Muchas opciones de menú
 */

class HomeWithDrawer extends StatelessWidget {
  const HomeWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi App'),
        // El icono de menú aparece automáticamente
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header del drawer
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 35),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Juan Pérez',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'juan@email.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Items del menú
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              selected: true,
              onTap: () {
                Navigator.pop(context); // Cerrar drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Mis Pedidos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/orders');
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/favorites');
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/help');
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Contenido Principal'),
      ),
    );
  }
}
```

---

### 3.5 UserAccountsDrawerHeader

```dart
/**
 * UserAccountsDrawerHeader
 *
 * ¿Qué hace?
 * Header prediseñado para drawer con información de usuario
 */

Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: const Text('Juan Pérez'),
        accountEmail: const Text('juan@email.com'),
        currentAccountPicture: const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://example.com/avatar.jpg',
          ),
        ),
        otherAccountsPictures: const [
          CircleAvatar(
            child: Text('JP'),
          ),
        ],
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        onDetailsPressed: () {
          // Mostrar selector de cuentas
        },
      ),
      // ... menu items
    ],
  ),
)
```

---

### 3.6 NavigationDrawer (Material 3)

```dart
/**
 * NavigationDrawer - Material 3
 *
 * Versión moderna del Drawer siguiendo Material 3
 */

class HomeWithNavigationDrawer extends StatefulWidget {
  const HomeWithNavigationDrawer({super.key});

  @override
  State<HomeWithNavigationDrawer> createState() =>
      _HomeWithNavigationDrawerState();
}

class _HomeWithNavigationDrawerState extends State<HomeWithNavigationDrawer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi App')),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          Navigator.pop(context); // Cerrar drawer
        },
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text('Menú Principal'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Text('Inicio'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: Text('Notificaciones'),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text('Configuración'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: Text('Ajustes'),
          ),
        ],
      ),
      body: const Center(child: Text('Contenido')),
    );
  }
}
```

---

### 3.7 TabBar y TabBarView

```dart
/**
 * TabBar - Navegación por pestañas
 *
 * ¿Qué hace?
 * Pestañas horizontales para cambiar entre vistas relacionadas
 *
 * ¿Para qué?
 * - Contenido relacionado en categorías
 * - Filtros rápidos
 * - Secciones de una misma pantalla
 */

class ProductsWithTabs extends StatefulWidget {
  const ProductsWithTabs({super.key});

  @override
  State<ProductsWithTabs> createState() => _ProductsWithTabsState();
}

class _ProductsWithTabsState extends State<ProductsWithTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.phone_android), text: 'Móviles'),
            Tab(icon: Icon(Icons.laptop), text: 'Laptops'),
            Tab(icon: Icon(Icons.tablet), text: 'Tablets'),
            Tab(icon: Icon(Icons.watch), text: 'Wearables'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MobilesTab(),
          LaptopsTab(),
          TabletsTab(),
          WearablesTab(),
        ],
      ),
    );
  }
}

// Tab individual
class MobilesTab extends StatelessWidget {
  const MobilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.phone_android),
          title: Text('Móvil ${index + 1}'),
          subtitle: Text('\$${(index + 1) * 100}'),
        );
      },
    );
  }
}
```

---

### 3.8 DefaultTabController (Simplificado)

```dart
/**
 * DefaultTabController
 *
 * ¿Qué hace?
 * Proporciona un TabController implícito para TabBar y TabBarView
 *
 * ¿Para qué?
 * Simplificar el código cuando no necesitas control manual
 */

class SimpleTabsScreen extends StatelessWidget {
  const SimpleTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Noticias'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Recientes'),
              Tab(text: 'Populares'),
              Tab(text: 'Guardadas'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Noticias Recientes')),
            Center(child: Text('Noticias Populares')),
            Center(child: Text('Noticias Guardadas')),
          ],
        ),
      ),
    );
  }
}
```

---

### 3.9 Navegación Anidada

```dart
/**
 * Navegación Anidada
 *
 * ¿Qué hace?
 * Cada tab tiene su propio Navigator y stack de navegación
 *
 * ¿Para qué?
 * - Flujos independientes por tab
 * - Mantener historial por sección
 * - UX similar a apps nativas iOS
 */

class MainScreenWithNestedNav extends StatefulWidget {
  const MainScreenWithNestedNav({super.key});

  @override
  State<MainScreenWithNestedNav> createState() =>
      _MainScreenWithNestedNavState();
}

class _MainScreenWithNestedNavState extends State<MainScreenWithNestedNav> {
  int _currentIndex = 0;

  // Keys para cada Navigator
  final _navigatorKeys = [
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

        // Intentar pop en el Navigator del tab actual
        final navigator = _navigatorKeys[_currentIndex].currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildNavigator(0, const HomeTab()),
            _buildNavigator(1, const SearchTab()),
            _buildNavigator(2, const ProfileTab()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == _currentIndex) {
              // Tap en el tab actual: ir al inicio del stack
              _navigatorKeys[index].currentState?.popUntil(
                (route) => route.isFirst,
              );
            } else {
              setState(() => _currentIndex = index);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigator(int index, Widget child) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}

// Tab con navegación interna
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Esta navegación es dentro del tab
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailScreen(),
              ),
            );
          },
          child: const Text('Ver Detalle'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: const Center(child: Text('Pantalla de detalle dentro del tab')),
    );
  }
}
```

---

## 💡 Puntos Clave

1. **BottomNavigationBar** para navegación principal (3-5 items)
2. **IndexedStack** preserva el estado entre tabs
3. **Drawer** para menú lateral con muchas opciones
4. **TabBar** para categorías relacionadas
5. **Navegación anidada** cada tab tiene su propio Navigator
6. **Material 3** usa NavigationBar y NavigationDrawer

---

## ⚠️ Errores Comunes

### ❌ No cerrar Drawer antes de navegar

```dart
// MALO: El drawer queda abierto
onTap: () {
  Navigator.pushNamed(context, '/settings');
}

// BUENO: Cerrar drawer primero
onTap: () {
  Navigator.pop(context); // Cerrar drawer
  Navigator.pushNamed(context, '/settings');
}
```

### ❌ Perder estado entre tabs

```dart
// MALO: Reconstruye el widget cada vez
body: _screens[_currentIndex]

// BUENO: Mantiene el estado
body: IndexedStack(
  index: _currentIndex,
  children: _screens,
)
```

---

## 🔗 Referencias

- [BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)
- [Drawer](https://api.flutter.dev/flutter/material/Drawer-class.html)
- [TabBar](https://api.flutter.dev/flutter/material/TabBar-class.html)

---

## ✅ Autoevaluación

1. ¿Cuándo usar BottomNavigationBar vs Drawer?
2. ¿Cómo preservo el estado entre tabs?
3. ¿Cuál es la diferencia entre TabController y DefaultTabController?
4. ¿Para qué sirve la navegación anidada?
5. ¿Cómo manejo el back button con navegación anidada?
