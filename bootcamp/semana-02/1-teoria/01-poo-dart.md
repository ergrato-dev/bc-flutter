# 01. Programación Orientada a Objetos en Dart

**Duración:** 2 horas  
**Modalidad:** Teoría + Ejercicios prácticos  
**Objetivo:** Dominar los principios de POO aplicados en Dart

---

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- ✅ Crear clases y objetos en Dart
- ✅ Implementar diferentes tipos de constructores
- ✅ Aplicar herencia y polimorfismo
- ✅ Usar modificadores de acceso y encapsulamiento
- ✅ Trabajar con clases abstractas e interfaces
- ✅ Implementar mixins para reutilización de código
- ✅ Utilizar enumeraciones para valores constantes

---

## PARTE 1: Clases y Objetos (40 minutos)

### 1️⃣ **Definición de Clases**

```dart
/**
 * What?
 * Una clase es un modelo o plantilla para crear objetos
 *
 * For?
 * Agrupar datos relacionados (propiedades) y comportamientos (métodos)
 *
 * Impact?
 * Permite modelar entidades del mundo real en código
 */

// Clase básica
class Person {
  // Propiedades (atributos)
  String name;
  int age;
  String email;

  // Constructor
  Person(this.name, this.age, this.email);

  // Método
  void introduce() {
    print('Hola, soy $name y tengo $age años');
  }

  // Método con retorno
  bool isAdult() {
    return age >= 18;
  }
}

void main() {
  // Crear instancia (objeto)
  var person1 = Person('Ana García', 25, 'ana@example.com');

  // Acceder a propiedades
  print(person1.name);  // Ana García
  print(person1.age);   // 25

  // Llamar métodos
  person1.introduce();  // Hola, soy Ana García y tengo 25 años
  print('¿Es adulto? ${person1.isAdult()}');  // true

  // Crear otro objeto
  var person2 = Person('Luis Torres', 16, 'luis@example.com');
  person2.introduce();
  print('¿Es adulto? ${person2.isAdult()}');  // false
}
```

### 2️⃣ **Constructores**

```dart
/**
 * What?
 * Métodos especiales para inicializar objetos
 *
 * For?
 * Configurar el estado inicial de un objeto al crearlo
 *
 * Impact?
 * Facilita la creación de objetos con diferentes configuraciones
 */

class Product {
  String name;
  double price;
  int stock;
  String? category;  // Opcional

  // Constructor por defecto (shorthand syntax)
  Product(this.name, this.price, this.stock, [this.category]);

  // Constructor nombrado
  Product.fromDiscount(this.name, double originalPrice, double discount, this.stock)
    : price = originalPrice * (1 - discount / 100);

  // Constructor nombrado para productos sin stock
  Product.outOfStock(this.name, this.price)
    : stock = 0,
      category = null;

  // Constructor factory
  factory Product.create(Map<String, dynamic> json) {
    return Product(
      json['name'],
      json['price'],
      json['stock'],
      json['category']
    );
  }

  void displayInfo() {
    print('$name - \$${price.toStringAsFixed(2)} (Stock: $stock)');
    if (category != null) {
      print('Categoría: $category');
    }
  }
}

void main() {
  // Constructor por defecto
  var product1 = Product('Laptop', 1200.00, 5, 'Electrónica');
  product1.displayInfo();

  // Constructor nombrado con descuento
  var product2 = Product.fromDiscount('Mouse', 50.00, 20, 10);
  product2.displayInfo();  // Precio: $40.00 (20% descuento)

  // Constructor nombrado sin stock
  var product3 = Product.outOfStock('Teclado', 80.00);
  product3.displayInfo();

  // Constructor factory desde JSON
  var product4 = Product.create({
    'name': 'Monitor',
    'price': 350.00,
    'stock': 3,
    'category': 'Pantallas'
  });
  product4.displayInfo();
}
```

### 3️⃣ **Getters y Setters**

