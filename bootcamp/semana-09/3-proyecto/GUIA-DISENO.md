# 🎨 Guía de Diseño - TaskManager Pro

## 📋 Contenido

1. [Sistema de Colores](#-sistema-de-colores)
2. [Tipografía](#-tipografía)
3. [Componentes](#-componentes)
4. [Layouts](#-layouts)
5. [Iconografía](#-iconografía)
6. [Animaciones](#-animaciones)

---

## 🎨 Sistema de Colores

### Paleta Principal

```dart
// lib/core/constants/app_colors.dart

import 'package:flutter/material.dart';

/// Colores de la aplicación TaskManager Pro.
///
/// Sigue las guías de Material Design 3.
abstract class AppColors {
  // ═══════════════════════════════════════════════════
  // COLORES PRIMARIOS
  // ═══════════════════════════════════════════════════

  /// Azul principal - acciones primarias
  static const primary = Color(0xFF1565C0);
  static const primaryLight = Color(0xFF5E92F3);
  static const primaryDark = Color(0xFF003C8F);
  static const onPrimary = Color(0xFFFFFFFF);

  // ═══════════════════════════════════════════════════
  // COLORES SECUNDARIOS
  // ═══════════════════════════════════════════════════

  /// Teal secundario - acentos
  static const secondary = Color(0xFF00897B);
  static const secondaryLight = Color(0xFF4EBAAA);
  static const secondaryDark = Color(0xFF005B4F);
  static const onSecondary = Color(0xFFFFFFFF);

  // ═══════════════════════════════════════════════════
  // COLORES DE SUPERFICIE
  // ═══════════════════════════════════════════════════

  static const surface = Color(0xFFFAFAFA);
  static const surfaceDark = Color(0xFF121212);
  static const background = Color(0xFFFFFFFF);
  static const backgroundDark = Color(0xFF1E1E1E);

  // ═══════════════════════════════════════════════════
  // COLORES DE PRIORIDAD
  // ═══════════════════════════════════════════════════

  /// Rojo - prioridad alta
  static const priorityHigh = Color(0xFFE53935);
  static const priorityHighLight = Color(0xFFFFCDD2);

  /// Naranja - prioridad media
  static const priorityMedium = Color(0xFFFFA726);
  static const priorityMediumLight = Color(0xFFFFE0B2);

  /// Verde - prioridad baja
  static const priorityLow = Color(0xFF43A047);
  static const priorityLowLight = Color(0xFFC8E6C9);

  // ═══════════════════════════════════════════════════
  // COLORES DE ESTADO
  // ═══════════════════════════════════════════════════

  /// Éxito
  static const success = Color(0xFF4CAF50);
  static const successLight = Color(0xFFE8F5E9);

  /// Error
  static const error = Color(0xFFF44336);
  static const errorLight = Color(0xFFFFEBEE);

  /// Advertencia
  static const warning = Color(0xFFFF9800);
  static const warningLight = Color(0xFFFFF3E0);

  /// Información
  static const info = Color(0xFF2196F3);
  static const infoLight = Color(0xFFE3F2FD);

  // ═══════════════════════════════════════════════════
  // COLORES DE TEXTO
  // ═══════════════════════════════════════════════════

  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const textDisabled = Color(0xFFBDBDBD);
  static const textOnDark = Color(0xFFFFFFFF);

  // ═══════════════════════════════════════════════════
  // COLORES DE BORDE Y DIVISOR
  // ═══════════════════════════════════════════════════

  static const divider = Color(0xFFE0E0E0);
  static const border = Color(0xFFBDBDBD);
  static const borderLight = Color(0xFFEEEEEE);
}
```

### Uso de Colores por Prioridad

| Prioridad | Color Principal | Color Fondo | Uso              |
| --------- | --------------- | ----------- | ---------------- |
| Alta      | `#E53935`       | `#FFCDD2`   | Tareas urgentes  |
| Media     | `#FFA726`       | `#FFE0B2`   | Tareas normales  |
| Baja      | `#43A047`       | `#C8E6C9`   | Tareas sin prisa |

---

## 📝 Tipografía

### Escala Tipográfica

```dart
// lib/core/theme/app_typography.dart

import 'package:flutter/material.dart';

/// Estilos tipográficos de la aplicación.
abstract class AppTypography {
  // ═══════════════════════════════════════════════════
  // TÍTULOS
  // ═══════════════════════════════════════════════════

  /// Título de página principal
  static const headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  /// Título de sección
  static const headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  /// Título de tarjeta
  static const headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  // ═══════════════════════════════════════════════════
  // TÍTULOS SECUNDARIOS
  // ═══════════════════════════════════════════════════

  /// Título de lista
  static const titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  /// Título de item
  static const titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  /// Subtítulo
  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // ═══════════════════════════════════════════════════
  // CUERPO DE TEXTO
  // ═══════════════════════════════════════════════════

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  );

  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  );

  // ═══════════════════════════════════════════════════
  // ETIQUETAS Y BOTONES
  // ═══════════════════════════════════════════════════

  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}
```

---

## 🧩 Componentes

### TaskItem Widget

```dart
/// Especificaciones de diseño para TaskItem
///
/// ┌─────────────────────────────────────────────┐
/// │ [Checkbox] [Title]                [Priority]│
/// │           [Description]           [Delete] │
/// │           [Due Date]                        │
/// └─────────────────────────────────────────────┘
///
/// Dimensiones:
/// - Altura mínima: 72dp
/// - Padding horizontal: 16dp
/// - Padding vertical: 12dp
/// - Espaciado entre elementos: 8dp
/// - Checkbox: 24x24dp
/// - Priority indicator: 12x12dp
/// - Delete icon: 24x24dp
///
/// Estados:
/// - Normal: fondo blanco, borde sutil
/// - Completada: título tachado, opacidad reducida
/// - Hover: elevación sutil
/// - Pressed: ripple effect
```

### Especificaciones de Tarjeta

| Propiedad           | Valor                        |
| ------------------- | ---------------------------- |
| Border Radius       | 12dp                         |
| Elevation (normal)  | 1dp                          |
| Elevation (pressed) | 4dp                          |
| Margin              | 8dp horizontal, 4dp vertical |
| Padding interno     | 16dp                         |

### Botones

```dart
/// Botón primario (crear tarea)
/// - BorderRadius: 24dp (pill shape)
/// - Height: 48dp
/// - Padding horizontal: 24dp
/// - Font: labelLarge
/// - Color: primary

/// FAB (Floating Action Button)
/// - Size: 56x56dp
/// - Icon size: 24dp
/// - Elevation: 6dp
/// - Color: primary
```

---

## 📐 Layouts

### Espaciado

```dart
// lib/core/constants/app_spacing.dart

/// Sistema de espaciado consistente.
abstract class AppSpacing {
  // Espaciado base
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Espaciado de pantalla
  static const double screenPadding = 16;
  static const double sectionSpacing = 24;

  // Espaciado de componentes
  static const double cardMargin = 8;
  static const double cardPadding = 16;
  static const double listItemSpacing = 8;
  static const double formFieldSpacing = 16;
}
```

### Grid System

```
┌─────────────────────────────────────┐
│  ←16dp→ [Content] ←16dp→            │
│                                     │
│  Ancho máximo de contenido: 600dp   │
│  (para tablets, centrar contenido)  │
└─────────────────────────────────────┘
```

### Responsive Breakpoints

| Breakpoint | Rango     | Layout                      |
| ---------- | --------- | --------------------------- |
| Compact    | 0-599dp   | Single column               |
| Medium     | 600-839dp | Single column, más padding  |
| Expanded   | 840dp+    | Two columns o Master-Detail |

---

## 🔣 Iconografía

### Iconos Principales

| Acción          | Icono | Código                 |
| --------------- | ----- | ---------------------- |
| Agregar         | ➕    | `Icons.add`            |
| Editar          | ✏️    | `Icons.edit`           |
| Eliminar        | 🗑️    | `Icons.delete`         |
| Completar       | ✓     | `Icons.check`          |
| Prioridad Alta  | 🔴    | Custom circle          |
| Prioridad Media | 🟠    | Custom circle          |
| Prioridad Baja  | 🟢    | Custom circle          |
| Calendario      | 📅    | `Icons.calendar_today` |
| Filtro          | ⏬    | `Icons.filter_list`    |
| Búsqueda        | 🔍    | `Icons.search`         |
| Configuración   | ⚙️    | `Icons.settings`       |

### Tamaños de Iconos

| Contexto         | Tamaño |
| ---------------- | ------ |
| AppBar actions   | 24dp   |
| List item        | 24dp   |
| FAB              | 24dp   |
| Tab bar          | 24dp   |
| Bottom nav       | 24dp   |
| Small indicators | 16dp   |
| Very small       | 12dp   |

---

## ✨ Animaciones

### Durations

```dart
// lib/core/constants/app_animations.dart

/// Duraciones estándar de animaciones.
abstract class AppAnimations {
  // Duraciones
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);

  // Curvas
  static const defaultCurve = Curves.easeInOut;
  static const entranceCurve = Curves.easeOut;
  static const exitCurve = Curves.easeIn;
  static const bounceCurve = Curves.elasticOut;
}
```

### Animaciones Recomendadas

| Acción          | Tipo                | Duración | Curva      |
| --------------- | ------------------- | -------- | ---------- |
| Aparecer item   | FadeIn + SlideUp    | 300ms    | easeOut    |
| Eliminar item   | FadeOut + SlideLeft | 200ms    | easeIn     |
| Toggle checkbox | Scale               | 150ms    | elasticOut |
| FAB press       | Scale down          | 100ms    | easeInOut  |
| Page transition | SlideRight          | 300ms    | easeInOut  |
| Loading         | Pulse               | ∞        | linear     |

### Ejemplo de Animación

```dart
/// Animación de entrada para items de lista
class AnimatedTaskItem extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedTaskItem({
    required this.child,
    required this.index,
  });

  @override
  _AnimatedTaskItemState createState() => _AnimatedTaskItemState();
}

class _AnimatedTaskItemState extends State<AnimatedTaskItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Delay basado en índice para efecto cascada
    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
```

---

## 📱 Tema Completo

```dart
// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Tema de la aplicación Material Design 3.
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
      ),
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    // Implementar tema oscuro...
    return lightTheme; // Placeholder
  }
}
```

---

> **Referencia**: Sigue las guías de [Material Design 3](https://m3.material.io/) para mantener consistencia visual.
