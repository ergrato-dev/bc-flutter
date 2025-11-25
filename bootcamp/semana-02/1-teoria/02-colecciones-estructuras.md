# 02. Colecciones y Estructuras de Datos en Dart

**Duración:** 2 horas  
**Modalidad:** Teoría + Ejercicios prácticos  
**Objetivo:** Dominar las colecciones y sus métodos avanzados en Dart

---

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Trabajar con List, Set y Map eficientemente
- ✅ Usar métodos de iteración y transformación
- ✅ Aplicar programación funcional con colecciones
- ✅ Filtrar, mapear y reducir datos
- ✅ Combinar y manipular colecciones complejas
- ✅ Optimizar el uso de colecciones según el caso de uso

---

## PARTE 1: Listas (List) (40 minutos)

### 1️⃣ **Creación y Manipulación Básica**

```dart
/**
 * What?
 * List es una colección ordenada de elementos indexados
 *
 * For?
 * Almacenar secuencias de datos del mismo tipo
 *
 * Impact?
 * Estructura de datos más utilizada en programación
 */

void main() {
  // Crear listas
  var numbers = [1, 2, 3, 4, 5];  // Tipo inferido: List<int>
  List<String> fruits = ['manzana', 'pera', 'uva'];
  List<double> prices = [10.5, 20.0, 15.75];

  // Lista vacía con tipo
  List<String> names = [];
  List<int> ages = <int>[];

  // Lista con longitud fija
  var fixedList = List<int>.filled(5, 0);  // [0, 0, 0, 0, 0]

  // Lista generada
  var squares = List.generate(5, (index) => index * index);  // [0, 1, 4, 9, 16]

  print('Números: $numbers');
  print('Frutas: $fruits');
  print('Cuadrados: $squares');
}
```

### 2️⃣ **Acceso y Modificación**

```dart
/**
 * What?
 * Operaciones para acceder y modificar elementos de la lista
 *
 * For?
 * Trabajar con elementos individuales o grupos
 *
 * Impact?
 * Control completo sobre los datos almacenados
 */

void main() {
  var languages = ['Dart', 'JavaScript', 'Python', 'Java', 'Go'];

  // Acceso por índice
  print('Primer elemento: ${languages[0]}');
  print('Último elemento: ${languages[languages.length - 1]}');
  print('Último elemento (alt): ${languages.last}');

  // Modificar elemento
  languages[1] = 'TypeScript';
  print('Modificado: $languages');

  // Agregar elementos
  languages.add('Rust');                    // Al final
  languages.insert(0, 'C++');               // En posición específica
  languages.addAll(['Swift', 'Kotlin']);    // Múltiples al final

  print('Después de agregar: $languages');

  // Eliminar elementos
  languages.remove('Java');                  // Por valor
  languages.removeAt(0);                     // Por índice
  languages.removeLast();                    // Último elemento

  print('Después de eliminar: $languages');

  // Verificar existencia
  print('¿Tiene Python? ${languages.contains("Python")}');
  print('Índice de Dart: ${languages.indexOf("Dart")}');

  // Sublistas
  var slice = languages.sublist(1, 4);
  print('Sublista [1-4]: $slice');

  // Limpiar lista
  // languages.clear();
}
```

### 3️⃣ **Métodos de Transformación**

```dart
/**
 * What?
 * Métodos para transformar listas usando programación funcional
 *
 * For?
 * Procesar datos de forma declarativa y elegante
 *
 * Impact?
 * Código más limpio y expresivo
 */

void main() {
  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // map() - Transformar cada elemento
  var doubled = numbers.map((n) => n * 2);
  print('Duplicados: ${doubled.toList()}');

  var squared = numbers.map((n) => n * n).toList();
  print('Cuadrados: $squared');

  // where() - Filtrar elementos
  var evens = numbers.where((n) => n % 2 == 0).toList();
  print('Pares: $evens');

  var greaterThan5 = numbers.where((n) => n > 5).toList();
  print('Mayores a 5: $greaterThan5');

  // Combinar map y where
  var result = numbers
      .where((n) => n % 2 == 0)
      .map((n) => n * n)
      .toList();
  print('Pares al cuadrado: $result');

  // any() - ¿Alguno cumple?
  print('¿Alguno mayor a 8? ${numbers.any((n) => n > 8)}');

  // every() - ¿Todos cumplen?
  print('¿Todos positivos? ${numbers.every((n) => n > 0)}');

  // firstWhere() - Primer elemento que cumple
  var firstEven = numbers.firstWhere((n) => n % 2 == 0);
  print('Primer par: $firstEven');

  // lastWhere() - Último elemento que cumple
  var lastEven = numbers.lastWhere((n) => n % 2 == 0);
  print('Último par: $lastEven');
}
```

