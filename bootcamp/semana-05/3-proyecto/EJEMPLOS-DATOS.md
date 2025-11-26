# 📊 Datos de Ejemplo - ShopApp

## 📁 Archivo de Mock Data

Crea `lib/data/mock_data.dart`:

```dart
import '../models/product.dart';
import '../models/category.dart';

/// Datos de prueba para la aplicación ShopApp
///
/// ¿Qué hace? Proporciona datos estáticos para desarrollo
/// ¿Para qué? Evitar dependencia de API durante desarrollo
/// ¿Cómo? Listas de objetos predefinidos con datos realistas
class MockData {
  MockData._();

  // =====================================================
  // CATEGORÍAS
  // =====================================================

  static final List<Category> categories = [
    const Category(
      id: 'cat_001',
      name: 'Electrónica',
      icon: '📱',
      color: 0xFF2196F3,
    ),
    const Category(
      id: 'cat_002',
      name: 'Ropa',
      icon: '👕',
      color: 0xFF9C27B0,
    ),
    const Category(
      id: 'cat_003',
      name: 'Hogar',
      icon: '🏠',
      color: 0xFF4CAF50,
    ),
    const Category(
      id: 'cat_004',
      name: 'Deportes',
      icon: '⚽',
      color: 0xFFFF9800,
    ),
    const Category(
      id: 'cat_005',
      name: 'Libros',
      icon: '📚',
      color: 0xFF795548,
    ),
  ];

  // =====================================================
  // PRODUCTOS
  // =====================================================

  static final List<Product> products = [
    // Electrónica
    const Product(
      id: 'prod_001',
      name: 'Auriculares Bluetooth Pro',
      description:
        'Auriculares inalámbricos con cancelación de ruido activa, '
        'batería de 30 horas y sonido Hi-Fi. Perfectos para trabajo '
        'y entretenimiento. Incluye estuche de carga y cable USB-C.',
      price: 89.99,
      originalPrice: 129.99,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
      categoryId: 'cat_001',
      rating: 4.7,
      reviewCount: 2341,
      stock: 45,
      tags: ['bluetooth', 'wireless', 'noise-cancelling'],
      isFeatured: true,
    ),
    const Product(
      id: 'prod_002',
      name: 'Smartwatch Fitness',
      description:
        'Reloj inteligente con monitor de ritmo cardíaco, GPS integrado, '
        'resistencia al agua 5ATM y más de 100 modos deportivos. '
        'Compatible con iOS y Android.',
      price: 149.99,
      originalPrice: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
      categoryId: 'cat_001',
      rating: 4.5,
      reviewCount: 1856,
      stock: 32,
      tags: ['smartwatch', 'fitness', 'gps'],
      isFeatured: true,
    ),
    const Product(
      id: 'prod_003',
      name: 'Cargador Inalámbrico 15W',
      description:
        'Cargador rápido inalámbrico compatible con todos los dispositivos '
        'Qi. Diseño ultra delgado con indicador LED y protección contra '
        'sobrecarga.',
      price: 24.99,
      originalPrice: 34.99,
      imageUrl: 'https://images.unsplash.com/photo-1586816879360-004f5b0c51e5',
      categoryId: 'cat_001',
      rating: 4.3,
      reviewCount: 987,
      stock: 78,
      tags: ['wireless', 'charger', 'fast-charging'],
      isFeatured: false,
    ),

    // Ropa
    const Product(
      id: 'prod_004',
      name: 'Camiseta Premium Algodón',
      description:
        'Camiseta de algodón orgánico 100%, corte regular fit. '
        'Disponible en múltiples colores. Suave, transpirable y '
        'resistente a múltiples lavados.',
      price: 29.99,
      originalPrice: null,
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
      categoryId: 'cat_002',
      rating: 4.6,
      reviewCount: 3456,
      stock: 120,
      tags: ['cotton', 'organic', 'casual'],
      isFeatured: false,
    ),
    const Product(
      id: 'prod_005',
      name: 'Sudadera con Capucha',
      description:
        'Sudadera de felpa francesa con capucha ajustable y bolsillo '
        'canguro. Interior suave y cálido, ideal para entretiempo.',
      price: 49.99,
      originalPrice: 69.99,
      imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7',
      categoryId: 'cat_002',
      rating: 4.8,
      reviewCount: 2134,
      stock: 65,
      tags: ['hoodie', 'casual', 'warm'],
      isFeatured: true,
    ),
    const Product(
      id: 'prod_006',
      name: 'Jeans Slim Fit',
      description:
        'Jeans de mezclilla premium con stretch para mayor comodidad. '
        'Corte slim fit, 5 bolsillos clásicos. Lavado medio.',
      price: 59.99,
      originalPrice: 79.99,
      imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d',
      categoryId: 'cat_002',
      rating: 4.4,
      reviewCount: 1678,
      stock: 43,
      tags: ['denim', 'slim', 'stretch'],
      isFeatured: false,
    ),

    // Hogar
    const Product(
      id: 'prod_007',
      name: 'Lámpara LED Inteligente',
      description:
        'Lámpara de escritorio LED con 5 niveles de brillo y 3 '
        'temperaturas de color. Control táctil y temporizador. '
        'Compatible con asistentes de voz.',
      price: 39.99,
      originalPrice: 54.99,
      imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c',
      categoryId: 'cat_003',
      rating: 4.5,
      reviewCount: 876,
      stock: 55,
      tags: ['led', 'smart', 'desk-lamp'],
      isFeatured: true,
    ),
    const Product(
      id: 'prod_008',
      name: 'Set de Organizadores',
      description:
        'Set de 6 cajas organizadoras de diferentes tamaños. '
        'Material resistente, apilables y plegables. Ideales para '
        'closet, cajones y estantes.',
      price: 34.99,
      originalPrice: null,
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64',
      categoryId: 'cat_003',
      rating: 4.2,
      reviewCount: 543,
      stock: 89,
      tags: ['organizer', 'storage', 'foldable'],
      isFeatured: false,
    ),

    // Deportes
    const Product(
      id: 'prod_009',
      name: 'Zapatillas Running Pro',
      description:
        'Zapatillas de running con tecnología de amortiguación avanzada. '
        'Upper transpirable, suela de goma duradera. Para corredores '
        'de nivel intermedio a avanzado.',
      price: 119.99,
      originalPrice: 159.99,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
      categoryId: 'cat_004',
      rating: 4.9,
      reviewCount: 4521,
      stock: 28,
      tags: ['running', 'sports', 'cushioning'],
      isFeatured: true,
    ),
    const Product(
      id: 'prod_010',
      name: 'Botella Térmica 750ml',
      description:
        'Botella de acero inoxidable con aislamiento al vacío. '
        'Mantiene bebidas frías 24h o calientes 12h. Libre de BPA, '
        'con tapa a prueba de fugas.',
      price: 27.99,
      originalPrice: 35.99,
      imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8',
      categoryId: 'cat_004',
      rating: 4.6,
      reviewCount: 1234,
      stock: 156,
      tags: ['bottle', 'thermal', 'stainless-steel'],
      isFeatured: false,
    ),
    const Product(
      id: 'prod_011',
      name: 'Mat de Yoga Premium',
      description:
        'Colchoneta de yoga de 6mm de grosor con textura antideslizante. '
        'Material TPE ecológico, incluye correa de transporte.',
      price: 44.99,
      originalPrice: null,
      imageUrl: 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f',
      categoryId: 'cat_004',
      rating: 4.7,
      reviewCount: 892,
      stock: 67,
      tags: ['yoga', 'fitness', 'eco-friendly'],
      isFeatured: false,
    ),

    // Libros
    const Product(
      id: 'prod_012',
      name: 'Flutter in Action',
      description:
        'Guía completa para desarrollar aplicaciones móviles con Flutter. '
        'Desde conceptos básicos hasta técnicas avanzadas. Incluye '
        'ejemplos prácticos y proyectos reales.',
      price: 42.99,
      originalPrice: 54.99,
      imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c',
      categoryId: 'cat_005',
      rating: 4.8,
      reviewCount: 567,
      stock: 34,
      tags: ['programming', 'flutter', 'mobile'],
      isFeatured: true,
    ),
    const Product(
      id: 'prod_013',
      name: 'Clean Code',
      description:
        'El clásico de Robert C. Martin sobre buenas prácticas de '
        'programación. Aprende a escribir código limpio, mantenible '
        'y profesional.',
      price: 38.99,
      originalPrice: null,
      imageUrl: 'https://images.unsplash.com/photo-1532012197267-da84d127e765',
      categoryId: 'cat_005',
      rating: 4.9,
      reviewCount: 8934,
      stock: 45,
      tags: ['programming', 'best-practices', 'classic'],
      isFeatured: false,
    ),
  ];

  // =====================================================
  // MÉTODOS DE BÚSQUEDA
  // =====================================================

  /// Obtiene productos por categoría
  static List<Product> getProductsByCategory(String categoryId) {
    return products.where((p) => p.categoryId == categoryId).toList();
  }

  /// Obtiene productos destacados
  static List<Product> getFeaturedProducts() {
    return products.where((p) => p.isFeatured).toList();
  }

  /// Obtiene productos en oferta
  static List<Product> getProductsOnSale() {
    return products.where((p) => p.originalPrice != null).toList();
  }

  /// Busca productos por término
  static List<Product> searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    return products.where((p) =>
      p.name.toLowerCase().contains(lowerQuery) ||
      p.description.toLowerCase().contains(lowerQuery) ||
      p.tags.any((tag) => tag.toLowerCase().contains(lowerQuery))
    ).toList();
  }

  /// Obtiene un producto por ID
  static Product? getProductById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Obtiene una categoría por ID
  static Category? getCategoryById(String id) {
    try {
      return categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
```

