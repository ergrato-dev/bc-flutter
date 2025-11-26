# 🎨 Guía de Diseño - TravelDiary

## 📋 Índice

1. [Paleta de Colores](#-paleta-de-colores)
2. [Tipografía](#-tipografía)
3. [Componentes](#-componentes)
4. [Pantallas](#-pantallas)
5. [Iconografía](#-iconografía)
6. [Animaciones](#-animaciones)

---

## 🎨 Paleta de Colores

### Colores Principales

```dart
class AppColors {
  // Primary
  static const Color primary = Color(0xFF2196F3);       // Azul principal
  static const Color primaryLight = Color(0xFF64B5F6);  // Azul claro
  static const Color primaryDark = Color(0xFF1976D2);   // Azul oscuro

  // Secondary
  static const Color secondary = Color(0xFFFF9800);     // Naranja viajes
  static const Color secondaryLight = Color(0xFFFFB74D);
  static const Color secondaryDark = Color(0xFFF57C00);

  // Background
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // States
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Map markers
  static const Color markerPhoto = Color(0xFF4CAF50);
  static const Color markerLocation = Color(0xFFFF5722);
  static const Color markerCurrent = Color(0xFF2196F3);
}
```

### Uso de Colores

| Elemento         | Color           | Uso                  |
| ---------------- | --------------- | -------------------- |
| AppBar           | `primary`       | Barra superior       |
| FAB              | `secondary`     | Acción principal     |
| Cards            | `surface`       | Contenedores         |
| Texto principal  | `textPrimary`   | Títulos, contenido   |
| Texto secundario | `textSecondary` | Subtítulos, fechas   |
| Estados de éxito | `success`       | Confirmaciones       |
| Estados de error | `error`         | Errores, eliminación |

---

## 📝 Tipografía

### Escala Tipográfica

```dart
class AppTextStyles {
  // Headlines
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
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
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}
```

---

## 🧩 Componentes

### DiaryCard

```
┌────────────────────────────────────────┐
│ ┌──────────────────────────────────┐   │
│ │                                  │   │
│ │         📷 IMAGEN PRINCIPAL      │   │
│ │           (aspect 16:9)          │   │
│ │                                  │   │
│ └──────────────────────────────────┘   │
│                                        │
│  Título de la Entrada                  │
│  📍 Barcelona, España                  │
│  📅 15 de Enero, 2024                  │
│                                        │
│  [📷 3] [💬 Ver más]                   │
└────────────────────────────────────────┘
```

```dart
class DiaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen principal con aspect ratio 16:9
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.file(/* ... */),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  entry.title,
                  style: AppTextStyles.headline3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Ubicación
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text(entry.location?.placeName ?? 'Sin ubicación'),
                  ],
                ),

                // Fecha
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 4),
                    Text(formatDate(entry.date)),
                  ],
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

### PhotoGrid

```
┌─────────┬─────────┬─────────┐
│         │         │         │
│   📷    │   📷    │   📷    │
│         │         │         │
├─────────┼─────────┼─────────┤
│         │         │         │
│   📷    │   📷    │   ➕    │
│         │         │  Añadir │
└─────────┴─────────┴─────────┘
```

```dart
class PhotoGrid extends StatelessWidget {
  final List<Photo> photos;
  final int maxPhotos;
  final VoidCallback onAddPhoto;
  final Function(int) onRemovePhoto;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: photos.length < maxPhotos
          ? photos.length + 1
          : photos.length,
      itemBuilder: (context, index) {
        if (index == photos.length && photos.length < maxPhotos) {
          return _buildAddButton();
        }
        return _buildPhotoItem(photos[index], index);
      },
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: onAddPhoto,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[400]!, style: BorderStyle.solid),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo, size: 32),
            SizedBox(height: 4),
            Text('Añadir'),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoItem(Photo photo, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(photo.localPath),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onRemovePhoto(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

### LocationSelector

```
┌────────────────────────────────────────┐
│  📍 Ubicación                          │
├────────────────────────────────────────┤
│  ┌──────────────────────────────────┐  │
│  │                                  │  │
│  │         🗺️ MINI MAPA            │  │
│  │              📍                  │  │
│  │                                  │  │
│  └──────────────────────────────────┘  │
│                                        │
│  Barcelona, España                     │
│  41.3851° N, 2.1734° E                 │
│                                        │
│  [🎯 Actual]  [📍 Seleccionar]        │
└────────────────────────────────────────┘
```

### PermissionCard

```
┌────────────────────────────────────────┐
│  🎥  Cámara                    ✅      │
│      Para tomar fotos de tus viajes    │
├────────────────────────────────────────┤
│  📍  Ubicación                 ⚠️      │
│      Etiquetar la ubicación    [Dar]   │
├────────────────────────────────────────┤
│  🔔  Notificaciones            ❌      │
│      Recordatorios diarios   [Config]  │
└────────────────────────────────────────┘
```

---

## 📱 Pantallas

### Home Screen

```
┌─────────────────────────────────────┐
│ ☰  TravelDiary               🔍    │
├─────────────────────────────────────┤
│                                     │
│  ┌───────────────────────────────┐  │
│  │      📷 Entrada 1             │  │
│  │      Título, ubicación, fecha │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │      📷 Entrada 2             │  │
│  │      Título, ubicación, fecha │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │      📷 Entrada 3             │  │
│  │      Título, ubicación, fecha │  │
│  └───────────────────────────────┘  │
│                                     │
│                              [+]    │
├─────────────────────────────────────┤
│   📔        🗺️        ⚙️           │
│  Diario    Mapa    Ajustes          │
└─────────────────────────────────────┘
```

### Entry Detail Screen

```
┌─────────────────────────────────────┐
│ ←  Detalle               ✏️  🗑️   │
├─────────────────────────────────────┤
│                                     │
│  ┌───────────────────────────────┐  │
│  │                               │  │
│  │      📷 FOTO PRINCIPAL        │  │
│  │                               │  │
│  └───────────────────────────────┘  │
│  [📷][📷][📷][📷]  ← Miniaturas    │
│                                     │
│  Mi Viaje a Barcelona               │
│  ═══════════════════                │
│                                     │
│  📍 Barcelona, España               │
│  📅 15 de Enero, 2024               │
│                                     │
│  Lorem ipsum dolor sit amet,        │
│  consectetur adipiscing elit.       │
│  Sed do eiusmod tempor...           │
│                                     │
│  ┌───────────────────────────────┐  │
│  │     🗺️ Mini Mapa             │  │
│  │          📍                   │  │
│  └───────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

### Map Screen

```
┌─────────────────────────────────────┐
│ ←  Mapa de Viajes          🔍 📍   │
├─────────────────────────────────────┤
│                                     │
│                                     │
│           🗺️ GOOGLE MAP             │
│                                     │
│        📍         📍                │
│                📍                   │
│     📍                              │
│              📍                     │
│                                     │
│   ┌─────────────────────┐           │
│   │ 📷 Título entrada   │           │
│   │ 📅 Fecha            │← InfoWindow│
│   │ [Ver detalle]       │           │
│   └─────────────────────┘           │
│                                     │
│                              [🎯]   │
├─────────────────────────────────────┤
│   📔        🗺️        ⚙️           │
└─────────────────────────────────────┘
```

### Form Screen

```
┌─────────────────────────────────────┐
│ ←  Nueva Entrada            💾     │
├─────────────────────────────────────┤
│                                     │
│  Título *                           │
│  ┌───────────────────────────────┐  │
│  │ Mi aventura en...             │  │
│  └───────────────────────────────┘  │
│                                     │
│  Descripción                        │
│  ┌───────────────────────────────┐  │
│  │                               │  │
│  │ Cuenta tu experiencia...      │  │
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
│  Fotos                              │
│  ┌─────┬─────┬─────┐               │
│  │ 📷  │ 📷  │  ➕ │               │
│  └─────┴─────┴─────┘               │
│                                     │
│  Ubicación                          │
│  ┌───────────────────────────────┐  │
│  │  🗺️      📍                   │  │
│  └───────────────────────────────┘  │
│  [🎯 Actual] [📍 Seleccionar]      │
│                                     │
│  Fecha                              │
│  [📅 15 Enero 2024        ▼]       │
│                                     │
└─────────────────────────────────────┘
```

---

## 🎭 Iconografía

### Iconos del Sistema

| Concepto     | Icono                  | Uso        |
| ------------ | ---------------------- | ---------- |
| Diario       | `Icons.book`           | Navegación |
| Mapa         | `Icons.map`            | Navegación |
| Ajustes      | `Icons.settings`       | Navegación |
| Cámara       | `Icons.camera_alt`     | Acción     |
| Galería      | `Icons.photo_library`  | Acción     |
| Ubicación    | `Icons.location_on`    | Info       |
| Fecha        | `Icons.calendar_today` | Info       |
| Notificación | `Icons.notifications`  | Acción     |
| Editar       | `Icons.edit`           | Acción     |
| Eliminar     | `Icons.delete`         | Acción     |
| Añadir       | `Icons.add`            | Acción     |
| Buscar       | `Icons.search`         | Acción     |
| Mi ubicación | `Icons.my_location`    | Acción     |

### Marcadores del Mapa

```dart
// Marcador personalizado con foto
BitmapDescriptor _createCustomMarker(String photoPath) async {
  // Crear marcador circular con la foto
  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(pictureRecorder);

  // Dibujar círculo con borde
  final paint = Paint()..color = AppColors.primary;
  canvas.drawCircle(Offset(40, 40), 40, paint);

  // Añadir imagen en el centro
  // ...

  return BitmapDescriptor.fromBytes(/* ... */);
}
```

---

## ✨ Animaciones

### Transiciones entre Pantallas

```dart
// Hero animation para fotos
Hero(
  tag: 'photo_${entry.id}',
  child: Image.file(File(entry.photos.first.localPath)),
)

// Transición personalizada
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  },
)
```

### Animaciones de Lista

```dart
// AnimatedList para entradas
AnimatedList(
  key: _listKey,
  initialItemCount: entries.length,
  itemBuilder: (context, index, animation) {
    return SlideTransition(
      position: animation.drive(
        Tween(begin: const Offset(1, 0), end: Offset.zero),
      ),
      child: DiaryCard(entry: entries[index]),
    );
  },
)
```

### Estados de Carga

```dart
// Shimmer para carga
Shimmer.fromColors(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  child: Container(
    height: 200,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
  ),
)
```

---

## 📐 Espaciado y Dimensiones

### Spacing Scale

```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}
```

### Border Radius

```dart
class AppRadius {
  static const double small = 4;
  static const double medium = 8;
  static const double large = 12;
  static const double xlarge = 16;
  static const double circular = 999;
}
```

### Elevation

```dart
class AppElevation {
  static const double none = 0;
  static const double low = 2;
  static const double medium = 4;
  static const double high = 8;
}
```

---

## 🔗 Navegación

| Anterior                 | Índice                  | Siguiente                                |
| ------------------------ | ----------------------- | ---------------------------------------- |
| [README.md](./README.md) | [Proyecto](./README.md) | [EJEMPLOS-DATOS.md](./EJEMPLOS-DATOS.md) |
