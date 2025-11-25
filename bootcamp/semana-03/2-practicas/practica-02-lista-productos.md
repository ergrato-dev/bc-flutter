# 🛒 Práctica 02: Lista de Productos

> **Duración estimada:** 45-60 minutos  
> **Nivel:** Principiante-Intermedio  
> **Conceptos:** ListView, ListView.builder, ListTile, Card, Image, Modelo de datos

---

## 📋 Objetivo

Crear una lista de productos scrolleable usando `ListView.builder`, aplicando los conceptos del **Módulo 02: Sistema de Layouts**.

---

## 🎨 Diseño a Implementar

```
┌─────────────────────────────────────────────┐
│  🛒 Tienda Flutter                    🔍   │
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ ┌─────┐                             │   │
│  │ │     │  MacBook Pro M3             │   │
│  │ │ 💻  │  Laptop Apple 14"           │   │
│  │ │     │  ⭐⭐⭐⭐⭐ (128)             │   │
│  │ └─────┘  $2,499.00                  │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ ┌─────┐                             │   │
│  │ │     │  iPhone 15 Pro              │   │
│  │ │ 📱  │  Smartphone Apple           │   │
│  │ │     │  ⭐⭐⭐⭐⭐ (256)             │   │
│  │ └─────┘  $1,199.00                  │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ ┌─────┐                             │   │
│  │ │     │  AirPods Pro                │   │
│  │ │ 🎧  │  Auriculares Apple          │   │
│  │ │     │  ⭐⭐⭐⭐☆ (89)              │   │
│  │ └─────┘  $249.00                    │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  ... (más productos)                        │
│                                             │
└─────────────────────────────────────────────┘
```

---

## 📝 Requisitos

### Funcionales

1. Mostrar lista scrolleable de productos
2. Cada producto muestra: imagen, nombre, descripción, rating y precio
3. Tap en producto muestra SnackBar con nombre
4. Lista optimizada para muchos elementos

### Técnicos

1. Crear modelo de datos `Product`
2. Usar `ListView.builder` para renderizado eficiente
3. Usar `Card` para cada item
4. Usar `Row` y `Column` para el layout interno
5. Usar `ClipRRect` para redondear imágenes
6. Usar `Image.network` con placeholder

---

## 🚀 Paso a Paso

### Paso 1: Crear el Modelo de Datos

```dart
/**
 * Paso 1: Definir el modelo Product
 *
 * ¿Qué hacemos?
 * Creamos una clase que representa un producto
 * con todas sus propiedades necesarias.
 */

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String category;
  final bool isAvailable;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.category,
    this.isAvailable = true,
  });
}

// Datos de ejemplo
final List<Product> sampleProducts = [
  const Product(
    id: '1',
    name: 'MacBook Pro M3',
    description: 'Laptop Apple 14" con chip M3',
    price: 2499.00,
    imageUrl: 'https://picsum.photos/200?random=1',
    rating: 4.9,
    reviewCount: 128,
    category: 'Laptops',
  ),
  const Product(
    id: '2',
    name: 'iPhone 15 Pro',
    description: 'Smartphone Apple 256GB',
    price: 1199.00,
    imageUrl: 'https://picsum.photos/200?random=2',
    rating: 4.8,
    reviewCount: 256,
    category: 'Smartphones',
  ),
  const Product(
    id: '3',
    name: 'AirPods Pro',
    description: 'Auriculares inalámbricos con ANC',
    price: 249.00,
    imageUrl: 'https://picsum.photos/200?random=3',
    rating: 4.6,
    reviewCount: 89,
    category: 'Audio',
  ),
  const Product(
    id: '4',
    name: 'iPad Air',
    description: 'Tablet Apple 10.9" M1',
    price: 599.00,
    imageUrl: 'https://picsum.photos/200?random=4',
    rating: 4.7,
    reviewCount: 203,
    category: 'Tablets',
  ),
  const Product(
    id: '5',
    name: 'Apple Watch Series 9',
    description: 'Smartwatch con GPS 45mm',
    price: 429.00,
    imageUrl: 'https://picsum.photos/200?random=5',
    rating: 4.5,
    reviewCount: 167,
    category: 'Wearables',
  ),
  const Product(
    id: '6',
    name: 'Magic Keyboard',
    description: 'Teclado inalámbrico con Touch ID',
    price: 199.00,
    imageUrl: 'https://picsum.photos/200?random=6',
    rating: 4.4,
    reviewCount: 78,
    category: 'Accesorios',
  ),
  const Product(
    id: '7',
    name: 'Studio Display',
    description: 'Monitor 5K 27" con webcam',
    price: 1599.00,
    imageUrl: 'https://picsum.photos/200?random=7',
    rating: 4.3,
    reviewCount: 45,
    category: 'Monitores',
  ),
  const Product(
    id: '8',
    name: 'HomePod mini',
    description: 'Altavoz inteligente con Siri',
    price: 99.00,
    imageUrl: 'https://picsum.photos/200?random=8',
    rating: 4.2,
    reviewCount: 312,
    category: 'Audio',
  ),
];
```