---

## 📦 Modelos de Datos

### Product Model

Crea `lib/models/product.dart`:

```dart
/// Modelo de Producto
///
/// ¿Qué hace? Representa un producto de la tienda
/// ¿Para qué? Estructura los datos del catálogo
/// ¿Cómo? Clase inmutable con todos los atributos del producto
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;  // null si no tiene descuento
  final String imageUrl;
  final String categoryId;
  final double rating;
  final int reviewCount;
  final int stock;
  final List<String> tags;
  final bool isFeatured;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.categoryId,
    required this.rating,
    required this.reviewCount,
    required this.stock,
    required this.tags,
    required this.isFeatured,
  });

  /// Calcula el porcentaje de descuento
  int? get discountPercentage {
    if (originalPrice == null) return null;
    return ((1 - price / originalPrice!) * 100).round();
  }

  /// Verifica si está en stock
  bool get isInStock => stock > 0;

  /// Verifica si tiene poco stock
  bool get isLowStock => stock > 0 && stock <= 5;

  /// Crea una copia con valores modificados
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    String? categoryId,
    double? rating,
    int? reviewCount,
    int? stock,
    List<String>? tags,
    bool? isFeatured,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      stock: stock ?? this.stock,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Product &&
      runtimeType == other.runtimeType &&
      id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}
```