### 4️⃣ **Reducción y Agregación**

```dart
/**
 * What?
 * Métodos para combinar elementos en un solo valor
 *
 * For?
 * Calcular sumas, promedios, concatenaciones, etc.
 *
 * Impact?
 * Operaciones complejas en una sola expresión
 */

void main() {
  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // reduce() - Combinar elementos
  var sum = numbers.reduce((a, b) => a + b);
  print('Suma total: $sum');

  var product = numbers.reduce((a, b) => a * b);
  print('Producto: $product');

  // fold() - Reducir con valor inicial
  var sumFold = numbers.fold(0, (prev, element) => prev + element);
  print('Suma con fold: $sumFold');

  var sumOfSquares = numbers.fold(0, (sum, n) => sum + n * n);
  print('Suma de cuadrados: $sumOfSquares');

  // Concatenar strings
  var words = ['Hola', 'mundo', 'desde', 'Dart'];
  var sentence = words.fold('', (prev, word) => prev.isEmpty ? word : '$prev $word');
  print('Frase: $sentence');

  // Calcular promedio
  var average = numbers.reduce((a, b) => a + b) / numbers.length;
  print('Promedio: ${average.toStringAsFixed(2)}');

  // Encontrar máximo y mínimo
  var max = numbers.reduce((a, b) => a > b ? a : b);
  var min = numbers.reduce((a, b) => a < b ? a : b);
  print('Máximo: $max, Mínimo: $min');
}
```

### 5️⃣ **Ordenamiento**

```dart
/**
 * What?
 * Métodos para ordenar listas
 *
 * For?
 * Organizar datos según criterios específicos
 *
 * Impact?
 * Datos ordenados para mejor presentación o procesamiento
 */

void main() {
  var numbers = [5, 2, 8, 1, 9, 3, 7, 4, 6];
  var names = ['Carlos', 'Ana', 'Beatriz', 'David'];

  // sort() - Ordenar in-place (modifica la lista original)
  numbers.sort();
  print('Números ordenados: $numbers');

  names.sort();
  print('Nombres ordenados: $names');

  // Ordenar descendente
  numbers.sort((a, b) => b.compareTo(a));
  print('Números desc: $numbers');

  // reversed - Invertir orden (retorna Iterable)
  var reversed = numbers.reversed.toList();
  print('Invertidos: $reversed');

  // Ordenar objetos complejos
  var products = [
    {'name': 'Laptop', 'price': 1200},
    {'name': 'Mouse', 'price': 25},
    {'name': 'Keyboard', 'price': 80},
    {'name': 'Monitor', 'price': 350},
  ];

  // Ordenar por precio
  products.sort((a, b) => (a['price'] as int).compareTo(b['price'] as int));

  print('\nProductos por precio:');
  for (var product in products) {
    print('${product['name']}: \$${product['price']}');
  }

  // Ordenar por nombre
  products.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));

  print('\nProductos por nombre:');
  for (var product in products) {
    print('${product['name']}: \$${product['price']}');
  }
}
```

---

## PARTE 2: Conjuntos (Set) (30 minutos)

### 1️⃣ **Características y Creación**

```dart
/**
 * What?
 * Set es una colección no ordenada de elementos únicos
 *
 * For?
 * Eliminar duplicados y operaciones de teoría de conjuntos
 *
 * Impact?
 * Búsqueda rápida y garantía de unicidad
 */

void main() {
  // Crear sets
  var numbers = {1, 2, 3, 4, 5};
  Set<String> colors = {'rojo', 'verde', 'azul'};

  // Set vacío (importante: usar tipo explícito)
  var emptySet = <String>{};  // Set
  // var notASet = {};           // Map!

  // Set desde lista (elimina duplicados)
  var list = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4];
  var uniqueNumbers = Set<int>.from(list);
  print('Lista: $list');
  print('Set: $uniqueNumbers');

  // Agregar elementos
  colors.add('amarillo');
  colors.add('rojo');  // No se agrega (ya existe)
  print('Colores: $colors');

  // Agregar múltiples
  colors.addAll(['naranja', 'violeta', 'verde']);  // 'verde' no se duplica
  print('Colores actualizados: $colors');

  print('Cantidad de colores: ${colors.length}');
}
```

