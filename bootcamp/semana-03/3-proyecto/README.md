# 🍳 Proyecto Integrador: App de Recetas

> **Duración estimada:** 3-4 horas  
> **Nivel:** Intermedio  
> **Semana:** 03 - Widgets y Layouts

---

## 📋 Descripción del Proyecto

Crear una aplicación de recetas de cocina que permita explorar diferentes recetas, ver sus detalles y marcar favoritos. Este proyecto integra todos los conceptos de **widgets**, **layouts** y **diseño responsivo** aprendidos durante la semana.

---

## 🎯 Objetivos de Aprendizaje

Al completar este proyecto, habrás demostrado dominio de:

- [ ] Uso de widgets básicos (Container, Text, Image, Icon)
- [ ] Composición de widgets complejos
- [ ] Layouts con Column, Row, Stack
- [ ] Listas con ListView y GridView
- [ ] Diseño responsivo con LayoutBuilder
- [ ] Navegación básica entre pantallas
- [ ] Organización de código en widgets reutilizables

---

## 🎨 Diseño de la Aplicación

### Pantalla Principal (Lista de Recetas)

```
┌─────────────────────────────────────────────────────────┐
│  🍳 Recetas Deliciosas                    🔍    ❤️     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Categorías                                             │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐                    │
│  │ 🍝 │ │ 🥗 │ │ 🍰 │ │ 🍲 │ │ 🥤 │  →                 │
│  │Past│ │Ensa│ │Post│ │Sopa│ │Bebi│                    │
│  └────┘ └────┘ └────┘ └────┘ └────┘                    │
│                                                         │
│  Recetas Populares                                      │
│  ┌─────────────────────────────────────────────────┐   │
│  │ ┌───────────────────────────────────────────┐   │   │
│  │ │                                           │   │   │
│  │ │              IMAGEN RECETA                │   │   │
│  │ │                                           │   │   │
│  │ │  ❤️                               ⭐ 4.8  │   │   │
│  │ └───────────────────────────────────────────┘   │   │
│  │  Pasta Carbonara                                │   │
│  │  🕐 30 min  👨‍🍳 Fácil  🔥 450 kcal              │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │  ...más recetas...                              │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Pantalla de Detalle

```
┌─────────────────────────────────────────────────────────┐
│  ←                                         ❤️    📤    │
├─────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────┐   │
│  │                                                 │   │
│  │                 IMAGEN GRANDE                   │   │
│  │                                                 │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Pasta Carbonara                              ⭐ 4.8    │
│  Por Chef María García                                  │
│                                                         │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐               │
│  │  🕐 30   │ │  👨‍🍳     │ │  🔥 450  │               │
│  │ minutos  │ │  Fácil   │ │  kcal    │               │
│  └──────────┘ └──────────┘ └──────────┘               │
│                                                         │
│  Descripción                                            │
│  La auténtica pasta carbonara italiana...              │
│                                                         │
│  Ingredientes                                           │
│  • 400g de espaguetis                                  │
│  • 200g de guanciale                                   │
│  • 4 yemas de huevo                                    │
│  • ...                                                 │
│                                                         │
│  Preparación                                            │
│  1. Hervir la pasta en agua con sal...                 │
│  2. Mientras tanto, cortar el guanciale...             │
│  3. ...                                                │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada
├── models/
│   └── recipe.dart           # Modelo de datos
├── data/
│   └── sample_recipes.dart   # Datos de ejemplo
├── screens/
│   ├── home_screen.dart      # Pantalla principal
│   └── recipe_detail.dart    # Detalle de receta
└── widgets/
    ├── category_chip.dart    # Chip de categoría
    ├── recipe_card.dart      # Tarjeta de receta
    └── info_chip.dart        # Chip de información
```

---

## 📝 Requisitos Funcionales

### RF01: Pantalla Principal

- Mostrar barra de búsqueda (visual, sin funcionalidad)
- Mostrar lista horizontal de categorías
- Mostrar grid/lista de recetas populares
- Cada receta muestra: imagen, nombre, tiempo, dificultad, calorías
- Botón de favorito en cada receta

### RF02: Pantalla de Detalle

- Mostrar imagen grande de la receta
- Mostrar información completa (nombre, chef, rating)
- Mostrar chips de información (tiempo, dificultad, calorías)
- Mostrar descripción
- Mostrar lista de ingredientes
- Mostrar pasos de preparación
- Botones de favorito y compartir

### RF03: Diseño Responsivo

- En móvil: lista vertical de recetas
- En tablet: grid de 2 columnas
- En desktop: grid de 3-4 columnas

---

## 🚀 Implementación Paso a Paso

### Archivo 1: `lib/models/recipe.dart`

```dart
/// Modelo de datos para una receta
///
/// Representa toda la información necesaria para mostrar
/// una receta en la aplicación.

class Recipe {
  final String id;
  final String name;
  final String chef;
  final String imageUrl;
  final String category;
  final int cookingTime; // en minutos
  final String difficulty; // Fácil, Media, Difícil
  final int calories;
  final double rating;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.chef,
    required this.imageUrl,
    required this.category,
    required this.cookingTime,
    required this.difficulty,
    required this.calories,
    required this.rating,
    required this.description,
    required this.ingredients,
    required this.steps,
    this.isFavorite = false,
  });
}

