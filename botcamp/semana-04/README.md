# Semana 4: Navegación y Rutas

## 🎯 Objetivos de Aprendizaje

- Implementar navegación entre pantallas
- Gestionar rutas nombradas
- Pasar datos entre pantallas
- Crear navegación con tabs y drawers
- Manejar el stack de navegación
- Implementar navegación anidada

## 📚 Contenido Teórico

### 1. Navegación Básica (2 horas)

#### Navigator Push y Pop

```dart
// Navegar a nueva pantalla
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => PantallaDestino()),
);

// Regresar
Navigator.pop(context);
```

#### Tipos de Transiciones

- `MaterialPageRoute`: Transición Material
- `CupertinoPageRoute`: Transición iOS
- `PageRouteBuilder`: Transiciones personalizadas

#### Pasar Datos

```dart
// Enviar datos
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetalleScreen(item: miItem),
  ),
);

// Recibir datos en constructor
class DetalleScreen extends StatelessWidget {
  final Item item;
  const DetalleScreen({required this.item});
}
```

### 2. Rutas Nombradas (2 horas)

#### Definir Rutas

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/detalle': (context) => DetalleScreen(),
    '/perfil': (context) => PerfilScreen(),
  },
)
```

#### Navegación con Rutas Nombradas

```dart
// Navegar
Navigator.pushNamed(context, '/detalle');

// Navegar con argumentos
Navigator.pushNamed(
  context,
  '/detalle',
  arguments: {'id': 123, 'nombre': 'Producto'},
);

// Recibir argumentos
final args = ModalRoute.of(context)!.settings.arguments as Map;
```

#### onGenerateRoute

```dart
onGenerateRoute: (settings) {
  if (settings.name == '/detalle') {
    final args = settings.arguments as Map;
    return MaterialPageRoute(
      builder: (context) => DetalleScreen(id: args['id']),
    );
  }
  return null;
}
```

### 3. Navegación Avanzada (2 horas)

#### Navigator 2.0 (Básico)

- Router
- RouterDelegate
- RouteInformationParser

#### Stack de Navegación

```dart
// Reemplazar pantalla actual
Navigator.pushReplacement(context, route);

// Limpiar stack y navegar
Navigator.pushAndRemoveUntil(
  context,
  route,
  (route) => false, // Eliminar todas
);

// Navegar hasta una ruta específica
Navigator.popUntil(context, ModalRoute.withName('/home'));
```

#### Retornar Datos

```dart
// Esperar resultado
final resultado = await Navigator.push(context, route);

// Retornar datos al hacer pop
Navigator.pop(context, 'Datos de retorno');
```

### 4. Navegación con Widgets (2 horas)

#### TabBar y TabBarView

```dart
DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.home), text: 'Inicio'),
          Tab(icon: Icon(Icons.search), text: 'Buscar'),
          Tab(icon: Icon(Icons.person), text: 'Perfil'),
        ],
      ),
    ),
    body: TabBarView(
      children: [
        HomeTab(),
        SearchTab(),
        ProfileTab(),
      ],
    ),
  ),
)
```

#### BottomNavigationBar

```dart
int _selectedIndex = 0;

BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) {
    setState(() {
      _selectedIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
  ],
)
```

#### Drawer (Menú Lateral)

```dart
Drawer(
  child: ListView(
    children: [
      UserAccountsDrawerHeader(
        accountName: Text('Usuario'),
        accountEmail: Text('usuario@email.com'),
        currentAccountPicture: CircleAvatar(...),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Inicio'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
        },
      ),
      // Más items...
    ],
  ),
)
```

## 💻 Ejercicios Prácticos

### Ejercicio 1: Navegación Básica

Crea una app con 3 pantallas:

- Pantalla de inicio con 2 botones
- Pantalla de perfil
- Pantalla de configuración
- Implementa navegación push/pop

### Ejercicio 2: Pasar Datos

Desarrolla una lista de contactos:

- Lista de contactos en pantalla principal
- Tap en contacto para ver detalles
- Pasar objeto completo del contacto
- Mostrar todos los datos

### Ejercicio 3: Rutas Nombradas

Refactoriza la app anterior usando:

- Rutas nombradas
- Argumentos en rutas
- onGenerateRoute para rutas dinámicas

### Ejercicio 4: BottomNavigationBar

Crea una app con navegación inferior:

- 4 tabs: Inicio, Explorar, Favoritos, Perfil
- Mantener estado de cada tab
- Iconos y labels descriptivos

### Ejercicio 5: Drawer Navigation

Implementa un menú lateral con:

- Header personalizado
- 5+ opciones de navegación
- Iconos para cada opción
- Cerrar drawer al navegar

## 🔨 Proyecto de la Semana

**App de Tienda en Línea (E-commerce)**

Desarrolla una aplicación de comercio electrónico con navegación completa:

**Características:**

1. **Pantalla Principal (Home)**

   - BottomNavigationBar con 4 tabs:
     - Inicio: Productos destacados
     - Categorías: Grid de categorías
     - Carrito: Lista de productos en carrito
     - Perfil: Información del usuario
   - Drawer con opciones adicionales

2. **Navegación de Productos**

   - Lista de productos por categoría
   - Tap en producto → Detalles del producto
   - Pasar datos del producto

3. **Pantalla de Detalles**

   - Información completa del producto
   - Galería de imágenes (PageView)
   - Botón "Agregar al carrito"
   - Botón "Compartir"

4. **Carrito de Compras**

   - Lista de productos agregados
   - Cantidad y precio
   - Total a pagar
   - Botón "Proceder al pago"

5. **Proceso de Checkout**

   - Formulario de dirección de envío
   - Método de pago
   - Resumen del pedido
   - Confirmación

6. **Drawer Menu**
   - Mis pedidos
   - Favoritos
   - Configuración
   - Ayuda
   - Cerrar sesión

**Requisitos técnicos:**

- Usar rutas nombradas para todas las pantallas
- Implementar BottomNavigationBar
- Implementar Drawer
- Pasar datos entre pantallas
- Mantener estado del carrito (StatefulWidget)
- Mínimo 20 productos en 5 categorías
- Animaciones de transición suaves

**Estructura de datos:**

```dart
class Producto {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final List<String> imagenes;
  final String categoria;
  final double rating;
  final int stock;
}

class ItemCarrito {
  final Producto producto;
  int cantidad;
}
```

**Rutas a implementar:**

```dart
routes: {
  '/': (context) => MainScreen(), // Con BottomNav
  '/detalle-producto': (context) => DetalleProductoScreen(),
  '/categoria': (context) => CategoriaScreen(),
  '/checkout': (context) => CheckoutScreen(),
  '/confirmacion': (context) => ConfirmacionScreen(),
  '/mis-pedidos': (context) => MisPedidosScreen(),
  '/favoritos': (context) => FavoritosScreen(),
}
```

## 📖 Recursos

### Documentación

- [Navigation and Routing](https://flutter.dev/docs/development/ui/navigation)
- [Navigator 2.0](https://flutter.dev/docs/development/ui/navigation/navigation-and-routing)
- [Cookbook: Navigation](https://flutter.dev/docs/cookbook/navigation)

### Videos

- [Flutter Navigation Tutorial](https://www.youtube.com/watch?v=nyvwx7o277U)
- [Navigator 2.0 Explained](https://www.youtube.com/watch?v=FBoAXUqKqq0)

### Paquetes Útiles

- [go_router](https://pub.dev/packages/go_router)
- [auto_route](https://pub.dev/packages/auto_route)
- [fluro](https://pub.dev/packages/fluro)

## ✅ Checklist de Completitud

- [ ] Ejercicio 1: Navegación básica completado
- [ ] Ejercicio 2: Pasar datos completado
- [ ] Ejercicio 3: Rutas nombradas completado
- [ ] Ejercicio 4: BottomNav completado
- [ ] Ejercicio 5: Drawer completado
- [ ] Proyecto: E-commerce app completado
- [ ] Todas las rutas funcionando correctamente
- [ ] Navegación fluida sin errores
- [ ] Datos pasados correctamente entre pantallas
- [ ] Código subido al repositorio

## 🎓 Evaluación

- **Ejercicios prácticos (1-5):** 35%
- **Proyecto de la semana:** 55%
- **Calidad de navegación y UX:** 10%

## 📝 Notas Importantes

- Siempre proporcionar un botón o gesto para regresar
- Considerar el comportamiento del botón back de Android
- Mantener la navegación intuitiva y predecible
- Evitar stacks de navegación muy profundos
- Limpiar el stack cuando sea necesario (ej: después de login)

## 🔧 Snippets Útiles

```dart
// Hero animation entre pantallas
Hero(
  tag: 'hero-tag',
  child: Image.asset('image.png'),
)

// WillPopScope para controlar botón back
WillPopScope(
  onWillPop: () async {
    // Lógica personalizada
    return true; // Permitir pop
  },
  child: Scaffold(...),
)

// Animación personalizada
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => NextScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(opacity: animation, child: child);
  },
)
```

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 3](../semana-03/README.md) | **Siguiente:** [Semana 5 →](../semana-05/README.md)