```dart
/**
 * What?
 * Métodos especiales para acceder y modificar propiedades
 *
 * For?
 * Controlar el acceso a propiedades y agregar lógica de validación
 *
 * Impact?
 * Encapsulamiento y validación de datos
 */

class BankAccount {
  String _accountNumber;  // Propiedad privada
  double _balance;
  String ownerName;

  BankAccount(this._accountNumber, this.ownerName, [this._balance = 0.0]);

  // Getter - leer valor
  double get balance => _balance;

  // Getter calculado
  String get accountInfo => 'Cuenta: $_accountNumber | Titular: $ownerName';

  // Getter para número oculto
  String get maskedAccount => '**** **** ${_accountNumber.substring(_accountNumber.length - 4)}';

  // Setter - modificar con validación
  set balance(double amount) {
    if (amount >= 0) {
      _balance = amount;
    } else {
      print('Error: El balance no puede ser negativo');
    }
  }

  // Métodos de negocio
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Depósito exitoso: +\$${amount.toStringAsFixed(2)}');
    }
  }

  bool withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('Retiro exitoso: -\$${amount.toStringAsFixed(2)}');
      return true;
    } else {
      print('Fondos insuficientes o monto inválido');
      return false;
    }
  }

  void showBalance() {
    print('$accountInfo | Balance: \$${balance.toStringAsFixed(2)}');
  }
}

void main() {
  var account = BankAccount('1234567890', 'María López', 1000.00);

  // Usar getters
  print(account.maskedAccount);  // **** **** 7890
  print(account.accountInfo);

  // Operaciones
  account.deposit(500.00);
  account.withdraw(200.00);
  account.showBalance();

  // Acceder al getter
  print('Balance actual: \$${account.balance}');

  // Intentar setter (si existiera público)
  // account.balance = -100;  // Error de validación
}
```

### 4️⃣ **Keyword `this`**

```dart
/**
 * What?
 * Referencia a la instancia actual del objeto
 *
 * For?
 * Distinguir entre parámetros y propiedades con el mismo nombre
 *
 * Impact?
 * Código más claro y evita conflictos de nombres
 */

class Rectangle {
  double width;
  double height;

  // Constructor con this.
  Rectangle(this.width, this.height);

  // Método que usa this explícitamente
  Rectangle scale(double factor) {
    return Rectangle(this.width * factor, this.height * factor);
  }

  // Método de comparación
  bool isBiggerThan(Rectangle other) {
    return this.area() > other.area();
  }

  double area() => width * height;

  double perimeter() => 2 * (width + height);

  void displayInfo() {
    print('Rectángulo: ${width}x${height}');
    print('Área: ${area()} | Perímetro: ${perimeter()}');
  }
}

void main() {
  var rect1 = Rectangle(10, 5);
  var rect2 = Rectangle(8, 6);

  rect1.displayInfo();
  rect2.displayInfo();

  // Comparar rectángulos
  if (rect1.isBiggerThan(rect2)) {
    print('rect1 tiene mayor área');
  } else {
    print('rect2 tiene mayor área');
  }

  // Escalar rectángulo
  var rect3 = rect1.scale(2);
  rect3.displayInfo();
}
```

---

## PARTE 2: Herencia y Polimorfismo (40 minutos)

### 1️⃣ **Herencia Básica**

```dart
/**
 * What?
 * Una clase (hija) hereda propiedades y métodos de otra clase (padre)
 *
 * For?
 * Reutilizar código y crear jerarquías de clases
 *
 * Impact?
 * Reduce duplicación y organiza el código de forma lógica
 */

// Clase padre (base)
class Animal {
  String name;
  int age;

  Animal(this.name, this.age);

  void eat() {
    print('$name está comiendo');
  }

  void sleep() {
    print('$name está durmiendo');
  }

  void makeSound() {
    print('$name hace un sonido');
  }
}

// Clase hija (derivada)
class Dog extends Animal {
  String breed;

  // Constructor que llama al constructor del padre
  Dog(String name, int age, this.breed) : super(name, age);

  // Override - sobreescribir método del padre
  @override
  void makeSound() {
    print('$name ladra: ¡Guau guau!');
  }

  // Método específico de Dog
  void fetch() {
    print('$name va a buscar la pelota');
  }
}

class Cat extends Animal {
  bool isIndoor;

  Cat(String name, int age, this.isIndoor) : super(name, age);

  @override
  void makeSound() {
    print('$name maúlla: ¡Miau!');
  }

  void scratch() {
    print('$name está arañando');
  }
}

void main() {
  var dog = Dog('Max', 3, 'Golden Retriever');
  var cat = Cat('Luna', 2, true);

  // Métodos heredados
  dog.eat();
  dog.sleep();

  // Métodos sobrescritos
  dog.makeSound();  // ¡Guau guau!
  cat.makeSound();  // ¡Miau!

  // Métodos específicos
  dog.fetch();
  cat.scratch();

  // Información
  print('\nInformación:');
  print('${dog.name} es un ${dog.breed} de ${dog.age} años');
  print('${cat.name} es un gato de ${cat.age} años (¿Interior? ${cat.isIndoor})');
}
```