### Paso 2: Crear la Estructura Base

```dart
/**
 * Paso 2: App y pantalla principal
 *
 * ¿Qué hacemos?
 * Creamos la estructura base con MaterialApp
 * y el Scaffold de la pantalla de productos.
 */

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Productos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 8),
            Text('Tienda Flutter'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Búsqueda
            },
          ),
        ],
      ),
      body: const ProductList(),
    );
  }
}
```

### Paso 3: Implementar ListView.builder

```dart
/**
 * Paso 3: ListView.builder para la lista
 *
 * ¿Por qué ListView.builder?
 * - Renderiza solo los items visibles
 * - Eficiente para listas largas
 * - Crea items bajo demanda
 */

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Padding alrededor de la lista
      padding: const EdgeInsets.all(16),

      // Cantidad de items
      itemCount: sampleProducts.length,

      // Constructor de cada item
      itemBuilder: (context, index) {
        final product = sampleProducts[index];
        return ProductCard(product: product);
      },
    );
  }
}
```

### Paso 4: Crear el ProductCard

```dart
/**
 * Paso 4: Widget de tarjeta de producto
 *
 * ¿Qué hacemos?
 * Creamos una Card que contiene toda la información
 * del producto en un layout horizontal.
 */

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Seleccionaste: ${product.name}'),
              action: SnackBarAction(
                label: 'Ver',
                onPressed: () {},
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              _buildProductImage(),

              const SizedBox(width: 16),

              // Información del producto
              Expanded(
                child: _buildProductInfo(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        product.imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        // Placeholder mientras carga
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        // En caso de error
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[200],
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categoría
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: Colors.indigo.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            product.category,
            style: TextStyle(
              fontSize: 10,
              color: Colors.indigo[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Nombre
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 4),

        // Descripción
        Text(
          product.description,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 8),

        // Rating
        _buildRating(),

        const SizedBox(height: 8),

        // Precio y disponibilidad
        _buildPriceRow(),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        // Estrellas
        ...List.generate(5, (index) {
          return Icon(
            index < product.rating.floor()
                ? Icons.star
                : index < product.rating
                    ? Icons.star_half
                    : Icons.star_border,
            color: Colors.amber,
            size: 16,
          );
        }),

        const SizedBox(width: 4),

        // Número de reseñas
        Text(
          '(${product.reviewCount})',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Precio
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),

        // Disponibilidad
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: product.isAvailable
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            product.isAvailable ? 'Disponible' : 'Agotado',
            style: TextStyle(
              fontSize: 11,
              color: product.isAvailable ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
```

---

## ✅ Código Completo

