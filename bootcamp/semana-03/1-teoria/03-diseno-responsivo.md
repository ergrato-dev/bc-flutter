# 📱 Módulo 03: Diseño Responsivo en Flutter

> **Duración estimada:** 1.5-2 horas  
> **Nivel:** Intermedio  
> **Prerrequisitos:** Módulo 01 (Widgets) y Módulo 02 (Layouts)

---

## 📋 Índice

1. [Introducción al Diseño Responsivo](#1-introducción-al-diseño-responsivo)
2. [MediaQuery](#2-mediaquery)
3. [LayoutBuilder](#3-layoutbuilder)
4. [OrientationBuilder](#4-orientationbuilder)
5. [Breakpoints y Patterns](#5-breakpoints-y-patterns)
6. [Adaptive vs Responsive](#6-adaptive-vs-responsive)
7. [SafeArea y Notches](#7-safearea-y-notches)
8. [Ejercicios Prácticos](#8-ejercicios-prácticos)
9. [Errores Comunes](#9-errores-comunes)
10. [Recursos Adicionales](#10-recursos-adicionales)

---

## 1. Introducción al Diseño Responsivo

### ¿Qué es el Diseño Responsivo?

El diseño responsivo permite que una aplicación se adapte automáticamente a diferentes tamaños de pantalla, orientaciones y dispositivos.

```
┌─────────────────────────────────────────────────────────────┐
│                    DISEÑO RESPONSIVO                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   📱 Móvil        📱 Tablet       💻 Desktop                │
│   ┌───────┐      ┌─────────┐     ┌───────────────┐         │
│   │ ═══   │      │ ═══ ══  │     │ ═══  ══  ══   │         │
│   │ ▭▭▭▭  │      │ ▭▭  ▭▭  │     │ ▭▭   ▭▭  ▭▭   │         │
│   │ ▭▭▭▭  │      │ ▭▭  ▭▭  │     │ ▭▭   ▭▭  ▭▭   │         │
│   │ ▭▭▭▭  │      │ ▭▭  ▭▭  │     │              │         │
│   └───────┘      └─────────┘     └───────────────┘         │
│   1 columna      2 columnas       3 columnas               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### ¿Por qué es Importante?

```dart
/**
 * Razones para implementar diseño responsivo:
 *
 * 1. VARIEDAD DE DISPOSITIVOS
 *    - Smartphones (320px - 480px)
 *    - Tablets (600px - 1024px)
 *    - Desktop/Web (1024px+)
 *
 * 2. ORIENTACIONES
 *    - Portrait (vertical)
 *    - Landscape (horizontal)
 *
 * 3. EXPERIENCIA DE USUARIO
 *    - Contenido legible
 *    - Navegación accesible
 *    - Uso eficiente del espacio
 */
```

---

## 2. MediaQuery

### ¿Qué es MediaQuery?

`MediaQuery` proporciona información sobre el dispositivo y las preferencias del usuario.

### Sintaxis Básica

```dart
/**
 * MediaQuery - Obtener información del dispositivo
 *
 * ¿Qué hace?
 * Proporciona datos sobre el tamaño de pantalla, orientación,
 * densidad de píxeles y preferencias del sistema.
 *
 * ¿Para qué?
 * Tomar decisiones de diseño basadas en el dispositivo actual.
 */

class ResponsiveExample extends StatelessWidget {
  const ResponsiveExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener MediaQueryData
    final mediaQuery = MediaQuery.of(context);

    // Dimensiones de la pantalla
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Orientación
    final orientation = mediaQuery.orientation;

    // Densidad de píxeles
    final devicePixelRatio = mediaQuery.devicePixelRatio;

    // Padding del sistema (notch, barra de estado)
    final padding = mediaQuery.padding;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ancho: ${screenWidth.toStringAsFixed(0)}px'),
            Text('Alto: ${screenHeight.toStringAsFixed(0)}px'),
            Text('Orientación: $orientation'),
            Text('Pixel Ratio: $devicePixelRatio'),
            Text('Padding top: ${padding.top}'),
          ],
        ),
      ),
    );
  }
}
```

### Propiedades Principales de MediaQuery

```dart
/**
 * Propiedades más utilizadas de MediaQueryData
 */

Widget build(BuildContext context) {
  final mq = MediaQuery.of(context);

  // ═══════════════════════════════════════════════════════
  // DIMENSIONES
  // ═══════════════════════════════════════════════════════

  // Tamaño total de la pantalla
  final Size size = mq.size;
  final double width = mq.size.width;   // Ancho en píxeles lógicos
  final double height = mq.size.height; // Alto en píxeles lógicos

  // ═══════════════════════════════════════════════════════
  // ORIENTACIÓN
  // ═══════════════════════════════════════════════════════

  // Portrait o Landscape
  final Orientation orientation = mq.orientation;
  final bool isPortrait = orientation == Orientation.portrait;
  final bool isLandscape = orientation == Orientation.landscape;

  // ═══════════════════════════════════════════════════════
  // PADDING Y ÁREAS SEGURAS
  // ═══════════════════════════════════════════════════════

  // Padding del sistema (notch, barra de estado, etc.)
  final EdgeInsets padding = mq.padding;
  final double statusBarHeight = mq.padding.top;
  final double bottomInset = mq.padding.bottom;

  // Área de visualización segura
  final EdgeInsets viewInsets = mq.viewInsets;
  final double keyboardHeight = mq.viewInsets.bottom;

  // ═══════════════════════════════════════════════════════
  // PREFERENCIAS DEL USUARIO
  // ═══════════════════════════════════════════════════════

  // Factor de escala del texto (accesibilidad)
  final double textScaleFactor = mq.textScaleFactor;

  // Modo oscuro activado
  final Brightness brightness = mq.platformBrightness;
  final bool isDarkMode = brightness == Brightness.dark;

  // Animaciones reducidas (accesibilidad)
  final bool reduceMotion = mq.disableAnimations;

  // Alto contraste
  final bool highContrast = mq.highContrast;

  // ═══════════════════════════════════════════════════════
  // DENSIDAD DE PÍXELES
  // ═══════════════════════════════════════════════════════

  // Ratio de píxeles del dispositivo
  final double pixelRatio = mq.devicePixelRatio;

  return const Placeholder();
}
```

### Uso Práctico de MediaQuery

```dart
/**
 * Ejemplo: Cambiar layout según ancho de pantalla
 */

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Decisión basada en ancho
    if (width < 600) {
      return const MobileLayout();
    } else if (width < 1200) {
      return const TabletLayout();
    } else {
      return const DesktopLayout();
    }
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ProductCard(title: 'Producto 1'),
        ProductCard(title: 'Producto 2'),
        ProductCard(title: 'Producto 3'),
      ],
    );
  }
}

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: const [
        ProductCard(title: 'Producto 1'),
        ProductCard(title: 'Producto 2'),
        ProductCard(title: 'Producto 3'),
        ProductCard(title: 'Producto 4'),
      ],
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: const [
        ProductCard(title: 'Producto 1'),
        ProductCard(title: 'Producto 2'),
        ProductCard(title: 'Producto 3'),
        ProductCard(title: 'Producto 4'),
      ],
    );
  }
}