### 2️⃣ **Operaciones de Conjuntos**

```dart
/**
 * What?
 * Operaciones matemáticas de teoría de conjuntos
 *
 * For?
 * Unión, intersección, diferencia entre conjuntos
 *
 * Impact?
 * Análisis y comparación eficiente de colecciones
 */

void main() {
  var setA = {1, 2, 3, 4, 5};
  var setB = {4, 5, 6, 7, 8};

  print('Set A: $setA');
  print('Set B: $setB');

  // Unión - elementos en A o B
  var union = setA.union(setB);
  print('\nUnión (A ∪ B): $union');

  // Intersección - elementos en A y B
  var intersection = setA.intersection(setB);
  print('Intersección (A ∩ B): $intersection');

  // Diferencia - elementos en A pero no en B
  var difference = setA.difference(setB);
  print('Diferencia (A - B): $difference');

  // Verificar pertenencia
  print('\n¿3 está en A? ${setA.contains(3)}');
  print('¿7 está en A? ${setA.contains(7)}');

  // Verificar si es subconjunto
  var setC = {2, 3};
  print('\n¿C es subconjunto de A? ${setC.difference(setA).isEmpty}');

  // Convertir a lista
  var listFromSet = setA.toList();
  print('\nSet como lista: $listFromSet');
}
```

### 3️⃣ **Caso de Uso: Análisis de Datos**

```dart
/**
 * Ejemplo práctico: Sistema de etiquetas y categorías
 */

class Article {
  String title;
  Set<String> tags;

  Article(this.title, this.tags);

  bool hasTag(String tag) => tags.contains(tag);

  void addTag(String tag) {
    tags.add(tag);
  }

  void addTags(List<String> newTags) {
    tags.addAll(newTags);
  }
}

void main() {
  var articles = [
    Article('Intro a Dart', {'programación', 'dart', 'tutorial'}),
    Article('POO en Dart', {'programación', 'dart', 'poo', 'avanzado'}),
    Article('Flutter Basics', {'flutter', 'dart', 'móvil', 'tutorial'}),
    Article('State Management', {'flutter', 'programación', 'avanzado'}),
  ];

  // Obtener todas las etiquetas únicas
  var allTags = <String>{};
  for (var article in articles) {
    allTags.addAll(article.tags);
  }
  print('Todas las etiquetas: $allTags');

  // Artículos con etiqueta específica
  var dartArticles = articles.where((a) => a.hasTag('dart')).toList();
  print('\nArtículos sobre Dart: ${dartArticles.length}');
  for (var article in dartArticles) {
    print('  - ${article.title}');
  }

  // Artículos con múltiples etiquetas
  var advancedDart = articles.where((a) =>
    a.hasTag('dart') && a.hasTag('avanzado')
  ).toList();

  print('\nArtículos avanzados de Dart:');
  for (var article in advancedDart) {
    print('  - ${article.title}');
  }

  // Etiquetas comunes entre artículos
  if (articles.length >= 2) {
    var commonTags = articles[0].tags.intersection(articles[1].tags);
    print('\nEtiquetas comunes entre "${articles[0].title}" y "${articles[1].title}":');
    print('  $commonTags');
  }
}
```

---

## PARTE 3: Mapas (Map) (50 minutos)

### 1️⃣ **Creación y Acceso**

```dart
/**
 * What?
 * Map es una colección de pares clave-valor
 *
 * For?
 * Almacenar datos asociativos (diccionarios)
 *
 * Impact?
 * Búsqueda rápida por clave
 */

void main() {
  // Crear maps
  var person = {
    'name': 'Ana García',
    'age': 28,
    'city': 'Madrid',
    'isActive': true,
  };

  // Map con tipos específicos
  Map<String, int> scores = {
    'math': 95,
    'science': 88,
    'history': 92,
  };

  // Map vacío
  var emptyMap = <String, dynamic>{};
  Map<int, String> months = {};

  // Acceder a valores
  print('Nombre: ${person['name']}');
  print('Edad: ${person['age']}');

  // Acceso seguro (retorna null si no existe)
  print('Email: ${person['email']}');  // null

  // Valor por defecto si no existe
  var email = person['email'] ?? 'no-email@example.com';
  print('Email: $email');

  // Modificar valores
  person['age'] = 29;
  person['email'] = 'ana@example.com';  // Agregar nueva clave

  print('\nPerson actualizado: $person');

  // Verificar existencia de clave
  print('¿Tiene nombre? ${person.containsKey('name')}');
  print('¿Tiene teléfono? ${person.containsKey('phone')}');

  // Verificar existencia de valor
  print('¿Tiene valor 28? ${person.containsValue(28)}');
}
```

