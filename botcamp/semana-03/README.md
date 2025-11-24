# Semana 3: Widgets y Layouts en Flutter

## 🎯 Objetivos de Aprendizaje

- Dominar los widgets básicos y avanzados de Flutter
- Implementar layouts complejos
- Crear interfaces responsivas
- Estilizar componentes de manera efectiva
- Manejar imágenes y assets

## 📚 Contenido Teórico

### 1. Widgets Fundamentales (2.5 horas)

#### Widgets de Estructura

- `Container`: Caja con decoración, padding, margin
- `Column` y `Row`: Layouts verticales y horizontales
- `Stack`: Apilar widgets
- `Expanded` y `Flexible`: Distribución de espacio
- `SizedBox`: Espaciado y dimensiones fijas
- `Padding`: Espaciado interno

#### Widgets de Texto

- `Text`: Mostrar texto
- `RichText`: Texto con múltiples estilos
- `TextStyle`: Estilos de fuente
- `TextField`: Entrada de texto

#### Widgets de Imagen

- `Image.asset`: Imágenes locales
- `Image.network`: Imágenes de internet
- `CircleAvatar`: Avatar circular
- `Icon`: Iconos Material/Cupertino

#### Widgets Interactivos

- `Button`: ElevatedButton, TextButton, OutlinedButton
- `IconButton`: Botón con icono
- `FloatingActionButton`: FAB
- `GestureDetector`: Detectar gestos
- `InkWell`: Efecto ripple

### 2. Sistema de Layouts (2.5 horas)

#### MainAxisAlignment y CrossAxisAlignment

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [...],
)
```

#### ListView

- `ListView`: Lista básica
- `ListView.builder`: Lista dinámica
- `ListView.separated`: Lista con separadores

#### GridView

- `GridView.count`: Grid con columnas fijas
- `GridView.builder`: Grid dinámico
- `GridView.extent`: Grid con tamaño máximo

#### Otros Layouts

- `Wrap`: Contenedor flexible
- `Table`: Tablas
- `SingleChildScrollView`: Scroll simple
- `PageView`: Páginas deslizables

### 3. Diseño Responsivo (1.5 horas)

#### MediaQuery

```dart
final size = MediaQuery.of(context).size;
final width = size.width;
final height = size.height;
```

#### LayoutBuilder

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return DesktopLayout();
    }
    return MobileLayout();
  },
)
```

#### OrientationBuilder

- Detectar orientación
- Adaptar layout según orientación

### 4. Estilos y Temas (1.5 horas)

#### BoxDecoration

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [...],
    gradient: LinearGradient(...),
  ),
)
```

#### ThemeData

- Colores primarios y secundarios
- Estilos de texto
- Temas claros y oscuros

#### Assets

- Configurar `pubspec.yaml`
- Cargar imágenes
- Cargar fuentes personalizadas

## 💻 Ejercicios Prácticos

### Ejercicio 1: Galería de Widgets

Crea una app que muestre diferentes tipos de widgets:

- Pantalla con tabs para cada categoría
- Ejemplos de cada widget
- Descripción y código de ejemplo

### Ejercicio 2: Layout Complex

Replica diseños complejos:

- Card con imagen, título, descripción y botones
- Perfil de usuario con estadísticas
- Timeline vertical

### Ejercicio 3: ListView Dinámico

Implementa una lista de contactos:

- Lista con avatar, nombre y teléfono
- Acción de deslizar para eliminar
- Búsqueda en tiempo real
- Pull to refresh

### Ejercicio 4: GridView de Productos

Crea un catálogo de productos:

- Grid de productos con imagen y precio
- Vista de detalles al hacer tap
- Filtros por categoría

### Ejercicio 5: Diseño Responsivo

Desarrolla una interfaz adaptativa:

- Vista de lista en móvil
- Vista de grid en tablet
- Sidebar en desktop

## 🔨 Proyecto de la Semana

**App de Catálogo de Restaurante**

Desarrolla una aplicación para mostrar el menú de un restaurante:

**Características:**

1. **Pantalla Principal (Home)**

   - AppBar con logo del restaurante
   - Categorías en scroll horizontal
   - Featured items destacados
   - Lista de platos populares

2. **Diseño de Cards para Platos**

   - Imagen del plato
   - Nombre y descripción
   - Precio
   - Rating con estrellas
   - Botón "Agregar"

3. **Pantalla de Categorías**

   - GridView de categorías
   - Icono y nombre
   - Número de platos

4. **Pantalla de Detalles**

   - Imagen grande del plato
   - Información completa
   - Ingredientes
   - Botones de acción

5. **Diseño Responsivo**
   - Adaptable a diferentes tamaños
   - Orientación vertical y horizontal

**Requisitos técnicos:**

- Usar `ListView.builder` y `GridView.builder`
- Implementar `MediaQuery` para responsividad
- Crear modelo de datos para Plato
- Estilos personalizados y consistentes
- Assets de imágenes configurados
- Mínimo 15 platos en 4 categorías

**Estructura de datos:**

```dart
class Plato {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagen;
  final String categoria;
  final double rating;
  final List<String> ingredientes;
}
```

## 📖 Recursos

### Documentación

- [Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Layout Widgets](https://flutter.dev/docs/development/ui/layout)
- [Material Design](https://material.io/design)

### Videos

- [Flutter Layouts Tutorial](https://www.youtube.com/watch?v=RJEnTRBxaSg)
- [Responsive Design in Flutter](https://www.youtube.com/watch?v=z7P1OFLw4kY)

### Herramientas

- [Flutter Widget Livebook](https://flutter-widget.live/)
- [FlutLab](https://flutlab.io/)
- [Figma to Flutter](https://www.figma.com/community/plugin/842896368936659224/Figma-to-Flutter)

## ✅ Checklist de Completitud

- [ ] Ejercicio 1: Galería de widgets completado
- [ ] Ejercicio 2: Layout complejo completado
- [ ] Ejercicio 3: ListView dinámico completado
- [ ] Ejercicio 4: GridView de productos completado
- [ ] Ejercicio 5: Diseño responsivo completado
- [ ] Proyecto: App de restaurante completado
- [ ] Assets configurados correctamente
- [ ] App probada en diferentes tamaños de pantalla
- [ ] Código subido al repositorio

## 🎓 Evaluación

- **Ejercicios prácticos (1-5):** 40%
- **Proyecto de la semana:** 50%
- **Diseño y UI/UX:** 10%

## 📝 Notas Importantes

- Explorar el Widget Inspector para entender la jerarquía
- Usar `const` constructors para optimizar performance
- Experimentar con diferentes combinaciones de widgets
- Mantener la jerarquía de widgets lo más plana posible
- Seguir Material Design guidelines

## 🎨 Tips de Diseño

- Usa espaciado consistente (múltiplos de 8)
- Limita la paleta de colores (3-5 colores)
- Jerarquía visual clara con tamaños de fuente
- Contraste adecuado para legibilidad
- Feedback visual en interacciones

## 🔧 Widgets Útiles

```dart
// Espaciado
SizedBox(height: 16)

// Card con sombra
Card(
  elevation: 4,
  child: ...,
)

// Divider
Divider(thickness: 1)

// SafeArea
SafeArea(child: ...)

// ClipRRect para esquinas redondeadas
ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: Image...
)
```

---

**Dedicación:** 8 horas | **Anterior:** [← Semana 2](../semana-02/README.md) | **Siguiente:** [Semana 4 →](../semana-04/README.md)
