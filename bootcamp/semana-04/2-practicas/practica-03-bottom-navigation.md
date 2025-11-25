# 💻 Práctica 03: Bottom Navigation

## 📋 Información General

| Campo               | Valor                                               |
| ------------------- | --------------------------------------------------- |
| **Dificultad**      | ⭐⭐ Intermedio                                     |
| **Tiempo estimado** | 30 minutos                                          |
| **Conceptos**       | BottomNavigationBar, IndexedStack, preservar estado |

---

## 🎯 Objetivos

- Implementar BottomNavigationBar con múltiples tabs
- Usar IndexedStack para preservar estado
- Crear navegación interna en cada tab
- Personalizar estilos de la barra inferior

---

## 📝 Descripción

Crearás una **app de red social simple** con 4 secciones:

1. **Feed**: Publicaciones recientes
2. **Buscar**: Explorar contenido
3. **Notificaciones**: Alertas y mensajes
4. **Perfil**: Información del usuario

---

## 📋 Instrucciones

### Paso 1: Crear el Proyecto

```bash
flutter create practica_bottom_nav
cd practica_bottom_nav
```

### Paso 2: Crear la Pantalla Principal

Crea `lib/screens/main_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'tabs/feed_tab.dart';
import 'tabs/search_tab.dart';
import 'tabs/notifications_tab.dart';
import 'tabs/profile_tab.dart';

/// Pantalla principal con BottomNavigationBar
///
/// ¿Qué hace? Gestiona la navegación entre tabs
/// ¿Cómo? Usa IndexedStack para preservar estado
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Lista de pantallas/tabs
  final List<Widget> _tabs = const [
    FeedTab(),
    SearchTab(),
    NotificationsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack preserva el estado de cada tab
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Alertas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
```

### Paso 3: Crear los Tabs

Crea `lib/screens/tabs/feed_tab.dart`:

```dart
import 'package:flutter/material.dart';

class FeedTab extends StatefulWidget {
  const FeedTab({super.key});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  final List<Map<String, String>> _posts = [
    {'user': 'Ana García', 'content': '¡Hola mundo! Mi primer post 🎉'},
    {'user': 'Carlos López', 'content': 'Aprendiendo Flutter, es increíble'},
    {'user': 'María Rodríguez', 'content': 'Buen día a todos 🌞'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // Agregar nuevo post
              setState(() {
                _posts.insert(0, {
                  'user': 'Tú',
                  'content': 'Nuevo post #${_posts.length + 1}',
                });
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            final post = _posts[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(child: Icon(Icons.person)),
                        const SizedBox(width: 12),
                        Text(
                          post['user']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(post['content']!),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.comment_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.share_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

Crea `lib/screens/tabs/search_tab.dart`:

```dart
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Buscar...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
      ),
      body: _searchQuery.isEmpty
          ? _buildTrending()
          : _buildSearchResults(),
    );
  }

  Widget _buildTrending() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Tendencias',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...['#Flutter', '#Dart', '#MobileApp', '#Coding'].map(
          (tag) => ListTile(
            leading: const Icon(Icons.trending_up),
            title: Text(tag),
            onTap: () {
              _searchController.text = tag;
              setState(() => _searchQuery = tag);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Center(
      child: Text('Resultados para: $_searchQuery'),
    );
  }
}
```

Crea `lib/screens/tabs/notifications_tab.dart`:

```dart
import 'package:flutter/material.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'type': 'like', 'user': 'Ana', 'time': 'Hace 5 min'},
      {'type': 'comment', 'user': 'Carlos', 'time': 'Hace 10 min'},
      {'type': 'follow', 'user': 'María', 'time': 'Hace 1 hora'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Marcar todas'),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              child: Icon(_getIcon(notif['type']!)),
            ),
            title: Text(_getMessage(notif['type']!, notif['user']!)),
            subtitle: Text(notif['time']!),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'like':
        return Icons.favorite;
      case 'comment':
        return Icons.comment;
      case 'follow':
        return Icons.person_add;
      default:
        return Icons.notifications;
    }
  }

  String _getMessage(String type, String user) {
    switch (type) {
      case 'like':
        return '$user le gustó tu publicación';
      case 'comment':
        return '$user comentó tu publicación';
      case 'follow':
        return '$user comenzó a seguirte';
      default:
        return 'Nueva notificación';
    }
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
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Navegar a configuración
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            const Text(
              'Usuario Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              '@usuario_demo',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('Posts', '42'),
                _buildStat('Seguidores', '1.2K'),
                _buildStat('Siguiendo', '380'),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Editar Perfil'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

// Pantalla de configuración (navegación interna)
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Cuenta'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacidad'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notificaciones'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
```

### Paso 4: Actualizar main.dart

```dart
import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

| Criterio                      | Puntos |
| ----------------------------- | ------ |
| BottomNavigationBar funcional | 2      |
| IndexedStack preserva estado  | 2      |
| Navegación interna en tabs    | 1      |
| Personalización visual        | 1      |
| **Total**                     | **6**  |

---

## 🚀 Desafío Extra

1. Agregar badge de notificaciones no leídas
2. Implementar NavigationBar (Material 3)
3. Agregar animación al cambiar de tab