### 2️⃣ **Iteración y Transformación**

```dart
/**
 * What?
 * Métodos para iterar y transformar maps
 *
 * For?
 * Procesar datos clave-valor eficientemente
 *
 * Impact?
 * Manipulación flexible de datos estructurados
 */

void main() {
  var products = {
    'laptop': 1200.0,
    'mouse': 25.0,
    'keyboard': 80.0,
    'monitor': 350.0,
  };

  // Iterar sobre claves
  print('Productos disponibles:');
  for (var key in products.keys) {
    print('  - $key');
  }

  // Iterar sobre valores
  print('\nPrecios:');
  for (var price in products.values) {
    print('  \$${price.toStringAsFixed(2)}');
  }

  // Iterar sobre pares clave-valor
  print('\nCatálogo completo:');
  for (var entry in products.entries) {
    print('  ${entry.key}: \$${entry.value.toStringAsFixed(2)}');
  }

  // forEach()
  print('\nCon descuento del 10%:');
  products.forEach((name, price) {
    var discounted = price * 0.9;
    print('  $name: \$${discounted.toStringAsFixed(2)}');
  });

  // map() - Transformar (retorna Iterable)
  var productNames = products.keys.map((name) => name.toUpperCase()).toList();
  print('\nNombres en mayúsculas: $productNames');

  // Crear nuevo map transformado
  var discountedProducts = products.map(
    (name, price) => MapEntry(name, price * 0.9)
  );
  print('\nProductos con descuento: $discountedProducts');

  // Filtrar map
  var expensiveProducts = Map.fromEntries(
    products.entries.where((entry) => entry.value > 100)
  );
  print('\nProductos caros (>$100): $expensiveProducts');
}
```

### 3️⃣ **Métodos Avanzados**

```dart
/**
 * What?
 * Operaciones avanzadas con maps
 *
 * For?
 * Manipulación compleja de datos estructurados
 *
 * Impact?
 * Mayor control sobre estructuras de datos
 */

void main() {
  var user = {
    'id': 1,
    'name': 'Carlos',
    'email': 'carlos@example.com',
  };

  // addAll() - Combinar maps
  var additionalInfo = {
    'age': 30,
    'city': 'Barcelona',
    'country': 'España',
  };

  user.addAll(additionalInfo);
  print('Usuario completo: $user');

  // remove() - Eliminar por clave
  user.remove('country');
  print('Sin país: $user');

  // removeWhere() - Eliminar con condición
  user.removeWhere((key, value) => key == 'age');
  print('Sin edad: $user');

  // putIfAbsent() - Agregar solo si no existe
  user.putIfAbsent('phone', () => '+34-600-000-000');
  user.putIfAbsent('email', () => 'nuevo@example.com');  // No se agrega

  print('Con teléfono: $user');

  // update() - Actualizar valor existente
  user.update('id', (value) => value + 100);
  print('ID actualizado: $user');

  // update con valor por defecto si no existe
  user.update(
    'score',
    (value) => value + 10,
    ifAbsent: () => 0,
  );
  print('Con score: $user');

  // clear() - Limpiar map
  // user.clear();
}
```

### 4️⃣ **Maps Anidados y Complejos**