### Category Model

Crea `lib/models/category.dart`:

```dart
/// Modelo de Categoría
///
/// ¿Qué hace? Representa una categoría de productos
/// ¿Para qué? Agrupa productos por tipo
/// ¿Cómo? Clase inmutable con identificador, nombre e icono
class Category {
  final String id;
  final String name;
  final String icon;  // Emoji o icon name
  final int color;    // Color en formato int (0xFFRRGGBB)

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Category &&
      runtimeType == other.runtimeType &&
      id == other.id;

  @override
  int get hashCode => id.hashCode;
}
```

### CartItem Model

Crea `lib/models/cart_item.dart`:

```dart
import 'product.dart';

/// Modelo de Item del Carrito
///
/// ¿Qué hace? Representa un producto en el carrito con su cantidad
/// ¿Para qué? Gestionar productos seleccionados por el usuario
/// ¿Cómo? Combina Product con cantidad y calcula subtotal
class CartItem {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    this.quantity = 1,
  });

  /// Calcula el subtotal de este item
  double get subtotal => product.price * quantity;

  /// Crea copia con cantidad modificada
  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is CartItem &&
      runtimeType == other.runtimeType &&
      product.id == other.product.id;

  @override
  int get hashCode => product.id.hashCode;
}
```

---

## 🛒 Provider del Carrito