### 2️⃣ **Clases Abstractas**

```dart
/**
 * What?
 * Clases que no pueden ser instanciadas directamente
 *
 * For?
 * Definir contratos que las clases hijas deben implementar
 *
 * Impact?
 * Estructura clara y obligación de implementar métodos específicos
 */

// Clase abstracta
abstract class Shape {
  String color;

  Shape(this.color);

  // Métodos abstractos (sin implementación)
  double calculateArea();
  double calculatePerimeter();

  // Método concreto (con implementación)
  void displayInfo() {
    print('Forma de color $color');
    print('Área: ${calculateArea().toStringAsFixed(2)}');
    print('Perímetro: ${calculatePerimeter().toStringAsFixed(2)}');
  }
}

class Circle extends Shape {
  double radius;

  Circle(String color, this.radius) : super(color);

  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }

  @override
  double calculatePerimeter() {
    return 2 * 3.14159 * radius;
  }
}

class Square extends Shape {
  double side;

  Square(String color, this.side) : super(color);

  @override
  double calculateArea() {
    return side * side;
  }

  @override
  double calculatePerimeter() {
    return 4 * side;
  }
}

class Triangle extends Shape {
  double base;
  double height;
  double side1, side2, side3;

  Triangle(String color, this.base, this.height,
           this.side1, this.side2, this.side3) : super(color);

  @override
  double calculateArea() {
    return (base * height) / 2;
  }

  @override
  double calculatePerimeter() {
    return side1 + side2 + side3;
  }
}

void main() {
  // No se puede instanciar clase abstracta
  // var shape = Shape('rojo');  // Error!

  List<Shape> shapes = [
    Circle('azul', 5),
    Square('verde', 4),
    Triangle('rojo', 6, 4, 5, 5, 6),
  ];

  print('=== FORMAS GEOMÉTRICAS ===\n');
  for (var shape in shapes) {
    shape.displayInfo();
    print('');
  }
}
```

### 3️⃣ **Polimorfismo**

```dart
/**
 * What?
 * Capacidad de objetos de diferentes clases de responder al mismo método
 *
 * For?
 * Tratar objetos de diferentes tipos de manera uniforme
 *
 * Impact?
 * Código más flexible y extensible
 */

abstract class Employee {
  String name;
  int id;

  Employee(this.name, this.id);

  // Método abstracto
  double calculateSalary();

  void showInfo() {
    print('Empleado: $name (ID: $id)');
    print('Salario: \$${calculateSalary().toStringAsFixed(2)}');
  }
}

class FullTimeEmployee extends Employee {
  double monthlySalary;

  FullTimeEmployee(String name, int id, this.monthlySalary)
    : super(name, id);

  @override
  double calculateSalary() {
    return monthlySalary;
  }
}

class HourlyEmployee extends Employee {
  double hourlyRate;
  int hoursWorked;

  HourlyEmployee(String name, int id, this.hourlyRate, this.hoursWorked)
    : super(name, id);

  @override
  double calculateSalary() {
    return hourlyRate * hoursWorked;
  }
}

class Contractor extends Employee {
  double projectFee;
  int projectsCompleted;

  Contractor(String name, int id, this.projectFee, this.projectsCompleted)
    : super(name, id);

  @override
  double calculateSalary() {
    return projectFee * projectsCompleted;
  }
}

void main() {
  // Lista polimórfica: diferentes tipos de empleados
  List<Employee> employees = [
    FullTimeEmployee('Ana López', 101, 3000),
    HourlyEmployee('Carlos Ruiz', 102, 25, 160),
    Contractor('María García', 103, 1500, 3),
  ];

  print('=== NÓMINA DE EMPLEADOS ===\n');

  double totalSalaries = 0;

  for (var employee in employees) {
    employee.showInfo();  // Polimorfismo en acción
    totalSalaries += employee.calculateSalary();
    print('');
  }

  print('Total nómina: \$${totalSalaries.toStringAsFixed(2)}');
}
```

---

## PARTE 3: Conceptos Avanzados (40 minutos)

### 1️⃣ **Mixins**

