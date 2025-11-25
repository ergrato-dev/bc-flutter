# 💻 Práctica 2: Colecciones y Listas en Dart

**⏱️ Duración:** 45 minutos  
**👥 Modalidad:** 🎓 **PRESENCIAL - Con documentación detallada**  
**📊 Dificultad:** ⭐⭐ Intermedio  
**🎯 Conceptos:** List, Set, Map, iteración, métodos de colecciones

---

## 🎯 Objetivo

Dominar el manejo de **colecciones en Dart** (List, Set, Map) y aprender a manipularlas con métodos como `map()`, `where()`, `reduce()`, y más.

**Importante:** Esta práctica se hace **EN CLASE, PASO A PASO** con el instructor.

---

## 📚 Conceptos que Aprenderemos Juntos

- ✅ Trabajar con List (listas/arrays)
- ✅ Usar Set para elementos únicos
- ✅ Manipular Map (diccionarios/objetos)
- ✅ Métodos de colecciones: map, where, reduce, fold
- ✅ Operador spread (...)
- ✅ Collection if y for

---

## 🖥️ Resultado Esperado

Al final de esta práctica, crearás programas que:

1. **Gestionen una lista de estudiantes** con operaciones CRUD
2. **Filtren y transformen datos** usando métodos de colecciones
3. **Calculen estadísticas** sobre conjuntos de datos
4. **Manipulen Maps** para gestionar información estructurada

---

## 📋 Requisitos

### Funcionales:

- [ ] Crear listas de diferentes tipos de datos
- [ ] Agregar, eliminar y modificar elementos
- [ ] Filtrar listas según criterios
- [ ] Transformar colecciones
- [ ] Calcular valores agregados (suma, promedio)
- [ ] Trabajar con Maps anidados

### Técnicos:

- [ ] Uso correcto de tipos genéricos (`List<T>`, `Map<K,V>`)
- [ ] Aplicar métodos inmutables vs mutables
- [ ] Manejar null safety en colecciones
- [ ] Código limpio y bien documentado
- [ ] Usar operadores modernos de Dart

---

## 🚀 Ejercicios Prácticos

### Ejercicio 1: Lista de Estudiantes (10 min)

**Objetivo:** Crear y manipular una lista de estudiantes con sus calificaciones.

```dart
/**
 * Sistema de gestión de estudiantes
 *
 * ¿Qué hace?
 * Maneja una lista de estudiantes con operaciones básicas
 *
 * ¿Para qué?
 * Practicar operaciones CRUD en listas
 *
 * ¿Cómo funciona?
 * 1. Define clase Student
 * 2. Crea lista de estudiantes
 * 3. Implementa operaciones de gestión
 */

class Student {
  final String name;
  final int age;
  final double grade;

  Student(this.name, this.age, this.grade);

  @override
  String toString() => '$name ($age años) - Nota: $grade';
}

void main() {
  // 1. Crear lista de estudiantes
  List<Student> students = [
    Student('Ana García', 20, 8.5),
    Student('Carlos López', 22, 7.8),
    Student('María Silva', 21, 9.2),
    Student('Juan Pérez', 23, 6.5),
  ];

  print('=== Lista Original ===');
  students.forEach(print);

  // 2. Agregar nuevo estudiante
  students.add(Student('Luis Martínez', 20, 8.0));
  print('\n=== Después de agregar ===');
  print('Total estudiantes: ${students.length}');

  // 3. Ordenar por calificación (descendente)
  students.sort((a, b) => b.grade.compareTo(a.grade));
  print('\n=== Ordenados por nota ===');
  students.forEach(print);

  // 4. Buscar estudiante específico
  final encontrado = students.firstWhere(
    (s) => s.name == 'María Silva',
    orElse: () => Student('No encontrado', 0, 0),
  );
  print('\n=== Búsqueda ===');
  print('Encontrado: $encontrado');
}
```

**Salida esperada:**

