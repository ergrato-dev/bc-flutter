# 📖 Glosario Técnico - Semana 02

> **POO, Colecciones y Flutter Básico**  
> **Total de términos**: 50+  
> **Organización**: Alfabética con categorías

---

## 🎯 Cómo Usar este Glosario

- **Durante el estudio**: Consulta términos desconocidos
- **Antes de prácticas**: Revisa conceptos clave
- **En proyectos**: Referencia rápida de sintaxis
- **Para exámenes**: Repaso sistemático

**Convenciones**:
- 📦 = Término de POO
- 📚 = Término de Colecciones
- 🎨 = Término de Flutter
- ⚙️ = Término general de Dart

---

## A

### abstract (📦)
**Definición**: Palabra clave para declarar clases o métodos que no pueden ser instanciados directamente y deben ser implementados por subclases.

**Sintaxis**:
```dart
abstract class Animal {
  void makeSound(); // Método abstracto
}
```

**Cuándo usar**: Cuando defines un contrato que otras clases deben cumplir.

**Ver también**: [implements](#implements), [extends](#extends)

---

### AppBar (🎨)
**Definición**: Widget de Material Design que muestra una barra superior con título, acciones y navegación.

**Sintaxis**:
```dart
AppBar(
  title: Text('Mi App'),
  actions: [IconButton(...)],
)
```

**Cuándo usar**: En casi todas las pantallas de una app Material.

**Ver también**: [Scaffold](#scaffold), [Material](#material)

---

### async/await (⚙️)
**Definición**: Palabras clave para manejar código asíncrono de forma secuencial.

**Sintaxis**:
```dart
Future<void> fetchData() async {
  final data = await apiCall();
}
```

**Cuándo usar**: Para operaciones que toman tiempo (red, archivos, etc.).

**Ver también**: [Future](#future), [Stream](#stream)

---

## B

### build() (🎨)
**Definición**: Método obligatorio en widgets que retorna la estructura de UI.

**Sintaxis**:
```dart
@override
Widget build(BuildContext context) {
  return Container(...);
}
```

**Cuándo usar**: En todos los widgets (StatelessWidget y StatefulWidget).

**Ver también**: [Widget](#widget), [StatelessWidget](#statelesswidget)

---

### BuildContext (🎨)
**Definición**: Objeto que contiene información sobre la ubicación de un widget en el árbol.

**Uso común**:
```dart
Theme.of(context)
Navigator.of(context)
MediaQuery.of(context)
```

**Cuándo usar**: Para acceder a funcionalidad del árbol de widgets.

**Ver también**: [build()](#build), [of()](#of)

---

## C

### class (📦)
**Definición**: Plantilla para crear objetos con propiedades y métodos.

**Sintaxis**:
```dart
class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  void greet() => print('Hola, soy $name');
}
```

**Cuándo usar**: Para modelar entidades y organizar código.

**Ver también**: [object](#object), [constructor](#constructor)

---

### Column (🎨)
**Definición**: Widget que organiza hijos verticalmente.

**Sintaxis**:
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Item 1'),
    Text('Item 2'),
  ],
)
```

**Cuándo usar**: Para layouts verticales.

**Ver también**: [Row](#row), [Flex](#flex)

---

### const (⚙️)
**Definición**: Palabra clave para valores constantes en tiempo de compilación.

**Sintaxis**:
```dart
const myWidget = Text('Constante');
const pi = 3.14159;
```

**Cuándo usar**: Para valores que nunca cambian (mejora performance).

**Ver también**: [final](#final), [immutable](#immutable)

---

### constructor (📦)
**Definición**: Método especial que inicializa objetos de una clase.

**Tipos**:
```dart
// Constructor por defecto
Person(this.name, this.age);

// Constructor nombrado
Person.guest() : name = 'Invitado', age = 0;

// Constructor factory
factory Person.fromJson(Map<String, dynamic> json) {
  return Person(json['name'], json['age']);
}
```

**Cuándo usar**: Para inicializar objetos con valores específicos.

**Ver también**: [class](#class), [factory](#factory)

---

### Container (🎨)
**Definición**: Widget versátil para crear cajas con decoración, padding, margen, etc.

**Sintaxis**:
```dart
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
  padding: EdgeInsets.all(16),
  child: Text('Contenido'),
)
```

**Cuándo usar**: Para diseño de cajas, espaciado, decoración.

**Ver también**: [SizedBox](#sizedbox), [DecoratedBox](#decoratedbox)

---

## D

### Dart (⚙️)
**Definición**: Lenguaje de programación desarrollado por Google, base de Flutter.

**Características**:
- Orientado a objetos
- Strongly typed
- Null safety
- Compilado y JIT

**Ver también**: [Flutter](#flutter), [SDK](#sdk)

---

### dynamic (⚙️)
**Definición**: Tipo que desactiva el chequeo de tipos en tiempo de compilación.

**Sintaxis**:
```dart
dynamic variable = 'String';
variable = 42; // OK, pero no recomendado
```

**Cuándo usar**: Evitar su uso; preferir tipos específicos.

**Ver también**: [Object](#object-type), [var](#var)

---

## E

### enum (⚙️)
**Definición**: Tipo especial para representar un conjunto fijo de valores.

**Sintaxis**:
```dart
enum Status {
  pending,
  active,
  completed,
}

Status current = Status.active;
```

**Cuándo usar**: Para estados, categorías, opciones limitadas.

**Ver también**: [switch](#switch), [values](#values)

---

### extends (📦)
**Definición**: Palabra clave para crear una clase que hereda de otra.

**Sintaxis**:
```dart
class Dog extends Animal {
  @override
  void makeSound() => print('Woof!');
}
```

**Cuándo usar**: Para reutilizar código y crear jerarquías.

**Ver también**: [abstract](#abstract), [super](#super)

---

## F

### factory (📦)
**Definición**: Constructor especial que puede retornar una instancia existente.

**Sintaxis**:
```dart
class Singleton {
  static final Singleton _instance = Singleton._internal();
  
  factory Singleton() => _instance;
  
  Singleton._internal();
}
```

**Cuándo usar**: Singleton, cache de objetos, lógica compleja de creación.

**Ver también**: [constructor](#constructor), [static](#static)

---

### final (⚙️)
**Definición**: Palabra clave para variables que se asignan una sola vez.

**Sintaxis**:
```dart
final String name = 'Juan';
final now = DateTime.now(); // Tipo inferido
```

**Cuándo usar**: Para valores que no cambiarán después de inicialización.

**Ver también**: [const](#const), [late](#late)

---

### Flutter (🎨)
**Definición**: Framework de Google para crear apps nativas multiplataforma.

**Características**:
- Usa Dart
- Hot reload
- Widget-based
- Multiplataforma (iOS, Android, Web, Desktop)

**Ver también**: [Dart](#dart), [Widget](#widget)

---

### Future (⚙️)
**Definición**: Objeto que representa un valor o error que estará disponible en el futuro.

**Sintaxis**:
```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data';
}
```

**Cuándo usar**: Operaciones asíncronas.

**Ver también**: [async/await](#asyncawait), [Stream](#stream)

---

## G

### getter (📦)
**Definición**: Método que accede a una propiedad privada.

**Sintaxis**:
```dart
class Circle {
  double radius;
  
  double get area => 3.14 * radius * radius;
}
```

**Cuándo usar**: Para propiedades calculadas o acceso controlado.

**Ver también**: [setter](#setter), [encapsulation](#encapsulation)

---

## H

### Hot Reload (🎨)
**Definición**: Característica de Flutter que actualiza la UI sin perder el estado.

**Uso**:
- Guarda el archivo (Cmd/Ctrl + S)
- Presiona `r` en terminal
- Cambios visuales reflejados instantáneamente

**Cuándo usar**: Durante desarrollo para ver cambios rápidamente.

**Ver también**: [Hot Restart](#hot-restart), [Flutter](#flutter)

---

### Hot Restart (🎨)
**Definición**: Reinicia la app completamente, perdiendo el estado.

**Uso**:
- Presiona `R` en terminal
- Shift + Cmd/Ctrl + F5 en VS Code

**Cuándo usar**: Para cambios en `main()`, inicialización.

**Ver también**: [Hot Reload](#hot-reload)

---

## I

### implements (📦)
**Definición**: Palabra clave para implementar una interfaz (clase abstracta).

**Sintaxis**:
```dart
class Dog implements Animal {
  @override
  void makeSound() => print('Woof!');
}
```

**Cuándo usar**: Para contratos, múltiples interfaces.

**Ver también**: [abstract](#abstract), [extends](#extends)

---

### immutable (🎨)
**Definición**: Concepto de objetos que no pueden cambiar después de creación.

**Sintaxis**:
```dart
@immutable
class Person {
  final String name;
  const Person(this.name);
}
```

**Cuándo usar**: En widgets y clases que no deben mutar.

**Ver también**: [const](#const), [final](#final)

---

## L

### late (⚙️)
**Definición**: Modificador que indica que una variable se inicializará después.

**Sintaxis**:
```dart
late String description;

void init() {
  description = 'Inicializado';
}
```

**Cuándo usar**: Inicialización diferida, pero garantizada.

**Ver también**: [final](#final), [nullable](#nullable)

---

### List (📚)
**Definición**: Colección ordenada de elementos.

**Sintaxis**:
```dart
List<int> numbers = [1, 2, 3];
numbers.add(4);
final first = numbers[0];
```

**Métodos comunes**: `add`, `remove`, `map`, `where`, `sort`

**Cuándo usar**: Para secuencias ordenadas de datos.

**Ver también**: [Set](#set), [Map](#map-collection)

---

## M

### main() (⚙️)
**Definición**: Función de entrada de toda aplicación Dart/Flutter.

**Sintaxis**:
```dart
void main() {
  runApp(MyApp());
}
```

**Cuándo usar**: Punto de inicio obligatorio.

**Ver también**: [runApp()](#runapp)

---

### Map (📚)
**Definición**: Colección de pares clave-valor.

**Sintaxis**:
```dart
Map<String, int> ages = {
  'Juan': 25,
  'María': 30,
};
ages['Pedro'] = 28;
```

**Métodos comunes**: `[]`, `[]=`, `keys`, `values`, `entries`

**Cuándo usar**: Para asociaciones clave-valor.

**Ver también**: [List](#list), [Set](#set)

---

### Material (🎨)
**Definición**: Sistema de diseño de Google implementado en Flutter.

**Componentes**: AppBar, Card, Button, etc.

**Uso**:
```dart
MaterialApp(
  theme: ThemeData(...),
  home: Scaffold(...),
)
```

**Cuándo usar**: Para apps con estilo Android/Material Design.

**Ver también**: [Cupertino](#cupertino), [Widget](#widget)

---

### MaterialApp (🎨)
**Definición**: Widget raíz para apps Material Design.

**Sintaxis**:
```dart
MaterialApp(
  title: 'Mi App',
  theme: ThemeData(...),
  home: HomeScreen(),
)
```

**Cuándo usar**: En la raíz de apps Material.

**Ver también**: [CupertinoApp](#cupertinoapp), [Scaffold](#scaffold)

---

### mixin (📦)
**Definición**: Forma de reutilizar código en múltiples jerarquías de clases.

**Sintaxis**:
```dart
mixin Swimming {
  void swim() => print('Swimming');
}

class Duck extends Animal with Swimming {}
```

**Cuándo usar**: Compartir comportamiento sin herencia.

**Ver también**: [with](#with), [extends](#extends)

---

## N

### Navigator (🎨)
**Definición**: Gestor de rutas y navegación entre pantallas.

**Sintaxis**:
```dart
// Ir a nueva pantalla
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);

// Volver
Navigator.pop(context);
```

**Cuándo usar**: Para navegación entre pantallas.

**Ver también**: [Route](#route), [MaterialPageRoute](#materialpageroute)

---

### null (⚙️)
**Definición**: Valor que representa ausencia de valor.

**Sintaxis**:
```dart
String? nullable = null; // Puede ser null
String nonNull = 'value'; // No puede ser null
```

**Cuándo usar**: Con null safety (? y !).

**Ver también**: [nullable](#nullable), [null safety](#null-safety)

---

## O

### Object (📦)
**Definición**: Instancia de una clase.

**Sintaxis**:
```dart
Person person = Person('Juan', 25);
// person es un objeto de la clase Person
```

**Cuándo usar**: Siempre que creas una instancia.

**Ver también**: [class](#class), [instance](#instance)

---

### @override (📦)
**Definición**: Anotación que indica que un método sobrescribe uno de la superclase.

**Sintaxis**:
```dart
class Dog extends Animal {
  @override
  void makeSound() => print('Woof!');
}
```

**Cuándo usar**: Al sobrescribir métodos heredados.

**Ver también**: [extends](#extends), [super](#super)

---

## P

### package (⚙️)
**Definición**: Conjunto reutilizable de código Dart.

**Uso**:
```yaml
# pubspec.yaml
dependencies:
  http: ^1.0.0
```

```dart
import 'package:http/http.dart' as http;
```

**Dónde buscar**: [pub.dev](https://pub.dev)

**Ver también**: [pubspec.yaml](#pubspecyaml), [import](#import)

---

### private (📦)
**Definición**: Modificador de acceso usando `_` (guion bajo).

**Sintaxis**:
```dart
class Person {
  String _privateField; // Solo visible en este archivo
  String publicField;
}
```

**Cuándo usar**: Para encapsular detalles de implementación.

**Ver también**: [encapsulation](#encapsulation), [getter](#getter)

---

## R

### Row (🎨)
**Definición**: Widget que organiza hijos horizontalmente.

**Sintaxis**:
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Icon(Icons.home),
    Text('Inicio'),
  ],
)
```

**Cuándo usar**: Para layouts horizontales.

**Ver también**: [Column](#column), [Flex](#flex)

---

### runApp() (🎨)
**Definición**: Función que inicia una aplicación Flutter.

**Sintaxis**:
```dart
void main() {
  runApp(MyApp());
}
```

**Cuándo usar**: En `main()` para iniciar la app.

**Ver también**: [main()](#main), [MaterialApp](#materialapp)

---

## S

### Scaffold (🎨)
**Definición**: Estructura básica de una pantalla Material.

**Sintaxis**:
```dart
Scaffold(
  appBar: AppBar(title: Text('Título')),
  body: Center(child: Text('Contenido')),
  floatingActionButton: FloatingActionButton(...),
)
```

**Cuándo usar**: En casi todas las pantallas.

**Ver también**: [AppBar](#appbar), [Material](#material)

---

### Set (📚)
**Definición**: Colección sin elementos duplicados.

**Sintaxis**:
```dart
Set<int> numbers = {1, 2, 3};
numbers.add(2); // No duplica
```

**Métodos comunes**: `add`, `remove`, `contains`, `union`, `intersection`

**Cuándo usar**: Cuando no quieres duplicados.

**Ver también**: [List](#list), [Map](#map-collection)

---

### setState() (🎨)
**Definición**: Método que notifica cambios de estado en StatefulWidget.

**Sintaxis**:
```dart
setState(() {
  counter++;
});
```

**Cuándo usar**: Para actualizar UI en StatefulWidget.

**Ver también**: [StatefulWidget](#statefulwidget), [State](#state)

---

### setter (📦)
**Definición**: Método que modifica una propiedad privada.

**Sintaxis**:
```dart
class Person {
  String _name;
  
  set name(String value) {
    if (value.isNotEmpty) _name = value;
  }
}
```

**Cuándo usar**: Para validación o lógica al asignar.

**Ver también**: [getter](#getter), [encapsulation](#encapsulation)

---

### State (🎨)
**Definición**: Objeto que contiene datos mutables de un StatefulWidget.

**Sintaxis**:
```dart
class _MyWidgetState extends State<MyWidget> {
  int counter = 0;
  
  @override
  Widget build(BuildContext context) { ... }
}
```

**Cuándo usar**: En widgets con estado mutable.

**Ver también**: [StatefulWidget](#statefulwidget), [setState()](#setstate)

---

### StatefulWidget (🎨)
**Definición**: Widget que tiene estado mutable.

**Sintaxis**:
```dart
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  // ...
}
```

**Cuándo usar**: Para UI que cambia con interacción.

**Ver también**: [StatelessWidget](#statelesswidget), [State](#state)

---

### StatelessWidget (🎨)
**Definición**: Widget sin estado mutable.

**Sintaxis**:
```dart
class Greeting extends StatelessWidget {
  final String name;
  
  const Greeting({required this.name});
  
  @override
  Widget build(BuildContext context) {
    return Text('Hola, $name');
  }
}
```

**Cuándo usar**: Para UI estática.

**Ver también**: [StatefulWidget](#statefulwidget), [Widget](#widget)

---

### super (📦)
**Definición**: Referencia a la superclase.

**Sintaxis**:
```dart
class Dog extends Animal {
  Dog(String name) : super(name);
  
  @override
  void makeSound() {
    super.makeSound(); // Llama al método de Animal
    print('Woof!');
  }
}
```

**Cuándo usar**: Para acceder a miembros de la clase padre.

**Ver también**: [extends](#extends), [@override](#override)

---

## T

### Text (🎨)
**Definición**: Widget para mostrar texto.

**Sintaxis**:
```dart
Text(
  'Hola Mundo',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
)
```

**Cuándo usar**: Para mostrar texto en UI.

**Ver también**: [TextStyle](#textstyle), [RichText](#richtext)

---

### this (📦)
**Definición**: Referencia al objeto actual.

**Sintaxis**:
```dart
class Person {
  String name;
  
  Person(this.name); // Shorthand
  
  void introduce() {
    print('Soy ${this.name}');
  }
}
```

**Cuándo usar**: Para referenciar propiedades/métodos del objeto.

**Ver también**: [class](#class), [constructor](#constructor)

---

### ThemeData (🎨)
**Definición**: Configuración de colores y estilos de la app.

**Sintaxis**:
```dart
ThemeData(
  primarySwatch: Colors.blue,
  textTheme: TextTheme(...),
  useMaterial3: true,
)
```

**Cuándo usar**: Para consistencia visual en la app.

**Ver también**: [MaterialApp](#materialapp), [Theme](#theme)

---

## V

### var (⚙️)
**Definición**: Palabra clave para inferencia de tipos.

**Sintaxis**:
```dart
var name = 'Juan'; // Infiere String
var age = 25; // Infiere int
```

**Cuándo usar**: Cuando el tipo es obvio por el valor.

**Ver también**: [final](#final), [dynamic](#dynamic)

---

### void (⚙️)
**Definición**: Tipo que indica que una función no retorna valor.

**Sintaxis**:
```dart
void printMessage(String message) {
  print(message);
}
```

**Cuándo usar**: Para funciones que no retornan nada.

**Ver también**: [Function](#function), [return](#return)

---

## W

### Widget (🎨)
**Definición**: Pieza básica de la UI en Flutter.

**Todo en Flutter es un widget**:
- Layout: Row, Column, Container
- Interacción: Button, TextField
- Estilo: Text, Icon
- Navegación: Scaffold, AppBar

**Ver también**: [StatelessWidget](#statelesswidget), [StatefulWidget](#statefulwidget)

---

### with (📦)
**Definición**: Palabra clave para aplicar mixins.

**Sintaxis**:
```dart
class Duck extends Animal with Swimming, Flying {}
```

**Cuándo usar**: Para usar mixins.

**Ver también**: [mixin](#mixin), [extends](#extends)

---

## 📊 Resumen por Categorías

### POO (Programación Orientada a Objetos) - 15 términos
`abstract`, `class`, `constructor`, `extends`, `factory`, `getter`, `implements`, `mixin`, `Object`, `@override`, `private`, `setter`, `super`, `this`, `with`

### Colecciones - 3 términos
`List`, `Map`, `Set`

### Flutter UI - 20 términos
`AppBar`, `build()`, `BuildContext`, `Column`, `Container`, `Flutter`, `Hot Reload`, `Hot Restart`, `immutable`, `main()`, `Material`, `MaterialApp`, `Navigator`, `Row`, `runApp()`, `Scaffold`, `setState()`, `State`, `StatefulWidget`, `StatelessWidget`, `Text`, `ThemeData`, `Widget`

### Dart General - 12 términos
`async/await`, `const`, `Dart`, `dynamic`, `enum`, `final`, `Future`, `late`, `null`, `package`, `var`, `void`

---

## 🎯 Estudio Recomendado

### Semana 02
**Prioridad Alta** (debes dominar):
- class, constructor, extends, List, Map, Set
- Widget, StatelessWidget, StatefulWidget, build()
- MaterialApp, Scaffold, Column, Row, Text

**Prioridad Media** (debes conocer):
- mixin, abstract, implements, getter, setter
- setState(), Container, AppBar, Navigator
- final, const, async/await

**Prioridad Baja** (para profundizar):
- factory, late, BuildContext, ThemeData
- Hot Reload, immutable, private

---

## 📚 Recursos Relacionados

- 📖 [Teoría: POO en Dart](../1-teoria/01-poo-dart.md)
- 📖 [Teoría: Colecciones](../1-teoria/02-colecciones-estructuras.md)
- 📖 [Teoría: Intro Flutter](../1-teoria/03-intro-flutter.md)
- 📋 [Documentación Oficial](../4-recursos/08-documentacion-oficial.md)

---

**Total**: 50+ términos técnicos  
**Actualizado**: Noviembre 2025  
**Versión**: 1.0
