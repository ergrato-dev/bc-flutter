# 🎨 Guía de Diseño - News Reader App

## 📱 Wireframes

### Navegación Principal

```
┌─────────────────────────────────────────────────────────────────┐
│                      NEWS READER APP                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  BottomNavigationBar:                                           │
│  ┌──────────┬──────────┬──────────┬──────────┬──────────┐       │
│  │   🏠     │   📑     │   🔍     │   ⭐     │   ⚙️     │       │
│  │  Home    │ Categorías│ Buscar  │ Favoritos│  Config  │       │
│  └──────────┴──────────┴──────────┴──────────┴──────────┘       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 1. Home Screen

```
┌─────────────────────────────────────────┐
│ ═══════════════════════════════════════ │
│    📰 News Reader              🔔  👤   │
│ ═══════════════════════════════════════ │
│                                         │
│  🌐 Top Headlines • España              │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │ ┌───────────────────────────────┐   │ │
│ │ │                               │   │ │
│ │ │        Featured Image         │   │ │
│ │ │          (300x180)            │   │ │
│ │ │                               │   │ │
│ │ └───────────────────────────────┘   │ │
│ │ Título de la noticia principal      │ │
│ │ Descripción breve de la noticia...  │ │
│ │ BBC News • hace 2 horas             │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ ┌─────────┬─────────────────────────┐   │
│ │  📷     │ Título noticia 2        │   │
│ │  100x80 │ Descripción breve...    │   │
│ │         │ CNN • hace 3h           │   │
│ └─────────┴─────────────────────────┘   │
│                                         │
│ ┌─────────┬─────────────────────────┐   │
│ │  📷     │ Título noticia 3        │   │
│ │  100x80 │ Descripción breve...    │   │
│ │         │ El País • hace 4h       │   │
│ └─────────┴─────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

### 2. Categorías Screen

```
┌─────────────────────────────────────────┐
│ ═══════════════════════════════════════ │
│    📑 Categorías                        │
│ ═══════════════════════════════════════ │
│                                         │
│ ┌─────┬─────┬─────┬─────┬─────┬─────┐  │
│ │ All │ 💼  │ 🎬  │ 🏥  │ 🔬  │ ⚽  │  │
│ │     │Busi.│Enter│Healt│Scien│Sport│  │
│ └─────┴─────┴─────┴─────┴─────┴─────┘  │
│        ↑ Chips de categorías            │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │  📷     Título categorizado         │ │
│ │         Descripción...              │ │
│ │         Fuente • Tiempo             │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │  📷     Título categorizado         │ │
│ │         Descripción...              │ │
│ │         Fuente • Tiempo             │ │
│ └─────────────────────────────────────┘ │
│                                         │
└─────────────────────────────────────────┘
```

### 3. Búsqueda Screen

```
┌─────────────────────────────────────────┐
│ ═══════════════════════════════════════ │
│  🔍 [                           ] ✕     │
│     Buscar noticias...                  │
│ ═══════════════════════════════════════ │
│                                         │
│  Búsquedas recientes          Limpiar  │
│  ┌─────────────────────────────────┐   │
│  │ 🕐 flutter                   ✕  │   │
│  │ 🕐 apple                     ✕  │   │
│  │ 🕐 inteligencia artificial   ✕  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  - - - - - - - - - - - - - - - - - - - │
│                                         │
│  Resultados para "query" (15)           │
│                                         │
│ ┌─────────┬─────────────────────────┐   │
│ │  📷     │ Título resultado        │   │
│ │         │ Descripción...          │   │
│ │         │ Fuente • Tiempo         │   │
│ └─────────┴─────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

### 4. Detalle Screen

```
┌─────────────────────────────────────────┐
│ ← Back                     ⭐  📤       │
│ ═══════════════════════════════════════ │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │                                     │ │
│ │                                     │ │
│ │         Hero Image                  │ │
│ │          (Full Width)               │ │
│ │                                     │ │
│ │                                     │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │ CATEGORÍA                           │ │
│ │                                     │ │
│ │ Título completo de la noticia       │ │
│ │ que puede ocupar varias líneas      │ │
│ │                                     │ │
│ │ 📰 BBC News    👤 John Doe          │ │
│ │ 📅 15 Ene 2024                      │ │
│ │                                     │ │
│ │ ─────────────────────────────────── │ │
│ │                                     │ │
│ │ Descripción completa de la noticia. │ │
│ │ Este es el contenido principal que  │ │
│ │ puede ser extenso y detallado...    │ │
│ │                                     │ │
│ │ ┌─────────────────────────────────┐ │ │
│ │ │   🌐 Leer artículo completo     │ │ │
│ │ └─────────────────────────────────┘ │ │
│ └─────────────────────────────────────┘ │
│                                         │
└─────────────────────────────────────────┘
```

### 5. Favoritos Screen

```
┌─────────────────────────────────────────┐
│ ═══════════════════════════════════════ │
│    ⭐ Favoritos             🗑️ Limpiar │
│ ═══════════════════════════════════════ │
│                                         │
│  Tienes 5 noticias guardadas           │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │  📷     │ Título favorito 1         │ │
│ │         │ Descripción...        ⭐  │ │
│ │         │ Fuente • Guardado hace 2h │ │
│ └─────────────────────────────────────┘ │
│                                         │
│ ┌─────────────────────────────────────┐ │
│ │  📷     │ Título favorito 2         │ │
│ │         │ Descripción...        ⭐  │ │
│ │         │ Fuente • Guardado hace 1d │ │
│ └─────────────────────────────────────┘ │
│                                         │
│         - Estado vacío -               │
│                                         │
│        ┌──────────────────┐            │
│        │      ⭐          │            │
│        │  Sin favoritos   │            │
│        │  Guarda noticias │            │
│        │  para leer luego │            │
│        └──────────────────┘            │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🎨 Paleta de Colores

