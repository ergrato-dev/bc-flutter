# 💻 Práctica 04: Drawer Menu

## 📋 Información General

| Campo | Valor |
|-------|-------|
| **Dificultad** | ⭐⭐⭐ Avanzado |
| **Tiempo estimado** | 35 minutos |
| **Conceptos** | Drawer, NavigationDrawer, UserAccountsDrawerHeader |

---

## 🎯 Objetivos

- Implementar Drawer navigation completo
- Crear UserAccountsDrawerHeader personalizado
- Gestionar navegación desde el drawer
- Mantener estado de selección activa

---

## 📝 Descripción

Crearás una **app de gestión empresarial** con navegación lateral:
- Header con información del usuario
- Menú principal con secciones
- Sección de configuración
- Opción de cerrar sesión

---

## 📋 Instrucciones

### Paso 1: Crear el Proyecto

```bash
flutter create practica_drawer_menu
cd practica_drawer_menu
```

### Paso 2: Crear la Pantalla Principal con Drawer

Crea `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/projects_page.dart';
import 'pages/team_page.dart';
import 'pages/reports_page.dart';
import 'pages/settings_page.dart';

/// Pantalla principal con Drawer
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  // Lista de páginas
  final List<Widget> _pages = const [
    DashboardPage(),
    ProjectsPage(),
    TeamPage(),
    ReportsPage(),
    SettingsPage(),
  ];

  // Títulos de las páginas
  final List<String> _titles = [
    'Dashboard',
    'Proyectos',
    'Equipo',
    'Reportes',
    'Configuración',
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Cerrar drawer
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que quieres salir?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Aquí iría la lógica de logout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sesión cerrada')),
              );
            },
            child: const Text('Salir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Header del usuario
            UserAccountsDrawerHeader(
              accountName: const Text(
                'Juan Pérez',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text('juan.perez@empresa.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'JP',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              otherAccountsPictures: const [
                CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Icon(Icons.add, color: Colors.grey),
                ),
              ],
            ),
            
            // Menú principal
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                    index: 0,
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    title: 'Proyectos',
                    index: 1,
                  ),
                  _buildMenuItem(
                    icon: Icons.group,
                    title: 'Equipo',
                    index: 2,
                  ),
                  _buildMenuItem(
                    icon: Icons.bar_chart,
                    title: 'Reportes',
                    index: 3,
                  ),
                  const Divider(),
                  _buildMenuItem(
                    icon: Icons.settings,
                    title: 'Configuración',
                    index: 4,
                  ),
                ],
              ),
            ),
            
            // Logout al final
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: _handleLogout,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
      onTap: () => _onItemSelected(index),
    );
  }
}
```

### Paso 3: Crear las Páginas

Crea `lib/screens/pages/dashboard_page.dart`:

```dart
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resumen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildStatCard('Proyectos', '12', Icons.folder, Colors.blue),
              _buildStatCard('Tareas', '48', Icons.task, Colors.orange),
              _buildStatCard('Equipo', '8', Icons.people, Colors.green),
              _buildStatCard('Completado', '85%', Icons.check_circle, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
```

Crea `lib/screens/pages/projects_page.dart`:

```dart
import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {'name': 'App Móvil', 'status': 'En progreso', 'progress': 0.7},
      {'name': 'Portal Web', 'status': 'Completado', 'progress': 1.0},
      {'name': 'API Backend', 'status': 'En progreso', 'progress': 0.4},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project['name'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(project['status'] as String),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: project['progress'] as double,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

Crea `lib/screens/pages/team_page.dart`:

```dart
import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final team = [
      {'name': 'Ana García', 'role': 'Diseñadora'},
      {'name': 'Carlos López', 'role': 'Desarrollador'},
      {'name': 'María Rodríguez', 'role': 'PM'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: team.length,
      itemBuilder: (context, index) {
        final member = team[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(member['name']![0]),
          ),
          title: Text(member['name']!),
          subtitle: Text(member['role']!),
          trailing: IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
```

Crea `lib/screens/pages/reports_page.dart`:

```dart
import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text('Reportes del mes'),
        ],
      ),
    );
  }
}
```

Crea `lib/screens/pages/settings_page.dart`:

```dart
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          leading: Icon(Icons.person),
          title: Text('Perfil'),
          trailing: Icon(Icons.chevron_right),
        ),
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notificaciones'),
          trailing: Icon(Icons.chevron_right),
        ),
        const ListTile(
          leading: Icon(Icons.lock),
          title: Text('Privacidad'),
          trailing: Icon(Icons.chevron_right),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode),
          title: const Text('Modo oscuro'),
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
```

### Paso 4: Actualizar main.dart

```dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión Empresarial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| Drawer con header de usuario | 2 |
| Menú con selección activa | 2 |
| Navegación funcional | 1 |
| Logout con confirmación | 1 |
| **Total** | **6** |

---

## 🚀 Desafío Extra

1. Implementar NavigationDrawer (Material 3)
2. Agregar múltiples cuentas en el header
3. Persistir el estado de selección
