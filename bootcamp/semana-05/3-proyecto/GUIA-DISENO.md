# 🎨 Guía de Diseño - ShopApp

## 📐 Estructura de Pantallas

### 1. HomeScreen (Pantalla Principal)

```
┌─────────────────────────────────────┐
│  🛒 ShopApp             🛒 (3)      │  ← AppBar con badge
├─────────────────────────────────────┤
│  🔍 Buscar productos...             │  ← SearchBar
├─────────────────────────────────────┤
│                                     │
│  📱 Electrónica  👕 Ropa  🏠 Hogar  │  ← Categorías (horizontal)
│                                     │
├─────────────────────────────────────┤
│  ⭐ Destacados                      │
│  ┌──────┐ ┌──────┐ ┌──────┐       │
│  │ IMG  │ │ IMG  │ │ IMG  │       │  ← Grid de productos
│  │ Name │ │ Name │ │ Name │       │
│  │ $99  │ │ $49  │ │ $29  │       │
│  │ ⭐4.5│ │ ⭐4.8│ │ ⭐4.2│       │
│  └──────┘ └──────┘ └──────┘       │
│                                     │
│  ┌──────┐ ┌──────┐ ┌──────┐       │
│  │ ...  │ │ ...  │ │ ...  │       │
│  └──────┘ └──────┘ └──────┘       │
│                                     │
└─────────────────────────────────────┘
```

### 2. ProductDetailScreen (Detalle del Producto)

```
┌─────────────────────────────────────┐
│  ←  Producto           ♡            │  ← AppBar con favorito
├─────────────────────────────────────┤
│                                     │
│         ┌───────────────┐           │
│         │               │           │
│         │    IMAGEN     │           │  ← Imagen grande
│         │   PRODUCTO    │           │
│         │               │           │
│         └───────────────┘           │
│                                     │
│  Auriculares Bluetooth Pro          │  ← Nombre
│  ⭐ 4.7  (2,341 reseñas)            │  ← Rating
│                                     │
│  $89.99  ~~$129.99~~  -31%          │  ← Precio con descuento
│                                     │
│  ─────────────────────────────────  │
│                                     │
│  Descripción del producto que       │  ← Descripción
│  explica las características        │
│  principales...                     │
│                                     │
│  Tags: bluetooth, wireless, audio   │  ← Tags
│                                     │
├─────────────────────────────────────┤
│  [ - ]  2  [ + ]     [Agregar 🛒]   │  ← Cantidad y botón
└─────────────────────────────────────┘
```

### 3. CartScreen (Carrito)

```
┌─────────────────────────────────────┐
│  ←  Carrito (3)        🗑️ Vaciar   │  ← AppBar
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────────┐│
│  │ [IMG]  Auriculares Pro         ││
│  │        $89.99 x 2 = $179.98    ││  ← CartItem
│  │        [ - ] 2 [ + ]    🗑️    ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │ [IMG]  Smartwatch Fitness      ││
│  │        $149.99 x 1 = $149.99   ││  ← CartItem
│  │        [ - ] 1 [ + ]    🗑️    ││
│  └─────────────────────────────────┘│
│                                     │
│  ─────────────────────────────────  │
│                                     │
│  Subtotal:              $329.97     │
│  Envío:                 $9.99       │  ← Resumen
│  ─────────────────────────────────  │
│  Total:                 $339.96     │
│                                     │
├─────────────────────────────────────┤
│     [ Proceder al Pago - $339.96 ]  │  ← Botón checkout
└─────────────────────────────────────┘
```

---

## 🎨 Paleta de Colores

### Tema Claro (Light Theme)

| Elemento | Color | Hex |
|----------|-------|-----|
| Primary | Azul | `#2196F3` |
| Secondary | Naranja | `#FF9800` |
| Background | Blanco | `#FFFFFF` |
| Surface | Gris claro | `#F5F5F5` |
| Text Primary | Negro | `#212121` |
| Text Secondary | Gris | `#757575` |
| Error | Rojo | `#F44336` |
| Success | Verde | `#4CAF50` |

### Tema Oscuro (Dark Theme)

| Elemento | Color | Hex |
|----------|-------|-----|
| Primary | Azul claro | `#64B5F6` |
| Secondary | Naranja | `#FFB74D` |
| Background | Gris oscuro | `#121212` |
| Surface | Gris | `#1E1E1E` |
| Text Primary | Blanco | `#FFFFFF` |
| Text Secondary | Gris claro | `#B0B0B0` |
| Error | Rojo claro | `#EF5350` |
| Success | Verde claro | `#81C784` |

---

## 📦 Componentes Reutilizables

### 1. ProductCard

