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

## I

### Immutability

**Definición:** Propiedad de un objeto que no puede ser modificado después de su creación.

**En Dart:** Usar `const` y `final`.

**Ejemplo:**

```dart
// Inmutable
const List<int> numeros = [1, 2, 3];
// numeros.add(4); // ERROR

// Mutable
final List<int> otros = [1, 2, 3];
otros.add(4); // OK, la lista es mutable
// otros = [5, 6]; // ERROR, la variable es final
```

**Ver también:** [const](#const), [final](#final)

---

### Inheritance

**Definición:** Mecanismo que permite crear una clase basada en otra, heredando sus propiedades y métodos.

**Palabra clave:** `extends`

**Ejemplo:**

```dart
class Animal {
  String name;
  
  Animal(this.name);
  
  void makeSound() {
    print('$name hace un sonido');
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);
  
  @override
  void makeSound() {
    print('$name ladra: Woof!');
  }
}
```

**Ver también:** [Override](#override), [Abstract Class](#abstract-class)

---

### Interface

**Definición:** En Dart, toda clase puede usarse como interface. Una clase que implementa una interface debe definir todos sus métodos.

**Palabra clave:** `implements`

**Ejemplo:**

```dart
class Swimmer {
  void swim() {
    print('Nadando');
  }
}

class Flyer {
  void fly() {
    print('Volando');
  }
}

class Duck implements Swimmer, Flyer {
  @override
  void swim() {
    print('El pato nada');
  }
  
  @override
  void fly() {
    print('El pato vuela');
  }
}
```

**Ver también:** [Abstract Class](#abstract-class), [Mixin](#mixin)

---

## L

### Lambda

**Definición:** Función anónima (sin nombre) que se usa como expresión.

**Sinónimo:** Anonymous function, closure.

**Ejemplo:**

```dart
List<int> numeros = [1, 2, 3, 4, 5];

// Lambda en map
var dobles = numeros.map((n) => n * 2);

// Lambda en where
var pares = numeros.where((n) => n % 2 == 0);

// Lambda asignada a variable
var suma = (int a, int b) => a + b;
print(suma(5, 3)); // 8
```

**Ver también:** [Arrow Function](#arrow-function), [Higher-Order Function](#higher-order-function)

---

### late

**Definición:** Modificador que permite declarar una variable no-nullable sin inicializarla inmediatamente.

**Uso:** Cuando sabes que la variable tendrá valor antes de usarse.

**Ejemplo:**

```dart
class User {
  late String name; // Será inicializada después
  
  void init() {
    name = 'Juan'; // Inicialización posterior
  }
  
  void greet() {
    print('Hola $name'); // OK si init() fue llamado antes
  }
}

void main() {
  User user = User();
  user.init();
  user.greet();
}
```

**Ver también:** [Null Safety](#null-safety)

---

### Library

**Definición:** Conjunto de código Dart reutilizable. Se importa con `import`.

**Ejemplos:**

```dart
// Librería core (automática)
// dart:core

// Otras librerías de Dart
import 'dart:async';
import 'dart:math';
import 'dart:io';

// Paquete externo
import 'package:http/http.dart' as http;

// Archivo local
import 'models/user.dart';
```

**Ver también:** [Package](#package), [import](#import)

---

### List

**Definición:** Colección ordenada de elementos. Permite duplicados. Acceso por índice.

**Operaciones:**

```dart
List<int> numeros = [1, 2, 3];

// Agregar
numeros.add(4); // [1, 2, 3, 4]
numeros.addAll([5, 6]); // [1, 2, 3, 4, 5, 6]

// Acceder
print(numeros[0]); // 1
print(numeros.first); // 1
print(numeros.last); // 6

// Eliminar
numeros.remove(3); // Elimina el 3
numeros.removeAt(0); // Elimina índice 0

// Métodos útiles
numeros.map((n) => n * 2); // Transforma
numeros.where((n) => n > 2); // Filtra
numeros.fold(0, (sum, n) => sum + n); // Reduce
```

**Ver también:** [Collection](#collection), [Set](#set), [Map](#map)

---

## M

### Map

**Definición:** Colección de pares clave-valor. Las claves son únicas.

**Uso:** Diccionarios, lookup tables, JSON parsing.

**Ejemplo:**

```dart
Map<String, int> edades = {
  'Ana': 25,
  'Luis': 30,
  'María': 28,
};

// Acceder
print(edades['Ana']); // 25

// Agregar/Modificar
edades['Pedro'] = 35;
edades['Ana'] = 26;

// Eliminar
edades.remove('Luis');

// Iterar
edades.forEach((nombre, edad) {
  print('$nombre tiene $edad años');
});

// Keys y values
print(edades.keys); // (Ana, María, Pedro)
print(edades.values); // (26, 28, 35)
```

**Ver también:** [Collection](#collection), [List](#list)

---

### Method

**Definición:** Función que pertenece a una clase u objeto.

**Tipos:**

```dart
class Calculator {
  // Instance method
  int suma(int a, int b) {
    return a + b;
  }
  
  // Static method
  static int multiplicar(int a, int b) {
    return a * b;
  }
}

void main() {
  Calculator calc = Calculator();
  print(calc.suma(2, 3)); // 5
  print(Calculator.multiplicar(2, 3)); // 6 (sin instancia)
}
```

**Ver también:** [Function](#function), [Class](#class)

---

### Mixin

**Definición:** Forma de reutilizar código de una clase en múltiples jerarquías de clases sin usar herencia.

**Palabra clave:** `mixin`, `with`

**Ejemplo:**

```dart
mixin Swimmer {
  void swim() {
    print('Nadando');
  }
}

mixin Flyer {
  void fly() {
    print('Volando');
  }
}

class Duck with Swimmer, Flyer {
  String name;
  Duck(this.name);
}

void main() {
  Duck duck = Duck('Donald');
  duck.swim(); // Nadando
  duck.fly(); // Volando
}
```

**Ver también:** [Inheritance](#inheritance), [Interface](#interface)

---

## N

### Named Constructor

**Definición:** Constructor con un nombre específico. Una clase puede tener múltiples named constructors.

**Ejemplo:**

```dart
class User {
  String name;
  int age;
  
  // Constructor principal
  User(this.name, this.age);
  
  // Named constructors
  User.guest() : name = 'Guest', age = 0;
  
  User.fromJson(Map<String, dynamic> json) 
      : name = json['name'], 
        age = json['age'];
}

void main() {
  User user1 = User('Ana', 25);
  User user2 = User.guest();
  User user3 = User.fromJson({'name': 'Luis', 'age': 30});
}
```

**Ver también:** [Constructor](#constructor), [Factory Constructor](#factory-constructor)

---

### Named Parameters

**Definición:** Parámetros de función que se pasan por nombre, no por posición.

**Ventajas:** Código más legible, orden flexible.

**Ejemplo:**

```dart
void configurar({
  required String host,
  int port = 80,
  bool ssl = false,
}) {
  print('$host:$port (SSL: $ssl)');
}

void main() {
  configurar(host: 'localhost'); // localhost:80 (SSL: false)
  configurar(host: 'api.example.com', port: 443, ssl: true);
  configurar(ssl: true, host: 'test.com'); // Orden flexible
}
```

**Ver también:** [Optional Parameters](#optional-parameters), [required](#required)

---

### Null Safety

**Definición:** Sistema de tipos que previene errores de null reference en compile-time.

**Introducido en:** Dart 2.12

**Conceptos:**

```dart
// Non-nullable (por defecto)
String name = 'Juan'; // No puede ser null

// Nullable (con ?)
String? apellido; // Puede ser null
apellido = null; // OK

// Null-aware operators
String texto = apellido ?? 'Sin apellido'; // ?? (if-null)
int? longitud = apellido?.length; // ?. (conditional access)
String forzado = apellido!; // ! (null assertion)
```

**Ver también:** [Operators](#null-aware-operators), [late](#late)

---

## O

### Object

**Definición:** Instancia de una clase. Clase base de todos los objetos en Dart.

**Ejemplo:**

```dart
class User {
  String name;
  User(this.name);
}

void main() {
  User user = User('Ana'); // user es un objeto
  
  print(user is Object); // true
  print(user.runtimeType); // User
}
```

**Ver también:** [Class](#class), [Instance](#instance)

---

### Optional Parameters

**Definición:** Parámetros que no son obligatorios al llamar una función.

**Tipos:**

```dart
// Opcionales posicionales (con [])
void saludar(String nombre, [String? apellido]) {
  print('Hola $nombre $apellido');
}

// Opcionales named (con {})
void configurar({String host = 'localhost', int port = 80}) {
  print('$host:$port');
}

void main() {
  saludar('Juan'); // OK
  saludar('Juan', 'Pérez'); // OK
  
  configurar(); // OK
  configurar(port: 443); // OK
}
```

**Ver también:** [Named Parameters](#named-parameters), [required](#required)

---

### Override

**Definición:** Redefinir un método de la clase padre en la clase hija.

**Anotación:** `@override`

**Ejemplo:**

```dart
class Animal {
  void makeSound() {
    print('Algún sonido');
  }
}

class Cat extends Animal {
  @override
  void makeSound() {
    print('Miau');
  }
}

void main() {
  Animal animal = Cat();
  animal.makeSound(); // Miau (polimorfismo)
}
```

**Ver también:** [Inheritance](#inheritance), [Polymorphism](#polymorphism)

---

## P

### Package

**Definición:** Colección de librerías Dart reutilizables publicadas en pub.dev.

**Gestión:** Archivo `pubspec.yaml`

**Ejemplo:**

```yaml
# pubspec.yaml
dependencies:
  http: ^0.13.5
  intl: ^0.18.0
```

```dart
// Usar package
import 'package:http/http.dart' as http;

void main() async {
  var response = await http.get(Uri.parse('https://api.example.com'));
  print(response.body);
}
```

**Ver también:** [Library](#library), [pub.dev](#pubdev)

---

### Property

**Definición:** Variable que pertenece a una clase u objeto.

**Ejemplo:**

```dart
class User {
  // Properties
  String name;
  int age;
  
  User(this.name, this.age);
}

void main() {
  User user = User('Ana', 25);
  print(user.name); // Acceder property
  user.age = 26; // Modificar property
}
```

**Ver también:** [Getter](#getter), [Setter](#setter)

---

## R

### required

**Definición:** Modificador para named parameters que los hace obligatorios.

**Introducido en:** Dart 2.12

**Ejemplo:**

```dart
class User {
  String name;
  int age;
  
  User({
    required this.name, // Obligatorio
    required this.age,   // Obligatorio
  });
}

void main() {
  // User user = User(); // ERROR: faltan parámetros
  User user = User(name: 'Ana', age: 25); // OK
}
```

**Ver también:** [Named Parameters](#named-parameters), [Optional Parameters](#optional-parameters)

---

## S

### Scope

**Definición:** Contexto en el cual una variable es accesible.

**Tipos:**

```dart
int global = 10; // Scope global

void funcion() {
  int local = 20; // Scope local
  
  if (true) {
    int bloque = 30; // Scope de bloque
    print(global); // OK
    print(local); // OK
    print(bloque); // OK
  }
  
  // print(bloque); // ERROR: fuera de scope
}
```

**Ver también:** [Closure](#closure), [Variable](#variable)

---

### Set

**Definición:** Colección no ordenada de elementos únicos (sin duplicados).

**Uso:** Eliminar duplicados, membresía.

**Ejemplo:**

```dart
Set<int> numeros = {1, 2, 3, 2, 1}; // {1, 2, 3}

// Agregar
numeros.add(4); // {1, 2, 3, 4}
numeros.add(3); // {1, 2, 3, 4} (no agrega duplicado)

// Verificar
print(numeros.contains(2)); // true

// Operaciones de conjuntos
Set<int> otros = {3, 4, 5};
print(numeros.union(otros)); // {1, 2, 3, 4, 5}
print(numeros.intersection(otros)); // {3, 4}
```

**Ver también:** [List](#list), [Map](#map)

---

### Setter

**Definición:** Método que se accede como propiedad para asignar un valor con lógica adicional.

**Sintaxis:** `set nombrePropiedad`

**Ejemplo:**

```dart
class Temperature {
  double _celsius = 0;
  
  // Getter
  double get celsius => _celsius;
  double get fahrenheit => _celsius * 9/5 + 32;
  
  // Setter
  set celsius(double value) {
    _celsius = value;
  }
  
  set fahrenheit(double value) {
    _celsius = (value - 32) * 5/9;
  }
}

void main() {
  Temperature temp = Temperature();
  temp.celsius = 25; // Usa setter
  print(temp.fahrenheit); // 77.0
}
```

**Ver también:** [Getter](#getter), [Property](#property)

---

### static

**Definición:** Modificador que hace que un miembro pertenezca a la clase, no a las instancias.

**Uso:** Constantes, utilidades, factory methods.

**Ejemplo:**

```dart
class Math {
  static const double pi = 3.14159;
  
  static int suma(int a, int b) {
    return a + b;
  }
}

void main() {
  print(Math.pi); // Sin crear instancia
  print(Math.suma(5, 3)); // 8
}
```

**Ver también:** [Class](#class), [const](#const)

---

### Stream

**Definición:** Secuencia asíncrona de datos que llegan a lo largo del tiempo.

**Diferencia con Future:** Future retorna un valor, Stream retorna múltiples valores.

**Ejemplo:**

```dart
Stream<int> contadorStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  await for (int valor in contadorStream()) {
    print(valor); // 1, 2, 3, 4, 5 (cada segundo)
  }
}
```

**Ver también:** [Future](#future), [async/await](#asyncawait)

---

### String Interpolation

**Definición:** Insertar valores de variables dentro de strings usando `$` o `${}`.

**Ejemplo:**

```dart
String nombre = 'Ana';
int edad = 25;

print('Hola $nombre'); // Hola Ana
print('En 5 años tendrás ${edad + 5} años'); // En 5 años tendrás 30 años

// Expresiones complejas necesitan {}
List<int> numeros = [1, 2, 3];
print('La lista tiene ${numeros.length} elementos');
```

**Ver también:** [String](#string)

---

## T

### this

**Definición:** Referencia al objeto actual dentro de una clase.

**Uso:** Diferenciar entre parámetros y propiedades.

**Ejemplo:**

```dart
class User {
  String name;
  int age;
  
  User(this.name, this.age); // Shorthand
  
  // Equivalente a:
  // User(String name, int age) {
  //   this.name = name;
  //   this.age = age;
  // }
  
  void describe() {
    print('${this.name} tiene ${this.age} años');
  }
}
```

**Ver también:** [Class](#class), [Constructor](#constructor)

---

### try-catch

**Definición:** Estructura para manejar excepciones y prevenir que el programa termine abruptamente.

**Bloques:** try, catch, on, finally

**Ejemplo:**

```dart
void main() {
  try {
    int resultado = 10 ~/ 0; // División por cero
  } on IntegerDivisionByZeroException {
    print('No se puede dividir por cero');
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Limpieza (siempre se ejecuta)');
  }
}
```

**Ver también:** [Exception](#exception), [Error Handling](#error-handling)

---

### Type Inference

**Definición:** Capacidad de Dart de inferir el tipo de una variable sin declararlo explícitamente.

**Palabra clave:** `var`

**Ejemplo:**

```dart
var nombre = 'Juan'; // Dart infiere String
var edad = 25; // Dart infiere int
var activo = true; // Dart infiere bool

// Equivalente a:
String nombre = 'Juan';
int edad = 25;
bool activo = true;
```

**Ver también:** [var](#var), [dynamic](#dynamic)

---

## V

### var

**Definición:** Palabra clave para declarar variables con inferencia de tipos.

**Ventaja:** Menos verboso, Dart infiere el tipo.

**Ejemplo:**

```dart
var nombre = 'Ana'; // String (inferido)
var edad = 25; // int (inferido)

// Una vez inferido, el tipo no cambia
// nombre = 42; // ERROR: no puede cambiar de String a int
```

**Ver también:** [Type Inference](#type-inference), [dynamic](#dynamic)

---

### void

**Definición:** Tipo de retorno que indica que una función no retorna ningún valor.

**Ejemplo:**

```dart
void saludar(String nombre) {
  print('Hola $nombre');
  // No hay return
}

void main() {
  saludar('Ana');
  var resultado = saludar('Luis'); // resultado es null
}
```

**Ver también:** [Function](#function), [Return](#return)

---

## Símbolos y Operadores

### ?? (If-null operator)

**Definición:** Retorna el operando izquierdo si no es null, sino retorna el derecho.

**Ejemplo:**

```dart
String? nombre;
String resultado = nombre ?? 'Anónimo'; // 'Anónimo'

nombre = 'Ana';
resultado = nombre ?? 'Anónimo'; // 'Ana'
```

---

### ??= (Null-aware assignment)

**Definición:** Asigna valor solo si la variable es null.

**Ejemplo:**

```dart
String? nombre;
nombre ??= 'Por defecto'; // Asigna porque es null
print(nombre); // 'Por defecto'

nombre ??= 'Otro'; // No asigna porque ya tiene valor
print(nombre); // 'Por defecto'
```

---

### ?. (Conditional member access)

**Definición:** Accede a un miembro solo si el objeto no es null.

**Ejemplo:**

```dart
String? nombre;
int? longitud = nombre?.length; // null (no lanza error)

nombre = 'Ana';
longitud = nombre?.length; // 3
```

---

### ! (Null assertion)

**Definición:** Fuerza que un valor nullable sea tratado como non-nullable.

**⚠️ Peligroso:** Lanza error en runtime si el valor es null.

**Ejemplo:**

```dart
String? nombre = 'Ana';
String nombreSeguro = nombre!; // OK

nombre = null;
// nombreSeguro = nombre!; // ERROR en runtime
```

---

### .. (Cascade notation)

**Definición:** Ver [Cascade Notation](#cascade-notation)

---

### => (Arrow syntax)

**Definición:** Ver [Arrow Function](#arrow-function-arrow-syntax)

---

## 📝 Notas Finales

Este glosario cubre los términos fundamentales de Dart para la semana 1. Consulta regularmente mientras programas.

**Recursos adicionales:**
- Documentación oficial: https://dart.dev/guides
- DartPad: https://dartpad.dev/
- API Reference: https://api.dart.dev/

---

_Última actualización: Noviembre 2024_
