# 🏠 Práctica 05: Pantalla Completa - Dashboard

> **Duración estimada:** 90 minutos  
> **Nivel:** Intermedio-Avanzado  
> **Conceptos:** Integración de todos los widgets y layouts de la semana

---

## 📋 Objetivo

Crear un dashboard completo que integre **widgets**, **layouts** y **diseño responsivo** aplicando todos los conceptos de la Semana 03.

---

## 🎨 Diseño a Implementar

```
┌─────────────────────────────────────────────────────────┐
│  📊 Dashboard                              👤 Usuario   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐    │
│  │   💰 $12.5K  │ │   📦 156     │ │   👥 2.3K    │    │
│  │   Ventas     │ │   Pedidos    │ │   Clientes   │    │
│  └──────────────┘ └──────────────┘ └──────────────┘    │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │              📈 Gráfico de Ventas               │   │
│  │  ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁▂▃▄▅▆▇█▇▆▅▄▃▂                  │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Actividad Reciente                                     │
│  ┌─────────────────────────────────────────────────┐   │
│  │ 🛒 Nuevo pedido #1234          hace 5 min       │   │
│  │ 👤 Cliente registrado          hace 12 min      │   │
│  │ 💳 Pago recibido $250          hace 1 hora      │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🚀 Código Completo

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

// ═══════════════════════════════════════════════════════
// MODELOS DE DATOS
// ═══════════════════════════════════════════════════════

class StatCard {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class Activity {
  final String title;
  final String time;
  final IconData icon;
  final Color color;

  const Activity({
    required this.title,
    required this.time,
    required this.icon,
    required this.color,
  });
}

// Datos de ejemplo
final stats = [
  const StatCard(
    title: 'Ventas',
    value: '\$12.5K',
    icon: Icons.attach_money,
    color: Colors.green,
  ),
  const StatCard(
    title: 'Pedidos',
    value: '156',
    icon: Icons.shopping_bag,
    color: Colors.orange,
  ),
  const StatCard(
    title: 'Clientes',
    value: '2.3K',
    icon: Icons.people,
    color: Colors.blue,
  ),
  const StatCard(
    title: 'Productos',
    value: '89',
    icon: Icons.inventory,
    color: Colors.purple,
  ),
];

final activities = [
  const Activity(
    title: 'Nuevo pedido #1234',
    time: 'hace 5 min',
    icon: Icons.shopping_cart,
    color: Colors.green,
  ),
  const Activity(
    title: 'Cliente registrado',
    time: 'hace 12 min',
    icon: Icons.person_add,
    color: Colors.blue,
  ),
  const Activity(
    title: 'Pago recibido \$250',
    time: 'hace 1 hora',
    icon: Icons.payment,
    color: Colors.orange,
  ),
  const Activity(
    title: 'Producto agotado',
    time: 'hace 2 horas',
    icon: Icons.warning,
    color: Colors.red,
  ),
];

// ═══════════════════════════════════════════════════════
// PANTALLA DASHBOARD
// ═══════════════════════════════════════════════════════

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const DashboardDrawer(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 800;

            if (isWide) {
              return _buildWideLayout();
            }
            return _buildNarrowLayout();
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          Icon(Icons.dashboard),
          SizedBox(width: 8),
          Text('Dashboard'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            radius: 16,
            child: Icon(Icons.person, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatsGrid(),
          const SizedBox(height: 24),
          const ChartCard(),
          const SizedBox(height: 24),
          const ActivityList(),
        ],
      ),
    );
  }

  Widget _buildWideLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const StatsGrid(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 2, child: ChartCard()),
              const SizedBox(width: 24),
              const Expanded(child: ActivityList()),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// GRID DE ESTADÍSTICAS
// ═══════════════════════════════════════════════════════

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 400 ? 2 : 4;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) {
            return StatCardWidget(stat: stats[index]);
          },
        );
      },
    );
  }
}

class StatCardWidget extends StatelessWidget {
  final StatCard stat;

  const StatCardWidget({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: stat.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(stat.icon, color: stat.color, size: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  stat.title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// TARJETA DE GRÁFICO
// ═══════════════════════════════════════════════════════

class ChartCard extends StatelessWidget {
  const ChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ventas Mensuales',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: CustomPaint(
                size: const Size(double.infinity, 200),
                painter: ChartPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simulación simple de gráfico
class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.blue.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    // Datos simulados
    final data = [0.3, 0.5, 0.4, 0.7, 0.6, 0.8, 0.75, 0.9, 0.85, 0.7];
    final stepX = size.width / (data.length - 1);

    path.moveTo(0, size.height * (1 - data[0]));
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(0, size.height * (1 - data[0]));

    for (int i = 1; i < data.length; i++) {
      path.lineTo(stepX * i, size.height * (1 - data[i]));
      fillPath.lineTo(stepX * i, size.height * (1 - data[i]));
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════
// LISTA DE ACTIVIDAD
// ═══════════════════════════════════════════════════════

class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actividad Reciente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...activities.map((activity) => ActivityTile(activity: activity)),
          ],
        ),
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final Activity activity;

  const ActivityTile({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: activity.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(activity.icon, color: activity.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              activity.title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            activity.time,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// DRAWER DE NAVEGACIÓN
// ═══════════════════════════════════════════════════════

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person, size: 30),
                ),
                SizedBox(height: 12),
                Text(
                  'Admin',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'admin@example.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: true,
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Pedidos'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Clientes'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Productos'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

- [ ] Stats grid se adapta (2 o 4 columnas)
- [ ] Layout cambia en pantallas anchas
- [ ] Gráfico renderiza correctamente
- [ ] Lista de actividad muestra todos los items
- [ ] Drawer funciona
- [ ] SafeArea aplicado correctamente
- [ ] Código modular y bien organizado