```dart
/**
 * What?
 * Forma de reutilizar código en múltiples jerarquías de clases
 *
 * For?
 * Agregar funcionalidad a clases sin usar herencia
 *
 * Impact?
 * Mayor flexibilidad y composición de comportamientos
 */

// Mixins
mixin Swimmer {
  void swim() {
    print('Nadando en el agua');
  }

  void dive() {
    print('Sumergiéndose');
  }
}

mixin Flyer {
  void fly() {
    print('Volando en el cielo');
  }

  void land() {
    print('Aterrizando');
  }
}

mixin Walker {
  void walk() {
    print('Caminando en tierra');
  }

  void run() {
    print('Corriendo');
  }
}

// Clase base
class Animal {
  String name;
  Animal(this.name);
}

// Usar mixins con 'with'
class Duck extends Animal with Swimmer, Flyer, Walker {
  Duck(String name) : super(name);

  void showAbilities() {
    print('\n$name puede:');
  }
}

class Fish extends Animal with Swimmer {
  Fish(String name) : super(name);
}

class Bird extends Animal with Flyer, Walker {
  Bird(String name) : super(name);
}

class Human extends Animal with Walker, Swimmer {
  Human(String name) : super(name);
}

void main() {
  var duck = Duck('Pato Donald');
  duck.showAbilities();
  duck.walk();
  duck.swim();
  duck.fly();

  var fish = Fish('Nemo');
  print('\n${fish.name} puede:');
  fish.swim();
  fish.dive();
  // fish.fly();  // Error: Fish no tiene este método

  var eagle = Bird('Águila');
  print('\n${eagle.name} puede:');
  eagle.fly();
  eagle.walk();

  var person = Human('Juan');
  print('\n${person.name} puede:');
  person.walk();
  person.run();
  person.swim();
}
```

### 2️⃣ **Interfaces (Implicit Interfaces)**

```dart
/**
 * What?
 * En Dart, toda clase define implícitamente una interfaz
 *
 * For?
 * Definir contratos que otras clases deben implementar
 *
 * Impact?
 * Flexibilidad para implementar múltiples interfaces
 */

// Clase que actúa como interfaz
class Printable {
  void printDetails() {
    // Implementación por defecto (opcional)
  }
}

class Saveable {
  void save() {}
  void load() {}
}

// Implementar múltiples interfaces con 'implements'
class Document implements Printable, Saveable {
  String title;
  String content;

  Document(this.title, this.content);

  @override
  void printDetails() {
    print('Documento: $title');
    print('Contenido: $content');
  }

  @override
  void save() {
    print('Guardando documento "$title"...');
  }

  @override
  void load() {
    print('Cargando documento "$title"...');
  }
}

class Image implements Printable, Saveable {
  String filename;
  int width, height;

  Image(this.filename, this.width, this.height);

  @override
  void printDetails() {
    print('Imagen: $filename (${width}x$height)');
  }

  @override
  void save() {
    print('Guardando imagen "$filename"...');
  }

  @override
  void load() {
    print('Cargando imagen "$filename"...');
  }
}

void main() {
  var doc = Document('Informe Q1', 'Resumen financiero del primer trimestre...');
  var img = Image('logo.png', 800, 600);

  // Lista polimórfica con interfaz
  List<Printable> printables = [doc, img];

  print('=== IMPRIMIENDO ELEMENTOS ===\n');
  for (var item in printables) {
    item.printDetails();
    print('');
  }

  // Trabajar con Saveable
  List<Saveable> saveables = [doc, img];

  print('=== GUARDANDO ELEMENTOS ===\n');
  for (var item in saveables) {
    item.save();
  }
}
```

### 3️⃣ **Enumeraciones (Enums)**