Crea `lib/providers/cart_provider.dart`:

```dart
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

/// Provider del Carrito de Compras
///
/// ¿Qué hace? Gestiona el estado del carrito de compras
/// ¿Para qué? Centralizar operaciones de agregar, eliminar, actualizar
/// ¿Cómo? ChangeNotifier con lista de CartItems y métodos de mutación
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  // =====================================================
  // GETTERS
  // =====================================================

  /// Lista de items (inmutable hacia afuera)
  List<CartItem> get items => List.unmodifiable(_items);

  /// Cantidad total de items en el carrito
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Cantidad de productos únicos
  int get uniqueItemCount => _items.length;

  /// Total del carrito
  double get total => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  /// Verifica si el carrito está vacío
  bool get isEmpty => _items.isEmpty;

  /// Verifica si un producto está en el carrito
  bool containsProduct(String productId) {
    return _items.any((item) => item.product.id == productId);
  }

  /// Obtiene la cantidad de un producto específico
  int getQuantity(String productId) {
    final item = _items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => const CartItem(product: Product(
        id: '', name: '', description: '', price: 0,
        imageUrl: '', categoryId: '', rating: 0,
        reviewCount: 0, stock: 0, tags: [], isFeatured: false,
      ), quantity: 0),
    );
    return item.quantity;
  }

  // =====================================================
  // MÉTODOS DE MUTACIÓN
  // =====================================================

  /// Agrega un producto al carrito
  void addItem(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Ya existe, incrementar cantidad
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + quantity,
      );
    } else {
      // Nuevo item
      _items.add(CartItem(product: product, quantity: quantity));
    }

    notifyListeners();
  }

  /// Elimina un producto del carrito
  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  /// Actualiza la cantidad de un producto
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }

    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  /// Incrementa la cantidad de un producto
  void incrementQuantity(String productId) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  /// Decrementa la cantidad de un producto
  void decrementQuantity(String productId) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      final currentQuantity = _items[index].quantity;
      if (currentQuantity > 1) {
        _items[index] = _items[index].copyWith(
          quantity: currentQuantity - 1,
        );
        notifyListeners();
      } else {
        removeItem(productId);
      }
    }
  }

  /// Limpia todo el carrito
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
```

---

## 💡 Uso Recomendado

### En main.dart:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        title: 'ShopApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
```

### En cualquier widget:

```dart
// Leer sin escuchar (para acciones)
final cart = context.read<CartProvider>();
cart.addItem(product);

// Escuchar cambios (para UI)
final total = context.watch<CartProvider>().total;

// Escuchar selectivamente (optimizado)
final itemCount = context.select<CartProvider, int>(
  (cart) => cart.itemCount,
);
```

---

## 🎨 Imágenes Alternativas

Si prefieres usar assets locales en lugar de URLs:

```dart
// En pubspec.yaml:
// assets:
//   - assets/images/

// Luego usa:
imageUrl: 'assets/images/product_001.jpg',
```

O genera placeholders con colores:

```dart
// Widget placeholder
Container(
  color: Colors.grey[300],
  child: const Icon(Icons.image, size: 48),
)
```

---

*Datos de ejemplo para ShopApp - Semana 05*
*Bootcamp Flutter*