```dart
/**
 * What?
 * Maps que contienen otros maps o estructuras complejas
 *
 * For?
 * Representar datos jerárquicos (JSON-like)
 *
 * Impact?
 * Modelar datos complejos del mundo real
 */

void main() {
  // Datos tipo JSON
  var company = {
    'name': 'Tech Solutions',
    'founded': 2020,
    'employees': [
      {
        'id': 1,
        'name': 'Ana López',
        'position': 'CEO',
        'salary': 150000,
        'skills': ['leadership', 'strategy', 'management'],
      },
      {
        'id': 2,
        'name': 'Carlos Ruiz',
        'position': 'CTO',
        'salary': 140000,
        'skills': ['flutter', 'dart', 'architecture'],
      },
      {
        'id': 3,
        'name': 'María García',
        'position': 'Developer',
        'salary': 80000,
        'skills': ['flutter', 'firebase', 'ui/ux'],
      },
    ],
    'departments': {
      'engineering': ['Carlos Ruiz', 'María García'],
      'management': ['Ana López'],
    },
  };

  // Acceder a datos anidados
  print('Compañía: ${company['name']}');
  print('Fundada en: ${company['founded']}');

  // Acceder a lista dentro del map
  var employees = company['employees'] as List;
  print('\nEmpleados: ${employees.length}');

  for (var employee in employees) {
    var emp = employee as Map;
    print('  - ${emp['name']}: ${emp['position']}');
  }

  // Calcular nómina total
  var totalSalary = employees.fold(0.0, (sum, emp) {
    var e = emp as Map;
    return sum + (e['salary'] as int);
  });
  print('\nNómina total: \$${totalSalary.toStringAsFixed(2)}');

  // Encontrar empleados con skill específico
  var flutterDevs = employees.where((emp) {
    var e = emp as Map;
    var skills = e['skills'] as List;
    return skills.contains('flutter');
  }).toList();

  print('\nDesarrolladores Flutter:');
  for (var dev in flutterDevs) {
    var d = dev as Map;
    print('  - ${d['name']}');
  }

  // Acceder a map anidado
  var departments = company['departments'] as Map;
  print('\nDepartamentos:');
  departments.forEach((dept, members) {
    print('  $dept: ${(members as List).length} miembros');
  });
}
```

### 5️⃣ **Ejemplo Integrador: Sistema de Inventario**

```dart
/**
 * Sistema completo usando Map, List y Set
 * Gestión de inventario con categorías y operaciones
 */

class InventorySystem {
  // Map de productos: id -> detalles
  Map<String, Map<String, dynamic>> products = {};

  // Map de categorías: nombre -> Set de IDs
  Map<String, Set<String>> categories = {};

  void addProduct(String id, String name, double price, String category, int stock) {
    products[id] = {
      'name': name,
      'price': price,
      'category': category,
      'stock': stock,
      'sales': 0,
    };

    // Agregar a categoría
    if (!categories.containsKey(category)) {
      categories[category] = <String>{};
    }
    categories[category]!.add(id);

    print('✓ Producto agregado: $name');
  }

  void updateStock(String id, int quantity) {
    if (products.containsKey(id)) {
      products[id]!['stock'] = quantity;
      print('✓ Stock actualizado: ${products[id]!['name']} = $quantity');
    }
  }

  void registerSale(String id, int quantity) {
    if (products.containsKey(id)) {
      var product = products[id]!;

      if (product['stock'] >= quantity) {
        product['stock'] -= quantity;
        product['sales'] += quantity;
        print('✓ Venta registrada: ${product['name']} x$quantity');
      } else {
        print('✗ Stock insuficiente para ${product['name']}');
      }
    }
  }

  List<Map<String, dynamic>> getProductsByCategory(String category) {
    if (!categories.containsKey(category)) return [];

    return categories[category]!
        .map((id) => {...products[id]!, 'id': id})
        .toList();
  }

  List<Map<String, dynamic>> getLowStock(int threshold) {
    return products.entries
        .where((entry) => entry.value['stock'] <= threshold)
        .map((entry) => {...entry.value, 'id': entry.key})
        .toList();
  }

  Map<String, double> getSalesByCategory() {
    var salesMap = <String, double>{};

    for (var entry in products.entries) {
      var product = entry.value;
      var category = product['category'] as String;
      var revenue = (product['price'] as double) * (product['sales'] as int);

      salesMap[category] = (salesMap[category] ?? 0) + revenue;
    }

    return salesMap;
  }

  void showReport() {
    print('\n╔═══════════════════════════════════════════╗');
    print('║        REPORTE DE INVENTARIO              ║');
    print('╚═══════════════════════════════════════════╝');

    print('\n📦 Total de productos: ${products.length}');
    print('📂 Categorías: ${categories.length}');

    print('\n📊 Productos por categoría:');
    categories.forEach((category, productIds) {
      print('  $category: ${productIds.length} productos');
    });

    print('\n⚠️  Stock bajo (≤5):');
    var lowStock = getLowStock(5);
    if (lowStock.isEmpty) {
      print('  Ninguno');
    } else {
      for (var product in lowStock) {
        print('  ${product['name']}: ${product['stock']} unidades');
      }
    }

    print('\n💰 Ventas por categoría:');
    var sales = getSalesByCategory();
    var totalRevenue = 0.0;

    sales.forEach((category, revenue) {
      print('  $category: \$${revenue.toStringAsFixed(2)}');
      totalRevenue += revenue;
    });

    print('\n💵 Ingresos totales: \$${totalRevenue.toStringAsFixed(2)}');
  }
}

void main() {
  var inventory = InventorySystem();

  // Agregar productos
  inventory.addProduct('P001', 'Laptop HP', 1200.0, 'Electrónica', 10);
  inventory.addProduct('P002', 'Mouse Logitech', 25.0, 'Electrónica', 50);
  inventory.addProduct('P003', 'Camiseta Nike', 45.0, 'Ropa', 30);
  inventory.addProduct('P004', 'Zapatillas Adidas', 120.0, 'Ropa', 15);
  inventory.addProduct('P005', 'Monitor Samsung', 350.0, 'Electrónica', 8);
  inventory.addProduct('P006', 'Libro Dart', 35.0, 'Libros', 3);

  // Registrar ventas
  print('\n═══ VENTAS ═══\n');
  inventory.registerSale('P001', 2);
  inventory.registerSale('P002', 10);
  inventory.registerSale('P003', 5);
  inventory.registerSale('P006', 2);

  // Actualizar stock
  print('\n═══ ACTUALIZACIÓN DE STOCK ═══\n');
  inventory.updateStock('P006', 20);

  // Mostrar reporte
  inventory.showReport();

  // Consultar productos por categoría
  print('\n═══ PRODUCTOS DE ELECTRÓNICA ═══\n');
  var electronics = inventory.getProductsByCategory('Electrónica');
  for (var product in electronics) {
    print('${product['name']}: \$${product['price']} (Stock: ${product['stock']})');
  }
}
```