```dart
/**
 * What?
 * Tipo especial para representar un conjunto fijo de valores constantes
 *
 * For?
 * Trabajar con opciones predefinidas de forma segura
 *
 * Impact?
 * Código más seguro y legible
 */

// Enum básico
enum Priority {
  low,
  medium,
  high,
  urgent
}

// Enum con propiedades (Dart 2.17+)
enum TaskStatus {
  todo('Por hacer', '⏳'),
  inProgress('En progreso', '🔄'),
  review('En revisión', '👀'),
  done('Completado', '✅'),
  cancelled('Cancelado', '❌');

  final String label;
  final String emoji;

  const TaskStatus(this.label, this.emoji);
}

class Task {
  String title;
  String description;
  Priority priority;
  TaskStatus status;
  DateTime createdAt;

  Task({
    required this.title,
    required this.description,
    this.priority = Priority.medium,
    this.status = TaskStatus.todo,
  }) : createdAt = DateTime.now();

  void updateStatus(TaskStatus newStatus) {
    status = newStatus;
    print('${status.emoji} Tarea "$title" actualizada a: ${status.label}');
  }

  void setPriority(Priority newPriority) {
    priority = newPriority;
    print('Prioridad de "$title" cambiada a: ${priorityLabel()}');
  }

  String priorityLabel() {
    switch (priority) {
      case Priority.low:
        return '🟢 Baja';
      case Priority.medium:
        return '🟡 Media';
      case Priority.high:
        return '🟠 Alta';
      case Priority.urgent:
        return '🔴 Urgente';
    }
  }

  void displayInfo() {
    print('\n📋 $title');
    print('   Descripción: $description');
    print('   Prioridad: ${priorityLabel()}');
    print('   Estado: ${status.emoji} ${status.label}');
    print('   Creada: ${createdAt.toString().substring(0, 16)}');
  }
}

void main() {
  var task1 = Task(
    title: 'Implementar autenticación',
    description: 'Agregar login y registro de usuarios',
    priority: Priority.high,
  );

  var task2 = Task(
    title: 'Actualizar documentación',
    description: 'Documentar nuevas APIs',
    priority: Priority.low,
    status: TaskStatus.inProgress,
  );

  var task3 = Task(
    title: 'Corregir bug crítico',
    description: 'Error en el proceso de pago',
    priority: Priority.urgent,
  );

  // Mostrar tareas
  task1.displayInfo();
  task2.displayInfo();
  task3.displayInfo();

  // Actualizar estados
  print('\n=== ACTUALIZACIONES ===\n');
  task1.updateStatus(TaskStatus.inProgress);
  task1.updateStatus(TaskStatus.review);
  task1.updateStatus(TaskStatus.done);

  task3.setPriority(Priority.high);

  // Trabajar con enums
  print('\n=== ESTADÍSTICAS ===\n');
  print('Total valores en Priority: ${Priority.values.length}');
  print('Valores: ${Priority.values}');
  print('Índice de Priority.high: ${Priority.high.index}');
}
```

---

## 📝 Ejemplo Integrador: Sistema de E-commerce

