# 🎨 Guía de Diseño - NotesVault

## Paleta de Colores

### Tema Claro

| Uso | Color | Hex |
|-----|-------|-----|
| Primary | Indigo | `#3F51B5` |
| Primary Variant | Deep Indigo | `#303F9F` |
| Secondary | Teal | `#009688` |
| Background | White | `#FFFFFF` |
| Surface | Gray 50 | `#FAFAFA` |
| Error | Red | `#B00020` |
| On Primary | White | `#FFFFFF` |
| On Background | Gray 900 | `#212121` |
| On Surface | Gray 700 | `#616161` |

### Tema Oscuro

| Uso | Color | Hex |
|-----|-------|-----|
| Primary | Indigo 200 | `#9FA8DA` |
| Primary Variant | Indigo 700 | `#5C6BC0` |
| Secondary | Teal 200 | `#80CBC4` |
| Background | Gray 900 | `#121212` |
| Surface | Gray 850 | `#1E1E1E` |
| Error | Red 200 | `#CF6679` |
| On Primary | Black | `#000000` |
| On Background | White | `#FFFFFF` |
| On Surface | Gray 300 | `#E0E0E0` |

### Colores de Notas

```dart
class NoteColors {
  static const List<int> values = [
    0xFFFFFFFF, // Blanco (default)
    0xFFFFF9C4, // Amarillo claro
    0xFFFFCCBC, // Naranja claro
    0xFFF8BBD0, // Rosa claro
    0xFFE1BEE7, // Púrpura claro
    0xFFBBDEFB, // Azul claro
    0xFFB2DFDB, // Teal claro
    0xFFC8E6C9, // Verde claro
    0xFFD7CCC8, // Marrón claro
    0xFFCFD8DC, // Gris azulado
  ];
  
  static const List<String> names = [
    'Blanco',
    'Amarillo',
    'Naranja',
    'Rosa',
    'Púrpura',
    'Azul',
    'Teal',
    'Verde',
    'Marrón',
    'Gris',
  ];
}
```

---

## Tipografía

### Escala Tipográfica

| Estilo | Tamaño | Peso | Uso |
|--------|--------|------|-----|
| Headline Large | 32sp | Bold | Títulos principales |
| Headline Medium | 28sp | SemiBold | Títulos de sección |
| Headline Small | 24sp | SemiBold | Subtítulos |
| Title Large | 22sp | Medium | Título de nota |
| Title Medium | 16sp | Medium | Elementos de lista |
| Body Large | 16sp | Regular | Contenido de nota |
| Body Medium | 14sp | Regular | Texto secundario |
| Body Small | 12sp | Regular | Captions, timestamps |
| Label Large | 14sp | Medium | Botones |
| Label Small | 11sp | Medium | Tags, badges |

### Implementación

```dart
class AppTypography {
  static TextTheme get textTheme => const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );
}
```

---

## Espaciado

### Sistema de Espaciado (8pt Grid)

```dart
class AppSpacing {
  static const double xs = 4.0;   // Extra small
  static const double sm = 8.0;   // Small
  static const double md = 16.0;  // Medium (base)
  static const double lg = 24.0;  // Large
  static const double xl = 32.0;  // Extra large
  static const double xxl = 48.0; // 2X Extra large
}
```

### Uso

```dart
// Padding de pantalla
EdgeInsets.all(AppSpacing.md)  // 16px

// Espacio entre elementos
SizedBox(height: AppSpacing.sm)  // 8px

// Margen de cards
EdgeInsets.symmetric(
  horizontal: AppSpacing.md,
  vertical: AppSpacing.sm,
)
```

---

## Componentes

### Note Card

```
┌─────────────────────────────────┐
│ ┌───────────────────────────┐  │ ← 12px padding
│ │ 🟡 Color indicator (4px)  │  │
│ └───────────────────────────┘  │
│                                 │
│ Título de la Nota              │ ← Title Medium, Bold
│                                 │
│ Vista previa del contenido     │ ← Body Small, Gray
│ de la nota que puede ser       │    Max 3 líneas
│ bastante largo...              │
│                                 │
│ ─────────────────────────────  │ ← Divider
│ ⭐  [work] [important]   ☁️✓  │ ← Tags + Sync status
│ Hace 2 horas                   │ ← Body Small, Gray 400
└─────────────────────────────────┘

Dimensiones:
- Width: Responsive (grid: 50% - padding)
- Min Height: 120px
- Border Radius: 12px
- Elevation: 1 (light) / 0 (dark con border)
```

### Vista Grid

```dart
GridView.builder(
  padding: EdgeInsets.all(AppSpacing.md),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: AppSpacing.sm,
    crossAxisSpacing: AppSpacing.sm,
    childAspectRatio: 0.85,
  ),
)
```

### Vista Lista

```dart
ListView.separated(
  padding: EdgeInsets.all(AppSpacing.md),
  separatorBuilder: (_, __) => SizedBox(height: AppSpacing.sm),
)
```

### Tag Chip

```
┌────────────────┐
│  work    ×    │  ← Removable
└────────────────┘

┌────────────────┐
│  work         │  ← Read-only
└────────────────┘

Height: 32px
Padding: 8px horizontal
Border Radius: 16px (pill)
Font: Label Small
```

### Sync Status Indicator

| Estado | Icono | Color | Tooltip |
|--------|-------|-------|---------|
| Synced | `cloud_done` | Green 500 | "Sincronizada" |
| Pending | `cloud_upload` | Orange 500 | "Pendiente" |
| Error | `cloud_off` | Red 500 | "Error de sync" |