// Widget auxiliar
class ProductCard extends StatelessWidget {
  final String title;

  const ProductCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Center(child: Text(title)),
    );
  }
}
```

### MediaQuery.sizeOf() - Optimización

```dart
/**
 * MediaQuery.sizeOf() vs MediaQuery.of()
 *
 * ¿Por qué usar sizeOf?
 * - Más eficiente cuando solo necesitas el tamaño
 * - Evita rebuilds innecesarios
 * - Flutter 3.10+
 */

class OptimizedResponsive extends StatelessWidget {
  const OptimizedResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    // ❌ Menos eficiente - escucha TODOS los cambios de MediaQuery
    // final width = MediaQuery.of(context).size.width;

    // ✅ Más eficiente - solo escucha cambios de tamaño
    final size = MediaQuery.sizeOf(context);

    // Otros métodos optimizados disponibles:
    // MediaQuery.orientationOf(context)
    // MediaQuery.paddingOf(context)
    // MediaQuery.viewInsetsOf(context)
    // MediaQuery.platformBrightnessOf(context)

    return Container(
      width: size.width * 0.8,
      height: size.height * 0.5,
      color: Colors.blue,
      child: const Center(
        child: Text('Contenedor responsivo'),
      ),
    );
  }
}
```

---

## 3. LayoutBuilder

### ¿Qué es LayoutBuilder?

`LayoutBuilder` construye widgets basándose en las constraints del padre, no del dispositivo completo.

```
┌─────────────────────────────────────────────────────────────┐
│                  MediaQuery vs LayoutBuilder                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   MediaQuery                    LayoutBuilder               │
│   ┌─────────────────┐          ┌─────────────────┐         │
│   │ ░░░░░░░░░░░░░░░ │          │                 │         │
│   │ ░░░░░░░░░░░░░░░ │          │   ┌─────────┐   │         │
│   │ ░░░░░░░░░░░░░░░ │          │   │ ▓▓▓▓▓▓▓ │   │         │
│   │ ░░░░░░░░░░░░░░░ │          │   │ ▓▓▓▓▓▓▓ │   │         │
│   │ ░░░░░░░░░░░░░░░ │          │   └─────────┘   │         │
│   └─────────────────┘          └─────────────────┘         │
│   Pantalla completa            Espacio del padre           │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Sintaxis Básica