```
=== Lista Original ===
Ana García (20 años) - Nota: 8.5
Carlos López (22 años) - Nota: 7.8
María Silva (21 años) - Nota: 9.2
Juan Pérez (23 años) - Nota: 6.5

=== Después de agregar ===
Total estudiantes: 5

=== Ordenados por nota ===
María Silva (21 años) - Nota: 9.2
Ana García (20 años) - Nota: 8.5
Luis Martínez (20 años) - Nota: 8.0
Carlos López (22 años) - Nota: 7.8
Juan Pérez (23 años) - Nota: 6.5

=== Búsqueda ===
Encontrado: María Silva (21 años) - Nota: 9.2
```

**📝 Practícalo en DartPad:** https://dartpad.dev

---

### Ejercicio 2: Transformación con map() y where() (10 min)

**Objetivo:** Filtrar y transformar colecciones.

```dart
/**
 * Sistema de análisis de notas
 *
 * ¿Qué hace?
 * Filtra y transforma listas de estudiantes
 *
 * ¿Para qué?
 * Practicar map() y where() - métodos fundamentales
 *
 * ¿Cómo funciona?
 * - where() filtra elementos según condición
 * - map() transforma cada elemento
 */

void main() {
  List<Student> students = [
    Student('Ana García', 20, 8.5),
    Student('Carlos López', 22, 7.8),
    Student('María Silva', 21, 9.2),
    Student('Juan Pérez', 23, 6.5),
    Student('Luis Martínez', 20, 8.0),
  ];

  // 1. Filtrar estudiantes aprobados (>= 7.0)
  final aprobados = students.where((s) => s.grade >= 7.0).toList();
  print('=== Estudiantes Aprobados ===');
  print('Total: ${aprobados.length}');
  aprobados.forEach(print);

  // 2. Filtrar estudiantes sobresalientes (>= 9.0)
  final sobresalientes = students.where((s) => s.grade >= 9.0);
  print('\n=== Estudiantes Sobresalientes ===');
  sobresalientes.forEach(print);

  // 3. Obtener solo los nombres
  final nombres = students.map((s) => s.name).toList();
  print('\n=== Solo Nombres ===');
  print(nombres);

  // 4. Transformar: crear lista de strings descriptivos
  final descripciones = students.map((s) {
    final estado = s.grade >= 7.0 ? 'APROBADO' : 'REPROBADO';
    return '${s.name}: $estado (${s.grade})';
  }).toList();

  print('\n=== Descripciones ===');
  descripciones.forEach(print);

  // 5. Encadenar operaciones: filtrar + transformar
  final aprobadosNombres = students
      .where((s) => s.grade >= 7.0)
      .map((s) => s.name)
      .toList();

  print('\n=== Nombres de Aprobados ===');
  print(aprobadosNombres);
}
```

**Conceptos clave:**

- `where()` retorna un `Iterable`, usa `.toList()` para convertir a lista
- `map()` transforma cada elemento sin modificar la lista original
- Puedes encadenar múltiples operaciones

---

### Ejercicio 3: Cálculos con reduce() y fold() (10 min)

**Objetivo:** Calcular valores agregados sobre colecciones.

