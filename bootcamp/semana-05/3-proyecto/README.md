# 🛒 Proyecto Integrador - Semana 05: ShopApp

## 📋 Información del Proyecto

| Aspecto | Detalle |
|---------|---------|
| **Nombre** | ShopApp |
| **Tema** | Gestión de Estado |
| **Puntos** | 50 pts (50% de la nota) |
| **Tiempo estimado** | 3 horas |

---

## 📖 Descripción

Crear una **tienda virtual** que demuestre gestión de estado aplicada:

- 📦 Catálogo de productos con categorías
- 🛒 Carrito de compras global con Provider
- 🔢 Badge con contador optimizado (Selector)
- ♥️ Sistema de favoritos (opcional)
- 💾 Persistencia local (opcional)

La aplicación debe demostrar el uso correcto de **Provider**, **ChangeNotifier**, **Consumer** y **Selector**.

---

## 📚 Documentación de Apoyo

| Documento | Descripción |
|-----------|-------------|
| 📊 [EJEMPLOS-DATOS.md](./EJEMPLOS-DATOS.md) | Mock data, modelos y CartProvider listo para usar |
| 🎨 [GUIA-DISENO.md](./GUIA-DISENO.md) | Wireframes, componentes y paleta de colores |

---

## 🎯 Requerimientos (50 pts)

### 1. Funcionalidad (20 pts)

| Requisito | Puntos | Descripción |
|-----------|--------|-------------|
| Listado de productos | 3 | Grid con ProductCard usando mock data |
| Detalle de producto | 3 | Pantalla con imagen, precio, descripción |
| Agregar al carrito | 5 | Añadir con cantidad, actualizar estado |
| Eliminar del carrito | 2 | Quitar items, actualizar total |
| Contador en AppBar | 3 | Badge con número de items |
| Favoritos | 2 | (Opcional) Marcar/desmarcar productos |
| Persistencia | 2 | (Opcional) SharedPreferences/Hive |

### 2. Calidad del Código (15 pts)

| Requisito | Puntos | Descripción |
|-----------|--------|-------------|
| Estructura clara | 4 | Carpetas: models, providers, screens, widgets |
| Documentación | 4 | Comentarios en widgets principales |
| Nomenclatura | 3 | Inglés, consistente, descriptivo |
| Tests | 4 | Al menos tests del CartProvider |

### 3. UX y Performance (10 pts)

| Requisito | Puntos | Descripción |
|-----------|--------|-------------|
| UI limpia | 4 | Material Design, espaciado correcto |
| Selector/select | 3 | Badge usa Selector, no watch |
| Sin rebuilds innecesarios | 3 | Consumer/Selector donde corresponda |

### 4. Presentación (5 pts)

| Requisito | Puntos | Descripción |
|-----------|--------|-------------|
| README | 2 | Instrucciones para correr |
| Screenshots/GIF | 3 | Demostración del flujo |

---

## 📁 Estructura Sugerida

```
lib/
├── main.dart                 # Entry point con ChangeNotifierProvider
├── core/
│   └── theme/
│       └── app_theme.dart    # Tema de la aplicación
├── data/
│   └── mock_data.dart        # Datos de prueba
├── models/
│   ├── product.dart          # Modelo de producto
│   ├── category.dart         # Modelo de categoría
│   └── cart_item.dart        # Item del carrito
├── providers/
│   ├── cart_provider.dart    # Estado del carrito
│   └── favorites_provider.dart  # (Opcional)
├── screens/
│   ├── home_screen.dart      # Listado de productos
│   ├── product_detail_screen.dart  # Detalle
│   └── cart_screen.dart      # Carrito
└── widgets/
    ├── product_card.dart     # Card para grid
    ├── cart_badge.dart       # Badge con Selector
    ├── cart_item_widget.dart # Item en lista del carrito
    └── quantity_selector.dart # +/- cantidad
```

---

## 🚀 Pasos para Iniciar

### 1. Crear el proyecto

```bash
flutter create shop_app
cd shop_app
```

### 2. Agregar dependencias

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

### 3. Configurar Provider

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),
  );
}
```

### 4. Implementar pantallas

1. **HomeScreen**: Grid de productos con ProductCard
2. **ProductDetailScreen**: Detalle con botón "Agregar"
3. **CartScreen**: Lista de items con total

---

## ✅ Checklist de Entrega

### Funcionalidad
- [ ] HomeScreen muestra productos en grid
- [ ] ProductCard muestra imagen, nombre, precio
- [ ] Tap en producto navega a detalle
- [ ] ProductDetail muestra toda la info
- [ ] Botón "Agregar al carrito" funciona
- [ ] Badge en AppBar muestra cantidad
- [ ] CartScreen muestra items agregados
- [ ] Se puede eliminar items del carrito
- [ ] Total se calcula correctamente

### Código
- [ ] CartProvider extiende ChangeNotifier
- [ ] Usa notifyListeners() al cambiar estado
- [ ] Badge usa context.select (no watch)
- [ ] Carpetas organizadas correctamente
- [ ] Nombres en inglés
- [ ] Comentarios en widgets principales

### Testing
- [ ] Test: carrito empieza vacío
- [ ] Test: addItem incrementa count
- [ ] Test: removeItem decrementa count
- [ ] Test: total se calcula bien

### Entrega
- [ ] README con instrucciones
- [ ] Screenshot de HomeScreen
- [ ] Screenshot de CartScreen
- [ ] (Opcional) GIF del flujo completo

---

## 💡 Tips y Recomendaciones

### 1. Empieza Simple

```dart
// Primero hazlo funcionar con watch
final cart = context.watch<CartProvider>();

// Luego optimiza con select donde sea necesario
final count = context.select<CartProvider, int>((c) => c.itemCount);
```

### 2. Separa Lógica de UI

```dart
// ❌ Malo: lógica en el widget
onPressed: () {
  final items = [...cart.items, product];
  // más lógica...
}

// ✅ Bueno: lógica en el provider
onPressed: () {
  cart.addItem(product);
}
```

### 3. Usa read() para Acciones

```dart
// Para callbacks, usa read (no escucha cambios)
onPressed: () {
  context.read<CartProvider>().addItem(product);
}
```

### 4. DevTools son tu Amigo

- Usa Flutter DevTools → Widget Inspector
- Observa qué widgets se reconstruyen
- Verifica que Selector evita rebuilds

---

## 🎁 Extensiones Opcionales

Si terminas antes, considera agregar:

1. **Favoritos** con otro ChangeNotifier
2. **Persistencia** con SharedPreferences
3. **Búsqueda** de productos
4. **Filtro** por categoría
5. **Animaciones** al agregar al carrito
6. **Tema oscuro** toggle

---

## 📖 Recursos

- [Provider Package](https://pub.dev/packages/provider)
- [Flutter State Management](https://docs.flutter.dev/data-and-backend/state-mgmt)
- [Selector Documentation](https://pub.dev/documentation/provider/latest/provider/Selector-class.html)

---

## 🔗 Navegación

| ⬅️ Prácticas | 📋 Teoría | ➡️ Recursos |
|--------------|-----------|-------------|
| [Ver Prácticas](../2-practicas/README.md) | [Ver Teoría](../1-teoria/README.md) | [Ver Recursos](../4-recursos/README.md) |

---

*Proyecto Integrador Semana 05 - ShopApp*  
*Bootcamp Flutter - Gestión de Estado*


_Buen trabajo: prioriza completar la funcionalidad antes de optimizar._