---

## 📝 Comparación de Colecciones

| Característica            | List       | Set            | Map               |
| ------------------------- | ---------- | -------------- | ----------------- |
| **Orden**                 | Ordenado   | No ordenado    | No ordenado       |
| **Duplicados**            | Sí         | No             | Claves únicas     |
| **Acceso**                | Por índice | Por valor      | Por clave         |
| **Uso típico**            | Secuencias | Valores únicos | Pares clave-valor |
| **Performance búsqueda**  | O(n)       | O(1)           | O(1)              |
| **Performance inserción** | O(1) final | O(1)           | O(1)              |

---

## ✅ Checklist de Comprensión

Al finalizar este módulo deberías poder:

- [ ] Crear y manipular listas
- [ ] Usar map(), where(), reduce(), fold()
- [ ] Ordenar listas con sort()
- [ ] Trabajar con sets y operaciones de conjuntos
- [ ] Crear y acceder a maps
- [ ] Iterar sobre maps con forEach()
- [ ] Transformar maps con map()
- [ ] Trabajar con maps anidados (JSON-like)
- [ ] Elegir la colección correcta según el caso de uso
- [ ] Combinar múltiples colecciones en soluciones complejas

---

## 🔗 Próximo Módulo

**Siguiente tema:**  
[03. Introducción a Flutter](./03-intro-flutter.md) - Comenzaremos con Flutter: instalación, estructura de proyectos y primeros widgets.

---

## 📚 Recursos Adicionales

### Documentación Oficial

- [Dart Collections](https://dart.dev/guides/libraries/library-tour#collections)
- [List API](https://api.dart.dev/stable/dart-core/List-class.html)
- [Set API](https://api.dart.dev/stable/dart-core/Set-class.html)
- [Map API](https://api.dart.dev/stable/dart-core/Map-class.html)

### Ejercicios Prácticos

- Crear un gestor de contactos con Map
- Implementar operaciones de conjuntos con Sets
- Sistema de filtrado de productos con List

---

**⏱️ Tiempo de estudio:** 2 horas  
**📖 Nivel:** Intermedio  
**🎯 Progreso:** 2/3 módulos de la Semana 2 completados