```dart
/**
 * Práctica 02: Lista de Productos
 *
 * Esta práctica demuestra el uso de:
 * - ListView.builder para listas eficientes
 * - Card para contenedores de items
 * - Row y Column para layouts
 * - ClipRRect para redondear imágenes
 * - Image.network con loadingBuilder y errorBuilder
 * - Modelos de datos en Dart
 */

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ═══════════════════════════════════════════════════════
// MODELO DE DATOS
// ═══════════════════════════════════════════════════════

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String category;
  final bool isAvailable;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.category,
    this.isAvailable = true,
  });
}

// Datos de ejemplo
final List<Product> sampleProducts = [
  const Product(
    id: '1',
    name: 'MacBook Pro M3',
    description: 'Laptop Apple 14" con chip M3',
    price: 2499.00,
    imageUrl: 'https://picsum.photos/200?random=1',
    rating: 4.9,
    reviewCount: 128,
    category: 'Laptops',
  ),
  const Product(
    id: '2',
    name: 'iPhone 15 Pro',
    description: 'Smartphone Apple 256GB',
    price: 1199.00,
    imageUrl: 'https://picsum.photos/200?random=2',
    rating: 4.8,
    reviewCount: 256,
    category: 'Smartphones',
  ),
  const Product(
    id: '3',
    name: 'AirPods Pro',
    description: 'Auriculares inalámbricos con ANC',
    price: 249.00,
    imageUrl: 'https://picsum.photos/200?random=3',
    rating: 4.6,
    reviewCount: 89,
    category: 'Audio',
  ),
  const Product(
    id: '4',
    name: 'iPad Air',
    description: 'Tablet Apple 10.9" M1',
    price: 599.00,
    imageUrl: 'https://picsum.photos/200?random=4',
    rating: 4.7,
    reviewCount: 203,
    category: 'Tablets',
  ),
  const Product(
    id: '5',
    name: 'Apple Watch Series 9',
    description: 'Smartwatch con GPS 45mm',
    price: 429.00,
    imageUrl: 'https://picsum.photos/200?random=5',
    rating: 4.5,
    reviewCount: 167,
    category: 'Wearables',
  ),
  const Product(
    id: '6',
    name: 'Magic Keyboard',
    description: 'Teclado inalámbrico con Touch ID',
    price: 199.00,
    imageUrl: 'https://picsum.photos/200?random=6',
    rating: 4.4,
    reviewCount: 78,
    category: 'Accesorios',
  ),
  const Product(
    id: '7',
    name: 'Studio Display',
    description: 'Monitor 5K 27" con webcam',
    price: 1599.00,
    imageUrl: 'https://picsum.photos/200?random=7',
    rating: 4.3,
    reviewCount: 45,
    category: 'Monitores',
  ),
  const Product(
    id: '8',
    name: 'HomePod mini',
    description: 'Altavoz inteligente con Siri',
    price: 99.00,
    imageUrl: 'https://picsum.photos/200?random=8',
    rating: 4.2,
    reviewCount: 312,
    category: 'Audio',
  ),
];

// ═══════════════════════════════════════════════════════
// APP PRINCIPAL
// ═══════════════════════════════════════════════════════

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Productos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}

// ═══════════════════════════════════════════════════════
// PANTALLA PRINCIPAL
// ═══════════════════════════════════════════════════════

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 8),
            Text('Tienda Flutter'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Búsqueda próximamente')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filtros próximamente')),
              );
            },
          ),
        ],
      ),
      body: const ProductList(),
    );
  }
}

// ═══════════════════════════════════════════════════════
// LISTA DE PRODUCTOS
// ═══════════════════════════════════════════════════════

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sampleProducts.length,
      itemBuilder: (context, index) {
        final product = sampleProducts[index];
        return ProductCard(product: product);
      },
    );
  }
}

// ═══════════════════════════════════════════════════════
// TARJETA DE PRODUCTO
// ═══════════════════════════════════════════════════════

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _onProductTap(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              const SizedBox(width: 16),
              Expanded(child: _buildProductInfo(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _onProductTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste: ${product.name}'),
        action: SnackBarAction(
          label: 'Ver',
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        product.imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[200],
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryBadge(),
        const SizedBox(height: 8),
        _buildProductName(),
        const SizedBox(height: 4),
        _buildProductDescription(),
        const SizedBox(height: 8),
        _buildRating(),
        const SizedBox(height: 8),
        _buildPriceRow(),
      ],
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        product.category,
        style: TextStyle(
          fontSize: 10,
          color: Colors.indigo[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      product.name,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProductDescription() {
    return Text(
      product.description,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[600],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < product.rating.floor()
                ? Icons.star
                : index < product.rating
                    ? Icons.star_half
                    : Icons.star_border,
            color: Colors.amber,
            size: 16,
          );
        }),
        const SizedBox(width: 4),
        Text(
          '(${product.reviewCount})',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        _buildAvailabilityBadge(),
      ],
    );
  }

  Widget _buildAvailabilityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: product.isAvailable
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        product.isAvailable ? 'Disponible' : 'Agotado',
        style: TextStyle(
          fontSize: 11,
          color: product.isAvailable ? Colors.green : Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
```

---

## 🏆 Desafíos Adicionales

### Desafío 1: Pull to Refresh

Implementa `RefreshIndicator` para recargar la lista.

### Desafío 2: Añadir al Carrito

Añade un botón para agregar productos al carrito.

### Desafío 3: Favoritos

Implementa un corazón para marcar productos como favoritos.

### Desafío 4: ListView.separated

Cambia a `ListView.separated` con un `Divider` entre items.

---

## 📚 Conceptos Aplicados

| Concepto           | Widget/Método      | Uso en la Práctica  |
| ------------------ | ------------------ | ------------------- |
| Lista eficiente    | `ListView.builder` | Lista de productos  |
| Contenedor de item | `Card`             | Cada producto       |
| Layout horizontal  | `Row`              | Imagen + Info       |
| Layout vertical    | `Column`           | Info del producto   |
| Imagen con borde   | `ClipRRect`        | Imagen del producto |
| Imagen de red      | `Image.network`    | Con loading/error   |
| Interactividad     | `InkWell`          | Tap en tarjeta      |
| Modelo de datos    | `Product` class    | Estructura de datos |

---

## 🔗 Referencias

- [Módulo 02: Sistema de Layouts](../1-teoria/02-sistema-layouts.md)
- [ListView - Flutter Docs](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [Card - Flutter Docs](https://api.flutter.dev/flutter/material/Card-class.html)

---

## ✅ Criterios de Evaluación

- [ ] La lista es scrolleable sin problemas
- [ ] Usa ListView.builder (no ListView con children)
- [ ] Las imágenes tienen placeholder de carga
- [ ] Las imágenes manejan errores
- [ ] El rating muestra estrellas correctamente
- [ ] El precio está formateado con 2 decimales
- [ ] El tap muestra feedback (SnackBar)
- [ ] El código está organizado en métodos separados
