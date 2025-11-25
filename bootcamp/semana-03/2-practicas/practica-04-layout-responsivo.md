# 📱 Práctica 04: Layout Responsivo

> **Duración estimada:** 60 minutos  
> **Nivel:** Intermedio  
> **Conceptos:** MediaQuery, LayoutBuilder, OrientationBuilder, Breakpoints

---

## 📋 Objetivo

Crear un layout que se adapte completamente a diferentes tamaños de pantalla y orientaciones.

---

## 🎨 Diseño a Implementar

```
MÓVIL (< 600px)              TABLET (≥ 600px)
┌─────────────┐              ┌─────────────────────┐
│   Header    │              │      Header         │
├─────────────┤              ├──────────┬──────────┤
│             │              │          │          │
│    Lista    │              │  Lista   │ Detalle  │
│  vertical   │              │          │          │
│             │              │          │          │
├─────────────┤              │          │          │
│   Bottom    │              │          │          │
│    Nav      │              └──────────┴──────────┘
└─────────────┘
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
      title: 'Layout Responsivo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const ResponsiveLayout(),
    );
  }
}

// ═══════════════════════════════════════════════════════
// CONSTANTES RESPONSIVE
// ═══════════════════════════════════════════════════════

abstract class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

// ═══════════════════════════════════════════════════════
// LAYOUT PRINCIPAL RESPONSIVO
// ═══════════════════════════════════════════════════════

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  int? _selectedIndex;

  final List<String> _items = List.generate(
    20,
    (index) => 'Elemento ${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= Breakpoints.mobile;

        if (isWide) {
          return _buildWideLayout();
        }
        return _buildNarrowLayout();
      },
    );
  }

  // Layout para tablet/desktop
  Widget _buildWideLayout() {
    return Scaffold(
      appBar: AppBar(title: const Text('App Responsiva')),
      body: Row(
        children: [
          // Panel izquierdo - Lista
          SizedBox(
            width: 300,
            child: _buildItemList(),
          ),
          const VerticalDivider(width: 1),
          // Panel derecho - Detalle
          Expanded(
            child: _selectedIndex != null
                ? _buildDetailView(_items[_selectedIndex!])
                : const Center(
                    child: Text('Selecciona un elemento'),
                  ),
          ),
        ],
      ),
    );
  }

  // Layout para móvil
  Widget _buildNarrowLayout() {
    return Scaffold(
      appBar: AppBar(title: const Text('App Responsiva')),
      body: _buildItemList(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Config',
          ),
        ],
      ),
    );
  }

  Widget _buildItemList() {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final isSelected = _selectedIndex == index;

        return ListTile(
          title: Text(_items[index]),
          leading: CircleAvatar(child: Text('${index + 1}')),
          selected: isSelected,
          selectedTileColor: Colors.purple.withOpacity(0.1),
          onTap: () {
            setState(() => _selectedIndex = index);

            // En móvil, navegar a otra pantalla
            final isNarrow =
                MediaQuery.sizeOf(context).width < Breakpoints.mobile;
            if (isNarrow) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text(_items[index])),
                    body: _buildDetailView(_items[index]),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildDetailView(String item) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article, size: 80, color: Colors.purple[300]),
          const SizedBox(height: 24),
          Text(
            item,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'Detalles de $item',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            label: const Text('Editar'),
          ),
        ],
      ),
    );
  }
}
```

---

## 🏆 Desafíos Adicionales

1. **OrientationBuilder**: Cambiar layout en landscape
2. **NavigationRail**: Usar en tablet en lugar de BottomNav
3. **Animated transitions**: Animar el cambio de layout

---

## ✅ Criterios de Evaluación

- [ ] Layout cambia según breakpoint (600px)
- [ ] En móvil: lista + navegación a detalle
- [ ] En tablet: lista y detalle lado a lado
- [ ] Selección visual funciona correctamente
- [ ] Código organizado y reutilizable
