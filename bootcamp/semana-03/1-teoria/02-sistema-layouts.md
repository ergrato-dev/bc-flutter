# 📗 Módulo 02: Sistema de Layouts en Flutter

> **Duración estimada**: 2.5 horas  
> **Nivel**: 🟢 Básico-Intermedio  
> **Prerrequisitos**: Módulo 01 (Widgets Fundamentales)

---

## 🎯 Objetivos del Módulo

Al finalizar este módulo serás capaz de:

- ✅ Dominar Column y Row con sus propiedades de alineación
- ✅ Implementar listas eficientes con ListView y sus variantes
- ✅ Crear grids dinámicos con GridView
- ✅ Usar Stack para superponer widgets
- ✅ Aplicar Expanded y Flexible para distribución de espacio
- ✅ Elegir el layout correcto para cada situación

---

## 📋 Índice

1. [Conceptos Fundamentales de Layout](#1-conceptos-fundamentales-de-layout)
2. [Column y Row](#2-column-y-row)
3. [Expanded y Flexible](#3-expanded-y-flexible)
4. [Stack y Positioned](#4-stack-y-positioned)
5. [ListView](#5-listview)
6. [GridView](#6-gridview)
7. [Otros Layouts](#7-otros-layouts)
8. [Patrones Comunes](#8-patrones-comunes)
9. [Ejercicios de Reflexión](#9-ejercicios-de-reflexión)

---

## 1. Conceptos Fundamentales de Layout

### El Sistema de Constraints

Flutter usa un sistema de **constraints** (restricciones) para determinar el tamaño de los widgets:

```
┌──────────────────────────────────────────────────────────┐
│                      PADRE                               │
│   "Hijo, puedes tener entre 0-400px de ancho           │
│    y entre 0-800px de alto"                             │
│                                                          │
│   ┌──────────────────────────────────────────┐          │
│   │              HIJO                         │          │
│   │   "Ok padre, necesito 200x100px"         │          │
│   │                                          │          │
│   └──────────────────────────────────────────┘          │
│                                                          │
│   Padre posiciona al hijo según las reglas              │
└──────────────────────────────────────────────────────────┘
```

**Regla de oro**: Los constraints bajan, los tamaños suben, el padre posiciona.

### Bounded vs Unbounded Constraints

```dart
/**
 * Bounded: El widget tiene un tamaño máximo definido
 * Unbounded: El widget puede crecer infinitamente
 *
 * ⚠️ ERRORES COMUNES:
 * - Column dentro de Column sin bounded height
 * - ListView dentro de Column sin Expanded
 */

// ✅ Correcto: Column con altura definida
SizedBox(
  height: 400,
  child: Column(
    children: [
      Text('Item 1'),
      Text('Item 2'),
    ],
  ),
)

// ❌ Error: ListView en Column sin límite
Column(
  children: [
    ListView(...)  // ERROR: Unbounded height
  ],
)

// ✅ Correcto: ListView en Column con Expanded
Column(
  children: [
    Text('Header'),
    Expanded(
      child: ListView(...),  // OK: Bounded por Expanded
    ),
  ],
)
```

---

## 2. Column y Row

### Column: Layout Vertical

Organiza hijos en una columna vertical.

```dart
/**
 * Column - Layout vertical
 *
 * Main Axis: Vertical (↓)
 * Cross Axis: Horizontal (→)
 */

Column(
  // Alineación en el eje principal (vertical)
  mainAxisAlignment: MainAxisAlignment.start,

  // Alineación en el eje cruzado (horizontal)
  crossAxisAlignment: CrossAxisAlignment.center,

  // Tamaño del eje principal
  mainAxisSize: MainAxisSize.max,  // Ocupa todo el espacio disponible
  // mainAxisSize: MainAxisSize.min,  // Solo lo necesario

  // Dirección del texto (afecta el orden)
  textDirection: TextDirection.ltr,

  // Dirección vertical
  verticalDirection: VerticalDirection.down,

  children: [
    Container(height: 50, color: Colors.red),
    Container(height: 50, color: Colors.green),
    Container(height: 50, color: Colors.blue),
  ],
)
```

### Row: Layout Horizontal

Organiza hijos en una fila horizontal.

```dart
/**
 * Row - Layout horizontal
 *
 * Main Axis: Horizontal (→)
 * Cross Axis: Vertical (↓)
 */

Row(
  // Alineación en el eje principal (horizontal)
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

  // Alineación en el eje cruzado (vertical)
  crossAxisAlignment: CrossAxisAlignment.center,

  // Tamaño del eje principal
  mainAxisSize: MainAxisSize.max,

  children: [
    Container(width: 50, height: 50, color: Colors.red),
    Container(width: 50, height: 50, color: Colors.green),
    Container(width: 50, height: 50, color: Colors.blue),
  ],
)
```

### MainAxisAlignment

```
┌────────────────────────────────────────────────────────────┐
│ MainAxisAlignment.start                                    │
│ [▓▓▓] [▓▓▓] [▓▓▓]                                         │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│ MainAxisAlignment.end                                      │
│                                         [▓▓▓] [▓▓▓] [▓▓▓] │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│ MainAxisAlignment.center                                   │
│              [▓▓▓] [▓▓▓] [▓▓▓]                            │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│ MainAxisAlignment.spaceBetween                             │
│ [▓▓▓]              [▓▓▓]              [▓▓▓]               │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│ MainAxisAlignment.spaceAround                              │
│   [▓▓▓]        [▓▓▓]        [▓▓▓]                         │
│ ←─→    ←────→      ←────→      ←─→                        │
│ 1x       2x          2x        1x                          │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│ MainAxisAlignment.spaceEvenly                              │
│    [▓▓▓]       [▓▓▓]       [▓▓▓]                          │
│ ←──→   ←────→      ←────→      ←──→                       │
│ 1x        1x          1x         1x                        │
└────────────────────────────────────────────────────────────┘
```

### CrossAxisAlignment

```
Column con diferentes CrossAxisAlignment:

┌──────────────────────┐  ┌──────────────────────┐  ┌──────────────────────┐
│ .start               │  │ .center              │  │ .end                 │
│ ▓▓▓                  │  │       ▓▓▓            │  │                ▓▓▓   │
│ ▓▓▓▓▓▓               │  │     ▓▓▓▓▓▓           │  │            ▓▓▓▓▓▓   │
│ ▓▓                   │  │        ▓▓            │  │                  ▓▓ │
└──────────────────────┘  └──────────────────────┘  └──────────────────────┘

┌──────────────────────┐
│ .stretch             │
│ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│  ← Todos ocupan el ancho completo
│ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│
│ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│
└──────────────────────┘
```

### Ejemplo Práctico: AppBar Personalizada

```dart
/**
 * Custom AppBar usando Row
 *
 * Demuestra uso de MainAxisAlignment y CrossAxisAlignment
 */

Container(
  height: 60,
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Izquierda: Botón menú
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),

      // Centro: Título
      Text(
        'Mi App',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Derecha: Acciones
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
    ],
  ),
)
```

---

## 3. Expanded y Flexible

### Expanded

Expande un hijo para ocupar todo el espacio disponible.

```dart
/**
 * Expanded - Ocupar espacio disponible
 *
 * Solo funciona dentro de Column, Row, o Flex
 * flex: determina la proporción de espacio (default: 1)
 */

// Ejemplo: Tres contenedores con diferentes proporciones
Row(
  children: [
    Expanded(
      flex: 2,  // 2/4 = 50% del espacio
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,  // 1/4 = 25% del espacio
      child: Container(color: Colors.green),
    ),
    Expanded(
      flex: 1,  // 1/4 = 25% del espacio
      child: Container(color: Colors.blue),
    ),
  ],
)

// Visualización:
// ┌──────────────────┬─────────┬─────────┐
// │      Rojo        │  Verde  │  Azul   │
// │     flex: 2      │ flex: 1 │ flex: 1 │
// │      (50%)       │  (25%)  │  (25%)  │
// └──────────────────┴─────────┴─────────┘
```

### Flexible

Similar a Expanded pero el hijo puede ser más pequeño que el espacio asignado.

```dart
/**
 * Flexible vs Expanded
 *
 * Expanded: hijo DEBE ocupar todo el espacio asignado
 * Flexible: hijo PUEDE ocupar hasta el espacio asignado
 */

// Con Expanded: el Container OCUPA todo
Row(
  children: [
    Expanded(
      child: Container(
        width: 50,  // ⚠️ Ignorado! Ocupa todo el espacio
        color: Colors.red,
      ),
    ),
  ],
)

// Con Flexible: el Container puede ser más pequeño
Row(
  children: [
    Flexible(
      child: Container(
        width: 50,  // ✅ Respetado si hay espacio
        color: Colors.red,
      ),
    ),
  ],
)

// Flexible con fit
Flexible(
  fit: FlexFit.loose,  // Default: puede ser más pequeño
  // fit: FlexFit.tight,  // Equivalente a Expanded
  child: Container(...),
)
```

### Spacer

Widget conveniente para crear espacio vacío expandible.

```dart
/**
 * Spacer - Espacio expandible
 *
 * Equivalente a Expanded(child: SizedBox.shrink())
 * Útil para empujar widgets a los extremos
 */

Row(
  children: [
    Text('Izquierda'),
    Spacer(),          // Empuja lo siguiente a la derecha
    Text('Derecha'),
  ],
)

// Con flex
Row(
  children: [
    Text('A'),
    Spacer(flex: 1),   // 1 parte
    Text('B'),
    Spacer(flex: 2),   // 2 partes (doble espacio)
    Text('C'),
  ],
)
```

### Patrón Común: Header con Búsqueda

```dart
/**
 * Ejemplo: Barra de búsqueda que se expande
 */

Row(
  children: [
    // Ícono fijo
    Icon(Icons.search),
    SizedBox(width: 8),

    // Campo de texto expandido
    Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar...',
          border: InputBorder.none,
        ),
      ),
    ),

    // Botón fijo
    IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {},
    ),
  ],
)
```

---

## 4. Stack y Positioned

### Stack

Apila widgets uno sobre otro.

```dart
/**
 * Stack - Apilar widgets
 *
 * Los hijos se dibujan en orden: primero el índice 0 (fondo)
 * alignment: alineación de hijos no posicionados
 * fit: cómo dimensionar hijos no posicionados
 */

Stack(
  // Alineación de hijos sin Positioned
  alignment: Alignment.center,

  // Cómo dimensionar el Stack
  fit: StackFit.loose,       // Tamaño del hijo más grande
  // fit: StackFit.expand,   // Expandir al padre
  // fit: StackFit.passthrough, // Pasar constraints del padre

  // Comportamiento del clipeo
  clipBehavior: Clip.hardEdge,

  children: [
    // Fondo (primer hijo)
    Container(
      width: 300,
      height: 200,
      color: Colors.blue,
    ),

    // Capa media
    Container(
      width: 200,
      height: 150,
      color: Colors.green,
    ),

    // Frente (último hijo)
    Container(
      width: 100,
      height: 100,
      color: Colors.red,
    ),
  ],
)
```

### Positioned

Posiciona un hijo dentro del Stack con coordenadas específicas.

```dart
/**
 * Positioned - Posicionamiento absoluto
 *
 * Usa top, right, bottom, left para posicionar
 * Usa width, height para dimensionar
 */

Stack(
  children: [
    // Fondo
    Container(color: Colors.grey.shade200),

    // Esquina superior izquierda
    Positioned(
      top: 10,
      left: 10,
      child: Icon(Icons.star, color: Colors.yellow),
    ),

    // Esquina superior derecha
    Positioned(
      top: 10,
      right: 10,
      child: Icon(Icons.close, color: Colors.red),
    ),

    // Centrado horizontalmente, abajo
    Positioned(
      bottom: 20,
      left: 0,
      right: 0,  // left + right = centrado horizontal
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Acción'),
        ),
      ),
    ),

    // Llenando un área específica
    Positioned(
      top: 50,
      left: 20,
      width: 150,
      height: 100,
      child: Container(
        color: Colors.blue.withOpacity(0.5),
        child: Center(child: Text('Área fija')),
      ),
    ),
  ],
)
```

### Positioned.fill

Llena todo el Stack.

```dart
/**
 * Positioned.fill - Llenar todo el espacio
 *
 * Equivalente a Positioned(top: 0, right: 0, bottom: 0, left: 0)
 */

Stack(
  children: [
    // Imagen de fondo que llena todo
    Positioned.fill(
      child: Image.network(
        'https://example.com/background.jpg',
        fit: BoxFit.cover,
      ),
    ),

    // Overlay oscuro
    Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.4),
      ),
    ),

    // Contenido centrado
    Center(
      child: Text(
        'Título',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
)
```

### Ejemplo Práctico: Card con Badge

```dart
/**
 * Tarjeta de producto con badge de descuento
 */

Stack(
  children: [
    // Card base
    Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://example.com/product.jpg',
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Producto', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$29.99'),
              ],
            ),
          ),
        ],
      ),
    ),

    // Badge de descuento
    Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '-20%',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    ),

    // Botón favorito
    Positioned(
      top: 8,
      right: 8,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.white,
        child: Icon(Icons.favorite_border, size: 18, color: Colors.grey),
      ),
    ),
  ],
)
```

---

## 5. ListView

### ListView Básico

Lista de widgets con scroll.

```dart
/**
 * ListView - Lista con scroll
 *
 * Renderiza TODOS los hijos inmediatamente
 * ⚠️ Solo para listas cortas (< 20 items)
 */

ListView(
  // Padding de la lista
  padding: EdgeInsets.all(16),

  // Dirección del scroll
  scrollDirection: Axis.vertical,
  // scrollDirection: Axis.horizontal,

  // Invertir orden
  reverse: false,

  // Física del scroll
  physics: BouncingScrollPhysics(),      // iOS style
  // physics: ClampingScrollPhysics(),   // Android style
  // physics: NeverScrollableScrollPhysics(), // Sin scroll

  // Reducir espacio si hay pocos items
  shrinkWrap: false,  // true cuando está dentro de otro scrollable

  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
    // ... más items
  ],
)
```

### ListView.builder

Lista optimizada para muchos elementos.

```dart
/**
 * ListView.builder - Lista optimizada
 *
 * Solo renderiza los items visibles (lazy loading)
 * ✅ Recomendado para listas largas
 */

final List<String> items = List.generate(100, (i) => 'Item $i');

ListView.builder(
  // Número de items (null = infinito)
  itemCount: items.length,

  // Constructor de cada item
  itemBuilder: (context, index) {
    return ListTile(
      leading: CircleAvatar(child: Text('${index + 1}')),
      title: Text(items[index]),
      subtitle: Text('Descripción del item $index'),
      trailing: Icon(Icons.chevron_right),
      onTap: () => print('Tap en $index'),
    );
  },

  // Altura estimada de cada item (mejora performance)
  itemExtent: 72.0,  // Si todos los items tienen la misma altura
  // prototypeItem: ListTile(...),  // O usar un prototipo
)
```

### ListView.separated

Lista con separadores personalizados.

```dart
/**
 * ListView.separated - Lista con separadores
 *
 * Permite personalizar el widget entre items
 */

ListView.separated(
  itemCount: 20,

  // Constructor de items
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },

  // Constructor de separadores
  separatorBuilder: (context, index) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade300,
      indent: 16,      // Margen izquierdo
      endIndent: 16,   // Margen derecho
    );
  },
)

// Separadores personalizados
ListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
  separatorBuilder: (context, index) {
    // Separador especial cada 5 items
    if ((index + 1) % 5 == 0) {
      return Container(
        height: 40,
        color: Colors.blue.shade50,
        child: Center(child: Text('Sección ${(index + 1) ~/ 5}')),
      );
    }
    return SizedBox(height: 8);
  },
)
```

### ListView dentro de Column

```dart
/**
 * ListView en Column - Errores comunes y soluciones
 */

// ❌ ERROR: Unbounded height
Column(
  children: [
    Text('Header'),
    ListView.builder(...),  // ERROR!
  ],
)

// ✅ Solución 1: Expanded
Column(
  children: [
    Text('Header'),
    Expanded(
      child: ListView.builder(...),
    ),
  ],
)

// ✅ Solución 2: SizedBox con altura fija
Column(
  children: [
    Text('Header'),
    SizedBox(
      height: 300,
      child: ListView.builder(...),
    ),
  ],
)

// ✅ Solución 3: shrinkWrap (solo para listas cortas)
Column(
  children: [
    Text('Header'),
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
    ),
  ],
)
```

---

## 6. GridView

### GridView.count

Grid con número fijo de columnas.

```dart
/**
 * GridView.count - Columnas fijas
 *
 * crossAxisCount: número de columnas
 */

GridView.count(
  // Número de columnas
  crossAxisCount: 2,

  // Espaciado
  mainAxisSpacing: 10,    // Espacio vertical entre filas
  crossAxisSpacing: 10,   // Espacio horizontal entre columnas

  // Proporción de cada celda (ancho / alto)
  childAspectRatio: 1.0,  // 1.0 = cuadrado

  // Padding
  padding: EdgeInsets.all(16),

  children: [
    Container(color: Colors.red),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
    Container(color: Colors.purple),
    Container(color: Colors.orange),
  ],
)
```

### GridView.builder

Grid optimizado para muchos elementos.

```dart
/**
 * GridView.builder - Grid optimizado
 *
 * Usa SliverGridDelegate para configurar el grid
 */

GridView.builder(
  padding: EdgeInsets.all(16),

  // Configuración del grid
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,          // 3 columnas
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 0.75,     // Más alto que ancho
  ),

  itemCount: 50,

  itemBuilder: (context, index) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.primaries[index % Colors.primaries.length],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('Item $index'),
          ),
        ],
      ),
    );
  },
)
```

### GridView.extent

Grid con tamaño máximo de celda.

```dart
/**
 * GridView.extent - Tamaño máximo por celda
 *
 * Flutter calcula cuántas columnas caben
 * Útil para diseño responsivo
 */

GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,  // Máximo 200px de ancho por celda
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1.0,
  ),
  itemCount: 20,
  itemBuilder: (context, index) => Container(
    color: Colors.blue.shade100,
    child: Center(child: Text('$index')),
  ),
)

// Alternativa con GridView.extent (sin builder)
GridView.extent(
  maxCrossAxisExtent: 150,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  children: List.generate(
    12,
    (index) => Container(color: Colors.teal.shade100),
  ),
)
```

### Ejemplo: Galería de Fotos

```dart
/**
 * Galería de fotos con GridView.builder
 */

class PhotoGallery extends StatelessWidget {
  final List<String> imageUrls;

  const PhotoGallery({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _openFullScreen(context, index),
          child: Hero(
            tag: 'photo_$index',
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _openFullScreen(BuildContext context, int index) {
    // Navegar a vista de pantalla completa
  }
}
```

---

## 7. Otros Layouts

### Wrap

Contenedor que hace wrap cuando no hay espacio.

```dart
/**
 * Wrap - Flow layout con wrap automático
 *
 * Ideal para tags, chips, botones de filtro
 */

Wrap(
  // Espaciado
  spacing: 8,         // Espacio horizontal entre hijos
  runSpacing: 8,      // Espacio vertical entre líneas

  // Alineación
  alignment: WrapAlignment.start,
  runAlignment: WrapAlignment.start,
  crossAxisAlignment: WrapCrossAlignment.start,

  // Dirección
  direction: Axis.horizontal,

  children: [
    Chip(label: Text('Flutter')),
    Chip(label: Text('Dart')),
    Chip(label: Text('Mobile')),
    Chip(label: Text('iOS')),
    Chip(label: Text('Android')),
    Chip(label: Text('Cross-platform')),
    Chip(label: Text('UI')),
    Chip(label: Text('Widgets')),
  ],
)

// Ejemplo: Filtros seleccionables
Wrap(
  spacing: 8,
  runSpacing: 4,
  children: filters.map((filter) {
    return FilterChip(
      label: Text(filter.name),
      selected: filter.isSelected,
      onSelected: (selected) => onFilterToggle(filter),
    );
  }).toList(),
)
```

### SingleChildScrollView

Hace scrollable un widget único.

```dart
/**
 * SingleChildScrollView - Scroll para un solo hijo
 *
 * Útil para formularios largos o contenido que puede exceder la pantalla
 */

SingleChildScrollView(
  // Padding
  padding: EdgeInsets.all(16),

  // Dirección
  scrollDirection: Axis.vertical,

  // Física
  physics: BouncingScrollPhysics(),

  // Controlador (para scroll programático)
  controller: _scrollController,

  child: Column(
    children: [
      // Contenido largo...
      TextField(decoration: InputDecoration(labelText: 'Nombre')),
      SizedBox(height: 16),
      TextField(decoration: InputDecoration(labelText: 'Email')),
      SizedBox(height: 16),
      TextField(
        decoration: InputDecoration(labelText: 'Descripción'),
        maxLines: 5,
      ),
      SizedBox(height: 24),
      ElevatedButton(
        onPressed: () {},
        child: Text('Enviar'),
      ),
    ],
  ),
)
```

### PageView

Páginas deslizables horizontalmente.

```dart
/**
 * PageView - Carrusel de páginas
 *
 * Ideal para onboarding, galerías, wizards
 */

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'Bienvenido',
      description: 'Descubre nuestra app',
      image: 'assets/onboarding1.png',
    ),
    OnboardingPage(
      title: 'Explora',
      description: 'Miles de productos',
      image: 'assets/onboarding2.png',
    ),
    OnboardingPage(
      title: 'Compra',
      description: 'Fácil y seguro',
      image: 'assets/onboarding3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // PageView
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final page = pages[index];
                return Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(page.image, height: 250),
                      SizedBox(height: 32),
                      Text(
                        page.title,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        page.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Indicadores de página
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(pages.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.blue
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),

          SizedBox(height: 32),

          // Botón
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < pages.length - 1) {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Navegar a Home
                  }
                },
                child: Text(_currentPage < pages.length - 1 ? 'Siguiente' : 'Empezar'),
              ),
            ),
          ),

          SizedBox(height: 40),
        ],
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

### Table

Tabla con filas y columnas definidas.

```dart
/**
 * Table - Tabla estructurada
 *
 * Útil para datos tabulares con estructura fija
 */

Table(
  // Ancho de columnas
  columnWidths: {
    0: FlexColumnWidth(2),    // 2 partes
    1: FlexColumnWidth(1),    // 1 parte
    2: FixedColumnWidth(100), // 100px fijo
  },

  // Borde
  border: TableBorder.all(
    color: Colors.grey.shade300,
    width: 1,
  ),

  // Alineación vertical por defecto
  defaultVerticalAlignment: TableCellVerticalAlignment.middle,

  children: [
    // Header
    TableRow(
      decoration: BoxDecoration(color: Colors.blue.shade50),
      children: [
        _buildCell('Producto', isHeader: true),
        _buildCell('Cantidad', isHeader: true),
        _buildCell('Precio', isHeader: true),
      ],
    ),
    // Datos
    TableRow(
      children: [
        _buildCell('Laptop'),
        _buildCell('2'),
        _buildCell('\$1,200'),
      ],
    ),
    TableRow(
      children: [
        _buildCell('Mouse'),
        _buildCell('5'),
        _buildCell('\$25'),
      ],
    ),
  ],
)

Widget _buildCell(String text, {bool isHeader = false}) {
  return Padding(
    padding: EdgeInsets.all(12),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}
```

---

## 8. Patrones Comunes

### Patrón: Lista con Header Fijo

```dart
/**
 * Lista con header que no hace scroll
 */

Column(
  children: [
    // Header fijo
    Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Mis Items', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          TextButton(onPressed: () {}, child: Text('Ver todos')),
        ],
      ),
    ),

    // Lista scrolleable
    Expanded(
      child: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
      ),
    ),
  ],
)
```

### Patrón: Grid Responsivo

```dart
/**
 * Grid que ajusta columnas según el ancho
 */

LayoutBuilder(
  builder: (context, constraints) {
    // Calcular columnas según ancho
    int crossAxisCount;
    if (constraints.maxWidth > 1200) {
      crossAxisCount = 6;
    } else if (constraints.maxWidth > 800) {
      crossAxisCount = 4;
    } else if (constraints.maxWidth > 600) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 20,
      itemBuilder: (context, index) => Card(
        child: Center(child: Text('$index')),
      ),
    );
  },
)
```

### Patrón: Formulario Scrolleable

```dart
/**
 * Formulario largo con scroll y botón fijo
 */

Scaffold(
  body: Column(
    children: [
      // Formulario scrolleable
      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(decoration: InputDecoration(labelText: 'Campo 1')),
              SizedBox(height: 16),
              TextField(decoration: InputDecoration(labelText: 'Campo 2')),
              SizedBox(height: 16),
              TextField(decoration: InputDecoration(labelText: 'Campo 3')),
              // ... más campos
            ],
          ),
        ),
      ),

      // Botón fijo en la parte inferior
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Guardar'),
          ),
        ),
      ),
    ],
  ),
)
```

---

## 9. Ejercicios de Reflexión

### 🤔 Preguntas de Comprensión

1. **¿Cuándo usar ListView.builder vs ListView?**

   - Piensa en el rendimiento con muchos items

2. **¿Por qué Expanded solo funciona dentro de Column/Row/Flex?**

   - Reflexiona sobre el sistema de constraints

3. **¿Cuál es la diferencia entre Stack y Column/Row?**

   - Considera el posicionamiento y superposición

4. **¿Cómo decidir entre GridView.count y GridView.extent?**
   - Piensa en diseño fijo vs responsivo

### ✍️ Mini-ejercicio Mental

Diseña la estructura de widgets para:

- Una pantalla de e-commerce con:
  - AppBar con búsqueda
  - Carrusel de ofertas
  - Grid de categorías
  - Lista de productos destacados
- ¿Qué layouts usarías en cada sección?

---

## 🔗 Recursos Relacionados

- **Módulo anterior**: [01-widgets-fundamentales.md](./01-widgets-fundamentales.md)
- **Siguiente módulo**: [03-diseno-responsivo.md](./03-diseno-responsivo.md)
- **Práctica relacionada**: [practica-02-layouts-complejos.md](../2-practicas/practica-02-layouts-complejos.md)

---

**Navegación**:
← [Widgets Fundamentales](./01-widgets-fundamentales.md) | [Volver al README](../README.md) | [Siguiente: Diseño Responsivo →](./03-diseno-responsivo.md)