```dart
/**
 * Sistema de estadísticas
 *
 * ¿Qué hace?
 * Calcula promedios, sumas y estadísticas sobre colecciones
 *
 * ¿Para qué?
 * Dominar reduce() y fold() para agregaciones
 *
 * ¿Cómo funciona?
 * - reduce() combina elementos en un solo valor
 * - fold() similar pero con valor inicial
 */

void main() {
  List<Student> students = [
    Student('Ana García', 20, 8.5),
    Student('Carlos López', 22, 7.8),
    Student('María Silva', 21, 9.2),
    Student('Juan Pérez', 23, 6.5),
    Student('Luis Martínez', 20, 8.0),
  ];

  // 1. Suma total de calificaciones con reduce()
  final totalGrades = students
      .map((s) => s.grade)
      .reduce((sum, grade) => sum + grade);

  print('=== Estadísticas ===');
  print('Suma total: ${totalGrades.toStringAsFixed(2)}');

  // 2. Promedio de calificaciones
  final promedio = totalGrades / students.length;
  print('Promedio: ${promedio.toStringAsFixed(2)}');

  // 3. Nota más alta con reduce()
  final notaMaxima = students
      .map((s) => s.grade)
      .reduce((max, grade) => grade > max ? grade : max);

  print('Nota máxima: $notaMaxima');

  // 4. Nota más baja
  final notaMinima = students
      .map((s) => s.grade)
      .reduce((min, grade) => grade < min ? grade : min);

  print('Nota mínima: $notaMinima');

  // 5. Usando fold() con valor inicial
  final sumaConFold = students.fold<double>(
    0.0, // valor inicial
    (sum, student) => sum + student.grade,
  );

  print('\nSuma con fold(): ${sumaConFold.toStringAsFixed(2)}');

  // 6. Contar estudiantes por rango de edad con fold()
  final mayoresDeVeintiuno = students.fold<int>(
    0,
    (count, student) => student.age > 21 ? count + 1 : count,
  );

  print('Estudiantes mayores de 21: $mayoresDeVeintiuno');

  // 7. Crear resumen con fold()
  final resumen = students.fold<Map<String, dynamic>>(
    {'total': 0, 'suma': 0.0, 'aprobados': 0},
    (acc, student) {
      acc['total'] = (acc['total'] as int) + 1;
      acc['suma'] = (acc['suma'] as double) + student.grade;
      if (student.grade >= 7.0) {
        acc['aprobados'] = (acc['aprobados'] as int) + 1;
      }
      return acc;
    },
  );

  print('\n=== Resumen General ===');
  print('Total estudiantes: ${resumen['total']}');
  print('Suma notas: ${(resumen['suma'] as double).toStringAsFixed(2)}');
  print('Aprobados: ${resumen['aprobados']}');
  print('Tasa aprobación: ${((resumen['aprobados'] as int) / (resumen['total'] as int) * 100).toStringAsFixed(1)}%');
}
```

**Diferencia clave:**

- `reduce()`: No tiene valor inicial, usa el primer elemento
- `fold()`: Requiere valor inicial, más flexible

---

### Ejercicio 4: Set - Elementos Únicos (8 min)

**Objetivo:** Trabajar con Sets para garantizar unicidad.

```dart
/**
 * Sistema de gestión de tags/etiquetas
 *
 * ¿Qué hace?
 * Maneja conjuntos de etiquetas únicas
 *
 * ¿Para qué?
 * Aprender Set para evitar duplicados
 *
 * ¿Cómo funciona?
 * Set automáticamente elimina duplicados
 */

void main() {
  // 1. Crear Set desde lista con duplicados
  final tags = ['dart', 'flutter', 'mobile', 'dart', 'flutter', 'web'];
  final uniqueTags = Set<String>.from(tags);

  print('=== Tags Únicos ===');
  print('Original: $tags');
  print('Únicos: $uniqueTags');

  // 2. Operaciones con Sets
  final skills1 = {'Dart', 'Flutter', 'Firebase'};
  final skills2 = {'Dart', 'React', 'Node.js'};

  print('\n=== Operaciones entre Sets ===');
  print('Skills 1: $skills1');
  print('Skills 2: $skills2');

  // Unión
  final allSkills = skills1.union(skills2);
  print('Unión: $allSkills');

  // Intersección (habilidades en común)
  final commonSkills = skills1.intersection(skills2);
  print('Intersección: $commonSkills');

  // Diferencia
  final onlyInSkills1 = skills1.difference(skills2);
  print('Solo en Skills1: $onlyInSkills1');

  // 3. Verificar membresía
  print('\n=== Verificaciones ===');
  print('¿Skills1 contiene Dart? ${skills1.contains('Dart')}');
  print('¿Skills1 contiene React? ${skills1.contains('React')}');

  // 4. Convertir entre List y Set
  final numbers = [1, 2, 3, 2, 4, 3, 5];
  final uniqueNumbers = numbers.toSet();
  final backToList = uniqueNumbers.toList()..sort();

  print('\n=== Conversiones ===');
  print('Lista original: $numbers');
  print('Set único: $uniqueNumbers');
  print('Lista ordenada: $backToList');
}
```

**Cuándo usar Set:**

- Necesitas garantizar elementos únicos
- Operaciones de conjuntos (unión, intersección)
- Verificación rápida de membresía

---

### Ejercicio 5: Map - Diccionarios (7 min)

**Objetivo:** Manipular Maps (pares clave-valor).

