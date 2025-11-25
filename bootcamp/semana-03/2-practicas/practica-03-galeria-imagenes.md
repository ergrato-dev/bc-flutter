# 🖼️ Práctica 03: Galería de Imágenes

> **Duración estimada:** 45-60 minutos  
> **Nivel:** Intermedio  
> **Conceptos:** GridView, GridView.builder, AspectRatio, Hero animation

---

## 📋 Objetivo

Crear una galería de imágenes usando `GridView.builder` que se adapte al tamaño de pantalla.

---

## 🎨 Diseño a Implementar

```
┌─────────────────────────────────────────────┐
│  🖼️ Mi Galería                        ≡    │
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐     │
│  │         │  │         │  │         │     │
│  │  IMG 1  │  │  IMG 2  │  │  IMG 3  │     │
│  │         │  │         │  │         │     │
│  └─────────┘  └─────────┘  └─────────┘     │
│                                             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐     │
│  │         │  │         │  │         │     │
│  │  IMG 4  │  │  IMG 5  │  │  IMG 6  │     │
│  │         │  │         │  │         │     │
│  └─────────┘  └─────────┘  └─────────┘     │
│                                             │
└─────────────────────────────────────────────┘
```

---

## 📝 Requisitos

### Funcionales

1. Grid de imágenes con 3 columnas (móvil) o más (tablet)
2. Tap en imagen abre vista completa
3. Indicador de carga en cada imagen
4. Manejo de errores de imagen

### Técnicos

1. `GridView.builder` para eficiencia
2. `LayoutBuilder` para columnas adaptativas
3. `Hero` para animación de transición
4. `Image.network` con estados

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
      title: 'Galería de Imágenes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const GalleryScreen(),
    );
  }
}

// ═══════════════════════════════════════════════════════
// MODELO DE DATOS
// ═══════════════════════════════════════════════════════

class GalleryImage {
  final String id;
  final String url;
  final String title;
  final String author;

  const GalleryImage({
    required this.id,
    required this.url,
    required this.title,
    required this.author,
  });
}

// Datos de ejemplo
final List<GalleryImage> sampleImages = List.generate(
  20,
  (index) => GalleryImage(
    id: 'img_$index',
    url: 'https://picsum.photos/400/400?random=$index',
    title: 'Imagen ${index + 1}',
    author: 'Fotógrafo ${index + 1}',
  ),
);

// ═══════════════════════════════════════════════════════
// PANTALLA PRINCIPAL
// ═══════════════════════════════════════════════════════

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.photo_library),
            SizedBox(width: 8),
            Text('Mi Galería'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {},
          ),
        ],
      ),
      body: const ImageGrid(),
    );
  }
}

// ═══════════════════════════════════════════════════════
// GRID DE IMÁGENES
// ═══════════════════════════════════════════════════════

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calcular columnas según ancho
        final columns = _calculateColumns(constraints.maxWidth);

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: sampleImages.length,
          itemBuilder: (context, index) {
            return ImageTile(image: sampleImages[index]);
          },
        );
      },
    );
  }

  int _calculateColumns(double width) {
    if (width < 400) return 2;
    if (width < 600) return 3;
    if (width < 900) return 4;
    return 5;
  }
}

// ═══════════════════════════════════════════════════════
// TILE DE IMAGEN
// ═══════════════════════════════════════════════════════

class ImageTile extends StatelessWidget {
  final GalleryImage image;

  const ImageTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openFullScreen(context),
      child: Hero(
        tag: image.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image.url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
            errorBuilder: (context, error, stack) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 40),
              );
            },
          ),
        ),
      ),
    );
  }

  void _openFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImage(image: image),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// PANTALLA COMPLETA
// ═══════════════════════════════════════════════════════

class FullScreenImage extends StatelessWidget {
  final GalleryImage image;

  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(image.title),
      ),
      body: Center(
        child: Hero(
          tag: image.id,
          child: InteractiveViewer(
            child: Image.network(
              image.url,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## ✅ Criterios de Evaluación

- [ ] Grid se adapta al ancho de pantalla
- [ ] Imágenes tienen loading indicator
- [ ] Errores de imagen se manejan
- [ ] Hero animation funciona
- [ ] InteractiveViewer permite zoom
