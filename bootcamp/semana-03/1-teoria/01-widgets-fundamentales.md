# 📘 Módulo 01: Widgets Fundamentales en Flutter

> **Duración estimada**: 2.5 horas  
> **Nivel**: 🟢 Básico-Intermedio  
> **Prerrequisitos**: Semana 02 (StatelessWidget, StatefulWidget, Material Design)

---

## 🎯 Objetivos del Módulo

Al finalizar este módulo serás capaz de:

- ✅ Identificar y utilizar widgets de estructura (Container, Column, Row, Stack)
- ✅ Implementar widgets de texto con estilos personalizados
- ✅ Manejar imágenes locales y de red con diferentes configuraciones
- ✅ Crear interfaces interactivas con botones y gestos
- ✅ Combinar widgets básicos para construir UIs complejas

---

## 📋 Índice

1. [Introducción a Widgets](#1-introducción-a-widgets)
2. [Widgets de Estructura](#2-widgets-de-estructura)
3. [Widgets de Texto](#3-widgets-de-texto)
4. [Widgets de Imagen](#4-widgets-de-imagen)
5. [Widgets Interactivos](#5-widgets-interactivos)
6. [Composición de Widgets](#6-composición-de-widgets)
7. [Ejercicios de Reflexión](#7-ejercicios-de-reflexión)

---

## 1. Introducción a Widgets

### ¿Qué es un Widget?

En Flutter, **todo es un widget**. Los widgets son los bloques fundamentales de construcción de la interfaz de usuario. Cada elemento visual que ves en pantalla es un widget o está compuesto por widgets.

```
┌─────────────────────────────────────────────────────┐
│                    MaterialApp                       │
│  ┌───────────────────────────────────────────────┐  │
│  │                   Scaffold                     │  │
│  │  ┌─────────────────────────────────────────┐  │  │
│  │  │               AppBar                     │  │  │
│  │  │  ┌─────────┐  ┌─────────────────────┐   │  │  │
│  │  │  │  Icon   │  │       Text          │   │  │  │
│  │  │  └─────────┘  └─────────────────────┘   │  │  │
│  │  └─────────────────────────────────────────┘  │  │
│  │  ┌─────────────────────────────────────────┐  │  │
│  │  │                body                      │  │  │
│  │  │     ┌─────────────────────────┐         │  │  │
│  │  │     │    Column / ListView    │         │  │  │
│  │  │     │  ┌────┐ ┌────┐ ┌────┐   │         │  │  │
│  │  │     │  │Card│ │Card│ │Card│   │         │  │  │
│  │  │     │  └────┘ └────┘ └────┘   │         │  │  │
│  │  │     └─────────────────────────┘         │  │  │
│  │  └─────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
```

### Tipos de Widgets

| Tipo              | Descripción                             | Ejemplos                           |
| ----------------- | --------------------------------------- | ---------------------------------- |
| **Estructurales** | Definen la disposición de otros widgets | Container, Column, Row, Stack      |
| **Presentación**  | Muestran contenido al usuario           | Text, Image, Icon                  |
| **Interactivos**  | Responden a acciones del usuario        | Button, TextField, GestureDetector |
| **Estilización**  | Aplican estilos y decoraciones          | Padding, DecoratedBox, Theme       |

### Principio de Composición

Flutter sigue el principio de **composición sobre herencia**. En lugar de crear widgets complejos mediante herencia, construyes UIs combinando widgets simples:

```dart
/**
 * Ejemplo de composición de widgets
 *
 * ¿Qué hace? Construye una tarjeta de producto
 * ¿Para qué? Demostrar cómo widgets simples se combinan
 * ¿Cómo? Anidando Container → Column → [Image, Text, Text]
 */
Widget productCard() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)],
    ),
    child: Column(
      children: [
        Image.network('https://example.com/product.jpg'),
        Text('Nombre del Producto'),
        Text('\$29.99'),
      ],
    ),
  );
}
```

---

## 2. Widgets de Estructura

### 2.1 Container

El widget más versátil de Flutter. Es una "caja" que puede contener un hijo y aplicar múltiples transformaciones.

```dart
/**
 * Container - Widget de caja versátil
 *
 * Propiedades principales:
 * - width/height: Dimensiones
 * - padding: Espacio interno
 * - margin: Espacio externo
 * - decoration: Estilos visuales (color, borde, sombra, gradiente)
 * - alignment: Alineación del hijo
 * - constraints: Restricciones de tamaño
 */
Container(
  // Dimensiones
  width: 200,
  height: 150,

  // Espaciado
  padding: EdgeInsets.all(16),        // Espacio interno
  margin: EdgeInsets.symmetric(       // Espacio externo
    horizontal: 20,
    vertical: 10,
  ),

  // Alineación del contenido
  alignment: Alignment.center,

  // Decoración (color, bordes, sombras, gradientes)
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.blueAccent, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    // Alternativa: gradiente en lugar de color sólido
    // gradient: LinearGradient(
    //   colors: [Colors.blue, Colors.purple],
    //   begin: Alignment.topLeft,
    //   end: Alignment.bottomRight,
    // ),
  ),

  // Widget hijo
  child: Text('Contenido'),
)
```

#### EdgeInsets: Control de Espaciado

```dart
/**
 * EdgeInsets - Diferentes formas de definir espaciado
 */

// Todos los lados iguales
EdgeInsets.all(16)

// Solo algunos lados
EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5)

// Simétrico (horizontal y vertical)
EdgeInsets.symmetric(horizontal: 20, vertical: 10)

// Desde valores LTRB (Left, Top, Right, Bottom)
EdgeInsets.fromLTRB(10, 20, 10, 20)

// Sin espaciado
EdgeInsets.zero
```

#### BoxDecoration: Estilos Avanzados

```dart
/**
 * BoxDecoration - Decoración de Container
 *
 * ⚠️ Nota: No puedes usar 'color' en Container si usas 'decoration'
 * El color debe ir dentro de BoxDecoration
 */
BoxDecoration(
  // Color sólido
  color: Colors.white,

  // O gradiente (no usar ambos)
  gradient: LinearGradient(
    colors: [Colors.blue.shade300, Colors.blue.shade700],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),

  // Bordes redondeados
  borderRadius: BorderRadius.circular(16),
  // O específico por esquina
  // borderRadius: BorderRadius.only(
  //   topLeft: Radius.circular(20),
  //   topRight: Radius.circular(20),
  // ),

  // Borde
  border: Border.all(
    color: Colors.grey.shade300,
    width: 1,
  ),

  // Sombras (puede tener múltiples)
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      spreadRadius: 2,
      offset: Offset(0, 2),
    ),
  ],

  // Imagen de fondo
  image: DecorationImage(
    image: AssetImage('assets/background.png'),
    fit: BoxFit.cover,
  ),
)
```

---

### 2.2 SizedBox

Widget simple para definir dimensiones fijas o crear espacio entre widgets.

```dart
/**
 * SizedBox - Caja con dimensiones fijas
 *
 * Usos principales:
 * 1. Crear espacio entre widgets
 * 2. Forzar dimensiones específicas
 * 3. Expandir para llenar espacio disponible
 */

// 1. Espacio vertical entre widgets
Column(
  children: [
    Text('Título'),
    SizedBox(height: 16),  // ← Espaciador vertical
    Text('Subtítulo'),
    SizedBox(height: 24),  // ← Más espacio
    ElevatedButton(onPressed: () {}, child: Text('Acción')),
  ],
)

// 2. Espacio horizontal
Row(
  children: [
    Icon(Icons.star),
    SizedBox(width: 8),    // ← Espaciador horizontal
    Text('Favorito'),
  ],
)

// 3. Dimensiones fijas para un widget
SizedBox(
  width: 100,
  height: 50,
  child: ElevatedButton(
    onPressed: () {},
    child: Text('Fijo'),
  ),
)

// 4. Expandir para llenar espacio (dentro de Column/Row con bounded height)
SizedBox.expand(
  child: Container(color: Colors.blue),
)

// 5. Desde tamaño específico
SizedBox.fromSize(
  size: Size(200, 100),
  child: Container(color: Colors.green),
)
```

---

### 2.3 Padding

Widget dedicado exclusivamente a agregar espacio interno.

```dart
/**
 * Padding vs Container con padding
 *
 * Usa Padding cuando:
 * - Solo necesitas espaciado interno
 * - No necesitas decoración, color, ni dimensiones
 *
 * Usa Container cuando:
 * - Necesitas múltiples propiedades (color, borde, sombra, etc.)
 */

// ✅ Correcto: Solo padding
Padding(
  padding: EdgeInsets.all(16),
  child: Text('Contenido con espacio'),
)

// ❌ Innecesario: Container solo para padding
Container(
  padding: EdgeInsets.all(16),
  child: Text('Contenido con espacio'),
)
```

---

### 2.4 Center

Centra su hijo tanto horizontal como verticalmente.

```dart
/**
 * Center - Centrar contenido
 *
 * Equivalente a:
 * Align(alignment: Alignment.center, child: ...)
 *
 * Pero más legible y semántico
 */

// Centrar un widget
Center(
  child: Text('Estoy centrado'),
)

// Con factor de escala (ocupa porcentaje del espacio)
Center(
  widthFactor: 0.8,   // 80% del ancho disponible
  heightFactor: 0.5,  // 50% del alto disponible
  child: Container(
    color: Colors.blue,
    child: Text('Centrado con factores'),
  ),
)
```

---

### 2.5 Align

Posiciona su hijo en una ubicación específica.

```dart
/**
 * Align - Posicionamiento preciso
 *
 * Alignment usa coordenadas de -1.0 a 1.0
 * (-1, -1) = topLeft
 * (0, 0) = center
 * (1, 1) = bottomRight
 */

// Usando constantes predefinidas
Align(
  alignment: Alignment.topRight,
  child: Icon(Icons.close),
)

// Usando valores personalizados
Align(
  alignment: Alignment(0.5, -0.8),  // Ligeramente derecha y arriba
  child: Text('Posición personalizada'),
)

// Constantes de Alignment disponibles:
// Alignment.topLeft      Alignment.topCenter      Alignment.topRight
// Alignment.centerLeft   Alignment.center         Alignment.centerRight
// Alignment.bottomLeft   Alignment.bottomCenter   Alignment.bottomRight
```

---

### 2.6 AspectRatio

Mantiene una proporción específica de ancho/alto.

```dart
/**
 * AspectRatio - Proporciones fijas
 *
 * Útil para:
 * - Videos (16:9, 4:3)
 * - Imágenes con proporción fija
 * - Cuadrados perfectos (1:1)
 */

// Proporción 16:9 (video)
AspectRatio(
  aspectRatio: 16 / 9,
  child: Container(
    color: Colors.black,
    child: Center(child: Text('Video 16:9', style: TextStyle(color: Colors.white))),
  ),
)

// Proporción 1:1 (cuadrado)
AspectRatio(
  aspectRatio: 1.0,
  child: Container(
    decoration: BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,  // Círculo perfecto en un cuadrado
    ),
  ),
)

// Proporción 3:4 (retrato)
AspectRatio(
  aspectRatio: 3 / 4,
  child: Image.network(
    'https://example.com/portrait.jpg',
    fit: BoxFit.cover,
  ),
)
```

---

### 2.7 FractionallySizedBox

Dimensiona su hijo como fracción del espacio disponible.

```dart
/**
 * FractionallySizedBox - Tamaño proporcional
 *
 * widthFactor: 0.5 = 50% del ancho disponible
 * heightFactor: 0.8 = 80% del alto disponible
 */

// 50% del ancho, 30% del alto
FractionallySizedBox(
  widthFactor: 0.5,
  heightFactor: 0.3,
  child: Container(
    color: Colors.blue,
    child: Center(child: Text('50% x 30%')),
  ),
)

// Solo ancho proporcional
FractionallySizedBox(
  widthFactor: 0.8,
  alignment: Alignment.center,
  child: ElevatedButton(
    onPressed: () {},
    child: Text('80% del ancho'),
  ),
)
```

---

### 2.8 ConstrainedBox y UnconstrainedBox

Control avanzado de restricciones de tamaño.

```dart
/**
 * ConstrainedBox - Restricciones de tamaño
 *
 * Aplica restricciones mínimas y/o máximas
 */

// Tamaño mínimo garantizado
ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 100,
    minHeight: 50,
  ),
  child: Container(
    color: Colors.blue,
    child: Text('Mínimo 100x50'),
  ),
)

// Tamaño máximo limitado
ConstrainedBox(
  constraints: BoxConstraints(
    maxWidth: 300,
    maxHeight: 200,
  ),
  child: Image.network('https://example.com/large-image.jpg'),
)

// Rango de tamaños
ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 100,
    maxWidth: 300,
    minHeight: 50,
    maxHeight: 150,
  ),
  child: Text('Contenido flexible dentro de límites'),
)

// Atajos útiles
BoxConstraints.tight(Size(200, 100))      // Tamaño exacto
BoxConstraints.loose(Size(200, 100))      // Máximo 200x100
BoxConstraints.expand()                    // Llenar todo el espacio
BoxConstraints.tightFor(width: 200)        // Solo ancho fijo
```

---

## 3. Widgets de Texto

### 3.1 Text

Widget básico para mostrar texto.

```dart
/**
 * Text - Mostrar texto
 *
 * Propiedades principales:
 * - style: Estilos de fuente
 * - textAlign: Alineación
 * - maxLines: Límite de líneas
 * - overflow: Comportamiento cuando excede espacio
 */

// Texto simple
Text('Hola Flutter')

// Texto con estilo completo
Text(
  'Texto Personalizado',
  style: TextStyle(
    // Tamaño
    fontSize: 24,

    // Peso (grosor)
    fontWeight: FontWeight.bold,    // w100-w900, normal, bold

    // Estilo
    fontStyle: FontStyle.italic,

    // Color
    color: Colors.blue,

    // Fondo
    backgroundColor: Colors.yellow.withOpacity(0.3),

    // Espaciado entre letras
    letterSpacing: 1.5,

    // Espaciado entre palabras
    wordSpacing: 4.0,

    // Altura de línea (1.0 = normal)
    height: 1.4,

    // Decoración (subrayado, tachado, etc.)
    decoration: TextDecoration.underline,
    decorationColor: Colors.red,
    decorationStyle: TextDecorationStyle.wavy,

    // Sombras
    shadows: [
      Shadow(
        color: Colors.black26,
        offset: Offset(2, 2),
        blurRadius: 4,
      ),
    ],

    // Familia de fuentes
    fontFamily: 'Roboto',
  ),

  // Alineación
  textAlign: TextAlign.center,

  // Límite de líneas
  maxLines: 2,

  // Cuando excede el espacio
  overflow: TextOverflow.ellipsis,  // ... al final
  // overflow: TextOverflow.fade,   // Desvanece
  // overflow: TextOverflow.clip,   // Corta

  // Dirección del texto
  textDirection: TextDirection.ltr,

  // Factor de escala (accesibilidad)
  textScaleFactor: 1.0,
)
```

### 3.2 RichText y TextSpan

Texto con múltiples estilos en un solo widget.

```dart
/**
 * RichText - Texto con múltiples estilos
 *
 * Útil para:
 * - Resaltar palabras clave
 * - Términos y condiciones
 * - Texto con enlaces
 */

RichText(
  text: TextSpan(
    // Estilo base para todo el texto
    style: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    children: [
      TextSpan(text: 'Bienvenido a '),
      TextSpan(
        text: 'Flutter',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      TextSpan(text: ', el framework para crear '),
      TextSpan(
        text: 'apps multiplataforma',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
      TextSpan(text: '.'),
    ],
  ),
)

// Con gestos (enlaces clicables)
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 14, color: Colors.black),
    children: [
      TextSpan(text: 'Al registrarte aceptas nuestros '),
      TextSpan(
        text: 'Términos y Condiciones',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // Abrir términos y condiciones
            print('Abrir T&C');
          },
      ),
      TextSpan(text: '.'),
    ],
  ),
)
```

### 3.3 Text.rich (Alternativa simplificada)

```dart
/**
 * Text.rich - Alternativa a RichText
 *
 * Más conveniente porque hereda el estilo del Theme
 */

Text.rich(
  TextSpan(
    children: [
      TextSpan(text: 'Precio: '),
      TextSpan(
        text: '\$29.99',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
      TextSpan(
        text: ' \$49.99',
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.grey,
        ),
      ),
    ],
  ),
)
```

### 3.4 SelectableText

Texto que el usuario puede seleccionar y copiar.

```dart
/**
 * SelectableText - Texto seleccionable
 *
 * Útil para:
 * - Códigos de verificación
 * - Direcciones
 * - Información que el usuario quiera copiar
 */

SelectableText(
  'ABC-123-XYZ',
  style: TextStyle(
    fontSize: 24,
    fontFamily: 'monospace',
    letterSpacing: 2,
  ),
  textAlign: TextAlign.center,

  // Personalizar menú contextual
  contextMenuBuilder: (context, editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  },
)

// Con rich text
SelectableText.rich(
  TextSpan(
    text: 'Tu código es: ',
    children: [
      TextSpan(
        text: 'FLUTTER2024',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
)
```

---

## 4. Widgets de Imagen

### 4.1 Image.asset

Imágenes locales desde la carpeta `assets/`.

```dart
/**
 * Image.asset - Imágenes locales
 *
 * Configuración previa en pubspec.yaml:
 * flutter:
 *   assets:
 *     - assets/images/
 *     - assets/icons/
 */

// Básico
Image.asset('assets/images/logo.png')

// Con configuración completa
Image.asset(
  'assets/images/producto.jpg',

  // Dimensiones
  width: 200,
  height: 150,

  // Cómo ajustar la imagen
  fit: BoxFit.cover,      // Cubre el área, puede recortar
  // fit: BoxFit.contain,  // Cabe completa, puede dejar espacio
  // fit: BoxFit.fill,     // Estira para llenar (puede distorsionar)
  // fit: BoxFit.fitWidth, // Ajusta al ancho
  // fit: BoxFit.fitHeight,// Ajusta al alto
  // fit: BoxFit.none,     // Tamaño original
  // fit: BoxFit.scaleDown,// Reduce si es mayor, no agranda

  // Alineación dentro del espacio
  alignment: Alignment.center,

  // Color de tinte (overlay)
  color: Colors.blue,
  colorBlendMode: BlendMode.colorBurn,

  // Imagen mientras carga (para assets grandes)
  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
    if (wasSynchronouslyLoaded) return child;
    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: Duration(milliseconds: 300),
      child: child,
    );
  },

  // Descripción para accesibilidad
  semanticLabel: 'Logo de la empresa',

  // Excluir de lectores de pantalla (si es decorativo)
  excludeFromSemantics: false,
)
```

### 4.2 Image.network

Imágenes desde URLs de internet.

```dart
/**
 * Image.network - Imágenes de internet
 *
 * ⚠️ Requiere conexión a internet
 * ⚠️ Considera usar cached_network_image para producción
 */

// Básico
Image.network('https://picsum.photos/200/300')

// Con configuración completa
Image.network(
  'https://example.com/image.jpg',

  width: 200,
  height: 150,
  fit: BoxFit.cover,

  // Widget mientras carga
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;

    // Calcular progreso
    final progress = loadingProgress.expectedTotalBytes != null
        ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes!
        : null;

    return Center(
      child: CircularProgressIndicator(
        value: progress,
      ),
    );
  },

  // Widget si hay error
  errorBuilder: (context, error, stackTrace) {
    return Container(
      width: 200,
      height: 150,
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, size: 48, color: Colors.grey),
          SizedBox(height: 8),
          Text('Error al cargar imagen'),
        ],
      ),
    );
  },

  // Headers HTTP (para autenticación, etc.)
  headers: {
    'Authorization': 'Bearer token123',
  },
)
```

### 4.3 Image.memory y Image.file

```dart
/**
 * Image.memory - Desde bytes en memoria
 *
 * Útil para imágenes generadas o procesadas
 */
Image.memory(
  Uint8List.fromList(imageBytes),
  fit: BoxFit.cover,
)

/**
 * Image.file - Desde archivo local
 *
 * Útil para fotos tomadas con cámara
 * Requiere import 'dart:io';
 */
Image.file(
  File('/path/to/image.jpg'),
  fit: BoxFit.cover,
)
```

### 4.4 CircleAvatar

Avatar circular para perfiles de usuario.

```dart
/**
 * CircleAvatar - Avatar circular
 *
 * Ideal para:
 * - Fotos de perfil
 * - Iniciales de usuario
 * - Íconos circulares
 */

// Con imagen
CircleAvatar(
  radius: 40,
  backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
)

// Con iniciales
CircleAvatar(
  radius: 30,
  backgroundColor: Colors.blue,
  child: Text(
    'JD',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
)

// Con ícono
CircleAvatar(
  radius: 25,
  backgroundColor: Colors.green,
  child: Icon(Icons.person, color: Colors.white),
)

// Con imagen y fallback
CircleAvatar(
  radius: 35,
  backgroundColor: Colors.grey.shade200,
  backgroundImage: NetworkImage(user.avatarUrl),
  onBackgroundImageError: (exception, stackTrace) {
    // Manejar error silenciosamente
    print('Error cargando avatar: $exception');
  },
  child: user.avatarUrl.isEmpty
      ? Text(user.initials)
      : null,
)
```

### 4.5 Icon

Iconos de Material Design y Cupertino.

```dart
/**
 * Icon - Iconos vectoriales
 *
 * Colecciones disponibles:
 * - Icons.* (Material Design)
 * - CupertinoIcons.* (iOS style)
 */

// Icono básico
Icon(Icons.favorite)

// Icono personalizado
Icon(
  Icons.shopping_cart,
  size: 32,
  color: Colors.blue,

  // Accesibilidad
  semanticLabel: 'Carrito de compras',
)

// Iconos comunes
Icon(Icons.home)           // Casa
Icon(Icons.settings)       // Configuración
Icon(Icons.person)         // Persona
Icon(Icons.search)         // Buscar
Icon(Icons.add)            // Agregar
Icon(Icons.delete)         // Eliminar
Icon(Icons.edit)           // Editar
Icon(Icons.share)          // Compartir
Icon(Icons.favorite)       // Favorito (corazón)
Icon(Icons.star)           // Estrella
Icon(Icons.check)          // Check
Icon(Icons.close)          // Cerrar
Icon(Icons.menu)           // Menú hamburguesa
Icon(Icons.more_vert)      // Más opciones (vertical)
Icon(Icons.arrow_back)     // Flecha atrás
Icon(Icons.arrow_forward)  // Flecha adelante

// Variantes
Icon(Icons.favorite)           // Sólido
Icon(Icons.favorite_border)    // Solo borde
Icon(Icons.favorite_outlined)  // Outlined
```

---

## 5. Widgets Interactivos

### 5.1 ElevatedButton

Botón con elevación y sombra.

```dart
/**
 * ElevatedButton - Botón elevado principal
 *
 * Usado para acciones principales
 */

// Básico
ElevatedButton(
  onPressed: () {
    print('Botón presionado');
  },
  child: Text('Guardar'),
)

// Deshabilitado
ElevatedButton(
  onPressed: null,  // null = deshabilitado
  child: Text('Deshabilitado'),
)

// Con ícono
ElevatedButton.icon(
  onPressed: () {},
  icon: Icon(Icons.save),
  label: Text('Guardar'),
)

// Personalizado
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    // Colores
    backgroundColor: Colors.blue,        // Color de fondo
    foregroundColor: Colors.white,       // Color del texto/icono
    disabledBackgroundColor: Colors.grey,

    // Elevación
    elevation: 4,
    shadowColor: Colors.black54,

    // Padding interno
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),

    // Forma
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),

    // Tamaño mínimo
    minimumSize: Size(150, 50),

    // Tamaño del texto
    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
  child: Text('Personalizado'),
)
```

### 5.2 TextButton y OutlinedButton

```dart
/**
 * TextButton - Botón de texto plano
 *
 * Para acciones secundarias o menos prominentes
 */
TextButton(
  onPressed: () {},
  child: Text('Cancelar'),
)

TextButton.icon(
  onPressed: () {},
  icon: Icon(Icons.info),
  label: Text('Más información'),
)

/**
 * OutlinedButton - Botón con borde
 *
 * Alternativa visual a ElevatedButton
 */
OutlinedButton(
  onPressed: () {},
  style: OutlinedButton.styleFrom(
    side: BorderSide(color: Colors.blue, width: 2),
  ),
  child: Text('Registrarse'),
)
```

### 5.3 IconButton

Botón circular con solo un ícono.

```dart
/**
 * IconButton - Botón de ícono
 *
 * Ideal para barras de herramientas y acciones rápidas
 */

IconButton(
  icon: Icon(Icons.favorite),
  onPressed: () {},

  // Tamaño del ícono
  iconSize: 28,

  // Color
  color: Colors.red,

  // Área de toque (splash)
  splashRadius: 24,

  // Tooltip (accesibilidad)
  tooltip: 'Agregar a favoritos',

  // Padding
  padding: EdgeInsets.all(8),
)

// Con estado toggle
IconButton(
  icon: Icon(
    isFavorite ? Icons.favorite : Icons.favorite_border,
    color: isFavorite ? Colors.red : Colors.grey,
  ),
  onPressed: () {
    setState(() {
      isFavorite = !isFavorite;
    });
  },
)
```

### 5.4 FloatingActionButton (FAB)

Botón de acción flotante.

```dart
/**
 * FloatingActionButton - Botón flotante principal
 *
 * Usado para la acción principal de una pantalla
 * Típicamente en Scaffold.floatingActionButton
 */

// Circular (default)
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
  tooltip: 'Agregar nuevo',
)

// Mini
FloatingActionButton.small(
  onPressed: () {},
  child: Icon(Icons.edit),
)

// Extended (con etiqueta)
FloatingActionButton.extended(
  onPressed: () {},
  icon: Icon(Icons.add),
  label: Text('Crear tarea'),
)

// Personalizado
FloatingActionButton(
  onPressed: () {},
  backgroundColor: Colors.green,
  foregroundColor: Colors.white,
  elevation: 8,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Icon(Icons.check),
)
```

### 5.5 GestureDetector

Detectar gestos del usuario.

```dart
/**
 * GestureDetector - Detector de gestos
 *
 * Convierte cualquier widget en interactivo
 */

GestureDetector(
  // Taps
  onTap: () => print('Tap simple'),
  onDoubleTap: () => print('Doble tap'),
  onLongPress: () => print('Presión larga'),

  // Con detalles de posición
  onTapDown: (details) => print('Tap en: ${details.localPosition}'),
  onTapUp: (details) => print('Levantado en: ${details.localPosition}'),

  // Arrastrar
  onPanStart: (details) => print('Inicio arrastre'),
  onPanUpdate: (details) => print('Arrastrando: ${details.delta}'),
  onPanEnd: (details) => print('Fin arrastre'),

  // Escalar (pinch)
  onScaleStart: (details) => print('Inicio escala'),
  onScaleUpdate: (details) => print('Escala: ${details.scale}'),
  onScaleEnd: (details) => print('Fin escala'),

  // Comportamiento
  behavior: HitTestBehavior.opaque,  // Responde en todo el área

  child: Container(
    width: 200,
    height: 200,
    color: Colors.blue,
    child: Center(child: Text('Tócame')),
  ),
)
```

### 5.6 InkWell

Similar a GestureDetector pero con efecto ripple de Material.

```dart
/**
 * InkWell - Gestos con efecto ripple
 *
 * ⚠️ Debe estar dentro de Material() para que el ripple sea visible
 */

Material(
  color: Colors.transparent,
  child: InkWell(
    onTap: () => print('Tap con ripple'),
    onLongPress: () => print('Long press'),

    // Personalizar ripple
    splashColor: Colors.blue.withOpacity(0.3),
    highlightColor: Colors.blue.withOpacity(0.1),

    // Forma del ripple
    borderRadius: BorderRadius.circular(12),
    // customBorder: CircleBorder(),  // Para ripple circular

    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('Tócame con efecto'),
    ),
  ),
)

// Card con InkWell
Card(
  child: InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(4),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('Card clickeable'),
    ),
  ),
)
```

---

## 6. Composición de Widgets

### Ejemplo Práctico: Tarjeta de Producto

```dart
/**
 * ProductCard - Tarjeta de producto completa
 *
 * ¿Qué hace? Muestra información de un producto
 * ¿Para qué? Demostrar composición de múltiples widgets
 * ¿Cómo? Combina Container, Column, Row, Image, Text, IconButton
 */

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    this.isFavorite = false,
    required this.onTap,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen con badge de favorito
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 150,
                      color: Colors.grey.shade200,
                      child: Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  ),
                ),
                // Botón favorito
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: onFavoriteToggle,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),

            // Contenido
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Precio
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
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

// Uso
ProductCard(
  imageUrl: 'https://example.com/product.jpg',
  name: 'Auriculares Bluetooth Premium',
  price: 79.99,
  rating: 4.5,
  isFavorite: true,
  onTap: () => print('Ver producto'),
  onFavoriteToggle: () => print('Toggle favorito'),
)
```

---

## 7. Ejercicios de Reflexión

### 🤔 Preguntas de Comprensión

1. **¿Cuándo usar Container vs Padding?**

   - Piensa en los casos donde solo necesitas espaciado interno

2. **¿Por qué RichText es útil?**

   - Considera escenarios con texto multiestilo

3. **¿Cuál es la diferencia entre GestureDetector e InkWell?**

   - Reflexiona sobre el feedback visual

4. **¿Cómo afecta BoxFit la visualización de imágenes?**
   - Experimenta con diferentes valores

### ✍️ Mini-ejercicio

Crea mentalmente la estructura de widgets para:

- Una tarjeta de usuario con avatar, nombre, email y botón de seguir
- ¿Qué widgets usarías?
- ¿Cómo los anidarías?

---

## 🔗 Recursos Relacionados

- **Siguiente módulo**: [02-sistema-layouts.md](./02-sistema-layouts.md)
- **Práctica relacionada**: [practica-01-widgets-basicos.md](../2-practicas/practica-01-widgets-basicos.md)
- **Glosario**: [Ver términos de widgets](../5-glosario/README.md)

---

**Navegación**:
← [Volver al README](../README.md) | [Siguiente: Sistema de Layouts →](./02-sistema-layouts.md)
