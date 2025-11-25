# 📖 Glosario - Semana 1: Introducción a Dart

Términos técnicos, conceptos clave y definiciones del vocabulario de Dart y programación fundamental.

---

## 🎯 Cómo Usar Este Glosario

- 📚 **Consulta rápida:** Busca términos específicos con Ctrl+F
- 🔤 **Orden alfabético:** Términos organizados de A-Z
- 💡 **Ejemplos:** Todos los términos incluyen ejemplos de código en Dart
- 🔗 **Referencias cruzadas:** Links entre términos relacionados

---

## A

### Abstract Class

**Definición:** Clase que no puede ser instanciada directamente y que puede contener métodos abstractos (sin implementación).

**Uso en Dart:** Para definir contratos que otras clases deben implementar.

**Ejemplo:**

```dart
abstract class Animal {
  void makeSound(); // Método abstracto
  
  void sleep() { // Método concreto
    print('Zzz...');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Woof!');
  }
}
```

**Ver también:** [Interface](#interface), [Inheritance](#inheritance)

---

### Arrow Function (Arrow Syntax)

**Definición:** Sintaxis corta para funciones que contienen una sola expresión. Usa `=>` en lugar de llaves `{}`.

**Ventajas:** Código más limpio y conciso.

**Ejemplo:**

```dart
// Función tradicional
int suma(int a, int b) {
  return a + b;
}

// Arrow function
int suma(int a, int b) => a + b;

// En colecciones
List<int> numeros = [1, 2, 3, 4];
List<int> dobles = numeros.map((n) => n * 2).toList();
```

**Ver también:** [Function](#function), [Lambda](#lambda)

---

### async/await

**Definición:** Palabras clave para trabajar con código asíncrono de forma legible, como si fuera síncrono.

**Uso en Dart:** Para operaciones que toman tiempo (API calls, lectura de archivos, etc.).

**Ejemplo:**

```dart
Future<String> fetchUserName() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Juan Pérez';
}

void main() async {
  print('Cargando...');
  String nombre = await fetchUserName();
  print('Usuario: $nombre');
}
```

**Ver también:** [Future](#future), [Stream](#stream)

---

## C

### Cascade Notation (..)

**Definición:** Operador que permite realizar múltiples operaciones sobre el mismo objeto sin repetir la variable.

**Sintaxis:** `..`

**Ejemplo:**

```dart
class Person {
  String? name;
  int? age;
  
  void describe() {
    print('$name tiene $age años');
  }
}

void main() {
  Person person = Person()
    ..name = 'Ana'
    ..age = 25
    ..describe(); // Ana tiene 25 años
}
```

**Ver también:** [Method Chaining](#method-chaining)

---

### Class

**Definición:** Plantilla para crear objetos que agrupa datos (propiedades) y comportamiento (métodos).

**Ejemplo:**

```dart
class User {
  // Propiedades
  String name;
  int age;
  
  // Constructor
  User(this.name, this.age);
  
  // Named constructor
  User.guest() : name = 'Guest', age = 0;
  
  // Método
  void greet() {
    print('Hola, soy $name');
  }
}

void main() {
  User user1 = User('Pedro', 30);
  User user2 = User.guest();
  
  user1.greet(); // Hola, soy Pedro
}
```

**Ver también:** [Constructor](#constructor), [Object](#object)

---

### Closure

**Definición:** Función que captura y recuerda variables de su scope exterior, incluso después de que ese scope termine.

**Uso:** Callbacks, factory functions, encapsulación.

**Ejemplo:**

```dart
Function makeCounter() {
  int count = 0;
  
  return () {
    count++;
    return count;
  };
}

void main() {
  var counter = makeCounter();
  print(counter()); // 1
  print(counter()); // 2
  print(counter()); // 3
}
```

**Ver también:** [Function](#function), [Scope](#scope)

---

### Collection

**Definición:** Estructura de datos que agrupa múltiples elementos. En Dart: List, Set, Map.

**Tipos:**

```dart
// List (ordenada, permite duplicados)
List<int> numeros = [1, 2, 3, 4];

// Set (no ordenado, sin duplicados)
Set<String> colores = {'rojo', 'azul', 'verde'};

// Map (key-value pairs)
Map<String, int> edades = {
  'Ana': 25,
  'Luis': 30,
};
```

**Ver también:** [List](#list), [Set](#set), [Map](#map)

---

### const

**Definición:** Palabra clave que crea constantes en tiempo de compilación. El valor debe conocerse antes de ejecutar el programa.

**Diferencia con final:** `const` es más restrictivo, el valor debe ser constante en compilación.

**Ejemplo:**

```dart
const double pi = 3.14159; // OK
const String nombre = 'Juan'; // OK

// const int edad = obtenerEdad(); // ERROR: debe ser constante

const List<int> numeros = [1, 2, 3]; // Lista inmutable
// numeros.add(4); // ERROR: no se puede modificar
```

**Ver también:** [final](#final), [Immutability](#immutability)

---

### Constructor

**Definición:** Método especial que se ejecuta al crear una instancia de una clase.

**Tipos en Dart:**

```dart
class User {
  String name;
  int age;
  
  // Constructor principal
  User(this.name, this.age);
  
  // Named constructor
  User.guest() : name = 'Guest', age = 0;
  
  // Factory constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'], json['age']);
  }
}
```

**Ver también:** [Class](#class), [Factory](#factory-constructor)

---

## D

### dart:core

**Definición:** Librería fundamental de Dart importada automáticamente. Contiene tipos básicos, colecciones, etc.

**Contenido:** Object, int, double, String, bool, List, Map, Set, DateTime, etc.

**Ejemplo:**

```dart
// No necesitas importar dart:core
void main() {
  String texto = 'Hola'; // String de dart:core
  int numero = 42; // int de dart:core
  List<int> lista = [1, 2, 3]; // List de dart:core
}
```

**Ver también:** [dart:async](#dartasync), [Library](#library)

---

### DartPad

**Definición:** Editor online oficial de Dart para escribir, ejecutar y compartir código sin instalar nada.

**URL:** https://dartpad.dev/

**Uso:** Practicar, experimentar, compartir ejemplos.

**Ver también:** [Dart SDK](#dart-sdk)

---

### dynamic

**Definición:** Tipo especial que desactiva el type checking estático. La variable puede contener cualquier tipo.

**⚠️ Evitar cuando sea posible:** Pierde los beneficios del tipado fuerte.

**Ejemplo:**

```dart
dynamic variable = 'texto';
variable = 42; // OK, puede cambiar de tipo
variable = true; // OK

// Problema: no hay autocompletado ni type checking
print(variable.length); // Puede fallar en runtime
```

**Ver también:** [Type Safety](#type-safety), [var](#var)

---

## E

### enum

**Definición:** Tipo especial para definir un conjunto fijo de valores constantes.

**Uso:** Estados, categorías, opciones limitadas.

**Ejemplo:**

```dart
enum Priority {
  low,
  medium,
  high,
}

class Task {
  String title;
  Priority priority;
  
  Task(this.title, this.priority);
}

void main() {
  Task task = Task('Estudiar Dart', Priority.high);
  
  if (task.priority == Priority.high) {
    print('¡Urgente!');
  }
}
```

**Ver también:** [const](#const)

---

### Exception

**Definición:** Objeto que representa un error o condición excepcional durante la ejecución.

**Manejo:**

```dart
void divide(int a, int b) {
  if (b == 0) {
    throw Exception('No se puede dividir por cero');
  }
  print(a / b);
}

void main() {
  try {
    divide(10, 0);
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Operación finalizada');
  }
}
```

**Ver también:** [try-catch](#try-catch), [Error Handling](#error-handling)

---

## F

### factory Constructor

**Definición:** Constructor especial que puede retornar una instancia existente o crear una nueva según lógica personalizada.

**Uso:** Singleton, cache de instancias, parsing.

**Ejemplo:**

```dart
class Database {
  static Database? _instance;
  
  factory Database() {
    _instance ??= Database._internal();
    return _instance!;
  }
  
  Database._internal();
}

void main() {
  var db1 = Database();
  var db2 = Database();
  print(db1 == db2); // true, misma instancia
}
```

**Ver también:** [Constructor](#constructor), [Singleton](#singleton)

---

### final

**Definición:** Palabra clave para variables que solo pueden asignarse una vez, pero el valor puede determinarse en runtime.

**Diferencia con const:** `final` se asigna en runtime, `const` en compile-time.

**Ejemplo:**

```dart
final String nombre = 'Juan'; // OK
final int edad = DateTime.now().year - 1995; // OK, calculado en runtime

// nombre = 'Pedro'; // ERROR: no se puede reasignar

final List<int> numeros = [1, 2, 3];
numeros.add(4); // OK, la lista puede modificarse
// numeros = [5, 6]; // ERROR: no se puede reasignar la variable
```

**Ver también:** [const](#const), [Immutability](#immutability)

---

### Function

**Definición:** Bloque de código reutilizable que realiza una tarea específica.

**Tipos en Dart:**

```dart
// Función con tipo de retorno
int suma(int a, int b) {
  return a + b;
}

// Función sin retorno
void saludar(String nombre) {
  print('Hola $nombre');
}

// Parámetros opcionales posicionales
int multiplicar(int a, [int b = 1]) {
  return a * b;
}

// Parámetros named
void configurar({required String host, int port = 80}) {
  print('$host:$port');
}
```

**Ver también:** [Arrow Function](#arrow-function), [Parameters](#parameters)

---

### Future

**Definición:** Representa un valor que estará disponible en el futuro (operación asíncrona).

**Estados:** uncompleted, completed (con valor o error).

**Ejemplo:**

```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Datos cargados';
}

void main() async {
  print('Iniciando...');
  String datos = await fetchData();
  print(datos);
}
```

**Ver también:** [async/await](#asyncawait), [Stream](#stream)

---

## G

### Getter

**Definición:** Método que se accede como propiedad para obtener un valor calculado.

**Sintaxis:** `get nombrePropiedad`

**Ejemplo:**

```dart
class Rectangle {
  double width;
  double height;
  
  Rectangle(this.width, this.height);
  
  // Getter
  double get area => width * height;
  double get perimeter => 2 * (width + height);
}

void main() {
  Rectangle rect = Rectangle(5, 3);
  print(rect.area); // 15.0 (sin paréntesis)
}
```

**Ver también:** [Setter](#setter), [Property](#property)

---

Continúa en la siguiente parte...