```dart
/// Card de producto para grid
///
/// Uso:
/// ProductCard(
///   product: product,
///   onTap: () => Navigator.push(...),
///   onAddToCart: () => cart.addItem(product),
/// )
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
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
            // Imagen con badge de descuento
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 48),
                    ),
                  ),
                ),
                if (product.discountPercentage != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product.discountPercentage}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Info del producto
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (product.originalPrice != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '\$${product.originalPrice!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${product.reviewCount})',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
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

### 2. CartBadge

```dart
/// Badge del carrito para AppBar (optimizado con Selector)
///
/// Uso en AppBar actions:
/// actions: [CartBadge()]
class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    // Selector: solo escucha itemCount, no todo el carrito
    final itemCount = context.select<CartProvider, int>(
      (cart) => cart.itemCount,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
        if (itemCount > 0)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                itemCount > 99 ? '99+' : '$itemCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
```

### 3. CartItemWidget

```dart
/// Widget para un item en la lista del carrito
class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback? onRemove;
  final ValueChanged<int>? onQuantityChanged;

  const CartItemWidget({
    super.key,
    required this.item,
    this.onRemove,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)} x ${item.quantity}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    '\$${item.subtotal.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Controles de cantidad
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: item.quantity > 1
                          ? () => onQuantityChanged?.call(item.quantity - 1)
                          : null,
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => onQuantityChanged?.call(item.quantity + 1),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 4. QuantitySelector

```dart
/// Selector de cantidad para ProductDetail
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final int maxQuantity;
  final ValueChanged<int> onChanged;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.maxQuantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: quantity > 1
              ? () => onChanged(quantity - 1)
              : null,
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[200],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: quantity < maxQuantity
              ? () => onChanged(quantity + 1)
              : null,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
```

---

## 📱 Responsive Design

### Breakpoints Recomendados

```dart
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

// Uso
extension ContextExtensions on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 900;
  bool get isDesktop => MediaQuery.of(this).size.width >= 900;
}
```

### Grid Adaptativo

```dart
// En HomeScreen
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: context.isMobile ? 2 : context.isTablet ? 3 : 4,
    childAspectRatio: 0.75,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) => ProductCard(product: products[index]),
)
```

---

## ✨ Animaciones Sugeridas

### Agregar al Carrito

```dart
// Efecto de "volar" al carrito
ScaleTransition(
  scale: _animation,
  child: IconButton(
    icon: const Icon(Icons.add_shopping_cart),
    onPressed: () {
      _controller.forward(from: 0);
      cart.addItem(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} agregado al carrito'),
          action: SnackBarAction(
            label: 'Ver carrito',
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ),
      );
    },
  ),
)
```

### Empty State

```dart
// Cuando el carrito está vacío
Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.shopping_cart_outlined,
        size: 80,
        color: Colors.grey[400],
      ),
      const SizedBox(height: 16),
      Text(
        'Tu carrito está vacío',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 8),
      Text(
        'Agrega productos para comenzar',
        style: TextStyle(color: Colors.grey[600]),
      ),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Explorar productos'),
      ),
    ],
  ),
)
```

---

## 📁 Estructura de Carpetas Sugerida

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_dimensions.dart
│   └── theme/
│       └── app_theme.dart
├── data/
│   └── mock_data.dart
├── models/
│   ├── product.dart
│   ├── category.dart
│   └── cart_item.dart
├── providers/
│   ├── cart_provider.dart
│   └── favorites_provider.dart  (opcional)
├── screens/
│   ├── home_screen.dart
│   ├── product_detail_screen.dart
│   ├── cart_screen.dart
│   └── category_screen.dart  (opcional)
└── widgets/
    ├── product_card.dart
    ├── cart_badge.dart
    ├── cart_item_widget.dart
    ├── quantity_selector.dart
    ├── category_chip.dart
    └── empty_state.dart
```

---

## 🧪 Testing Tips

### Test del CartProvider

```dart
void main() {
  group('CartProvider', () {
    late CartProvider cart;

    setUp(() {
      cart = CartProvider();
    });

    test('starts empty', () {
      expect(cart.isEmpty, true);
      expect(cart.itemCount, 0);
    });

    test('addItem increases count', () {
      cart.addItem(mockProduct);
      expect(cart.itemCount, 1);
      expect(cart.total, mockProduct.price);
    });

    test('addItem same product increases quantity', () {
      cart.addItem(mockProduct);
      cart.addItem(mockProduct);
      expect(cart.uniqueItemCount, 1);
      expect(cart.itemCount, 2);
    });

    test('removeItem decreases count', () {
      cart.addItem(mockProduct);
      cart.removeItem(mockProduct.id);
      expect(cart.isEmpty, true);
    });
  });
}
```

---

*Guía de Diseño para ShopApp - Semana 05*
*Bootcamp Flutter*