```dart
/**
 * LayoutBuilder - Construir según constraints del padre
 *
 * ¿Qué hace?
 * Proporciona las constraints (restricciones) que el widget
 * padre impone, permitiendo adaptar el contenido.
 *
 * ¿Para qué?
 * Ideal para componentes reutilizables que deben adaptarse
 * al espacio disponible donde se coloquen.
 */

class LayoutBuilderExample extends StatelessWidget {
  const LayoutBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // constraints contiene:
          // - minWidth, maxWidth
          // - minHeight, maxHeight

          print('Ancho disponible: ${constraints.maxWidth}');
          print('Alto disponible: ${constraints.maxHeight}');

          if (constraints.maxWidth < 400) {
            return const CompactView();
          } else {
            return const ExpandedView();
          }
        },
      ),
    );
  }
}

class CompactView extends StatelessWidget {
  const CompactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: const Center(
        child: Text('Vista Compacta'),
      ),
    );
  }
}

class ExpandedView extends StatelessWidget {
  const ExpandedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(
        child: Text('Vista Expandida'),
      ),
    );
  }
}
```

### BoxConstraints en Detalle

```dart
/**
 * BoxConstraints - Las restricciones de espacio
 */

LayoutBuilder(
  builder: (context, BoxConstraints constraints) {
    // Dimensiones mínimas permitidas
    final double minW = constraints.minWidth;
    final double minH = constraints.minHeight;

    // Dimensiones máximas permitidas
    final double maxW = constraints.maxWidth;
    final double maxH = constraints.maxHeight;

    // Propiedades útiles
    final bool hasBoundedWidth = constraints.hasBoundedWidth;
    final bool hasBoundedHeight = constraints.hasBoundedHeight;
    final bool hasInfiniteWidth = constraints.maxWidth == double.infinity;
    final bool hasInfiniteHeight = constraints.maxHeight == double.infinity;

    // Obtener el tamaño más grande posible
    final Size biggest = constraints.biggest;

    // Obtener el tamaño más pequeño posible
    final Size smallest = constraints.smallest;

    // Verificar si es "tight" (min == max)
    final bool isTight = constraints.isTight;

    return Container(
      constraints: BoxConstraints(
        maxWidth: maxW * 0.8,
        maxHeight: maxH * 0.6,
      ),
      color: Colors.blue,
      child: Text('Max: ${maxW.toInt()} x ${maxH.toInt()}'),
    );
  },
)
```