### Tema Claro

```dart
// lib/core/theme/app_colors.dart

class AppColors {
  // Primary
  static const Color primary = Color(0xFF1976D2);      // Azul
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF0D47A1);

  // Secondary
  static const Color secondary = Color(0xFFFF5722);    // Naranja
  static const Color secondaryLight = Color(0xFFFF8A50);

  // Background
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Categories
  static const Color business = Color(0xFF3F51B5);
  static const Color entertainment = Color(0xFFE91E63);
  static const Color health = Color(0xFF4CAF50);
  static const Color science = Color(0xFF9C27B0);
  static const Color sports = Color(0xFFFF5722);
  static const Color technology = Color(0xFF00BCD4);
}
```

### Tema Oscuro

```dart
class AppColorsDark {
  // Primary
  static const Color primary = Color(0xFF90CAF9);
  static const Color primaryDark = Color(0xFF1976D2);

  // Background
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color card = Color(0xFF2C2C2C);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
}
```

---

## 📐 Tipografía

```dart
// lib/core/theme/app_typography.dart

class AppTypography {
  static const String fontFamily = 'Roboto';

  // Headlines
  static const TextStyle headline1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Color(0xFF757575),
  );
}
```

---

## 🧩 Componentes UI

### NewsCard - Horizontal

```dart
/**
 * NewsCard - Tarjeta de noticia horizontal
 *
 * Uso: Lista de noticias
 */
class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const NewsCard({
    super.key,
    required this.article,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? '',
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Contenido
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.description ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          article.source.name,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _formatTime(article.publishedAt),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Favorito
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.amber : Colors.grey,
                ),
                onPressed: onFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return 'hace ${diff.inMinutes}m';
    if (diff.inHours < 24) return 'hace ${diff.inHours}h';
    return 'hace ${diff.inDays}d';
  }
}
```

### FeaturedCard - Grande

```dart
/**
 * FeaturedNewsCard - Tarjeta destacada
 *
 * Uso: Primera noticia del home
 */
class FeaturedNewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;

  const FeaturedNewsCard({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: Colors.grey[200],
                ),
                errorWidget: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, size: 48),
                ),
              ),
            ),

            // Contenido
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blue,
                        child: Text(
                          article.source.name[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article.source.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(article.publishedAt),
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
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

### CategoryChip

```dart
/**
 * CategoryChip - Chip de categoría
 */
class CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : color,
                fontWeight: FontWeight.w500,
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

## 📏 Espaciado y Dimensiones

```dart
// lib/core/theme/app_spacing.dart

class AppSpacing {
  // Padding
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  // Border Radius
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;

  // Image sizes
  static const double thumbnailWidth = 100;
  static const double thumbnailHeight = 80;
  static const double featuredAspectRatio = 16 / 9;

  // Icon sizes
  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconLg = 32;
}
```

---

## 📱 Responsive Breakpoints

```dart
// lib/core/utils/responsive.dart

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static int getGridCrossAxisCount(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }
}
```

---

📅 **Semana:** 06 | 📱 **Proyecto:** News Reader App