```dart
/**
 * Sistema de gestión de productos
 *
 * ¿Qué hace?
 * Usa Map para almacenar y buscar productos
 *
 * ¿Para qué?
 * Practicar estructuras clave-valor
 *
 * ¿Cómo funciona?
 * Map asocia claves únicas con valores
 */

void main() {
  // 1. Crear Map de productos (ID -> Nombre)
  final productos = {
    'P001': 'Laptop',
    'P002': 'Mouse',
    'P003': 'Teclado',
    'P004': 'Monitor',
  };

  print('=== Catálogo de Productos ===');
  print(productos);

  // 2. Acceder a valores
  print('\nProducto P001: ${productos['P001']}');
  print('Producto P999: ${productos['P999'] ?? 'No encontrado'}');

  // 3. Agregar y modificar
  productos['P005'] = 'Webcam';
  productos['P002'] = 'Mouse Inalámbrico'; // modificar

  print('\n=== Después de modificar ===');
  print(productos);

  // 4. Iterar sobre Map
  print('\n=== Listado Completo ===');
  productos.forEach((id, nombre) {
    print('$id: $nombre');
  });

  // 5. Map con objetos complejos
  final inventario = <String, Map<String, dynamic>>{
    'P001': {
      'nombre': 'Laptop',
      'precio': 1200.00,
      'stock': 15,
    },
    'P002': {
      'nombre': 'Mouse',
      'precio': 25.99,
      'stock': 50,
    },
    'P003': {
      'nombre': 'Teclado',
      'precio': 89.99,
      'stock': 30,
    },
  };

  print('\n=== Inventario Completo ===');
  inventario.forEach((id, producto) {
    print('$id: ${producto['nombre']} - \$${producto['precio']} (Stock: ${producto['stock']})');
  });

  // 6. Calcular valor total del inventario
  final valorTotal = inventario.values.fold<double>(
    0.0,
    (sum, producto) => sum + (producto['precio'] * producto['stock']),
  );

  print('\n=== Estadísticas ===');
  print('Total productos: ${inventario.length}');
  print('Valor total inventario: \$${valorTotal.toStringAsFixed(2)}');

  // 7. Filtrar productos con poco stock
  final bajoStock = inventario.entries
      .where((entry) => entry.value['stock'] < 20)
      .map((entry) => entry.value['nombre'])
      .toList();

  print('Productos con bajo stock: $bajoStock');
}
```

**Cuándo usar Map:**

- Búsquedas rápidas por clave
- Asociar datos relacionados
- Almacenar configuraciones
- Cachear resultados

---

## 🎯 Desafío Final (Opcional - 10 min)

Crea un **sistema completo de gestión de biblioteca** que combine List, Set y Map:

```dart
/**
 * Sistema de Biblioteca
 * Integra todos los conceptos aprendidos
 */

class Book {
  final String isbn;
  final String title;
  final String author;
  final Set<String> categories;
  final int year;

  Book(this.isbn, this.title, this.author, this.categories, this.year);

  @override
  String toString() => '$title by $author ($year)';
}

void main() {
  final library = [
    Book('123', 'Clean Code', 'Robert Martin', {'programming', 'best-practices'}, 2008),
    Book('456', 'Flutter Complete', 'Max Müller', {'flutter', 'mobile'}, 2022),
    Book('789', 'Dart Mastery', 'Ana López', {'dart', 'programming'}, 2023),
  ];

  // TODO: Implementa las siguientes funcionalidades
  // 1. Buscar libros por categoría
  final programming = library.where((b) => b.categories.contains('programming'));

  // 2. Listar todos los autores únicos
  final authors = library.map((b) => b.author).toSet();

  // 3. Calcular el año promedio de publicación
  final avgYear = library.map((b) => b.year).reduce((a, b) => a + b) / library.length;

  // 4. Crear un Map de ISBN -> Book
  final isbnMap = Map.fromIterable(library, key: (b) => b.isbn, value: (b) => b);

  // 5. Obtener todas las categorías únicas de toda la biblioteca
  final allCategories = library
      .expand((b) => b.categories)
      .toSet();

  print('Libros de programación: $programming');
  print('Autores únicos: $authors');
  print('Año promedio: ${avgYear.toStringAsFixed(0)}');
  print('Categorías: $allCategories');
}
```

