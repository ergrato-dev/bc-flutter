# 📖 Glosario Técnico - Semana 03

> Términos y conceptos clave de Widgets y Layouts en Flutter.

---

## 🔤 Índice Alfabético

[A](#a) | [B](#b) | [C](#c) | [D](#d) | [E](#e) | [F](#f) | [G](#g) | [H](#h) | [I](#i) | [L](#l) | [M](#m) | [O](#o) | [P](#p) | [R](#r) | [S](#s) | [T](#t) | [W](#w)

---

## A

### Adaptive Design

Diseño que se **adapta** usando diferentes widgets según la plataforma (iOS vs Android). Diferente de responsive que solo cambia tamaños.

### Alignment

Propiedad que define la posición de un widget dentro de su contenedor. Valores como `Alignment.center`, `Alignment.topLeft`.

### AspectRatio

Widget que mantiene una relación de aspecto específica (ancho/alto) para su hijo.

```dart
AspectRatio(
  aspectRatio: 16/9,
  child: Container(color: Colors.blue),
)
```

---

## B

### BoxConstraints

Objeto que define las restricciones de tamaño (mínimo y máximo) para un widget. Incluye `minWidth`, `maxWidth`, `minHeight`, `maxHeight`.

### BoxDecoration

Clase para decorar un Container con color, bordes, sombras, gradientes y forma.

```dart
BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8),
  boxShadow: [BoxShadow(...)],
)
```

### Breakpoint

Punto de quiebre de tamaño donde el diseño cambia. Ejemplo: 600px para móvil vs tablet.

---

## C

### Card

Widget Material Design que muestra contenido en una superficie elevada con bordes redondeados.

### Center

Widget que centra su hijo dentro del espacio disponible. Shortcut de `Align(alignment: Alignment.center)`.

### CircleAvatar

Widget que muestra una imagen o texto en un círculo. Útil para fotos de perfil.

### ClipRRect

Widget que recorta su hijo con bordes redondeados.

### Column

Widget que organiza sus hijos **verticalmente** de arriba a abajo.

### Constraints (Restricciones)

Límites de tamaño que un widget padre impone a sus hijos. Flutter usa un sistema de restricciones para calcular tamaños.

### Container

Widget versátil que combina padding, margin, decoración, tamaño y transformaciones.

### CrossAxisAlignment

Alineación en el eje perpendicular al principal. En Column es horizontal, en Row es vertical.

---

## D

### Decoration

Estilo visual aplicado a un Container (colores, bordes, sombras).

### Density

Densidad de píxeles de la pantalla. Afecta cómo se renderizan los tamaños.

### DevicePixelRatio

Relación entre píxeles físicos y lógicos. Un ratio de 2.0 significa que hay 2 píxeles físicos por cada píxel lógico.

---

## E

### EdgeInsets

Clase que define espaciado (padding/margin) en los cuatro lados de un widget.

```dart
EdgeInsets.all(16)           // Todos los lados
EdgeInsets.symmetric(horizontal: 8, vertical: 16)
EdgeInsets.only(left: 8, top: 16)
```

### Expanded

Widget que expande su hijo para llenar el espacio disponible en un Row/Column. Usa `flex` para proporciones.

---

## F

### Flex

Factor que determina cuánto espacio ocupa un Expanded/Flexible relativo a otros.

### Flexible

Similar a Expanded pero permite que el hijo ocupe **menos** espacio si no lo necesita.

### FittedBox

Widget que escala y posiciona su hijo para ajustarse al espacio disponible.

### Flex Direction

Dirección principal de un Flex widget: horizontal (Row) o vertical (Column).

---

## G

### GestureDetector

Widget que detecta gestos (tap, swipe, long press) y ejecuta callbacks.

### GridView

Widget que muestra sus hijos en una cuadrícula 2D scrolleable.

### GridView.builder

Constructor eficiente de GridView que crea items bajo demanda.

---

## H

### Hero

Widget que anima la transición de un elemento entre pantallas.

---

## I

### Image

Widget para mostrar imágenes desde assets, red o memoria.

### InkWell

Widget que responde al tap con un efecto de onda (ripple effect).

### IntrinsicHeight/Width

Widgets que dimensionan sus hijos según su tamaño intrínseco. **Usar con precaución** - puede ser costoso.

---

## L

### LayoutBuilder

Widget que proporciona las constraints del padre para construir layouts adaptativos.

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return WideLayout();
    }
    return NarrowLayout();
  },
)
```

### ListView

Widget scrolleable que muestra una lista de hijos linealmente.

### ListView.builder

Constructor eficiente que crea items bajo demanda. Ideal para listas largas.

### ListView.separated

ListView con separadores entre items.

---

## M

### MainAxisAlignment

Alineación en el eje principal. En Column es vertical, en Row es horizontal.

Valores: `start`, `end`, `center`, `spaceBetween`, `spaceAround`, `spaceEvenly`.

### MainAxisSize

Cuánto espacio ocupa un Row/Column en su eje principal: `max` (todo) o `min` (solo lo necesario).

### Margin

Espacio **externo** alrededor de un widget.

### MaterialApp

Widget raíz para apps Material Design. Configura tema, rutas y localización.

### MediaQuery

Widget que proporciona información del dispositivo: tamaño, orientación, brillo, etc.

```dart
final width = MediaQuery.sizeOf(context).width;
final orientation = MediaQuery.orientationOf(context);
```

---

## O

### OrientationBuilder

Widget que reconstruye cuando cambia la orientación (portrait/landscape).

### Overflow

Cuando el contenido excede el espacio disponible. Puede causar errores de renderizado.

---

## P

### Padding

Widget que añade espacio **interno** alrededor de su hijo.

### Positioned

Widget usado dentro de Stack para posicionar elementos con coordenadas absolutas.

---

## R

### RenderFlex Overflow

Error común cuando un Row/Column tiene hijos que exceden el espacio disponible.

### Responsive Design

Diseño que se **adapta** a diferentes tamaños de pantalla usando el mismo conjunto de widgets.

### Row

Widget que organiza sus hijos **horizontalmente** de izquierda a derecha.

---

## S

### SafeArea

Widget que añade padding para evitar áreas del sistema (notch, barra de estado).

### Scaffold

Estructura base de una pantalla Material: AppBar, Body, Drawer, FAB, BottomNav.

### ScrollView

Widget que permite hacer scroll de su contenido.

### SingleChildScrollView

ScrollView para un solo hijo. Útil cuando el contenido puede exceder la pantalla.

### SizedBox

Widget que fuerza un tamaño específico a su hijo o crea espacios vacíos.

```dart
SizedBox(width: 100, height: 50, child: ...)
SizedBox(height: 16)  // Espaciador
SizedBox.expand()     // Expandir al máximo
```

### SliverGrid / SliverList

Versiones "sliver" de Grid y List para usar con CustomScrollView.

### Spacer

Widget que ocupa espacio vacío en un Row/Column. Equivalente a `Expanded(child: SizedBox())`.

### Stack

Widget que superpone sus hijos uno sobre otro.

---

## T

### Text

Widget para mostrar texto con estilos.

### TextStyle

Clase que define el estilo del texto: fuente, tamaño, color, peso, etc.

### Tight Constraints

Restricciones donde min == max, forzando un tamaño exacto.

---

## W

### Widget

Unidad básica de UI en Flutter. Todo es un widget: botones, textos, layouts, apps.

### Widget Tree

Estructura jerárquica de widgets que forma la UI de la aplicación.

### Wrap

Widget que organiza sus hijos en filas/columnas y hace wrap cuando no caben.

```dart
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [Chip(...), Chip(...), Chip(...)],
)
```

---

## 📊 Resumen por Categoría

### Widgets de Estructura

`Container`, `SizedBox`, `Padding`, `Center`, `Align`

### Widgets de Layout

`Row`, `Column`, `Stack`, `Wrap`, `Expanded`, `Flexible`, `Spacer`

### Widgets de Lista

`ListView`, `GridView`, `SingleChildScrollView`, `CustomScrollView`

### Widgets Responsive

`MediaQuery`, `LayoutBuilder`, `OrientationBuilder`, `SafeArea`

### Widgets de Contenido

`Text`, `Image`, `Icon`, `Card`, `CircleAvatar`

### Widgets Interactivos

`GestureDetector`, `InkWell`, `ElevatedButton`, `IconButton`
