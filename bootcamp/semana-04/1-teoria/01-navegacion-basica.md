# 📚 Módulo 01: Navegación Básica en Flutter

## 🎯 Objetivos del Módulo

- Comprender el concepto de Navigator y stack de rutas
- Implementar navegación con `push` y `pop`
- Usar diferentes tipos de rutas (MaterialPageRoute, CupertinoPageRoute)
- Pasar datos entre pantallas mediante constructores
- Retornar datos desde una pantalla

## ⏱️ Tiempo Estimado: 50 minutos

---

## 📚 Contenido

### 1.1 ¿Qué es Navigator?

El **Navigator** es un widget que gestiona un stack (pila) de objetos Route. Funciona como una pila LIFO (Last In, First Out):

```
┌─────────────────────────────────────┐
│           STACK DE RUTAS            │
├─────────────────────────────────────┤
│                                     │
│   ┌─────────────────────┐           │
│   │  Pantalla Detalle   │ ◄── TOP   │
│   └─────────────────────┘   (visible)
│   ┌─────────────────────┐           │
│   │  Pantalla Lista     │           │
│   └─────────────────────┘           │
│   ┌─────────────────────┐           │
│   │  Pantalla Home      │ ◄── BASE  │
│   └─────────────────────┘           │
│                                     │
│   push() ──► Añade al top           │
│   pop()  ──► Remueve del top        │
│                                     │
└─────────────────────────────────────┘
```

**¿Qué hace?**
- Mantiene un historial de pantallas visitadas
- Permite navegar hacia adelante (push) y hacia atrás (pop)
- Gestiona las transiciones entre pantallas

**¿Para qué sirve?**
- Crear flujos de navegación en la app
- Mantener el estado de navegación
- Permitir al usuario regresar a pantallas anteriores

**¿Cómo funciona?**
- Cada pantalla es un `Route` en el stack
- `push()` añade una nueva ruta al top
- `pop()` remueve la ruta del top
- La ruta en el top es la pantalla visible

---

### 1.2 Navigator.push() - Navegación Básica

```dart
/**
 * Navegación básica con Navigator.push()
 * 
 * ¿Qué hace?
 * Añade una nueva pantalla al stack de navegación
 * 
 * ¿Para qué?
 * Ir de una pantalla a otra (ej: de lista a detalle)
 * 
 * ¿Cómo funciona?
 * 1. Navigator encuentra el Navigator más cercano en el árbol
 * 2. Crea una nueva ruta con MaterialPageRoute
 * 3. Añade la ruta al stack
 * 4. Ejecuta la animación de transición
 */

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar a la pantalla de detalle
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailScreen(),
              ),
            );
          },
          child: const Text('Ir a Detalle'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        // El botón de back aparece automáticamente
      ),
      body: const Center(
        child: Text('Pantalla de Detalle'),
      ),
    );
  }
}
```

---

### 1.3 Navigator.pop() - Regresar

```dart
/**
 * Regresar con Navigator.pop()
 * 
 * ¿Qué hace?
 * Remueve la pantalla actual del stack y regresa a la anterior
 * 
 * ¿Para qué?
 * - Cerrar una pantalla de detalle
 * - Cancelar un formulario
 * - Regresar después de una acción
 * 
 * ¿Cómo funciona?
 * 1. Remueve la ruta actual del top del stack
 * 2. Ejecuta la animación de transición inversa
 * 3. La pantalla anterior se vuelve visible
 */

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Regresar a la pantalla anterior
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pantalla de Detalle'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 1.4 Tipos de Routes

Flutter ofrece diferentes tipos de rutas con distintas animaciones:

```dart
/**
 * MaterialPageRoute
 * 
 * ¿Qué hace?
 * Crea una ruta con transición estilo Material Design
 * 
 * ¿Para qué?
 * Apps Android o que siguen Material Design
 * 
 * Animación: Slide desde la derecha (Android) o bottom (iOS)
 */
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NextScreen(),
  ),
);

/**
 * CupertinoPageRoute
 * 
 * ¿Qué hace?
 * Crea una ruta con transición estilo iOS
 * 
 * ¿Para qué?
 * Apps iOS o que siguen Human Interface Guidelines
 * 
 * Animación: Slide desde la derecha con parallax
 */
import 'package:flutter/cupertino.dart';

Navigator.push(
  context,
  CupertinoPageRoute(
    builder: (context) => const NextScreen(),
  ),
);

/**
 * PageRouteBuilder - Transiciones personalizadas
 * 
 * ¿Qué hace?
 * Permite crear transiciones completamente personalizadas
 * 
 * ¿Para qué?
 * - Animaciones únicas (fade, scale, rotation)
 * - Branding específico de la app
 * - Experiencias de usuario diferenciadas
 */
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const NextScreen();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Transición de fade (desvanecimiento)
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  ),
);
```

#### Ejemplo de Transiciones Personalizadas

```dart
/**
 * Clase helper para transiciones reutilizables
 * 
 * ¿Qué hace?
 * Encapsula diferentes tipos de transiciones
 * 
 * ¿Para qué?
 * Reutilizar animaciones en toda la app
 */