### Componente Reutilizable con LayoutBuilder

```dart
/**
 * Ejemplo: Card adaptativa que cambia su layout interno
 * según el espacio disponible
 */

class AdaptiveInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const AdaptiveInfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Si el ancho es menor a 200, usar layout vertical
            if (constraints.maxWidth < 200) {
              return _buildVerticalLayout();
            }
            // Si no, usar layout horizontal
            return _buildHorizontalLayout();
          },
        ),
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 48, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      children: [
        Icon(icon, size: 48, color: Colors.blue),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(description),
            ],
          ),
        ),
      ],
    );
  }
}

// Uso del componente
class CardShowcase extends StatelessWidget {
  const CardShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card ancha - mostrará layout horizontal
            const AdaptiveInfoCard(
              title: 'Flutter',
              description: 'Framework para apps multiplataforma',
              icon: Icons.flutter_dash,
            ),
            const SizedBox(height: 16),
            // Card en espacio limitado - mostrará layout vertical
            SizedBox(
              width: 150,
              child: const AdaptiveInfoCard(
                title: 'Dart',
                description: 'Lenguaje de programación',
                icon: Icons.code,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 4. OrientationBuilder

### ¿Qué es OrientationBuilder?

`OrientationBuilder` detecta cambios de orientación y reconstruye su contenido.

```dart
/**
 * OrientationBuilder - Responder a cambios de orientación
 *
 * ¿Qué hace?
 * Detecta si el dispositivo está en portrait o landscape
 * y permite adaptar el UI.
 *
 * ¿Cuándo usar?
 * Cuando necesitas layouts completamente diferentes
 * según la orientación del dispositivo.
 */

class OrientationExample extends StatelessWidget {
  const OrientationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orientation Demo')),
      body: OrientationBuilder(
        builder: (context, Orientation orientation) {
          return GridView.count(
            // 2 columnas en portrait, 4 en landscape
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            padding: const EdgeInsets.all(8),
            children: List.generate(
              8,
              (index) => Card(
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(
                  child: Text(
                    'Item ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
```

### Combinando OrientationBuilder con LayoutBuilder

```dart
/**
 * Patrón avanzado: Combinar ambos builders
 * para máxima adaptabilidad
 */

class FullyAdaptiveLayout extends StatelessWidget {
  const FullyAdaptiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isPortrait = orientation == Orientation.portrait;
              final isNarrow = constraints.maxWidth < 600;

              // Lógica combinada
              if (isPortrait && isNarrow) {
                return const MobilePortraitLayout();
              } else if (!isPortrait && isNarrow) {
                return const MobileLandscapeLayout();
              } else if (isPortrait) {
                return const TabletPortraitLayout();
              } else {
                return const TabletLandscapeLayout();
              }
            },
          );
        },
      ),
    );
  }
}

// Layouts específicos (simplificados)
class MobilePortraitLayout extends StatelessWidget {
  const MobilePortraitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('📱 Mobile Portrait'));
  }
}

class MobileLandscapeLayout extends StatelessWidget {
  const MobileLandscapeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('📱 Mobile Landscape'));
  }
}

class TabletPortraitLayout extends StatelessWidget {
  const TabletPortraitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('📱 Tablet Portrait'));
  }
}

class TabletLandscapeLayout extends StatelessWidget {
  const TabletLandscapeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('💻 Tablet Landscape'));
  }
}
```

---

## 5. Breakpoints y Patterns

### Sistema de Breakpoints

```dart
/**
 * Breakpoints estándar para diseño responsivo
 *
 * Estos valores son convenciones comunes, puedes ajustarlos
 * según las necesidades de tu aplicación.
 */

abstract class Breakpoints {
  // Móvil pequeño (iPhone SE, etc.)
  static const double mobileSmall = 320;

  // Móvil normal
  static const double mobile = 480;

  // Tablet pequeña
  static const double tabletSmall = 600;