```dart
// Tamaño: 16x16px
Icon(
  status.icon,
  size: 16,
  color: status.color,
)
```

### Color Picker

```
┌─────────────────────────────────────┐
│  Seleccionar color                  │
│  ─────────────────────────────────  │
│  ⚪ 🟡 🟠 🩷 🟣                     │
│  🔵 💚 🟢 🟤 ⬜                     │
│                                     │
│              [Cancelar] [Aceptar]   │
└─────────────────────────────────────┘

Color circle: 40x40px
Spacing: 8px
Selected: Border 2px Primary
```

### Search Bar

```
┌─────────────────────────────────────┐
│ 🔍  Buscar notas...            ✕   │
└─────────────────────────────────────┘

Height: 48px
Border Radius: 24px (pill)
Background: Surface variant
Icon color: On Surface variant
```

---

## Animaciones

### Transiciones

| Elemento | Animación | Duración |
|----------|-----------|----------|
| Página | Slide horizontal | 300ms |
| Modal/Bottom Sheet | Slide vertical | 250ms |
| Card tap | Scale (0.98) | 100ms |
| FAB | Scale in/out | 200ms |
| Snackbar | Slide up | 200ms |

### Curvas

```dart
// Para la mayoría de animaciones
Curves.easeInOut

// Para entradas
Curves.easeOut

// Para salidas
Curves.easeIn

// Para bounce effects
Curves.elasticOut
```

### Implementación de Tap Effect

```dart
class TapEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: Duration(milliseconds: 100),
        child: child,
      ),
    );
  }
}
```

---

## Iconografía

### Iconos Principales

| Función | Icono Material |
|---------|----------------|
| Agregar | `add` |
| Editar | `edit` |
| Eliminar | `delete` |
| Favorito | `star` / `star_border` |
| Buscar | `search` |
| Configuración | `settings` |
| Filtrar | `filter_list` |
| Ordenar | `sort` |
| Vista Grid | `grid_view` |
| Vista Lista | `view_list` |
| Exportar | `file_upload` |
| Importar | `file_download` |
| Papelera | `delete_sweep` |
| Restaurar | `restore_from_trash` |
| Sync | `sync` |
| Offline | `cloud_off` |

### Tamaños

| Contexto | Tamaño |
|----------|--------|
| AppBar | 24px |
| Lista | 24px |
| FAB | 24px |
| Badge/Indicator | 16px |
| Tab Bar | 24px |
| Bottom Nav | 24px |

---

## Layouts de Pantallas

### Home Screen

```
┌─────────────────────────────────────┐
│ AppBar (56px)                       │
│ ┌─────────────────────────────────┐ │
│ │ NotesVault         🔍  ⚙️  ⋮  │ │
│ └─────────────────────────────────┘ │
├─────────────────────────────────────┤
│ Tab Bar (48px)                      │
│ ┌─────────────────────────────────┐ │
│ │ [All] [⭐Fav] [🗑️Trash]        │ │
│ └─────────────────────────────────┘ │
├─────────────────────────────────────┤
│ Filters (optional, 48px)            │
│ ┌─────────────────────────────────┐ │
│ │ [work×] [personal×] [+tag]     │ │
│ └─────────────────────────────────┘ │
├─────────────────────────────────────┤
│                                     │
│ Content Area (flexible)             │
│ GridView / ListView                 │
│                                     │
│                                     │
│                                     │
├─────────────────────────────────────┤
│ FAB Position                   [+]  │
└─────────────────────────────────────┘
```

### Editor Screen

```
┌─────────────────────────────────────┐
│ AppBar (56px)                       │
│ ┌─────────────────────────────────┐ │
│ │ ←  Editar nota    ☁️✓  💾 ⋮   │ │
│ └─────────────────────────────────┘ │
├─────────────────────────────────────┤
│ Color Bar (48px)                    │
│ ┌─────────────────────────────────┐ │
│ │ 🎨 ⚪🟡🟠🩷🟣🔵💚🟢🟤         │ │
│ └─────────────────────────────────┘ │
├─────────────────────────────────────┤
│                                     │
│ Title TextField                     │
│ ┌─────────────────────────────────┐ │
│ │ Título de la nota               │ │
│ └─────────────────────────────────┘ │
│                                     │
│ Content TextField (expanded)        │
│ ┌─────────────────────────────────┐ │
│ │ Contenido...                    │ │
│ │                                 │ │
│ │                                 │ │
│ │                                 │ │
│ └─────────────────────────────────┘ │
│                                     │
├─────────────────────────────────────┤
│ Tags Bar (56px)                     │
│ ┌─────────────────────────────────┐ │
│ │ 🏷️ [work×] [important×] [+]    │ │
│ └─────────────────────────────────┘ │
├─────────────────────────────────────┤
│ Actions Bar (56px)                  │
│ ┌─────────────────────────────────┐ │
│ │ ⭐Favorito  🗑️Eliminar  📤Share│ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

---

## Responsive Breakpoints

```dart
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

// Grid columns por breakpoint
int getGridColumns(double width) {
  if (width < Breakpoints.mobile) return 2;
  if (width < Breakpoints.tablet) return 3;
  if (width < Breakpoints.desktop) return 4;
  return 5;
}
```

---

## Accesibilidad

### Contraste Mínimo

- Texto normal: 4.5:1
- Texto grande: 3:1
- Iconos: 3:1

### Touch Targets

- Mínimo: 48x48dp
- Recomendado: 56x56dp para acciones principales

### Semántica

```dart
Semantics(
  label: 'Agregar nueva nota',
  button: true,
  child: FloatingActionButton(...),
)
```