class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final RouteTransitionType transitionType;

  CustomPageRoute({
    required this.page,
    this.transitionType = RouteTransitionType.fade,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case RouteTransitionType.fade:
                return FadeTransition(opacity: animation, child: child);
              
              case RouteTransitionType.scale:
                return ScaleTransition(scale: animation, child: child);
              
              case RouteTransitionType.slideUp:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              
              case RouteTransitionType.slideRight:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
            }
          },
        );
}

enum RouteTransitionType {
  fade,
  scale,
  slideUp,
  slideRight,
}

// Uso:
Navigator.push(
  context,
  CustomPageRoute(
    page: const DetailScreen(),
    transitionType: RouteTransitionType.slideUp,
  ),
);
```

---

### 1.5 Pasar Datos Entre Pantallas

#### Método 1: Constructor (Recomendado)

```dart
/**
 * Pasar datos mediante constructor
 * 
 * ¿Qué hace?
 * Envía datos a la nueva pantalla como parámetros del constructor
 * 
 * ¿Para qué?
 * - Pasar objetos completos (User, Product, etc.)
 * - Pasar IDs para cargar datos
 * - Pasar configuraciones
 * 
 * ¿Cómo funciona?
 * 1. La pantalla destino define parámetros en constructor
 * 2. Al navegar, se pasan los valores
 * 3. La pantalla destino usa los datos
 */

// Modelo de datos
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

// Pantalla de lista
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  final List<Product> products = const [
    Product(id: '1', name: 'Laptop', price: 999.99, imageUrl: '...'),
    Product(id: '2', name: 'Phone', price: 699.99, imageUrl: '...'),
    Product(id: '3', name: 'Tablet', price: 499.99, imageUrl: '...'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            onTap: () {
              // Pasar el producto completo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Pantalla de detalle - recibe el producto
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 100),
            ),
            const SizedBox(height: 16),
            
            // Nombre
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            
            // Precio
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Botón de compra
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Acción de compra
                },
                child: const Text('Agregar al Carrito'),
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

### 1.6 Retornar Datos con pop()

```dart
/**
 * Retornar datos desde una pantalla
 * 
 * ¿Qué hace?
 * Permite que una pantalla envíe un resultado a la pantalla anterior
 * 
 * ¿Para qué?
 * - Seleccionar un item de una lista
 * - Confirmar una acción (Sí/No)
 * - Retornar datos de un formulario
 * 
 * ¿Cómo funciona?
 * 1. push() retorna un Future con el resultado
 * 2. pop(resultado) envía el resultado
 * 3. La pantalla original recibe el resultado con await
 */

// Pantalla que espera un resultado
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedColor;

  Future<void> _selectColor() async {
    // Esperar el resultado de la pantalla de selección
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const ColorPickerScreen(),
      ),
    );

    // Verificar si se seleccionó un color
    if (result != null) {
      setState(() {
        selectedColor = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selección de Color')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedColor != null
                  ? 'Color seleccionado: $selectedColor'
                  : 'Ningún color seleccionado',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectColor,
              child: const Text('Seleccionar Color'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla que retorna un resultado
class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});

  static const colors = ['Rojo', 'Verde', 'Azul', 'Amarillo', 'Naranja'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Elige un Color')),
      body: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(colors[index]),
            leading: const Icon(Icons.color_lens),
            onTap: () {
              // Retornar el color seleccionado
              Navigator.pop(context, colors[index]);
            },
          );
        },
      ),
    );
  }
}
```

---

### 1.7 Navigator.pushReplacement()

```dart
/**
 * pushReplacement - Reemplazar la pantalla actual
 * 
 * ¿Qué hace?
 * Reemplaza la pantalla actual por una nueva (no se puede volver)
 * 
 * ¿Para qué?
 * - Login exitoso → Home (no volver a login)
 * - Splash → Home
 * - Onboarding completado → Home
 * 
 * ¿Cómo funciona?
 * 1. Remueve la ruta actual del stack
 * 2. Añade la nueva ruta
 * 3. No hay forma de volver a la pantalla anterior
 */

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLogin(BuildContext context) {
    // Simular login exitoso
    // Reemplazar Login por Home (no se puede volver a Login)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _handleLogin(context),
          child: const Text('Iniciar Sesión'),
        ),
      ),
    );
  }
}
```

---

### 1.8 Navigator.pushAndRemoveUntil()

