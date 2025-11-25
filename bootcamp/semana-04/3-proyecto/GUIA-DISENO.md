# 🎨 Guía de Diseño - TravelApp

## 📐 Sistema de Diseño

### Espaciado

```dart
// Sistema de espaciado consistente
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}
```

### Bordes Redondeados

```dart
class AppRadius {
  AppRadius._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 999.0;
}
```

---

## 🎨 Tema de la Aplicación

```dart
// lib/config/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Colores principales
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFFFF9800);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFF44336);
  static const Color successColor = Color(0xFF4CAF50);

  // Colores de texto
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
```

---

## 📱 Diseño de Pantallas

### 1. Splash Screen

```
┌─────────────────────────────┐
│                             │
│                             │
│                             │
│         [Logo App]          │
│                             │
│         TravelApp           │
│                             │
│                             │
│      [Loading Spinner]      │
│                             │
└─────────────────────────────┘
```

**Especificaciones:**

- Fondo: Gradiente `primaryColor` → `primaryColor.shade700`
- Logo: 120x120 px, centrado
- Texto: Poppins Bold, 32px, blanco
- Spinner: `CircularProgressIndicator` blanco
- Duración: 2-3 segundos

---

### 2. Onboarding Screen

```
┌─────────────────────────────┐
│                             │
│      [Imagen/Ilustración]   │
│                             │
│                             │
├─────────────────────────────┤
│                             │
│    Descubre el mundo        │
│                             │
│    Encuentra los mejores    │
│    destinos para tu         │
│    próxima aventura         │
│                             │
│         ● ○ ○               │
│                             │
│  [Skip]        [Siguiente]  │
│                             │
└─────────────────────────────┘
```

**3 Páginas:**

1. "Descubre el mundo" - Explorar destinos
2. "Planifica tu viaje" - Reservar fácilmente
3. "Vive la aventura" - Disfruta sin preocupaciones

---

### 3. Login Screen

```
┌─────────────────────────────┐
│         ←                   │
│                             │
│      [Logo pequeño]         │
│                             │
│    Bienvenido de nuevo      │
│    Inicia sesión para       │
│    continuar                │
│                             │
│  ┌───────────────────────┐  │
│  │ 📧 Email              │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ 🔒 Contraseña      👁  │  │
│  └───────────────────────┘  │
│                             │
│  ¿Olvidaste tu contraseña?  │
│                             │
│  ┌───────────────────────┐  │
│  │     Iniciar Sesión    │  │
│  └───────────────────────┘  │
│                             │
│  ───────── o ─────────      │
│                             │
│  [Google]  [Facebook]       │
│                             │
│  ¿No tienes cuenta?         │
│  Regístrate                 │
│                             │
└─────────────────────────────┘
```

---

### 4. Main Screen (Explore Tab)

```
┌─────────────────────────────┐
│  ☰       TravelApp      🔔  │
├─────────────────────────────┤
│                             │
│  Hola, Juan 👋              │
│  ¿A dónde vamos?            │
│                             │
│  ┌───────────────────────┐  │
│  │ 🔍 Buscar destino...  │  │
│  └───────────────────────┘  │
│                             │
│  Categorías                 │
│  [🏖️Playas][⛰️Montañas]...  │
│                             │
│  Destinos Populares         │
│  ┌─────────┐ ┌─────────┐   │
│  │ [Img]   │ │ [Img]   │   │
│  │ París   │ │ Tokio   │   │
│  │ ⭐ 4.8  │ │ ⭐ 4.9  │   │
│  │ $1,200  │ │ $1,500  │   │
│  └─────────┘ └─────────┘   │
│                             │
├─────────────────────────────┤
│  🏠    🔍    📋    👤       │
└─────────────────────────────┘
```

---

### 5. Destination Detail Screen

```
┌─────────────────────────────┐
│  ←                      ♡   │
│                             │
│  ┌───────────────────────┐  │
│  │                       │  │
│  │    [Imagen Grande]    │  │
│  │                       │  │
│  │      ● ● ○ ○ ○        │  │
│  └───────────────────────┘  │
│                             │
│  París, Francia             │
│  ⭐ 4.8 (2.4k reviews)      │
│                             │
│  Descripción                │
│  La ciudad del amor...      │
│  [Ver más]                  │
│                             │
│  Highlights                 │
│  [Torre Eiffel] [Louvre]    │
│  [Champs-Élysées]           │
│                             │
│  ─────────────────────────  │
│  Desde $1,200               │
│  por persona                │
│           ┌──────────────┐  │
│           │   Reservar   │  │
│           └──────────────┘  │
└─────────────────────────────┘
```