class Category {
  final String id;
  final String name;
  final String emoji;

  const Category({
    required this.id,
    required this.name,
    required this.emoji,
  });
}
```

### Archivo 2: `lib/data/sample_recipes.dart`

```dart
import '../models/recipe.dart';

/// Categorías disponibles
final List<Category> categories = [
  const Category(id: 'pasta', name: 'Pastas', emoji: '🍝'),
  const Category(id: 'salad', name: 'Ensaladas', emoji: '🥗'),
  const Category(id: 'dessert', name: 'Postres', emoji: '🍰'),
  const Category(id: 'soup', name: 'Sopas', emoji: '🍲'),
  const Category(id: 'drink', name: 'Bebidas', emoji: '🥤'),
  const Category(id: 'meat', name: 'Carnes', emoji: '🥩'),
  const Category(id: 'fish', name: 'Pescados', emoji: '🐟'),
  const Category(id: 'vegan', name: 'Vegano', emoji: '🌱'),
];

/// Recetas de ejemplo
final List<Recipe> sampleRecipes = [
  Recipe(
    id: '1',
    name: 'Pasta Carbonara',
    chef: 'Chef María García',
    imageUrl: 'https://picsum.photos/400/300?random=1',
    category: 'pasta',
    cookingTime: 30,
    difficulty: 'Fácil',
    calories: 450,
    rating: 4.8,
    description:
        'La auténtica pasta carbonara italiana, cremosa y deliciosa. '
        'Una receta tradicional romana que conquistará tu paladar.',
    ingredients: [
      '400g de espaguetis',
      '200g de guanciale o panceta',
      '4 yemas de huevo',
      '100g de queso pecorino romano',
      'Pimienta negra recién molida',
      'Sal al gusto',
    ],
    steps: [
      'Hervir la pasta en agua con sal hasta que esté al dente.',
      'Mientras tanto, cortar el guanciale en cubos pequeños.',
      'Dorar el guanciale en una sartén hasta que esté crujiente.',
      'En un bowl, mezclar las yemas con el queso rallado.',
      'Escurrir la pasta reservando un poco del agua de cocción.',
      'Mezclar la pasta caliente con el guanciale fuera del fuego.',
      'Añadir la mezcla de huevo y queso, removiendo rápidamente.',
      'Servir inmediatamente con pimienta negra y más queso.',
    ],
  ),
  Recipe(
    id: '2',
    name: 'Ensalada César',
    chef: 'Chef Carlos Ruiz',
    imageUrl: 'https://picsum.photos/400/300?random=2',
    category: 'salad',
    cookingTime: 15,
    difficulty: 'Fácil',
    calories: 280,
    rating: 4.5,
    description:
        'Una ensalada clásica con pollo a la parrilla, crutones crujientes '
        'y el famoso aderezo César casero.',
    ingredients: [
      'Lechuga romana',
      '200g de pechuga de pollo',
      'Crutones de pan',
      'Queso parmesano',
      'Aderezo César',
      'Anchoas (opcional)',
    ],
    steps: [
      'Lavar y cortar la lechuga romana.',
      'Grillar la pechuga de pollo y cortarla en tiras.',
      'Preparar el aderezo César casero.',
      'Mezclar todos los ingredientes en un bowl grande.',
      'Servir con crutones y queso parmesano rallado.',
    ],
  ),
  Recipe(
    id: '3',
    name: 'Tiramisú Clásico',
    chef: 'Chef Ana Martínez',
    imageUrl: 'https://picsum.photos/400/300?random=3',
    category: 'dessert',
    cookingTime: 45,
    difficulty: 'Media',
    calories: 380,
    rating: 4.9,
    description:
        'El postre italiano por excelencia. Capas de bizcocho empapado '
        'en café con una crema de mascarpone irresistible.',
    ingredients: [
      '500g de mascarpone',
      '4 huevos',
      '100g de azúcar',
      'Bizcochos de soletilla',
      'Café espresso frío',
      'Cacao en polvo',
      'Licor de café (opcional)',
    ],
    steps: [
      'Preparar café espresso fuerte y dejarlo enfriar.',
      'Separar las yemas de las claras.',
      'Batir las yemas con el azúcar hasta blanquear.',
      'Añadir el mascarpone y mezclar bien.',
      'Montar las claras a punto de nieve e incorporar.',
      'Mojar los bizcochos en café y colocar en capas.',
      'Alternar capas de crema y bizcochos.',
      'Refrigerar mínimo 4 horas. Espolvorear cacao antes de servir.',
    ],
  ),
  Recipe(
    id: '4',
    name: 'Sopa de Tomate',
    chef: 'Chef Luis Fernández',
    imageUrl: 'https://picsum.photos/400/300?random=4',
    category: 'soup',
    cookingTime: 40,
    difficulty: 'Fácil',
    calories: 150,
    rating: 4.3,
    description:
        'Una reconfortante sopa de tomate casera, perfecta para los días fríos. '
        'Simple pero llena de sabor.',
    ingredients: [
      '1kg de tomates maduros',
      '1 cebolla',
      '2 dientes de ajo',
      'Caldo de verduras',
      'Albahaca fresca',
      'Aceite de oliva',
      'Sal y pimienta',
    ],
    steps: [
      'Asar los tomates en el horno a 200°C por 20 minutos.',
      'Sofreír la cebolla y el ajo en aceite de oliva.',
      'Añadir los tomates asados y el caldo.',
      'Cocinar a fuego lento por 15 minutos.',
      'Triturar hasta obtener una textura suave.',
      'Servir caliente con hojas de albahaca fresca.',
    ],
  ),
  Recipe(
    id: '5',
    name: 'Risotto de Setas',
    chef: 'Chef María García',
    imageUrl: 'https://picsum.photos/400/300?random=5',
    category: 'pasta',
    cookingTime: 35,
    difficulty: 'Media',
    calories: 420,
    rating: 4.7,
    description:
        'Un cremoso risotto italiano con variedad de setas silvestres. '
        'La técnica perfecta para un arroz al dente.',
    ingredients: [
      '300g de arroz arborio',
      '200g de setas variadas',
      '1 litro de caldo de pollo',
      '1 cebolla',
      'Vino blanco',
      'Queso parmesano',
      'Mantequilla',
    ],
    steps: [
      'Calentar el caldo y mantenerlo caliente.',
      'Sofreír la cebolla picada en mantequilla.',
      'Añadir las setas y saltear.',
      'Incorporar el arroz y tostar ligeramente.',
      'Añadir el vino y dejar evaporar.',
      'Ir añadiendo caldo poco a poco, removiendo constantemente.',
      'Terminar con mantequilla y parmesano (mantecatura).',
    ],
  ),
  Recipe(
    id: '6',
    name: 'Smoothie Verde',
    chef: 'Chef Ana Martínez',
    imageUrl: 'https://picsum.photos/400/300?random=6',
    category: 'drink',
    cookingTime: 5,
    difficulty: 'Fácil',
    calories: 120,
    rating: 4.4,
    description:
        'Un batido energético y nutritivo con espinacas, plátano y manzana. '
        'Perfecto para empezar el día con energía.',
    ingredients: [
      '1 puñado de espinacas',
      '1 plátano maduro',
      '1 manzana verde',
      '200ml de leche de almendras',
      '1 cucharada de miel',
      'Hielo al gusto',
    ],
    steps: [
      'Lavar bien las espinacas y la manzana.',
      'Cortar el plátano y la manzana en trozos.',
      'Añadir todos los ingredientes a la licuadora.',
      'Triturar hasta obtener una textura suave.',
      'Servir inmediatamente bien frío.',
    ],
  ),
];
```

---

## 📱 Pantallas Principales

Los archivos de pantallas se encuentran en los documentos adjuntos:

- **[home_screen.dart](./home_screen.dart)** - Pantalla principal con lista de recetas
- **[recipe_detail_screen.dart](./recipe_detail_screen.dart)** - Detalle de receta

---

## ✅ Criterios de Evaluación (50 puntos)

### Funcionalidad (20 pts)

| Criterio                                 | Puntos |
| ---------------------------------------- | ------ |
| Lista de categorías horizontal funciona  | 3      |
| Grid de recetas se muestra correctamente | 4      |
| Navegación a detalle funciona            | 4      |
| Detalle muestra toda la información      | 4      |
| Botón favorito funciona                  | 3      |
| Sin errores de ejecución                 | 2      |

### Diseño Responsivo (15 pts)

| Criterio                                 | Puntos |
| ---------------------------------------- | ------ |
| Columnas se adaptan al ancho             | 5      |
| Espaciado correcto en diferentes tamaños | 3      |
| Imágenes escalan correctamente           | 3      |
| SafeArea aplicado                        | 2      |
| Scroll funciona correctamente            | 2      |

### Calidad del Código (15 pts)

| Criterio                          | Puntos |
| --------------------------------- | ------ |
| Widgets separados y reutilizables | 4      |
| Código bien organizado            | 3      |
| Nombres descriptivos en inglés    | 3      |
| Comentarios explicativos          | 3      |
| Sin código duplicado              | 2      |

---

## 🏆 Desafíos Adicionales

1. **Búsqueda**: Implementar filtrado de recetas por nombre
2. **Filtro por categoría**: Tap en categoría filtra las recetas
3. **Animaciones**: Añadir Hero animation a las imágenes
4. **Persistencia**: Guardar favoritos en SharedPreferences
5. **Dark Mode**: Implementar tema oscuro

---

## 📚 Referencias

- [Módulo 01: Widgets Fundamentales](../1-teoria/01-widgets-fundamentales.md)
- [Módulo 02: Sistema de Layouts](../1-teoria/02-sistema-layouts.md)
- [Módulo 03: Diseño Responsivo](../1-teoria/03-diseno-responsivo.md)
- [Práctica 05: Dashboard](../2-practicas/practica-05-pantalla-completa.md)