  // Tablet
  static const double tablet = 768;

  // Tablet grande / Desktop pequeño
  static const double tabletLarge = 1024;

  // Desktop
  static const double desktop = 1200;

  // Desktop grande
  static const double desktopLarge = 1440;
}
```

### Clase Helper para Responsividad

```dart
/**
 * Clase utilitaria para consultas responsivas
 *
 * ¿Qué hace?
 * Centraliza la lógica de detección de tipo de dispositivo.
 *
 * ¿Para qué?
 * Reutilizar la lógica en toda la aplicación sin repetir código.
 */

class ResponsiveHelper {
  final BuildContext context;

  ResponsiveHelper(this.context);

  // Obtener ancho de pantalla
  double get screenWidth => MediaQuery.sizeOf(context).width;

  // Obtener alto de pantalla
  double get screenHeight => MediaQuery.sizeOf(context).height;

  // Verificaciones de tipo de dispositivo
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // Orientación
  bool get isPortrait =>
      MediaQuery.orientationOf(context) == Orientation.portrait;
  bool get isLandscape =>
      MediaQuery.orientationOf(context) == Orientation.landscape;

  // Número de columnas sugerido para grids
  int get gridColumns {
    if (isMobile) return 2;
    if (isTablet) return 3;
    return 4;
  }

  // Padding adaptativo
  double get horizontalPadding {
    if (isMobile) return 16;
    if (isTablet) return 24;
    return 32;
  }

  // Factor de escala para fuentes
  double get fontScale {
    if (isMobile) return 1.0;
    if (isTablet) return 1.1;
    return 1.2;
  }

  // Método para obtener valor según dispositivo
  T value<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}