---

### 6. Booking Screen

```
┌─────────────────────────────┐
│  ←    Reservar viaje        │
├─────────────────────────────┤
│                             │
│  París, Francia             │
│  ┌───────────────────────┐  │
│  │ [Mini imagen] París   │  │
│  │ $1,200/persona        │  │
│  └───────────────────────┘  │
│                             │
│  Fecha de inicio            │
│  ┌───────────────────────┐  │
│  │ 📅 15 Dic 2024        │  │
│  └───────────────────────┘  │
│                             │
│  Fecha de fin               │
│  ┌───────────────────────┐  │
│  │ 📅 22 Dic 2024        │  │
│  └───────────────────────┘  │
│                             │
│  Viajeros                   │
│  ┌───────────────────────┐  │
│  │    [-]    2    [+]    │  │
│  └───────────────────────┘  │
│                             │
│  ─────────────────────────  │
│  Resumen                    │
│  7 noches × 2 = $2,400      │
│  Impuestos        $240      │
│  ─────────────────────────  │
│  Total           $2,640     │
│                             │
│  ┌───────────────────────┐  │
│  │  Confirmar Reserva    │  │
│  └───────────────────────┘  │
│                             │
└─────────────────────────────┘
```

---

### 7. Drawer Menu

```
┌─────────────────────────────┐
│  ┌─────────────────────┐    │
│  │                     │    │
│  │  [Avatar]           │    │
│  │  Juan Pérez         │    │
│  │  juan@email.com     │    │
│  │                     │    │
│  └─────────────────────┘    │
│                             │
│  👤  Mi Cuenta              │
│  ─────────────────────────  │
│  ✈️  Mis Viajes             │
│  ─────────────────────────  │
│  ❤️  Favoritos              │
│  ─────────────────────────  │
│  ⚙️  Configuración          │
│  ─────────────────────────  │
│  ❓  Ayuda                  │
│  ─────────────────────────  │
│                             │
│                             │
│                             │
│  🚪  Cerrar Sesión          │
│                             │
└─────────────────────────────┘
```

---

## 🧩 Componentes Reutilizables

### Destination Card

```dart
class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen con botón favorito
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    destination.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: onFavorite,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            // Información
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        destination.country,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text('${destination.rating}'),
                        ],
                      ),
                      Text(
                        '\$${destination.price.toInt()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
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

### Booking Card

```dart
class BookingCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback onTap;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Imagen miniatura
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  booking.destination.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.destination.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatDate(booking.startDate)} - ${_formatDate(booking.endDate)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    _buildStatusChip(booking.status),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BookingStatus status) {
    Color color;
    String label;

    switch (status) {
      case BookingStatus.pending:
        color = Colors.orange;
        label = 'Pendiente';
        break;
      case BookingStatus.confirmed:
        color = Colors.green;
        label = 'Confirmada';
        break;
      case BookingStatus.completed:
        color = Colors.blue;
        label = 'Completada';
        break;
      case BookingStatus.cancelled:
        color = Colors.red;
        label = 'Cancelada';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
```

---

## 📏 Especificaciones de Iconos

| Elemento      | Icono                   | Tamaño |
| ------------- | ----------------------- | ------ |
| Tab Home      | `Icons.home`            | 24px   |
| Tab Search    | `Icons.search`          | 24px   |
| Tab Bookings  | `Icons.calendar_today`  | 24px   |
| Tab Profile   | `Icons.person`          | 24px   |
| Back          | `Icons.arrow_back`      | 24px   |
| Menu          | `Icons.menu`            | 24px   |
| Favorite      | `Icons.favorite_border` | 24px   |
| Location      | `Icons.location_on`     | 16px   |
| Star          | `Icons.star`            | 16px   |
| Notifications | `Icons.notifications`   | 24px   |

---

## 🎭 Animaciones Sugeridas

### Transición entre pantallas

```dart
// Transición slide desde la derecha
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) =>
    const DestinationDetailScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  },
);
```

### Animación de favorito

```dart
// Escala al tocar
ScaleTransition(
  scale: Tween(begin: 1.0, end: 1.3).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ),
  ),
  child: Icon(Icons.favorite, color: Colors.red),
);
```