```dart
/**
 * pushAndRemoveUntil - Limpiar el stack de navegación
 * 
 * ¿Qué hace?
 * Navega a una nueva pantalla y remueve todas las anteriores
 * hasta que la condición sea verdadera
 * 
 * ¿Para qué?
 * - Logout: ir a Login y limpiar todo el historial
 * - Completar un flujo: limpiar pantallas intermedias
 * - Reset de la app
 * 
 * ¿Cómo funciona?
 * 1. Añade la nueva ruta
 * 2. Remueve rutas del stack mientras la condición sea false
 * 3. Se detiene cuando la condición es true o el stack está vacío
 */

// Ejemplo: Logout - ir a Login y limpiar todo
void _handleLogout(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false, // Remover TODAS las rutas
  );
}

// Ejemplo: Ir a Home y mantener solo Home
void _goToHomeAndClear(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
    (route) => route.isFirst, // Mantener solo la primera ruta
  );
}

// Ejemplo: Después de completar una compra
class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('¡Pedido Confirmado!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Tu pedido ha sido procesado'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ir a Home y limpiar carrito, checkout, etc.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 1.9 Verificar si se Puede Hacer Pop

```dart
/**
 * Navigator.canPop() y Navigator.maybePop()
 * 
 * ¿Qué hacen?
 * - canPop(): Verifica si hay rutas para hacer pop
 * - maybePop(): Hace pop solo si es posible
 * 
 * ¿Para qué?
 * - Evitar errores al intentar pop en la última pantalla
 * - Manejar el botón de back de Android
 * - Lógica condicional de navegación
 */

class SafeNavigationExample extends StatelessWidget {
  const SafeNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navegación Segura'),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null, // No mostrar back button si no hay a dónde volver
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Solo hace pop si es posible
            Navigator.maybePop(context);
          },
          child: const Text('Volver (si es posible)'),
        ),
      ),
    );
  }
}
```

---

### 1.10 WillPopScope - Interceptar Back Button

```dart
/**
 * WillPopScope (Deprecado) / PopScope (Flutter 3.16+)
 * 
 * ¿Qué hace?
 * Intercepta el intento de salir de la pantalla (back button)
 * 
 * ¿Para qué?
 * - Confirmar antes de salir de un formulario
 * - Guardar cambios antes de salir
 * - Prevenir salida accidental
 */

// Flutter 3.16+ usa PopScope
class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool _hasUnsavedChanges = false;
  final _controller = TextEditingController();

  Future<bool> _showExitConfirmation() async {
    if (!_hasUnsavedChanges) return true;

    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Salir sin guardar?'),
        content: const Text('Tienes cambios sin guardar. ¿Deseas salir?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Salir'),
          ),
        ],
      ),
    );

    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        final shouldPop = await _showExitConfirmation();
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Formulario')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Escribe algo...',
            ),
            onChanged: (value) {
              setState(() {
                _hasUnsavedChanges = value.isNotEmpty;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

---

## 💡 Puntos Clave

1. **Navigator es un stack**: push añade, pop remueve
2. **MaterialPageRoute** para transiciones Material Design
3. **Pasar datos por constructor** es la forma más limpia
4. **await Navigator.push()** para recibir resultados
5. **pushReplacement** cuando no quieres que el usuario vuelva
6. **pushAndRemoveUntil** para limpiar el historial
7. **PopScope** para interceptar el back button

---

## ⚠️ Errores Comunes

### ❌ Error: Pop sin rutas en el stack

```dart
// MALO: Error si es la única pantalla
Navigator.pop(context);

// BUENO: Verificar primero
if (Navigator.canPop(context)) {
  Navigator.pop(context);
}
```

### ❌ Error: No manejar resultado null

```dart
// MALO: Puede ser null si el usuario usa back button
final result = await Navigator.push(...);
print(result.length); // Error si result es null

// BUENO: Verificar null
final result = await Navigator.push(...);
if (result != null) {
  print(result.length);
}
```

### ❌ Error: Usar context después de async

```dart
// MALO: El context puede ser inválido después de await
await someAsyncOperation();
Navigator.pop(context); // Posible error

// BUENO: Verificar mounted
await someAsyncOperation();
if (context.mounted) {
  Navigator.pop(context);
}
```

---

## 🔗 Referencias

- [Navigation Basics - Flutter Docs](https://docs.flutter.dev/cookbook/navigation/navigation-basics)
- [Return Data from Screen](https://docs.flutter.dev/cookbook/navigation/returning-data)
- [Navigate with Arguments](https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments)

---

## ✅ Autoevaluación

1. ¿Cuál es la diferencia entre `push` y `pushReplacement`?
2. ¿Cómo paso un objeto completo a otra pantalla?
3. ¿Cómo recibo un resultado de una pantalla?
4. ¿Cuándo usarías `pushAndRemoveUntil`?
5. ¿Cómo intercepto el back button del sistema?