```dart
/**
 * Ejemplo completo que integra todos los conceptos de POO
 * Sistema de comercio electrónico con productos, carritos y órdenes
 */

// Enum para categorías
enum ProductCategory {
  electronics,
  clothing,
  books,
  food,
  toys
}

// Clase abstracta base
abstract class Product {
  final String id;
  String name;
  double price;
  int stock;
  ProductCategory category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
  });

  // Método abstracto
  double calculateFinalPrice();

  void displayInfo() {
    print('$name - \$${price.toStringAsFixed(2)} (Stock: $stock)');
  }

  bool isAvailable() => stock > 0;
}

// Mixin para productos con descuento
mixin Discountable {
  double applyDiscount(double price, double discountPercent) {
    return price * (1 - discountPercent / 100);
  }
}

// Producto físico
class PhysicalProduct extends Product with Discountable {
  double weight;
  double? discountPercent;

  PhysicalProduct({
    required String id,
    required String name,
    required double price,
    required int stock,
    required ProductCategory category,
    required this.weight,
    this.discountPercent,
  }) : super(id: id, name: name, price: price, stock: stock, category: category);

  @override
  double calculateFinalPrice() {
    if (discountPercent != null && discountPercent! > 0) {
      return applyDiscount(price, discountPercent!);
    }
    return price;
  }

  @override
  void displayInfo() {
    super.displayInfo();
    if (discountPercent != null) {
      print('  Descuento: ${discountPercent}% - Precio final: \$${calculateFinalPrice().toStringAsFixed(2)}');
    }
    print('  Peso: ${weight}kg');
  }
}

// Producto digital
class DigitalProduct extends Product {
  String downloadUrl;
  int fileSizeMB;

  DigitalProduct({
    required String id,
    required String name,
    required double price,
    required this.downloadUrl,
    required this.fileSizeMB,
  }) : super(
    id: id,
    name: name,
    price: price,
    stock: 999999,  // Stock ilimitado
    category: ProductCategory.electronics,
  );

  @override
  double calculateFinalPrice() => price;

  @override
  void displayInfo() {
    super.displayInfo();
    print('  Tamaño: ${fileSizeMB}MB - Digital');
  }
}

// Carrito de compras
class ShoppingCart {
  Map<String, int> _items = {};  // productId -> cantidad
  List<Product> _products;

  ShoppingCart(this._products);

  void addItem(String productId, int quantity) {
    var product = _products.firstWhere((p) => p.id == productId);

    if (product.stock >= quantity) {
      _items[productId] = (_items[productId] ?? 0) + quantity;
      print('✓ Agregado: ${product.name} x$quantity');
    } else {
      print('✗ Stock insuficiente para ${product.name}');
    }
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      var product = _products.firstWhere((p) => p.id == productId);
      print('✓ Eliminado: ${product.name}');
      _items.remove(productId);
    }
  }

  double getTotal() {
    double total = 0;
    for (var entry in _items.entries) {
      var product = _products.firstWhere((p) => p.id == entry.key);
      total += product.calculateFinalPrice() * entry.value;
    }
    return total;
  }

  void showCart() {
    print('\n🛒 CARRITO DE COMPRAS');
    print('=' * 50);

    if (_items.isEmpty) {
      print('Carrito vacío');
      return;
    }

    for (var entry in _items.entries) {
      var product = _products.firstWhere((p) => p.id == entry.key);
      var quantity = entry.value;
      var subtotal = product.calculateFinalPrice() * quantity;

      print('${product.name} x$quantity');
      print('  Precio unitario: \$${product.calculateFinalPrice().toStringAsFixed(2)}');
      print('  Subtotal: \$${subtotal.toStringAsFixed(2)}');
    }

    print('=' * 50);
    print('TOTAL: \$${getTotal().toStringAsFixed(2)}');
  }

  int get itemCount => _items.values.reduce((a, b) => a + b);
}

void main() {
  print('=== SISTEMA DE E-COMMERCE ===\n');

  // Crear productos
  var products = <Product>[
    PhysicalProduct(
      id: 'P001',
      name: 'Laptop HP',
      price: 1200.00,
      stock: 5,
      category: ProductCategory.electronics,
      weight: 2.5,
      discountPercent: 10,
    ),
    PhysicalProduct(
      id: 'P002',
      name: 'Camiseta Nike',
      price: 45.00,
      stock: 20,
      category: ProductCategory.clothing,
      weight: 0.3,
    ),
    DigitalProduct(
      id: 'D001',
      name: 'Curso Flutter',
      price: 99.00,
      downloadUrl: 'https://example.com/curso',
      fileSizeMB: 2500,
    ),
  ];

  // Mostrar catálogo
  print('📦 CATÁLOGO DE PRODUCTOS\n');
  for (var product in products) {
    product.displayInfo();
    print('');
  }

  // Crear carrito y agregar productos
  var cart = ShoppingCart(products);

  cart.addItem('P001', 1);
  cart.addItem('P002', 2);
  cart.addItem('D001', 1);

  cart.showCart();

  print('\n✓ Productos en carrito: ${cart.itemCount}');
}
```

---

## ✅ Checklist de Comprensión

Al finalizar este módulo deberías poder:

- [ ] Crear clases con propiedades y métodos
- [ ] Usar diferentes tipos de constructores
- [ ] Implementar getters y setters
- [ ] Aplicar herencia con `extends`
- [ ] Sobreescribir métodos con `@override`
- [ ] Crear y usar clases abstractas
- [ ] Implementar interfaces con `implements`
- [ ] Usar mixins con `with`
- [ ] Trabajar con enumeraciones
- [ ] Entender el polimorfismo
- [ ] Aplicar encapsulamiento con `_`

---

## 🔗 Próximo Módulo

**Siguiente tema:**  
[02. Colecciones y Estructuras de Datos](./02-colecciones-estructuras.md) - Aprenderemos a trabajar con List, Set, Map y métodos avanzados de colecciones.

---

## 📚 Recursos Adicionales

### Documentación Oficial

- [Dart Classes](https://dart.dev/guides/language/language-tour#classes)
- [Dart Constructors](https://dart.dev/guides/language/language-tour#constructors)
- [Dart Mixins](https://dart.dev/guides/language/language-tour#adding-features-to-a-class-mixins)
- [Effective Dart: Design](https://dart.dev/guides/language/effective-dart/design)

### Videos Recomendados

- [Dart OOP - Flutter Official](https://www.youtube.com/watch?v=AqD97w_ofVw)
- [Classes in Dart - The Net Ninja](https://www.youtube.com/watch?v=vFjkqZUi2wI)

---

**⏱️ Tiempo de estudio:** 2 horas  
**📖 Nivel:** Intermedio  
**🎯 Progreso:** 1/3 módulos de la Semana 2 completados