// Uso en un widget
class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.horizontalPadding,
        ),
        child: GridView.count(
          crossAxisCount: responsive.gridColumns,
          children: List.generate(
            12,
            (index) => Card(
              child: Center(
                child: Text(
                  'Item $index',
                  style: TextStyle(
                    fontSize: 16 * responsive.fontScale,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Widget Responsivo Reutilizable

```dart
/**
 * Widget que muestra diferentes children según el breakpoint
 */

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return desktop ?? tablet ?? mobile;
        }
        if (constraints.maxWidth >= 600) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}

// Uso
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        mobile: ListView(
          children: const [Text('Lista móvil')],
        ),
        tablet: GridView.count(
          crossAxisCount: 2,
          children: const [Text('Grid tablet')],
        ),
        desktop: Row(
          children: const [
            Expanded(child: Text('Sidebar')),
            Expanded(flex: 3, child: Text('Contenido')),
          ],
        ),
      ),
    );
  }
}
```

---

## 6. Adaptive vs Responsive

### Diferencias Clave

```
┌─────────────────────────────────────────────────────────────┐
│              RESPONSIVE vs ADAPTIVE                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   RESPONSIVE                     ADAPTIVE                   │
│   ───────────                    ────────                   │
│   • Fluido                       • Discreto                 │
│   • Se estira/encoge            • Layouts fijos             │
│   • Un layout que se adapta     • Múltiples layouts         │
│   • Basado en porcentajes       • Basado en breakpoints     │
│                                                             │
│   Ejemplo:                       Ejemplo:                   │
│   width: 80%                     if (width < 600)           │
│   flex: 1                          MobileLayout()           │
│                                  else                       │
│                                    DesktopLayout()          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Diseño Responsive (Fluido)

```dart
/**
 * Ejemplo de diseño RESPONSIVE
 * El contenido se estira proporcionalmente
 */

class ResponsiveDesign extends StatelessWidget {
  const ResponsiveDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        // Padding proporcional al ancho
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05,
        ),
        child: Column(
          children: [
            // Header ocupa 20% del alto
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
              child: const Center(child: Text('Header')),
            ),
            // Contenido ocupa el resto
            Expanded(
              child: Row(
                children: [
                  // Sidebar 30%
                  Expanded(
                    flex: 3,
                    child: Container(color: Colors.grey[200]),
                  ),
                  // Main content 70%
                  Expanded(
                    flex: 7,
                    child: Container(color: Colors.grey[100]),
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
```

### Diseño Adaptive (Discreto)

```dart
/**
 * Ejemplo de diseño ADAPTIVE
 * Layouts completamente diferentes según el dispositivo
 */

class AdaptiveDesign extends StatelessWidget {
  const AdaptiveDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Layout completamente diferente según breakpoint
    if (width < 600) {
      return const _MobileLayout();
    } else if (width < 1024) {
      return const _TabletLayout();
    } else {
      return const _DesktopLayout();
    }
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile')),
      drawer: const Drawer(child: Text('Menu')),
      body: ListView(
        children: const [Text('Contenido en lista')],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const _TabletLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Rail de navegación
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                label: Text('Search'),
              ),
            ],
            selectedIndex: 0,
          ),
          // Contenido
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: const [Text('Grid content')],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Drawer permanente
          const SizedBox(
            width: 250,
            child: Drawer(
              child: Text('Navegación completa'),
            ),
          ),
          // Contenido principal
          Expanded(
            child: Column(
              children: [
                // Toolbar
                Container(
                  height: 60,
                  color: Colors.grey[200],
                  child: const Text('Toolbar con más opciones'),
                ),
                // Grid de contenido
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: const [Text('Grid grande')],
                  ),
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

---

## 7. SafeArea y Notches

### ¿Qué es SafeArea?

`SafeArea` asegura que el contenido no sea obstruido por el hardware del dispositivo.

```
┌─────────────────────────────────────────────────────────────┐
│                      SafeArea                               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   Sin SafeArea              Con SafeArea                    │
│   ┌───────────────┐        ┌───────────────┐               │
│   │▓▓▓ NOTCH ▓▓▓▓│        │▓▓▓ NOTCH ▓▓▓▓│               │
│   │Texto cortado!│        │───────────────│               │
│   │              │        │ Texto visible │               │
│   │              │        │               │               │
│   │              │        │               │               │
│   │▓▓▓▓▓▓▓▓▓▓▓▓▓│        │───────────────│               │
│   └───────────────┘        └───────────────┘               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Uso de SafeArea

```dart
/**
 * SafeArea - Evitar obstrucciones del sistema
 *
 * ¿Qué hace?
 * Añade padding automáticamente para evitar:
 * - Notch/Dynamic Island (iOS)
 * - Barra de estado
 * - Indicador de home (iOS)
 * - Navegación por gestos
 */

class SafeAreaExample extends StatelessWidget {
  const SafeAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Configurar qué lados proteger
        top: true,      // Proteger arriba (notch, status bar)
        bottom: true,   // Proteger abajo (home indicator)
        left: true,     // Proteger izquierda
        right: true,    // Proteger derecha

        // Padding mínimo adicional
        minimum: const EdgeInsets.all(16),

        child: Column(
          children: const [
            Text('Este texto está en área segura'),
            Expanded(
              child: Center(
                child: Text('Contenido principal'),
              ),
            ),
            Text('Footer también protegido'),
          ],
        ),
      ),
    );
  }
}
```

### Acceder al Padding del Sistema

```dart
/**
 * Acceder manualmente al padding del sistema
 * Útil cuando necesitas control fino
 */

class ManualSafeArea extends StatelessWidget {
  const ManualSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el padding del sistema
    final padding = MediaQuery.paddingOf(context);

    return Scaffold(
      body: Column(
        children: [
          // Espacio para la barra de estado
          SizedBox(height: padding.top),

          // Contenido
          Expanded(
            child: Container(
              color: Colors.blue[100],
              child: const Center(
                child: Text('Contenido con control manual'),
              ),
            ),
          ),

          // Espacio para el indicador de home
          SizedBox(height: padding.bottom),
        ],
      ),
    );
  }
}
```

### SliverSafeArea para CustomScrollView

```dart
/**
 * Para usar SafeArea dentro de CustomScrollView
 */

class SliverSafeAreaExample extends StatelessWidget {
  const SliverSafeAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar que respeta el safe area automáticamente
          const SliverAppBar(
            title: Text('Mi App'),
            floating: true,
          ),

          // Safe area para el contenido
          SliverSafeArea(
            // Solo aplicar en la parte inferior
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
                childCount: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 8. Ejercicios Prácticos

### Ejercicio 1: Tarjeta Responsiva

```dart
/**
 * EJERCICIO 1: Crear una tarjeta que cambie su layout
 *
 * Requisitos:
 * - En pantallas < 400px: layout vertical (imagen arriba, texto abajo)
 * - En pantallas >= 400px: layout horizontal (imagen izquierda, texto derecha)
 */

// Tu solución aquí...
```

<details>
<summary>💡 Ver Solución</summary>

```dart
class ResponsiveCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const ResponsiveCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 400;

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  imageUrl,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(description),
                    ],
                  ),
                ),
              ],
            );
          }

          return Row(
            children: [
              Image.network(
                imageUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(description),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

</details>

### Ejercicio 2: Grid Adaptativo

```dart
/**
 * EJERCICIO 2: Crear un grid que ajuste columnas automáticamente
 *
 * Requisitos:
 * - < 400px: 1 columna
 * - 400-800px: 2 columnas
 * - 800-1200px: 3 columnas
 * - >= 1200px: 4 columnas
 */

// Tu solución aquí...
```

<details>
<summary>💡 Ver Solución</summary>

```dart
class AdaptiveGrid extends StatelessWidget {
  final List<Widget> children;

  const AdaptiveGrid({
    super.key,
    required this.children,
  });

  int _getColumnCount(double width) {
    if (width < 400) return 1;
    if (width < 800) return 2;
    if (width < 1200) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _getColumnCount(constraints.maxWidth);

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          padding: const EdgeInsets.all(16),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}

// Uso
class GridDemo extends StatelessWidget {
  const GridDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveGrid(
        children: List.generate(
          20,
          (index) => Card(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                'Item $index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

</details>

### Ejercicio 3: Layout Master-Detail

```dart
/**
 * EJERCICIO 3: Crear un layout master-detail responsivo
 *
 * Requisitos:
 * - En móvil: solo lista, navegar a detalle en otra pantalla
 * - En tablet/desktop: lista a la izquierda, detalle a la derecha
 */

// Tu solución aquí...
```

<details>
<summary>💡 Ver Solución</summary>

```dart
class MasterDetailLayout extends StatefulWidget {
  const MasterDetailLayout({super.key});

  @override
  State<MasterDetailLayout> createState() => _MasterDetailLayoutState();
}

class _MasterDetailLayoutState extends State<MasterDetailLayout> {
  int? selectedIndex;

  final items = List.generate(
    20,
    (index) => 'Item ${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;

        if (isWide) {
          // Tablet/Desktop: lado a lado
          return Row(
            children: [
              // Lista (master)
              SizedBox(
                width: 300,
                child: _buildList(),
              ),
              const VerticalDivider(width: 1),
              // Detalle
              Expanded(
                child: selectedIndex != null
                    ? _buildDetail(items[selectedIndex!])
                    : const Center(
                        child: Text('Selecciona un item'),
                      ),
              ),
            ],
          );
        }

        // Móvil: solo lista (navegación para detalle)
        return _buildList();
      },
    );
  }

  Widget _buildList() {
    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            selected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              // En móvil, navegar a otra pantalla
              final isWide = MediaQuery.sizeOf(context).width >= 600;
              if (!isWide) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: Text(items[index])),
                      body: _buildDetail(items[index]),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildDetail(String item) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.article, size: 64),
          const SizedBox(height: 16),
          Text(
            item,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text('Detalles de $item'),
        ],
      ),
    );
  }
}
```

</details>

---

## 9. Errores Comunes

### Error 1: Usar MediaQuery en initState

```dart
// ❌ INCORRECTO - MediaQuery no disponible en initState
class BadExample extends StatefulWidget {
  @override
  _BadExampleState createState() => _BadExampleState();
}

class _BadExampleState extends State<BadExample> {
  late double screenWidth;

  @override
  void initState() {
    super.initState();
    // ❌ Esto causará un error
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// ✅ CORRECTO - Usar didChangeDependencies o build
class GoodExample extends StatefulWidget {
  @override
  _GoodExampleState createState() => _GoodExampleState();
}

class _GoodExampleState extends State<GoodExample> {
  late double screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ✅ Aquí sí está disponible
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    // ✅ También aquí
    final width = MediaQuery.sizeOf(context).width;
    return Container();
  }
}
```

### Error 2: Rebuilds Innecesarios

```dart
// ❌ INCORRECTO - Causa rebuilds en cada cambio de MediaQuery
Widget build(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  // Solo usamos el ancho, pero escuchamos TODOS los cambios
  return Container(width: mediaQuery.size.width * 0.5);
}

// ✅ CORRECTO - Solo escuchar lo necesario
Widget build(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  return Container(width: size.width * 0.5);
}
```

### Error 3: No Considerar el Teclado

```dart
// ❌ INCORRECTO - El contenido queda oculto bajo el teclado
Scaffold(
  body: Column(
    children: [
      Expanded(child: ListView(...)),
      TextField(), // Puede quedar oculto
    ],
  ),
)

// ✅ CORRECTO - Considerar viewInsets
Scaffold(
  resizeToAvoidBottomInset: true, // Por defecto es true
  body: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          // Contenido
          TextField(),
        ],
      ),
    ),
  ),
)
```

### Error 4: Hardcodear Valores

```dart
// ❌ INCORRECTO - Valores fijos que no escalan
Container(
  width: 350, // No se adapta
  padding: EdgeInsets.all(20), // Siempre igual
)

// ✅ CORRECTO - Valores relativos o adaptativos
LayoutBuilder(
  builder: (context, constraints) {
    final padding = constraints.maxWidth < 600 ? 16.0 : 24.0;

    return Container(
      width: constraints.maxWidth * 0.9,
      padding: EdgeInsets.all(padding),
    );
  },
)
```

---

## 10. Recursos Adicionales

### 📚 Documentación Oficial

- [MediaQuery - Flutter Docs](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html)
- [LayoutBuilder - Flutter Docs](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
- [SafeArea - Flutter Docs](https://api.flutter.dev/flutter/widgets/SafeArea-class.html)
- [Adaptive Design - Flutter](https://docs.flutter.dev/ui/adaptive-responsive)

### 📦 Paquetes Útiles

- [`responsive_builder`](https://pub.dev/packages/responsive_builder)
- [`responsive_framework`](https://pub.dev/packages/responsive_framework)
- [`flutter_screenutil`](https://pub.dev/packages/flutter_screenutil)

### 🔗 Referencias Cruzadas

- **Módulo 01:** [Widgets Fundamentales](./01-widgets-fundamentales.md)
- **Módulo 02:** [Sistema de Layouts](./02-sistema-layouts.md)
- **Prácticas:** [Ejercicios Guiados](../2-practicas/)
- **Glosario:** [Términos de Responsive](../5-glosario/)

---

## ✅ Checklist de Aprendizaje

Antes de continuar, asegúrate de:

- [ ] Entender la diferencia entre MediaQuery y LayoutBuilder
- [ ] Saber cuándo usar cada herramienta
- [ ] Poder crear layouts adaptativos con breakpoints
- [ ] Entender SafeArea y su importancia
- [ ] Conocer las diferencias entre responsive y adaptive
- [ ] Poder combinar OrientationBuilder con LayoutBuilder
- [ ] Saber optimizar con MediaQuery.sizeOf()

---

> **Siguiente paso:** Aplicar estos conceptos en las [Prácticas](../2-practicas/) de la semana.