---

## ✅ Checklist de Completitud

Verifica que has completado:

- [ ] Ejercicio 1: Lista de Estudiantes
- [ ] Ejercicio 2: map() y where()
- [ ] Ejercicio 3: reduce() y fold()
- [ ] Ejercicio 4: Set - Elementos Únicos
- [ ] Ejercicio 5: Map - Diccionarios
- [ ] Desafío Final (opcional)

---

## 📖 Conceptos Clave Aprendidos

### List (Listas)

```dart
// Crear lista
List<int> numbers = [1, 2, 3];

// Métodos comunes
numbers.add(4);              // agregar
numbers.remove(2);           // eliminar
numbers[0];                  // acceder
numbers.length;              // tamaño
numbers.isEmpty;             // está vacía?
numbers.sort();              // ordenar
```

### Métodos de Transformación

```dart
// map() - transformar elementos
numbers.map((n) => n * 2).toList();

// where() - filtrar
numbers.where((n) => n > 5).toList();

// reduce() - agregar (sin valor inicial)
numbers.reduce((a, b) => a + b);

// fold() - agregar (con valor inicial)
numbers.fold(0, (sum, n) => sum + n);

// expand() - aplanar listas
[[1,2], [3,4]].expand((list) => list); // [1,2,3,4]
```

### Set (Conjuntos)

```dart
Set<String> tags = {'dart', 'flutter'};
tags.add('mobile');
tags.contains('dart');        // true
tags.union(otherSet);         // unión
tags.intersection(otherSet);  // intersección
tags.difference(otherSet);    // diferencia
```

### Map (Diccionarios)

```dart
Map<String, int> ages = {'Juan': 25, 'Ana': 30};
ages['Carlos'] = 28;
ages.keys;                           // claves
ages.values;                         // valores
ages.entries;                        // pares clave-valor
ages.forEach((k, v) => print('$k: $v'));
```

---

## 🚀 Recursos Adicionales

### Documentación Oficial

- [Dart Collections](https://dart.dev/guides/libraries/library-tour#collections)
- [Iterable Collections](https://dart.dev/codelabs/iterables)
- [Effective Dart: Collections](https://dart.dev/guides/language/effective-dart/usage#collections)

### Videos Recomendados

- [Dart Collections Tutorial](https://www.youtube.com/watch?v=IcsxFZh6-s4)
- [List, Set, Map en Dart](https://www.youtube.com/watch?v=F-Y3TXP_hAQ)

---

## 💡 Tips para el Éxito

1. **Practica en DartPad** cada ejercicio inmediatamente
2. **Experimenta** cambiando valores y condiciones
3. **Encadena métodos** para operaciones complejas: `.where().map().toList()`
4. **Usa tipos genéricos** para seguridad de tipos: `List<String>`, `Map<int, User>`
5. **Recuerda**: `map()` y `where()` retornan `Iterable`, usa `.toList()` si necesitas `List`
6. **Null safety**: Usa `??` para valores por defecto cuando accedas a Maps

---

## 🆘 Errores Comunes

### Error 1: Olvidar .toList()

```dart
// ❌ Error: where() retorna Iterable, no List
final filtered = numbers.where((n) => n > 5);
filtered.add(10); // Error!

// ✅ Correcto
final filtered = numbers.where((n) => n > 5).toList();
filtered.add(10); // OK
```

### Error 2: reduce() con lista vacía

```dart
// ❌ Error: reduce() falla si la lista está vacía
final empty = <int>[];
final sum = empty.reduce((a, b) => a + b); // Error!

// ✅ Correcto: usa fold()
final sum = empty.fold(0, (a, b) => a + b); // 0
```

### Error 3: Modificar durante iteración

```dart
// ❌ Error: no modifiques la colección mientras iteras
for (var item in list) {
  list.remove(item); // Error!
}

// ✅ Correcto: usa where()
list = list.where((item) => condition).toList();
```

---

**🎯 Próximo Paso:** Una vez completada esta práctica, avanza a `practica-03-funciones-avanzadas.md`
